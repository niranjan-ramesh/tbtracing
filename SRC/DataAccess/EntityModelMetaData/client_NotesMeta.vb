Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_NotesMeta))> _
Partial Public Class client_Notes

End Class

Public Class client_NotesMeta

    <RestrictXSS(ErrorMessage:="<strong>Label</strong> field contains bad characters. ")> _
    <StringLength(50, ErrorMessage:="<strong>Label</strong> must be 50 characters or less.")> _
    <Required(ErrorMessage:="<strong>Label</strong> is required")> _
    Public Property NoteLabel As String

    <RestrictXSS(ErrorMessage:="<strong>Notes</strong> contains bad characters. ")> _
    <StringLength(1000, ErrorMessage:="<strong>Notes</strong> must be 1000 characters or less.")> _
    <Required(ErrorMessage:="<strong>Note</strong> Details are required")> _
    Public Property NoteText As String

End Class
