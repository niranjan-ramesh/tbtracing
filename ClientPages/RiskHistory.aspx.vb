Public Class RiskHistory
    Inherits System.Web.UI.Page

    Private intClientID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkAddNew.NavigateUrl = String.Format(lnkAddNew.NavigateUrl, intClientID)
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("RiskSuccess")) Then
            'Display success panel.
            pnlSuccess.Visible = True
            Session.Remove("RiskSuccess")
        Else
            pnlSuccess.Visible = False
        End If
    End Sub
#End Region

#Region "Get Data"
    Public Function rptDetails_GetData() As IEnumerable(Of TBTracing.RisksItem)
        Dim result As List(Of RisksItem) = Nothing

        Try
            Dim db As IClientDA = New ClientDAImpl()
            result = db.GetRisksHistory(intClientID)
            If IsNothing(result) OrElse result.Count = 0 Then
                pnlEmptyRisks.Visible = True
            Else
                pnlEmptyRisks.Visible = False
            End If

            Return result
        Catch ex As Exception
            LogHelper.LogError("Error getting risks for client.", "RiskHistory.aspx", ex)
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
        Return result
    End Function
#End Region

End Class