Public Class InvestigationHistory
    Inherits System.Web.UI.Page

    Private intClientID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkAddIGRA.NavigateUrl = String.Format(lnkAddIGRA.NavigateUrl, intClientID.ToString())
            lnkAddBloodwork.NavigateUrl = String.Format(lnkAddBloodwork.NavigateUrl, intClientID.ToString())
            lnkAddDiagnosticImage.NavigateUrl = String.Format(lnkAddDiagnosticImage.NavigateUrl, intClientID.ToString())
        Else
            Session.Add("ErrorMessage", "Error Retrieving Investigations Data")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("InvestigationSuccess")) Then
            'Display success panel.
            pnlSuccess.Visible = True
            Session.Remove("InvestigationSuccess")
        Else
            pnlSuccess.Visible = False
        End If

        Dim db As IClientDA = New ClientDAImpl()
        gvIGRAHistory.DataSource = db.GetIGRAHistory(intClientID)
        gvIGRAHistory.DataBind()

        gvBloodworkHistory.DataSource = db.GetBloodworkHistory(intClientID)
        gvBloodworkHistory.DataBind()

        gvDiagnosticImages.DataSource = db.GetDiagnosticHistory(intClientID)
        gvDiagnosticImages.DataBind()
    End Sub

    Private Sub gvIGRAHistory_PreRender(sender As Object, e As EventArgs) Handles gvIGRAHistory.PreRender
        If gvIGRAHistory.Rows.Count > 0 Then
            gvIGRAHistory.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

    Private Sub gvBloodworkHistory_PreRender(sender As Object, e As EventArgs) Handles gvBloodworkHistory.PreRender
        If gvBloodworkHistory.Rows.Count > 0 Then
            gvBloodworkHistory.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

    Protected Sub gvDiagnosticImages_PreRender(sender As Object, e As EventArgs)
        If gvDiagnosticImages.Rows.Count > 0 Then
            gvDiagnosticImages.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub
End Class