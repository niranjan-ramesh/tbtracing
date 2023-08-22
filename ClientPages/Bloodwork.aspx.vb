Public Class Bloodwork
    Inherits System.Web.UI.Page

    Private intBloodworkID As Nullable(Of Integer)
    Private intClientID As Integer

#Region "Page Load"
    Private Sub Bloodwork_Init(sender As Object, e As EventArgs) Handles Me.Init
        'Check for Test ID
        If Not IsNothing(Request.Params("testid")) AndAlso IsNumeric(Request.Params("testid")) Then
            intBloodworkID = Integer.Parse(Request.Params("testid"))
        End If

        'Check for Client ID
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error Retrieving Bloodwork")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Determine which FormView Mode to use
        If IsNothing(intBloodworkID) Then
            BloodworkFormView.InsertItemTemplate = BloodworkFormView.EditItemTemplate
            BloodworkFormView.DefaultMode = FormViewMode.Insert
        Else
            BloodworkFormView.EditItemTemplate = BloodworkFormView.EditItemTemplate
            BloodworkFormView.DefaultMode = FormViewMode.Edit
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub
#End Region

#Region "Bloodwork CRUD"
    Public Sub BloodworkFormView_InsertItem()
        Dim item = New TBTracing.client_Bloodwork()
        TryUpdateModel(item)

        If ModelState.IsValid Then
            Try
                item.ClientID = intClientID
                Dim db As IClientDA = New ClientDAImpl()
                db.AddBloodwork(item)
                Session.Add("InvestigationSuccess", "True")
                Response.Redirect("~/ClientPages/InvestigationHistory?clientid=" & intClientID, False)
            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error adding Bloodwork", "Bloodwork.aspx", dataEx)
                Session.Add("ErrorMessage", "Error Saving Bloodwork")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error Adding Bloodwork", "Bloodwork.aspx", ex)
                Session.Add("ErrorMessage", "Error Saving Bloodwork")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function BloodworkFormView_GetItem() As TBTracing.client_Bloodwork
        Try
            Using db As New TBTracingEntities
                Dim bloodworkToUpdate As client_Bloodwork = db.client_Bloodwork.Find(intBloodworkID)
                Return bloodworkToUpdate
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting Bloodwork for update.", "Bloodwork Error", ex)
            Session.Add("ErrorMessage", "Error Retrieving Bloodwork")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub BloodworkFormView_UpdateItem()
        Dim item As client_Bloodwork = New client_Bloodwork()
        TryUpdateModel(item)

        'Set the Client ID and Test ID
        item.ClientID = intClientID
        item.ID = intBloodworkID

        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateBloodwork(item, intBloodworkID)
                Session.Add("InvestigationSuccess", "True")
                Response.Redirect("~/ClientPages/InvestigationHistory?clientid=" & intClientID, False)
            Catch dataEX As TBDataAccessException
                LogHelper.LogError("DB Error updating Bloodwork.", "Bloodwork.aspx", dataEX)
                Session.Add("ErrorMessage", "Error Updating Bloodwork")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("General Error udpating Bloodwork.", "Bloodwork.aspx", ex)
                Session.Add("ErrorMessage", "Error Updating Bloodwork")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "ForView binding"
    Protected Sub BloodworkFormView_DataBound(sender As Object, e As EventArgs)
        Dim addButton As LinkButton = BloodworkFormView.FindControl("addButton")
        Dim updateButton As LinkButton = BloodworkFormView.FindControl("updateButton")
        Dim cancelButton As HyperLink = BloodworkFormView.FindControl("lnkCancelButton")

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        'Display the applicable button (i.e. add/update)
        If IsNothing(intBloodworkID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If
    End Sub
#End Region

#Region "Reason Filtering Change"
    Protected Sub dsReasons_Selecting(sender As Object, e As EntityDataSourceSelectingEventArgs)
        dsReasons.WhereParameters("bloodtype") = New Parameter("bloodtype", DbType.Int32, DataConstants.ReasonForTestBloodwork.ToString())
    End Sub

    Protected Sub ddReasonForTesting_TextChanged(sender As Object, e As EventArgs)
        Try
            Dim ddReason As DropDownList = CType(BloodworkFormView.FindControl("ddReasonForTesting"), DropDownList)
            Dim tbOther As TextBox = CType(BloodworkFormView.FindControl("tbTestReasonOther"), TextBox)

            If Not IsNothing(ddReason) AndAlso Not IsNothing(tbOther) Then
                Dim strOtherBloodwork As String = DataConstants.FollowupOtherBloodword.ToString
                If Not String.IsNullOrEmpty(ddReason.SelectedValue) AndAlso ddReason.SelectedValue = strOtherBloodwork Then
                    tbOther.Enabled = True
                Else
                    tbOther.Text = String.Empty
                    tbOther.Enabled = False
                End If
            End If
        Catch ex As Exception
            LogHelper.LogError("Error with reason for Bloodwork testing dropdown change", "Bloodwork.aspx", ex)
            Session.Add("ErrorMessage", "Error With Bloodwork Test.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

End Class