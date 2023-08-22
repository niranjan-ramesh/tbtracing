Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(clinic_TBClinicAppointmentsMeta))> _
Public Class clinic_TBClinicAppointments

End Class

Public Class clinic_TBClinicAppointmentsMeta

    <DataType(DataType.Date, ErrorMessage:="Invalid <strong>Appointment Time</strong>")> _
    <Required(ErrorMessage:="<strong>Appointment Time</strong> is required.")> _
    Public Property Time As Nullable(Of TimeSpan)

    <Required(ErrorMessage:="<strong>Client</strong> is required.")> _
    Public Property ClientID As Nullable(Of Integer)

    <Required(ErrorMessage:="<strong>Physician</strong> is required.")> _
    Public Property PhysicianID As Nullable(Of Integer)

    <RestrictXSS(ErrorMessage:="<strong>Comments</strong> contains bad characters.")> _
    <StringLength(500, ErrorMessage:="<strong>Comments</strong> must be 500 characters or less.")> _
    Public Property Comments As String

End Class
