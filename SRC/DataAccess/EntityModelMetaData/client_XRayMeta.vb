Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_XRayMeta))> _
Partial Public Class client_XRay

End Class

Public Class client_XRayMeta

    <DataType(DataType.Date, ErrorMessage:="Invalid <strong>Exam Date</strong>")> _
    Public Property ExamDate As Nullable(Of Date)

    <RestrictXSS(ErrorMessage:="Notes for <strong>Infiltrate</strong> contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for <strong>Infiltrate</strong> must be 500 characters of less.")> _
    Public Property InfiltrateYesNoNotes As String

    <RestrictXSS(ErrorMessage:="Notes for <strong>Any cavitary lesion</strong> contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for <strong>Any cavitary lesion</strong> must be 500 characters of less.")> _
    Public Property CavitaryLessionNotes As String

    <RestrictXSS(ErrorMessage:="Notes for <strong>Nodule with poorly defined margins</strong> contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for <strong>Nodule with poorly defined margins</strong> must be 500 characters of less.")> _
    Public Property NoduleNotes As String

    <RestrictXSS(ErrorMessage:="Notes for <strong>Pleural effusion</strong> contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for <strong>Pleural effusion</strong> must be 500 characters of less.")> _
    Public Property PleuralEffusionNotes As String

    <RestrictXSS(ErrorMessage:="Notes for <strong>Hilar or mediastinal Lymphadenopathy</strong> contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for <strong>Hilar or mediastinal Lymphadenopathy</strong> must be 500 characters of less.")> _
    Public Property HilarLymphadenopathyNotes As String

    <RestrictXSS(ErrorMessage:="Notes for <strong>Linear interstital disease</strong> contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for <strong>Linear interstital disease</strong> must be 500 characters of less.")> _
    Public Property LinearDiseaseNotes As String

    <RestrictXSS(ErrorMessage:="X-Ray <strong>comments</strong> contains bad characters.")> _
    <StringLength(5000, ErrorMessage:="X-Ray <strong>comments</strong> must be 5000 characters or less.")> _
    Public Property Comments As String

    <StringLength(500, ErrorMessage:="Other test reason must be 500 characters or less.")> _
    <RestrictXSS(ErrorMessage:="Other test reason field contains bad characters.")> _
    Public Property ReasonForTestingOther As String

End Class
