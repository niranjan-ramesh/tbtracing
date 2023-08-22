Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_ContactTracingMeta))> _
Partial Public Class client_ContactTracing

End Class

Public Class client_ContactTracingMeta

    <RestrictXSS(ErrorMessage:="First name contains bad characters. ")> _
    <StringLength(5000, ErrorMessage:="Comments must be 5000 characters or less.")> _
    Public Property Comments As String

    <DataType(DataType.DateTime, ErrorMessage:="Invalid Date")> _
    Public Property FromDate As Nullable(Of Date)

    <DataType(DataType.DateTime, ErrorMessage:="Invalid Date")> _
    Public Property ToDate As Nullable(Of Date)

    <DataType(DataType.DateTime, ErrorMessage:="Invalid Date")> _
    Public Property LastContact As Nullable(Of Date)


End Class
