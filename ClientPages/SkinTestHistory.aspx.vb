Public Class SkinTestHistory
    Inherits System.Web.UI.Page

    Private intClientID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            LogHelper.LogInfo("Missing client id.", "SkinTestHistory.aspx")
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("SkinSuccess")) Then
            'Display success panel.
            pnlSuccess.Visible = True
            Session.Remove("SkinSuccess")
        Else
            pnlSuccess.Visible = False
        End If

        lnkAddNew.NavigateUrl = String.Format(lnkAddNew.NavigateUrl, intClientID.ToString())

        Dim db As IClientDA = New ClientDAImpl()
        gvHistory.DataSource = db.GetSkinTestHistory(intClientID)
        gvHistory.DataBind()

        'Bind the BCG Status
        If Not Page.IsPostBack Then
            populateBCG()
        End If
    End Sub
#End Region


#Region "GV Render"
    Protected Sub gvHistory_PreRender(sender As Object, e As EventArgs) Handles gvHistory.PreRender
        If Not IsNothing(gvHistory) AndAlso Not IsNothing(gvHistory.HeaderRow) Then gvHistory.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub
#End Region

#Region "BCG Add/Save BCG"
    Protected Sub updateButton_Click(sender As Object, e As EventArgs) Handles updateButton.Click
        Try
            If Page.IsValid() Then
                Dim objBCG As client_BCG = New client_BCG()
                objBCG.ClientID = intClientID
                If Not String.IsNullOrEmpty(rblBCGStatus.SelectedValue) Then
                    objBCG.StatusID = Integer.Parse(rblBCGStatus.SelectedValue)
                Else
                    objBCG.StatusID = Nothing
                End If

                If Not String.IsNullOrEmpty(tbImmuneDate.Text) Then
                    objBCG.ImmunizationYear = tbImmuneDate.Text
                Else
                    objBCG.ImmunizationYear = Nothing
                End If

                Dim db As IClientDA = New ClientDAImpl()
                db.AddUpdateBCG(objBCG)

                'Route back to history screen, with a success message.
                Session.Add("SkinSuccess", "True")
                Response.Redirect("~/ClientPages/SkinTestHistory.aspx?clientid=" & intClientID.ToString(), False)
            End If


        Catch ex As Exception
            LogHelper.LogInfo("Error updating BCG.", "SkinTestHistory.aspx")
            Session.Add("ErrorMessage", "Error updating BCG.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

#Region "Populate BCG"
    Private Sub populateBCG()
        Try
            Using db As New TBTracingEntities()
                Dim objBCG As client_BCG = (From objQuery In db.client_BCG _
                                           Where objQuery.ClientID = intClientID _
                                           Select objQuery).FirstOrDefault()

                If Not IsNothing(objBCG) Then
                    If Not IsNothing(objBCG.StatusID) Then rblBCGStatus.SelectedValue = objBCG.StatusID
                    If Not IsNothing(objBCG.ImmunizationYear) Then tbImmuneDate.Text = objBCG.ImmunizationYear
                End If
            End Using
        Catch ex As Exception
            LogHelper.LogInfo("Error populating BCG.", "SkinTestHistory.aspx")
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

End Class