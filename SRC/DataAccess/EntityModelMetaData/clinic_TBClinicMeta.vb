Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(clinic_TBClinicMeta))> _
Public Class clinic_TBClinic

End Class

Public Class clinic_TBClinicMeta

    <DataType(DataType.Date, ErrorMessage:="Invalid <strong>Clinic Date</strong>")> _
    <Required(ErrorMessage:="<strong>Clinic Date</strong> is required.")> _
    Public Property ClinicDate As Nullable(Of Date)

    <Required(ErrorMessage:="<strong>Physician</strong> is required.")> _
    Public Property PhysicianID As Nullable(Of Integer)

    <RestrictXSS(ErrorMessage:="<strong>Comments</strong> contains bad characters.")> _
    <StringLength(5000, ErrorMessage:="<strong>Comments</strong> must be 5000 characters or less.")> _
    Public Property Comments As String

End Class