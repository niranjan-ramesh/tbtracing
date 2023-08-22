Public Class ClinicAppointmentGridLineItem
    Inherits clinic_TBClinicAppointments

    Public Property strClientName As String
    Public Property strPhysicianName As String
    Public Property strLanguage As String
    Public Property strReason As String
    Public Property strCompletedByName As String

    Public Sub New(ByRef baseClass As clinic_TBClinicAppointments)
        MyBase.ID = baseClass.ID
        MyBase.ClinicID = baseClass.ClinicID
        MyBase.Time = baseClass.Time
        MyBase.ClientID = baseClass.ClientID
        MyBase.PhysicianID = baseClass.PhysicianID
        MyBase.Reason = baseClass.Reason
        MyBase.Language = baseClass.Language
        MyBase.Comments = baseClass.Comments
        MyBase.Complete = baseClass.Complete
        MyBase.CompletedDate = baseClass.CompletedDate
        MyBase.CompletedByID = baseClass.CompletedByID
    End Sub

    Public Sub New()

    End Sub

End Class
