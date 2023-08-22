Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_OutcomeMeta))> _
Partial Public Class client_Outcome

End Class

Public Class client_OutcomeMeta

    <Required(ErrorMessage:="Outcome type is required.")> _
    Public Property Outcome As Nullable(Of Integer)

    <DataType(DataType.Date, ErrorMessage:="Invalid Determination Date.")> _
    <Required(ErrorMessage:="Outcome Determination Date Required.")> _
    Public Property OutcomeDeterminationDate As Nullable(Of Date)

    <RestrictXSS(ErrorMessage:="Comments box has bad characters. ")> _
    <StringLength(5000, ErrorMessage:="Comments must be 5000 characters or less.")> _
    Public Property Comments As String

    <RestrictXSS(ErrorMessage:="Transfer destination has bad characters. ")> _
    <StringLength(200, ErrorMessage:="Transfer destination must be 200 characters or less.")> _
    Public Property TransferDestination As String

End Class

