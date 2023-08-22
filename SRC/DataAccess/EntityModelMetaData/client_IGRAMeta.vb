Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_IGRAMeta))> _
Partial Public Class client_IGRA

End Class
Public Class client_IGRAMeta

    <DataType(DataType.Date, ErrorMessage:="Invalid <strong>Collected Date</strong>")> _
    <Required(ErrorMessage:="<strong>Collected Date</strong> is required/.")> _
    Public Property CollectionDate As Nullable(Of Date)

    <DataType(DataType.Date, ErrorMessage:="Invalid <strong>Result Date</strong>")> _
    Public Property ResultDate As Nullable(Of Date)

    <RestrictXSS(ErrorMessage:="IGRA <strong>comments</strong> contains bad characters.")> _
    <StringLength(5000, ErrorMessage:="IGRA <strong>comments</strong> must be 5000 characters or less.")> _
    Public Property Comments As String

    <StringLength(500, ErrorMessage:="Other test reason must be 500 characters or less.")> _
    <RestrictXSS(ErrorMessage:="Other test reason field contains bad characters.")> _
    Public Property ReasonForTestingOther As String

End Class
