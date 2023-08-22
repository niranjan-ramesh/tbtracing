Public Class OutcomeTreatmentSchedule
    Inherits System.Web.UI.Page

    Private intOutcomeID As Nullable(Of Integer)
    Private intClientID As Integer
    Private intTreatmentID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsNothing(Request.Params("outcomeid")) AndAlso IsNumeric(Request.Params("outcomeid")) Then
            intOutcomeID = Integer.Parse(Request.Params("outcomeid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Request.Params("treatid")) AndAlso IsNumeric(Request.Params("treatid")) Then
            intTreatmentID = Integer.Parse(Request.Params("treatid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If


        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))

        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("AddDOTSuccess")) Then
            Session.Remove("AddDOTSuccess")
            pnlSuccess.Visible = True
        Else
            pnlSuccess.Visible = False
        End If


        lnkAddDOT.NavigateUrl = String.Format(lnkAddDOT.NavigateUrl, intClientID.ToString(), intTreatmentID.ToString(), intOutcomeID.ToString())
        'lnkBack.NavigateUrl = String.Format(lnkBack.NavigateUrl, intClientID.ToString(), intTreatmentID.ToString(), intOutcomeID.ToString())
    End Sub
#End Region

#Region "GV Styles"
    Protected Sub gvDOTHistory_PreRender(sender As Object, e As EventArgs)
        If Not IsNothing(gvDOTHistory) AndAlso Not IsNothing(gvDOTHistory.HeaderRow) Then gvDOTHistory.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub
#End Region

End Class