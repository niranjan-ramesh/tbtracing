Public Class OutcomeHistory
    Inherits System.Web.UI.Page

    Private intClientID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkAddNew.NavigateUrl = String.Format(lnkAddNew.NavigateUrl, intClientID.ToString())
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("OutcomeSuccess")) Then
            pnlSuccess.Visible = True
            If Session.Item("OutcomeSuccess").Equals("True") Then
                ltStatusMessage.Text = "Outcome Saved Successfully.  Please update any associated treatment information."
            Else
                ltStatusMessage.Text = Session.Item("OutcomeSuccess")
            End If


            Session.Remove("OutcomeSuccess")
        Else
            pnlSuccess.Visible = False
        End If
    End Sub
#End Region

#Region "GV Data"
    Public Function gvHistory_GetData() As IQueryable(Of TBTracing.OutcomeGridLineItem)
        Dim db As IClientDA = New ClientDAImpl()
        Return db.GetOutcomeForClient(intClientID, Nothing).AsQueryable()
    End Function
#End Region

#Region "GV Render CSS"
    Protected Sub gvHistory_PreRender(sender As Object, e As EventArgs)
        If Not IsNothing(gvHistory) AndAlso Not IsNothing(gvHistory.HeaderRow) Then gvHistory.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub
#End Region

End Class