Public Class SymptomHistory
    Inherits System.Web.UI.Page

    Private intClientID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkAddNew.NavigateUrl = String.Format(lnkAddNew.NavigateUrl, intClientID)
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("SymptomSuccess")) Then
            'Display success panel.
            pnlSuccess.Visible = True
            Session.Remove("SymptomSuccess")
        Else
            pnlSuccess.Visible = False
        End If

    End Sub

    Public Function rptDetails_GetData() As IEnumerable(Of SymptomsItem)
        Dim result As List(Of SymptomsItem) = Nothing

        Try
            Dim db As IClientDA = New ClientDAImpl()
            result = db.GetSymptomsHistory(intClientID)
            If IsNothing(result) OrElse result.Count = 0 Then
                pnlEmptySymptoms.Visible = True
            Else
                pnlEmptySymptoms.Visible = False
            End If
            Return result

        Catch ex As Exception
            LogHelper.LogError("Error get symptoms.", "SymptomHistory.aspx", ex)
            Session.Add("ErrorMessage", "Error getting symptoms.")
            Response.Redirect("~/ErrorPage.aspx")
        End Try
        Return result
    End Function
End Class