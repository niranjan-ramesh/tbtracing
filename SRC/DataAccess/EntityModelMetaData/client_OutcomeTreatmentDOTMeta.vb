Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_OutcomeTreatmentDOTMeta))> _
Partial Public Class client_OutcomeTreatmentDOT

End Class

Public Class client_OutcomeTreatmentDOTMeta

    <DataType(DataType.Date, ErrorMessage:="Invalid Exam Date.")> _
    <Required(ErrorMessage:="DOT Date Required.")> _
    Public Property DOTDate As Nullable(Of Date)


End Class
