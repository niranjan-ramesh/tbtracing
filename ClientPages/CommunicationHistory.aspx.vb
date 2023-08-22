Public Class CommunicationHistory
    Inherits System.Web.UI.Page

    Private intClientID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkAddNew.NavigateUrl = String.Format(lnkAddNew.NavigateUrl, intClientID.ToString())
        Else
            LogHelper.LogInfo("Missing client id", "CommunicationHistory.aspx")
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("CommunicationSuccess")) Then
            'Display success panel.
            pnlSuccess.Visible = True
            Session.Remove("CommunicationSuccess")
        Else
            pnlSuccess.Visible = False
        End If



        If Not Page.IsPostBack Then
            Try
                populateForm()
                Dim db As IClientDA = New ClientDAImpl()
                gvHistory.DataSource = db.GetCommunicationHistory(intClientID)
                gvHistory.DataBind()
            Catch ex As Exception
                LogHelper.LogError("Error populating Communication History Form.", "CommunicationHistory.aspx", ex)
                'TODO: ROUTE TO ERROR PAGE
            End Try



        End If

    End Sub

    Protected Sub lbSaveBulletin_Click(sender As Object, e As EventArgs) Handles lbSaveBulletin.Click
        Try
            Dim bulletinNotes As String = tbContactBulletin.Text

            Using db As New TBTracingEntities
                Dim objBulletin As client_CommunicationBulletin = (From queryObject In db.client_CommunicationBulletin _
                                                                  Where queryObject.ClientID = intClientID _
                                                                  Select queryObject).FirstOrDefault()

                If IsNothing(objBulletin) Then
                    Dim newBulletin As client_CommunicationBulletin = New client_CommunicationBulletin()
                    newBulletin.ClientID = intClientID
                    newBulletin.CommunicationBulletin = bulletinNotes
                    db.client_CommunicationBulletin.Add(newBulletin)
                Else
                    objBulletin.CommunicationBulletin = bulletinNotes
                End If

                db.SaveChanges()
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error with communication bulletin.", "CommunicationHistory.aspx", ex)
            'TODO: Go to error page.
        End Try
    End Sub

    Private Sub populateForm()
        Try
            Using db As New TBTracingEntities
                Dim objClientDemo As client_Demographic = (From clientDemo In db.client_Demographic _
                                                          Where clientDemo.ClientID = intClientID _
                                                          And clientDemo.Active = True).FirstOrDefault()


                tbEmail.Text = objClientDemo.Email
                tbHomePhone.Text = objClientDemo.HomePhone
                tbMobilePhone.Text = objClientDemo.MobilePhone
                tbOtherPhone.Text = objClientDemo.OtherPhone

                tbEmail.ReadOnly = True
                tbHomePhone.ReadOnly = True
                tbMobilePhone.ReadOnly = True
                tbOtherPhone.ReadOnly = True

                Dim objBulletin As client_CommunicationBulletin = (From queryObject In db.client_CommunicationBulletin _
                                                                  Where queryObject.ClientID = intClientID _
                                                                  Select queryObject).FirstOrDefault()

                If Not IsNothing(objBulletin) Then
                    tbContactBulletin.Text = objBulletin.CommunicationBulletin
                End If
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error populating form.", "CommunicationHistory.aspx", ex)
            'TODO: Route to error page.
        End Try
    End Sub

    Protected Sub gvHistory_PreRender(sender As Object, e As EventArgs) Handles gvHistory.PreRender
        If Not IsNothing(gvHistory) AndAlso Not IsNothing(gvHistory.HeaderRow) Then gvHistory.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub
End Class