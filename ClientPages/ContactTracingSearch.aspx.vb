Public Class ContactTracingSearch
    Inherits System.Web.UI.Page

    Private intClientID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkAddNewClient.NavigateUrl = String.Format(lnkAddNewClient.NavigateUrl, intClientID.ToString())
        Else
            LogHelper.LogInfo("Missing client id.", "ContactTracingSearch.aspx")

            Session.Add("ErrorMessage", "Missing Client ID.")
            Response.Redirect("~/ErrorPage.aspx")
        End If

        If Not IsNothing(Session.Item("ContactSuccess")) Then
            pnlSuccess.Visible = True
            lblSuccessMessage.Text = Session.Item("ContactSuccess")
            Session.Remove("ContactSuccess")
        Else
            pnlSuccess.Visible = False
        End If

    End Sub

    Protected Sub gvClients_PreRender(sender As Object, e As EventArgs) Handles gvClients.PreRender
        If Not IsNothing(gvClients) AndAlso Not IsNothing(gvClients.HeaderRow) Then gvClients.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub

    Protected Sub dsClientList_Selecting(sender As Object, e As EntityDataSourceSelectingEventArgs) Handles dsClientList.Selecting
        Try
            Dim strFirstName As String = tbFirstName.Text
            Dim strDOB As String = tbDOB.Text
            Dim strLastName As String = tbLastName.Text
            Dim intStatus As Nullable(Of Integer) = Nothing

            If Not String.IsNullOrEmpty(ddStatus.SelectedValue) Then
                intStatus = Integer.Parse(ddStatus.SelectedValue)
            End If

            If Not String.IsNullOrEmpty(strFirstName) Then
                dsClientList.WhereParameters("FirstName") = New Parameter("FirstName", DbType.String, strFirstName)
                dsClientList.Where = "it.FirstName LIKE '%'+@FirstName+'%' "
            End If

            If Not String.IsNullOrEmpty(strLastName) Then
                dsClientList.WhereParameters("LastName") = New Parameter("LastName", DbType.String, strLastName)
                dsClientList.Where = "it.LastName LIKE '%'+@LastName+'%' "
            End If

            If Not String.IsNullOrEmpty(strDOB) Then
                Dim objDataHelper As DataHelper = New DataHelper()
                Dim dob As DateTime = objDataHelper.convertStringToDate(strDOB)
                dsClientList.WhereParameters("DateofBirth") = New Parameter("DateofBirth", DbType.DateTime, dob.ToString())
                dsClientList.Where = "it.DateofBirth = @DateofBirth "
            End If

            If Not IsNothing(intStatus) Then
                dsClientList.WhereParameters("StatusID") = New Parameter("StatusID", DbType.Int32, intStatus.ToString())
                dsClientList.Where = "it.StatusID = @StatusID "
            End If

            dsClientList.WhereParameters("ClientID") = New Parameter("ClientID", DbType.Int32, intClientID.ToString())
            If String.IsNullOrEmpty(dsClientList.Where) Then
                dsClientList.Where = "it.ClientID <> @ClientID"
            Else
                dsClientList.Where = dsClientList.Where & " AND it.ClientID <> @ClientID"
            End If


        Catch ex As Exception
            LogHelper.LogError("Error filtering client list.", "ContactTracingSearch.aspx", ex)
            Session.Add("ErrorMessage", "Error searcing for client.")
            Response.Redirect("~/ErrorPage.aspx")
        End Try
    End Sub

    Protected Sub lbSearch_Click(sender As Object, e As EventArgs) Handles lbSearch.Click
        gvClients.DataBind()
    End Sub
End Class