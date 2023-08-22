Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_CommunicationMeta))> _
Partial Public Class client_Communication

End Class

Public Class client_CommunicationMeta

    <RestrictXSS(ErrorMessage:="First name contains bad characters. ")> _
    <StringLength(1000, ErrorMessage:="Comments must be 1000 characters or less.")> _
    Public Property Comments As String

    <RestrictXSS(ErrorMessage:="Contacted By has bad characters. ")> _
    <StringLength(1000, ErrorMessage:="Contacted By must be 200 characters or less.")> _
    Public Property ContactedByName As String

    <Required(ErrorMessage:="Communication Date Required.")> _
    Public Property CommunicationDateTime As Nullable(Of Date)
End Class

