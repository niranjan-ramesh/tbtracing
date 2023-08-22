Imports System.IO

Public Class DocsNotes
    Inherits System.Web.UI.Page

    Private intClientID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Check for Client ID
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkAddNote.NavigateUrl = String.Format(lnkAddNote.NavigateUrl, intClientID.ToString())
        Else
            Session.Add("ErrorMessage", "Error Retrieving Documents and Notes")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("NoteSuccess")) Then
            'Display success panel.
            pnlSuccess.Visible = True
            Session.Remove("NoteSuccess")
        Else
            pnlSuccess.Visible = False
        End If


        ' Bind GridViews
        'Dim db As IClientDA = New ClientDAImpl()
        'gvNotesHistory.DataSource = db.GetNotesHistory(intClientID)
        'gvNotesHistory.DataBind()
    End Sub

    Private Sub gvNotesHistory_PreRender(sender As Object, e As EventArgs) Handles gvNotesHistory.PreRender
        If gvNotesHistory.Rows.Count > 0 Then
            gvNotesHistory.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

    Private Sub gvNotesHistory_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvNotesHistory.RowCommand
        Dim index As Integer = Convert.ToInt32(e.CommandArgument)
        Dim noteID As Integer = gvNotesHistory.DataKeys(index).Value
        Dim noteToDownload As NotesGridLineItem = Nothing

        Try
            'If e.CommandName = "SelectNote" Then
            '    Dim db As IClientDA = New ClientDAImpl()
            '    docToDownload = db.GetDocument(docID)

            '    If Not docToDownload Is Nothing Then
            '        Dim docFullName As String = docToDownload.documentName & "." & docToDownload.documentType

            '        Response.Clear()
            '        Response.Buffer = True
            '        Response.Charset = ""
            '        Response.ContentType = docToDownload.documentMime
            '        Response.AddHeader("Content-Disposition", "attachment; filename=" + docFullName)
            '        Response.OutputStream.Write(docToDownload.documentContent, 0, docToDownload.documentContent.Length)
            '        Response.Flush()
            '        Response.End()
            '    End If
            'End If
        Catch ex As Exception
            LogHelper.LogError("Error Downloading Document", "DocsNotes.aspx", ex)
            Session.Add("ErrorMessage", "Error Downloading Document.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try

    End Sub

    Public Sub gvNotesHistory_DeleteItem(ID As Integer)
        'This is only a "soft" delete, just set Active to False
        Dim noteID As Integer = ID

        Using db As New TBTracingEntities
            Dim noteToDelete As client_Notes = db.client_Notes.Find(noteID)

            TryUpdateModel(noteToDelete)

            noteToDelete.ClientID = intClientID
            noteToDelete.ID = ID
            noteToDelete.Active = False

            If ModelState.IsValid Then
                Try
                    Dim db2 As IClientDA = New ClientDAImpl()
                    db2.DeleteNote(noteToDelete, noteID)
                    Response.Redirect("~/ClientPages/DocsNotes?clientid=" & intClientID, False)
                Catch dataEX As TBDataAccessException
                    LogHelper.LogError("DB Error updating Note.", "DocsNotes.aspx", dataEX)
                    Session.Add("ErrorMessage", "Error Deleting Note")
                    Response.Redirect("~/ErrorPage.aspx", False)
                Catch ex As Exception
                    LogHelper.LogError("General Error updating Document.", "DocsNotes.aspx", ex)
                    Session.Add("ErrorMessage", "Error Deleting Note")
                    Response.Redirect("~/ErrorPage.aspx", False)
                End Try
            End If
        End Using
    End Sub

    Public Function gvNotesHistory_GetData() As IEnumerable(Of TBTracing.NotesGridLineItem)
        Dim docList As List(Of NotesGridLineItem) = Nothing

        Try
            Dim db As IClientDA = New ClientDAImpl()
            docList = db.GetNotesHistory(intClientID)

        Catch ex As Exception
            LogHelper.LogError("Error getting notes for client.", "DocsNotes.aspx", ex)
            Session.Add("ErrorMessage", "Error Retrieving Client's Notes")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try

        Return docList
    End Function

    Private Sub gvDocumentsHistory_PreRender(sender As Object, e As EventArgs) Handles gvDocumentsHistory.PreRender
        If gvDocumentsHistory.Rows.Count > 0 Then
            gvDocumentsHistory.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

    Private Sub gvDocumentsHistory_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvDocumentsHistory.RowCommand
        Dim index As Integer = Convert.ToInt32(e.CommandArgument)
        Dim docID As Integer = gvDocumentsHistory.DataKeys(index).Value
        Dim docToDownload As DocumentsGridLineItem = Nothing

        Try
            If e.CommandName = "SelectDoc" Then
                Dim db As IClientDA = New ClientDAImpl()
                docToDownload = db.GetDocument(docID)

                If Not docToDownload Is Nothing Then
                    Dim docFullName As String = docToDownload.documentName & "." & docToDownload.documentType

                    Response.Clear()
                    Response.Buffer = True
                    Response.Charset = ""
                    Response.ContentType = docToDownload.documentMime
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + docFullName)
                    Response.OutputStream.Write(docToDownload.documentContent, 0, docToDownload.documentContent.Length)
                    Response.Flush()
                    Response.End()
                End If
            End If
        Catch ex As Exception
            LogHelper.LogError("Error Downloading Document", "DocsNotes.aspx", ex)
            Session.Add("ErrorMessage", "Error Downloading Document.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try

    End Sub

    Public Sub DocumentFormView_InsertItem()
        Dim docFileUpload As FileUpload = DocumentFormView.FindControl("fuAddDocument")
        Dim docValidator As CustomValidator = DocumentFormView.FindControl("fileUploadValidator")
        Dim docFileName As TextBox = DocumentFormView.FindControl("tbFileName")

        'Check if File was selected
        If docFileUpload.PostedFile Is Nothing OrElse String.IsNullOrEmpty(docFileUpload.PostedFile.FileName) OrElse docFileUpload.PostedFile.InputStream Is Nothing Then
            docValidator.IsValid = False
            docValidator.ErrorMessage = "Invalid file type to upload"
        End If

        Validate()

        ' NEED TO FIGURE OUT HOW TO GET THIS INFO FROM common_DocumentType table
        If Page.IsValid Then
            Dim extension As String = Path.GetExtension(docFileUpload.PostedFile.FileName).ToLower()
            Dim MIMEType As String = Nothing
            Dim docExtension As String = ""
            Dim docType As Integer
            Select Case extension
                Case ".pdf"
                    MIMEType = "application/pdf"
                    docExtension = "pdf"
                    docType = 1
                Case ".doc"
                    MIMEType = "application/msword"
                    docExtension = "doc"
                    docType = 2
                Case ".docx"
                    MIMEType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                    docExtension = "docx"
                    docType = 4
                Case ".xls"
                    'MIMEType = "application/excel"
                    MIMEType = "application/vnd.ms-excel"
                    docExtension = "xls"
                    docType = 5
                Case ".xlsx"
                    MIMEType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                    docExtension = "xlsx"
                    docType = 6
                Case ".zip"
                    MIMEType = "application/zip"
                    docExtension = "zip"
                    docType = 7
                Case ".txt"
                    MIMEType = "text/plain"
                    docExtension = "txt"
                    docType = 8
                Case ".msg"
                    MIMEType = "application/vnd.ms-outlook"
                    docExtension = "msg"
                    docType = 9
                Case Else
                    docValidator.IsValid = False
                    docValidator.ErrorMessage = "Invalid File to Upload"
            End Select

            'Save document to db
            If docValidator.IsValid Then
                Try
                    Dim item = New TBTracing.client_Document()
                    TryUpdateModel(item)

                    If ModelState.IsValid Then
                        Try
                            item.ClientID = intClientID
                            item.DocumentType = docType
                            item.DocumentContents = docFileUpload.FileBytes
                            Dim db As IClientDA = New ClientDAImpl()
                            db.AddDocument(item)
                            Response.Redirect("~/ClientPages/DocsNotes?clientid=" & intClientID, False)
                        Catch dataEx As TBDataAccessException
                            LogHelper.LogError("Data access error adding Document", "DocsNotes.aspx", dataEx)
                            Session.Add("ErrorMessage", "Error Saving Document")
                            Response.Redirect("~/ErrorPage.aspx", False)
                        Catch ex As Exception
                            LogHelper.LogError("Generic Error Adding Document", "DocsNotes.aspx", ex)
                            Session.Add("ErrorMessage", "Error Saving Document")
                            Response.Redirect("~/ErrorPage.aspx", False)
                        End Try
                    End If
                Catch ex As Exception
                    LogHelper.LogError("Error adding Document.", "DocsNotes.aspx", ex)
                    Session.Add("ErrorMessage", "Error Saving IGRA")
                    Response.Redirect("~/ErrorPage.aspx", False)
                End Try
            End If
        End If

        If Not Page.IsValid Then
            'Input failed validation.  Display validation summary.
            docValidationSummary.Visible = True
            docValidationSummary.ShowSummary = True
        End If

    End Sub

    Public Function gvDocumentsHistory_GetData() As IEnumerable(Of TBTracing.DocumentsGridLineItem)
        Dim docList As List(Of DocumentsGridLineItem) = Nothing

        Try
            Dim db As IClientDA = New ClientDAImpl()
            docList = db.GetDocumentList(intClientID)

        Catch ex As Exception
            LogHelper.LogError("Error getting documents for client.", "DocsNotes.aspx", ex)
            Session.Add("ErrorMessage", "Error Retrieving Client's Documents")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try

        Return docList
    End Function

    Public Sub gvDocumentsHistory_DeleteItem(ID As Integer)
        'This is only a "soft" delete, just set Active to False
        Dim docID As Integer = ID

        Using db As New TBTracingEntities
            Dim docToDelete As client_Document = db.client_Document.Find(docID)

            TryUpdateModel(docToDelete)

            docToDelete.ClientID = intClientID
            docToDelete.ID = ID
            docToDelete.Active = False

            If ModelState.IsValid Then
                Try
                    Dim db2 As IClientDA = New ClientDAImpl()
                    db2.DeleteDocument(docToDelete, docID)
                    Response.Redirect("~/ClientPages/DocsNotes?clientid=" & intClientID, False)
                Catch dataEX As TBDataAccessException
                    LogHelper.LogError("DB Error updating Document.", "DocsNotes.aspx", dataEX)
                    Session.Add("ErrorMessage", "Error Deleting Document")
                    Response.Redirect("~/ErrorPage.aspx", False)
                Catch ex As Exception
                    LogHelper.LogError("General Error updating Document.", "DocsNotes.aspx", ex)
                    Session.Add("ErrorMessage", "Error Deleting Document")
                    Response.Redirect("~/ErrorPage.aspx", False)
                End Try
            End If
        End Using
    End Sub

End Class