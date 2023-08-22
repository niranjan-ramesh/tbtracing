Public Class DiagnosticImage
    Inherits System.Web.UI.Page

    Private intDiagnosticID As Nullable(Of Integer)
    Private intClientID As Integer

#Region "Page Load"
    Private Sub XRay_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        'Check for Test ID
        If Not IsNothing(Request.Params("testid")) AndAlso IsNumeric(Request.Params("testid")) Then
            intDiagnosticID = Integer.Parse(Request.Params("testid"))
        End If

        'Check for Client ID
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error Retrieving Client X-Ray Test")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If


        'Determine which FormView Mode to use
        If IsNothing(intDiagnosticID) Then
            fvDiagnosticImage.InsertItemTemplate = fvDiagnosticImage.EditItemTemplate
            fvDiagnosticImage.DefaultMode = FormViewMode.Insert
        Else
            fvDiagnosticImage.EditItemTemplate = fvDiagnosticImage.EditItemTemplate
            fvDiagnosticImage.DefaultMode = FormViewMode.Edit
        End If

    End Sub
#End Region

#Region "FormView CRUD"
    Public Function fvDiagnosticImage_GetItem() As TBTracing.client_DiagnosticImage
        Try
            Using db As New TBTracingEntities
                Dim imageToUpdate As client_DiagnosticImage = db.client_DiagnosticImage.Find(intDiagnosticID)
                Return imageToUpdate
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting Diagnostic Image for update.", "XRay Error", ex)
            Session.Add("ErrorMessage", "Error Retrieving Diagnostic Image Data")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function


    Public Sub fvDiagnosticImage_InsertItem()
        Dim item As New client_DiagnosticImage
        TryUpdateModel(item)

        If ModelState.IsValid Then
            Try
                item.ClientID = intClientID
                Dim db As IClientDA = New ClientDAImpl()
                db.AddDiagnosticImage(item)
                Session.Add("InvestigationSuccess", "True")
                Response.Redirect("~/ClientPages/InvestigationHistory?clientid=" & intClientID, False)
            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error adding diagnonsitc image", "DiagnosticImage.aspx", dataEx)
                Session.Add("ErrorMessage", "Error Saving diagnonsitc image")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error adding diagnonsitc image", "DiagnosticImage.aspx", ex)
                Session.Add("ErrorMessage", "Error Saving diagnonsitc image")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub


    ' The id parameter name should match the DataKeyNames value set on the control
    Public Sub fvDiagnosticImage_UpdateItem()
        Dim item As client_DiagnosticImage = New client_DiagnosticImage()
        TryUpdateModel(item)
        'Set the client id.
        item.ClientID = intClientID
        item.ID = intDiagnosticID

        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateDiagnosticImage(item)
                Session.Add("InvestigationSuccess", "True")
                Response.Redirect("~/ClientPages/InvestigationHistory?clientid=" & intClientID, False)
            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error updating diagnonsitc image", "DiagnosticImage.aspx", dataEx)
                Session.Add("ErrorMessage", "Error updating diagnonsitc image")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error updating diagnonsitc image", "DiagnosticImage.aspx", ex)
                Session.Add("ErrorMessage", "Error updating diagnonsitc image")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "FV Databind"
    Protected Sub fvDiagnosticImage_DataBound(sender As Object, e As EventArgs)
        Dim addButton As LinkButton = fvDiagnosticImage.FindControl("addButton")
        Dim updateButton As LinkButton = fvDiagnosticImage.FindControl("updateButton")
        Dim cancelButton As HyperLink = fvDiagnosticImage.FindControl("lnkCancelButton")


        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        If IsNothing(intDiagnosticID) Then
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
        dsReasons.WhereParameters("ditype") = New Parameter("ditype", DbType.Int32, DataConstants.ReasonForDI.ToString())
    End Sub

    Protected Sub ddReasonForTesting_TextChanged(sender As Object, e As EventArgs)
        Try
            Dim ddReason As DropDownList = CType(fvDiagnosticImage.FindControl("ddReasonForTesting"), DropDownList)
            Dim tbOther As TextBox = CType(fvDiagnosticImage.FindControl("tbTestReasonOther"), TextBox)

            If Not IsNothing(ddReason) AndAlso Not IsNothing(tbOther) Then
                Dim strOtherDI As String = DataConstants.FollowupOtherDI.ToString
                If Not String.IsNullOrEmpty(ddReason.SelectedValue) AndAlso ddReason.SelectedValue = strOtherDI Then
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