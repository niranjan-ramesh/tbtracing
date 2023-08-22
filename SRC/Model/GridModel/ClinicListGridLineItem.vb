Public Class ClinicListGridLineItem
    Inherits clinic_TBClinic

    Public Property strPhysicianName As String
    Public Property strClinicDate As String
    Public Property intNumberOfAppointments As Integer

    Public Sub New(ByRef baseClass As clinic_TBClinic)
        MyBase.ID = baseClass.ID
        MyBase.ClinicDate = baseClass.ClinicDate
        MyBase.StartTime = baseClass.StartTime
        MyBase.EndTime = baseClass.EndTime
        MyBase.PhysicianID = baseClass.PhysicianID
        MyBase.Comments = baseClass.Comments
        MyBase.clinic_TBClinicAppointments = baseClass.clinic_TBClinicAppointments
    End Sub

    Public Sub New()

    End Sub
End Class
