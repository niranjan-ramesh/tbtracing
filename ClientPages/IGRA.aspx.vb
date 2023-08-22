Public Class IGRA
    Inherits System.Web.UI.Page

    Private intIGRAID As Nullable(Of Integer)
    Private intClientID As Integer

#Region "Page Load"
    Private Sub IGRA_Init(sender As Object, e As EventArgs) Handles Me.Init
        'Check for Test ID
        If Not IsNothing(Request.Params("testid")) AndAlso IsNumeric(Request.Params("testid")) Then
            intIGRAID = Integer.Parse(Request.Params("testid"))
        End If

        'Check for Client ID
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error Retrieving IGRA")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Determine which FormView Mode to use
        If IsNothing(intIGRAID) Then
            IGRAFormView.InsertItemTemplate = IGRAFormView.EditItemTemplate
            IGRAFormView.DefaultMode = FormViewMode.Insert
        Else
            IGRAFormView.EditItemTemplate = IGRAFormView.EditItemTemplate
            IGRAFormView.DefaultMode = FormViewMode.Edit
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
    End Sub
#End Region

#Region "IGRA CRUD"
    Public Sub IGRAFormView_InsertItem()
        Dim item = New TBTracing.client_IGRA()
        TryUpdateModel(item)

        If ModelState.IsValid Then
            Try
                item.ClientID = intClientID
                Dim db As IClientDA = New ClientDAImpl()
                db.AddIGRA(item)
                Session.Add("InvestigationSuccess", "True")
                Response.Redirect("~/ClientPages/InvestigationHistory?clientid=" & intClientID, False)
            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error adding IGRA", "IGRA.aspx", dataEx)
                Session.Add("ErrorMessage", "Error Saving IGRA")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error Adding IGRA", "IGRA.aspx", ex)
                Session.Add("ErrorMessage", "Error Saving IGRA")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function IGRAFormView_GetItem() As TBTracing.client_IGRA
        Try
            Using db As New TBTracingEntities
                Dim igraToUpdate As client_IGRA = db.client_IGRA.Find(intIGRAID)
                Return igraToUpdate
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting IGRA for update.", "IGRA Error", ex)
            Session.Add("ErrorMessage", "Error Retrieving IGRA")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub IGRAFormView_UpdateItem()
        Dim item As client_IGRA = New client_IGRA()
        TryUpdateModel(item)

        item.ClientID = intClientID
        item.ID = intIGRAID

        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateIGRA(item, intIGRAID)
                Session.Add("InvestigationSuccess", "True")
                Response.Redirect("~/ClientPages/InvestigationHistory?clientid=" & intClientID, False)
            Catch dataEX As TBDataAccessException
                LogHelper.LogError("DB Error updating IGRA.", "IGRA.aspx", dataEX)
                Session.Add("ErrorMessage", "Error Updating IGRA")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("General Error udpating IGRA.", "IGRA.aspx", ex)
                Session.Add("ErrorMessage", "Error Updating IGRA")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "Form View Binding"
    Protected Sub IGRAFormView_DataBound(sender As Object, e As EventArgs)
        Dim addButton As LinkButton = IGRAFormView.FindControl("addButton")
        Dim updateButton As LinkButton = IGRAFormView.FindControl("updateButton")
        Dim cancelButton As HyperLink = IGRAFormView.FindControl("lnkCancelButton")

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        'Display the applicable button (i.e. add/update)
        If IsNothing(intIGRAID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If
    End Sub
#End Region

#Region "Reason Filter / Changing"
    Protected Sub dsReasons_Selecting(sender As Object, e As EntityDataSourceSelectingEventArgs)
        dsReasons.WhereParameters("igratype") = New Parameter("igratype", DbType.Int32, DataConstants.ReasonForTestIGRA.ToString())
    End Sub

    Protected Sub ddReasonForTesting_TextChanged(sender As Object, e As EventArgs)
        Try
            Dim ddReason As DropDownList = CType(IGRAFormView.FindControl("ddReasonForTesting"), DropDownList)
            Dim tbOther As TextBox = CType(IGRAFormView.FindControl("tbReasonOther"), TextBox)

            If Not IsNothing(ddReason) AndAlso Not IsNothing(tbOther) Then
                Dim strOtherIGRA As String = DataConstants.FollowupOtherIGRA.ToString
                If Not String.IsNullOrEmpty(ddReason.SelectedValue) AndAlso ddReason.SelectedValue = strOtherIGRA Then
                    tbOther.Enabled = True
                Else
                    tbOther.Text = String.Empty
                    tbOther.Enabled = False
                End If
            End If
        Catch ex As Exception
            LogHelper.LogError("Error with reason for IGRA testing dropdown change", "IGRA.aspx", ex)
            Session.Add("ErrorMessage", "Error With IGRA Test.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub

#End Region


End Class