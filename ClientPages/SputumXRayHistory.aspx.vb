Public Class SputumXRayHistory
    Inherits System.Web.UI.Page

    Private intClientID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Check for Client ID
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkAddSputum.NavigateUrl = String.Format(lnkAddSputum.NavigateUrl, intClientID.ToString())
            lnkAddChestXRay.NavigateUrl = String.Format(lnkAddChestXRay.NavigateUrl, intClientID.ToString())
            lnkAddXRay.NavigateUrl = String.Format(lnkAddXRay.NavigateUrl, intClientID.ToString())

        Else
            Session.Add("ErrorMessage", "Error Retrieving Sputum and X-Ray Data")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Set success message it in Session
        If Not IsNothing(Session.Item("SputumXraySuccess")) Then
            'Display success panel.
            pnlSuccess.Visible = True
            Session.Remove("SputumXraySuccess")
        Else
            pnlSuccess.Visible = False
        End If


        ' Bind GridViews
        Dim db As IClientDA = New ClientDAImpl()
        gvSputumHistory.DataSource = db.GetSputumHistory(intClientID)
        gvSputumHistory.DataBind()

        gvChestXrayHistory.DataSource = db.GetChestXrayHistory(intClientID)
        gvChestXrayHistory.DataBind()

        gvXrayHistory.DataSource = db.GetXrayHistory(intClientID)
        gvXrayHistory.DataBind()

        

    End Sub

    Private Sub gvSputumHistory_PreRender(sender As Object, e As EventArgs) Handles gvSputumHistory.PreRender
        If gvSputumHistory.Rows.Count > 0 Then
            gvSputumHistory.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

    Private Sub gvChestXrayHistory_PreRender(sender As Object, e As EventArgs) Handles gvChestXrayHistory.PreRender
        If gvChestXrayHistory.Rows.Count > 0 Then
            gvChestXrayHistory.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

    Private Sub gvXrayHistory_PreRender(sender As Object, e As EventArgs) Handles gvXrayHistory.PreRender
        If gvXrayHistory.Rows.Count > 0 Then
            gvXrayHistory.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

   
End Class