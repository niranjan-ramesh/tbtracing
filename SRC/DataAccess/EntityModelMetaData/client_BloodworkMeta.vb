Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_BloodworkMeta))> _
Partial Public Class client_Bloodwork

End Class

Public Class client_BloodworkMeta

    <DataType(DataType.Date, ErrorMessage:="Invalid <strong>Collected Date</strong>")> _
    <Required(ErrorMessage:="Collected Date is Required.")> _
    Public Property CollectedDate As Nullable(Of Date)

    <DataType(DataType.Date, ErrorMessage:="Invalid <strong>Result Date</strong>")> _
    Public Property ResultDate As Nullable(Of Date)

    <RestrictXSS(ErrorMessage:="Bloodwork <strong>comments</strong> contains bad characters")> _
    <StringLength(5000, ErrorMessage:="Bloodwork <strong>comments</strong> must be 5000 characters or less")> _
    Public Property Comments As String

    <StringLength(500, ErrorMessage:="Other test reason must be 500 characters or less.")> _
    <RestrictXSS(ErrorMessage:="Other test reason field contains bad characters.")> _
    Public Property ReasonForTestingOther As String

End Class
