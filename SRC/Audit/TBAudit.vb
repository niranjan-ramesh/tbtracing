Imports Microsoft.AspNet.Identity
Imports System.Web

Public Class TBAudit

    Shared Sub New()
        LoginType = My.Settings.audit_Login
        LogoutType = My.Settings.audit_Logout
        AddEditDemographic = My.Settings.audit_AddEditDemographic
        AddClient = My.Settings.audit_AddEditDemographic
        AddEditSkinTest = My.Settings.audit_AddEditSkinTest
        AddEditSputum = My.Settings.audit_AddEditSputum
        AddEditCommunication = My.Settings.audit_AddEditCommunication
        AddEditSymptoms = My.Settings.audit_AddEditSymptoms
        AddEditIGRA = My.Settings.audit_AddEditIGRA
        AddEditBloodwork = My.Settings.audit_AddEditBloodwork
        AddEditNote = My.Settings.audit_AddEditNote
        AddEditRisks = My.Settings.audit_AddEditRisks
        AddEditFollowup = My.Settings.audit_AddEditFollowup
        AddEditContactTracing = My.Settings.audit_AddEditContactTracing
        AddEditOutcome = My.Settings.audit_AddEditOutcome
        AddEditTreatment = My.Settings.audit_AddEditTreatment
        AddEditClinic = My.Settings.audit_AddEditClinic
        AddEditXrayImagine = My.Settings.audit_AddEditXrayImagine
        PageView = My.Settings.audit_PageView
    End Sub

    Public Shared ReadOnly LoginType As Integer
    Public Shared ReadOnly LogoutType As Integer
    Public Shared ReadOnly AddEditDemographic As Integer
    Public Shared ReadOnly AddClient As Integer
    Public Shared ReadOnly AddEditSkinTest As Integer
    Public Shared ReadOnly AddEditSputum As Integer
    Public Shared ReadOnly AddEditCommunication As Integer
    Public Shared ReadOnly AddEditIGRA As Integer
    Public Shared ReadOnly AddEditBloodwork As Integer
    Public Shared ReadOnly AddEditSymptoms As Integer
    Public Shared ReadOnly AddEditNote As Integer
    Public Shared ReadOnly AddEditRisks As Integer
    Public Shared ReadOnly AddEditFollowup As Integer
    Public Shared ReadOnly AddEditContactTracing As Integer
    Public Shared ReadOnly AddEditOutcome As Integer
    Public Shared ReadOnly AddEditTreatment As Integer
    Public Shared ReadOnly AddEditClinic As Integer
    Public Shared ReadOnly AddEditXrayImagine As Integer
    Public Shared ReadOnly PageView As Integer

    Public Shared Sub addAudit(ByRef auditType As Integer, ByRef strTitle As String, ByRef strDetails As String, ByRef intClientID As Nullable(Of Integer))
        Try
            Using db As New TBTracingEntities
                Dim objAudit As New Audit()
                objAudit.AuditDate = DateTime.Now
                objAudit.AuditTitle = strTitle
                objAudit.AuditDetails = strDetails
                objAudit.AuditType = auditType

                'Dim manager = New UserManager()
                'Dim selectedUser As ApplicationUser = manager.FindByName(HttpContext.Current.User.Identity.Name)
                'Dim userDisplayName As String = selectedUser.FirstName & " " & selectedUser.LastName

                Dim userName As String = "N/A"
                If Not IsNothing(HttpContext.Current.User) Then
                    userName = HttpContext.Current.User.Identity.Name
                End If


                objAudit.AuditUser = userName

                If Not IsNothing(intClientID) Then
                    objAudit.ClientID = intClientID
                End If

                db.Audit.Add(objAudit)
                db.SaveChanges()
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error adding audit details.", "Audit Error", ex)
        End Try
    End Sub


End Class
