Public Class ContactHistory
    Inherits System.Web.UI.Page

    Private intClientID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkAddNew.NavigateUrl = String.Format(lnkAddNew.NavigateUrl, intClientID.ToString())
        Else
            LogHelper.LogInfo("Missing client id.", "ContactHistory.aspx")
            Session.Add("ErrorMessage", "Missing Client ID.")
            Response.Redirect("~/ErrorPage.aspx")
        End If

        If Not IsNothing(Session.Item("ContactSuccess")) Then
            pnlSuccess.Visible = True
            Session.Remove("ContactSuccess")
        Else
            pnlSuccess.Visible = False
        End If
    End Sub
#End Region

#Region "History Grid"
    Public Function gvHistory_GetData() As IQueryable(Of ContactTracingHistoryGrid)
        Dim db As IClientDA = New ClientDAImpl()
        Return db.GetContactTracingHistory(intClientID).AsQueryable()
    End Function

    ' The id parameter name should match the DataKeyNames value set on the control
    Public Sub gvHistory_DeleteItem(ByVal TraceID As Integer)
        Try
            Using db As New TBTracingEntities
                Dim objContact As client_ContactTracing = db.client_ContactTracing.Find(TraceID)

                TBAudit.addAudit(TBAudit.AddEditContactTracing, "Deleting contact tracing for Client ID:" & intClientID.ToString(), "Delete contact tracing ID: " & id.ToString(), intClientID)
                objContact.Active = False

                db.SaveChanges()
                Response.Redirect(Request.RawUrl, False)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error deleting contact.", "ContactHistory.aspx", ex)
            Session.Add("ErrorMessage", "Error Deleting Contact.")
            Response.Redirect("~/ErrorPage.aspx")
        End Try
    End Sub

#End Region

#Region "Notes Grid"
    Public Function gvNotes_GetData() As IQueryable(Of TBTracing.client_ContactNote)
        Dim db As New TBTracingEntities()
        Return db.client_ContactNote.Where(Function(p) p.ClientID = intClientID And p.Active = True)
    End Function

    Public Sub fvContactNotes_InsertItem()
        Dim item = New TBTracing.client_ContactNote()
        item.ClientID = intClientID

        TryUpdateModel(item)
        item.Active = True
        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.AddContactNote(item)
                gvNotes.DataBind()
            Catch ex As Exception
                LogHelper.LogError("Error adding contact note.", "ContactHistory.aspx", ex)
                Session.Add("ErrorMessage", "Error adding contact note information.")
                Response.Redirect("~/ErrorPage.aspx")
            End Try
        End If
    End Sub

    ' The id parameter name should match the DataKeyNames value set on the control
    Public Sub gvNotes_UpdateItem(ByVal id As Integer)
        Dim item As client_ContactNote = New client_ContactNote()
        item.ClientID = intClientID

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Dim db As IClientDA = New ClientDAImpl()
            db.UpdateContactNote(item)
        End If
    End Sub

    ' The id parameter name should match the DataKeyNames value set on the control
    Public Sub gvNotes_DeleteItem(ByVal id As Integer)
        Using db As New TBTracingEntities
            Dim noteToDelete As client_ContactNote = db.client_ContactNote.Find(id)

            If Not IsNothing(noteToDelete) Then
                noteToDelete.Active = False
                db.SaveChanges()
            End If

        End Using
    End Sub

#End Region

#Region "GV CSS"

#End Region
    Protected Sub gvHistory_PreRender(sender As Object, e As EventArgs)
        If Not IsNothing(gvHistory) AndAlso Not IsNothing(gvHistory.HeaderRow) Then gvHistory.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub

    Protected Sub gvNotes_PreRender(sender As Object, e As EventArgs)
        If Not IsNothing(gvNotes) AndAlso Not IsNothing(gvNotes.HeaderRow) Then gvNotes.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub



End Class