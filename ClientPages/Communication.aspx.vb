Public Class Communication
    Inherits System.Web.UI.Page

    Private intCommID As Nullable(Of Integer)
    Private intClientID As Integer

#Region "Page Load"
    Private Sub Communication_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        'If editing a skin test, we will be passed a testid
        If Not IsNothing(Request.Params("commid")) AndAlso IsNumeric(Request.Params("commid")) Then
            intCommID = Integer.Parse(Request.Params("commid"))
        End If

        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            LogHelper.LogInfo("Missing client id.", "Communication.aspx")
            Session.Add("ErrorMessage", "Missing Client ID.")
            Response.Redirect("~/ErrorPage.aspx")
        End If

        'Hack to use single template on form view
        If IsNothing(intCommID) Then
            ForViewCommunication.InsertItemTemplate = ForViewCommunication.EditItemTemplate
            ForViewCommunication.DefaultMode = FormViewMode.Insert
        Else
            ForViewCommunication.EditItemTemplate = ForViewCommunication.EditItemTemplate
            ForViewCommunication.DefaultMode = FormViewMode.Edit
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
    End Sub
#End Region

#Region "Communication CRUD"
    Public Sub ForViewCommunication_InsertItem()
        Dim item = New TBTracing.client_Communication()
        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                Using db As New TBTracingEntities
                    item.ClientID = intClientID
                    db.client_Communication.Add(item)
                    db.SaveChanges()
                    Session.Add("CommunicationSuccess", "True")
                    Response.Redirect(String.Format("~/ClientPages/CommunicationHistory.aspx?clientid={0}", intClientID.ToString()), False)
                End Using
            Catch ex As Exception
                LogHelper.LogError("Error adding communication.", "Comminication.aspx", ex)
                Session.Add("ErrorMessage", "Error adding communication.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    ' The id parameter should match the DataKeyNames value set on the control
    ' or be decorated with a value provider attribute, e.g. <QueryString>ByVal id as Integer
    Public Function ForViewCommunication_GetItem() As TBTracing.client_Communication
        Try
            Dim result As client_Communication = Nothing
            Using db As New TBTracingEntities
                result = db.client_Communication.Find(intCommID)
            End Using
            Return result
        Catch ex As Exception
            LogHelper.LogError("Error getting communication for update.", "Communication.aspx", ex)
            Session.Add("ErrorMessage", "Error getting communication details.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    ' The id parameter name should match the DataKeyNames value set on the control
    Public Sub ForViewCommunication_UpdateItem()
        Dim item As client_Communication = New client_Communication()
        TryUpdateModel(item)
        If ModelState.IsValid Then
            item.ClientID = intClientID
            item.ID = intCommID

            Try
                Dim db As IClientDA = New ClientDAImpl
                db.UpdateCommunication(item)
                Session.Add("CommunicationSuccess", "True")
                Response.Redirect(String.Format("~/ClientPages/CommunicationHistory?clientid={0}", intClientID), False)
            Catch ex As Exception
                LogHelper.LogError("Error updating communication.", "Communication.aspx", ex)
                Session.Add("ErrorMessage", "Error updating communication.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "Form Databound"
    Protected Sub ForViewCommunication_DataBound(sender As Object, e As EventArgs) Handles ForViewCommunication.DataBound
        Dim addButton As LinkButton = ForViewCommunication.FindControl("addButton")
        Dim updateButton As LinkButton = ForViewCommunication.FindControl("updateButton")
        Dim cancelButton As HyperLink = ForViewCommunication.FindControl("lnkCancelButton")

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        If IsNothing(intCommID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If
    End Sub
#End Region

End Class