Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_SkinTestMeta))> _
Partial Public Class client_SkinTest

End Class

Public Class client_SkinTestMeta

    <DataType(DataType.Date, ErrorMessage:="Invalid Date Read.")> _
    Public Property DateRead As Nullable(Of Date)

    <DataType(DataType.Date, ErrorMessage:="Invalid Date Placed.")> _
    Public Property DatePlaced As Nullable(Of Date)

    <RestrictXSS(ErrorMessage:="Test comments contains bad characters.")> _
    <StringLength(2000, ErrorMessage:="Test comments must be 2000 characters or less.")> _
    Public Property Comments As String

    <RestrictXSS(ErrorMessage:="Result comments contains bad characters.")> _
    <StringLength(2000, ErrorMessage:="Result comments must be 2000 characters or less.")> _
    Public Property CommentsResult As String

    <StringLength(25, ErrorMessage:="Induration must be 25 characters or less.")> _
    <RestrictXSS(ErrorMessage:="Induration field contains bad characters.")> _
    Public Property Iduration As String

    <DataType(DataType.Date, ErrorMessage:="Invalid Followup Date.")> _
    Public Property FollowUpDate As Nullable(Of Date)

    <StringLength(500, ErrorMessage:="Other test reason must be 500 characters or less.")> _
    <RestrictXSS(ErrorMessage:="Other test reason field contains bad characters.")> _
    Public Property TestReasonOther As String

    <StringLength(100, ErrorMessage:="Read By must be 100 characters or less.")> _
    <RestrictXSS(ErrorMessage:="Read By contains bad characters.")> _
    Public Property ReadByText As String


End Class
