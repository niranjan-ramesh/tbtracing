Public Class Notes
    Inherits System.Web.UI.Page

    Private intNotesID As Nullable(Of Integer)
    Private intClientID As Integer

#Region "Page Load"
    Private Sub Notes_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        ' Check for Note ID
        If Not IsNothing(Request.Params("noteid")) AndAlso IsNumeric(Request.Params("noteid")) Then
            intNotesID = Integer.Parse(Request.Params("noteid"))
        End If

        ' Check for Client ID
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error Retrieving Note")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        ' Change FormView mode depending on whether Note ID is passed
        If IsNothing(intNotesID) Then
            NotesFormView.InsertItemTemplate = NotesFormView.EditItemTemplate
            NotesFormView.DefaultMode = FormViewMode.Insert
        Else
            NotesFormView.EditItemTemplate = NotesFormView.EditItemTemplate
            NotesFormView.DefaultMode = FormViewMode.Edit
        End If
    End Sub
#End Region

#Region "Note CRUD"
    Public Sub NotesFormView_InsertItem()
        Dim item = New TBTracing.client_Notes()
        item.ClientID = intClientID

        TryUpdateModel(item)
        item.Active = True
        item.DateAdded = DateTime.Now

        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.AddNote(item)
                Session.Add("NoteSuccess", "True")
                Response.Redirect("~/ClientPages/DocsNotes?clientid=" & intClientID.ToString(), False)
            Catch ex As Exception
                LogHelper.LogError("Error adding Note.", "Notes.aspx", ex)
                Session.Add("ErrorMessage", "Error Saving Note")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function NotesFormView_GetItem() As TBTracing.client_Notes
        Try
            Using db As New TBTracingEntities
                Dim noteToUpdate As client_Notes = db.client_Notes.Find(intNotesID)
                Return noteToUpdate
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting Note for update", "Notes Error", ex)
            Session.Add("ErrorMessage", "Error Retrieving Note")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub NotesFormView_UpdateItem()
        Dim item As client_Notes = New client_Notes()
        TryUpdateModel(item)

        If ModelState.IsValid Then
            item.ClientID = intClientID
            item.ID = intNotesID
            item.Active = True
            item.DateAdded = DateTime.Now
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateNote(item, intNotesID)
                Session.Add("NoteSuccess", "True")
                Response.Redirect(String.Format("~/ClientPages/DocsNotes?clientid={0}", intClientID.ToString()), False)
            Catch dataEX As TBDataAccessException
                LogHelper.LogError("DB Error updating Note.", "Notes.aspx", dataEX)
                Session.Add("ErrorMessage", "Error Updating Note")
                Response.Redirect("~/ErrorPage.aspx")
            Catch ex As Exception
                LogHelper.LogError("General Error udpating Note.", "Notes.aspx", ex)
                Session.Add("ErrorMessage", "Error Updating Note")
                Response.Redirect("~/ErrorPage.aspx")
            End Try
        End If
    End Sub
#End Region

#Region "ForView binding"
    Protected Sub NotesFormView_DataBound(sender As Object, e As EventArgs)
        Dim addButton As LinkButton = NotesFormView.FindControl("addButton")
        Dim updateButton As LinkButton = NotesFormView.FindControl("updateButton")
        Dim cancelButton As HyperLink = NotesFormView.FindControl("lnkCancelButton")

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        If IsNothing(intNotesID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If
    End Sub
#End Region


End Class