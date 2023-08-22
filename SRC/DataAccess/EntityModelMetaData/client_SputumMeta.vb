Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_SputumMeta))> _
Partial Public Class client_Sputum

End Class

Public Class client_SputumMeta

    <DataType(DataType.Date, ErrorMessage:="Invalid <strong>Collected Date</strong>")> _
    <Required(ErrorMessage:="Collected Date is Required.")> _
    Public Property CollectedDate As Nullable(Of Date)

    <DataType(DataType.Date, ErrorMessage:="Invalid <strong>Result Date</strong>")> _
    Public Property ResultDate As Nullable(Of Date)

    <RestrictXSS(ErrorMessage:="Sputum Test <strong>comments</strong> contains bad characters")> _
    <StringLength(2000, ErrorMessage:="Sputum Test <strong>comments</strong> must be 2000 characters or less")> _
    Public Property Comments As String

    <StringLength(500, ErrorMessage:="Other test reason must be 500 characters or less.")> _
    <RestrictXSS(ErrorMessage:="Other test reason field contains bad characters.")> _
    Public Property ReasonForTestingOther As String

End Class
