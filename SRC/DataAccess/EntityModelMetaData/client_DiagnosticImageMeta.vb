Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_DiagnosticImageMeta))> _
Partial Public Class client_DiagnosticImage

End Class

Public Class client_DiagnosticImageMeta
    Public Property ID As Integer
    Public Property ExamDate As Nullable(Of Date)

    Public Property ViewID As Nullable(Of Integer)

    Public Property AreaID As Nullable(Of Integer)

    Public Property IndicationID As Nullable(Of Integer)

    Public Property ResultID As Nullable(Of Integer)

    <StringLength(5000, ErrorMessage:="Findings must be 5000 characters or less.")> _
    Public Property Findings As String

    Public Property ClientID As Nullable(Of Integer)

    Public Property ReasonForTesting As Nullable(Of Integer)

    <StringLength(200, ErrorMessage:="Other Reason for Testing must be 200 characters or less.")> _
    Public Property ReasonForTestingOther As String

    <StringLength(200, ErrorMessage:="Other Procedure must be 200 characters or less.")> _
    <RestrictXSS(ErrorMessage:="Other Procedure field contains bad characters.")> _
    Public Property OtherProcedure As String

End Class
