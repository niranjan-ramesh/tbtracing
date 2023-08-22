Public Class Risks
    Inherits System.Web.UI.Page

    Private intRiskID As Nullable(Of Integer)
    Private intClientID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If editing a skin test, we will be passed a testid
        If Not IsNothing(Request.Params("riskid")) AndAlso IsNumeric(Request.Params("riskid")) Then
            intRiskID = Integer.Parse(Request.Params("riskid"))
        End If

        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Hack to use single template on form view
        If IsNothing(intRiskID) Then
            FormViewRisks.InsertItemTemplate = FormViewRisks.EditItemTemplate
            FormViewRisks.DefaultMode = FormViewMode.Insert
        Else
            FormViewRisks.EditItemTemplate = FormViewRisks.EditItemTemplate
            FormViewRisks.DefaultMode = FormViewMode.Edit
        End If
    End Sub
#End Region

#Region "GridView Databind"
    Protected Sub FormViewRisks_DataBound(sender As Object, e As EventArgs) Handles FormViewRisks.DataBound
        Dim addButton As LinkButton = CType(FormViewRisks.FindControl("addButton"), LinkButton)
        Dim updateButton As LinkButton = CType(FormViewRisks.FindControl("updateButton"), LinkButton)
        Dim cancelButton As HyperLink = FormViewRisks.FindControl("lnkCancelButton")

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        If IsNothing(intRiskID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If
    End Sub
#End Region

#Region "Risk CRUD"
    Public Sub FormViewRisks_InsertItem()
        Dim item = New TBTracing.client_RiskFactors()
        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                item.ClientID = intClientID
                Dim db As IClientDA = New ClientDAImpl()
                db.AddRisk(item)
                Session.Add("RiskSuccess", "True")
                Response.Redirect(String.Format("~/ClientPages/RiskHistory.aspx?clientid={0}", intClientID.ToString()), False)
            Catch ex As Exception
                LogHelper.LogError("Error adding risks.", "Risks.aspx", ex)
                Session.Add("ErrorMessage", "Error adding risks.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function FormViewRisks_GetItem() As TBTracing.client_RiskFactors
        Try
            Dim result As client_RiskFactors = Nothing
            Using db As New TBTracingEntities
                result = db.client_RiskFactors.Find(intRiskID)
            End Using
            Return result
        Catch ex As Exception
            LogHelper.LogError("Error getting risks for update.", "Risks.aspx", ex)
            Session.Add("ErrorMessage", "Error updating risks.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub FormViewRisks_UpdateItem()
        Dim item As client_RiskFactors = New client_RiskFactors()
        TryUpdateModel(item)

        If ModelState.IsValid Then
            item.ClientID = intClientID
            item.ID = intRiskID
            Try
                Dim db As IClientDA = New ClientDAImpl
                db.UpdateRisk(item)
                Session.Add("RiskSuccess", "True")
                Response.Redirect(String.Format("~/ClientPages/RiskHistory.aspx?clientid={0}", intClientID.ToString()), False)
            Catch ex As Exception
                LogHelper.LogError("Error updating symptoms.", "Symptoms.aspx", ex)
                Session.Add("ErrorMessage", "Error updating symptoms.")
                Response.Redirect("~/ErrorPage.aspx")
            End Try
        End If
    End Sub
#End Region

End Class