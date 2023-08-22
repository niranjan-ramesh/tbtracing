Public Class Symptoms
    Inherits System.Web.UI.Page

    Private intSymptomID As Nullable(Of Integer)
    Private intClientID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'If editing a skin test, we will be passed a testid
        If Not IsNothing(Request.Params("symptomid")) AndAlso IsNumeric(Request.Params("symptomid")) Then
            intSymptomID = Integer.Parse(Request.Params("symptomid"))
        End If

        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Hack to use single template on form view
        If IsNothing(intSymptomID) Then
            FormViewSymptoms.InsertItemTemplate = FormViewSymptoms.EditItemTemplate
            FormViewSymptoms.DefaultMode = FormViewMode.Insert
        Else
            FormViewSymptoms.EditItemTemplate = FormViewSymptoms.EditItemTemplate
            FormViewSymptoms.DefaultMode = FormViewMode.Edit
        End If
    End Sub
#End Region

#Region "Symptoms Databind"
    Protected Sub FormViewSymptoms_DataBound(sender As Object, e As EventArgs) Handles FormViewSymptoms.DataBound
        Dim addButton As LinkButton = FormViewSymptoms.FindControl("addButton")
        Dim updateButton As LinkButton = FormViewSymptoms.FindControl("updateButton")
        Dim cancelButton As HyperLink = FormViewSymptoms.FindControl("lnkCancelButton")

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        If IsNothing(intSymptomID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If
    End Sub
#End Region

#Region "Symptoms CRUD"
    Public Sub FormViewSymptoms_InsertItem()
        Dim item = New TBTracing.client_Symptoms()
        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                item.ClientID = intClientID
                Dim db As IClientDA = New ClientDAImpl()
                db.AddSymptoms(item)
                Session.Add("SymptomSuccess", "True")
                Response.Redirect(String.Format("~/ClientPages/SymptomHistory.aspx?clientid={0}", intClientID.ToString()), False)
            Catch ex As Exception
                LogHelper.LogError("Error inserting symptoms.", "Symptoms.aspx", ex)
                Session.Add("ErrorMessage", "Error updating symptoms.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Sub FormViewSymptoms_UpdateItem()
        Dim item As client_Symptoms = New client_Symptoms()
        TryUpdateModel(item)
        If ModelState.IsValid Then
            item.ClientID = intClientID
            item.ID = intSymptomID
            Try
                Dim db As IClientDA = New ClientDAImpl
                db.UpdateSymptoms(item)
                Session.Add("SymptomSuccess", "True")
                Response.Redirect(String.Format("~/ClientPages/SymptomHistory.aspx?clientid={0}", intClientID.ToString()), False)
            Catch ex As Exception
                LogHelper.LogError("Error updating symptoms.", "Symptoms.aspx", ex)
                Session.Add("ErrorMessage", "Error updating symptoms.")
                Response.Redirect("~/ErrorPage.aspx")
            End Try
        End If
    End Sub

    Public Function FormViewSymptoms_GetItem() As TBTracing.client_Symptoms
        Try
            Dim result As client_Symptoms = Nothing
            Using db As New TBTracingEntities
                result = db.client_Symptoms.Find(intSymptomID)
            End Using
            Return result
        Catch ex As Exception
            LogHelper.LogError("Error getting symptoms for update.", "Symptoms.aspx", ex)
            Session.Add("ErrorMessage", "Error updating symptoms.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function
#End Region

End Class