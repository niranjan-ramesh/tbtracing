Public Class TreatmentHistory
    Inherits System.Web.UI.Page

    Private intClientID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            'lnkAddNew.NavigateUrl = String.Format(lnkAddNew.NavigateUrl, intClientID.ToString())
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("OutcomeSuccess")) Then
            pnlSuccess.Visible = True
            Session.Remove("OutcomeSuccess")
        Else
            pnlSuccess.Visible = False
        End If
    End Sub
#End Region

#Region "GV Data"
    Public Function gvHistory_GetData() As IQueryable(Of TBTracing.OutcomeGridLineItem)
        Try
            Dim db As IClientDA = New ClientDAImpl()
            Dim activeStatus As Integer = My.Settings.activeTBOutcome
            Dim latentStatus As Integer = My.Settings.latentTBOutcome
            Dim statusList As List(Of Integer) = New List(Of Integer) From {activeStatus, latentStatus}
            Return db.GetOutcomeForClient(intClientID, statusList).AsQueryable()
        Catch ex As Exception
            LogHelper.LogError("Error getting treatment history", "TreatmentHistory.aspx", ex)
            Session.Add("ErrorMessage", "Error retrieving Treatment history.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function
#End Region

#Region "GV Render CSS"
    Protected Sub gvHistory_PreRender(sender As Object, e As EventArgs)
        If Not IsNothing(gvHistory) AndAlso Not IsNothing(gvHistory.HeaderRow) Then gvHistory.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub
#End Region

#Region "GV GV Post Binding"
    Protected Sub gvHistory_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvHistory.RowDataBound
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then
                Dim item As OutcomeGridLineItem = e.Row.DataItem
                If Not IsNothing(item) Then
                    Dim btnDOT As HyperLink = CType(e.Row.FindControl("btnDOT"), HyperLink)
                    If Not item.hasRegimen And Not IsNothing(btnDOT) Then
                        btnDOT.Visible = False
                    End If
                End If
            End If
        Catch ex As Exception
            LogHelper.LogError("Error with DOT button binding", "TreatmentHistory.aspx", ex)
            Session.Add("ErrorMessage", "Error retrieving Treatment history.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

End Class