Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_OutcomeTreatmentRegimenMeta))> _
Partial Public Class client_OutcomeTreatmentRegimen

End Class

Public Class client_OutcomeTreatmentRegimenMeta

    <DataType(DataType.Date, ErrorMessage:="Invalid Start Date.")> _
    Public Property StartDate As Nullable(Of Date)

    <DataType(DataType.Date, ErrorMessage:="Invalid End Date.")> _
    Public Property EndDate As Nullable(Of Date)

    <RestrictXSS(ErrorMessage:="Invalid characters in followup notes.")> _
    <StringLength(250, ErrorMessage:="Notes must be 250 characters or less.")> _
    Public Property Notes As String

    <Required(ErrorMessage:="Treatment status required.")> _
    Public Property StatusID As Nullable(Of Integer)

    <Required(ErrorMessage:="Medication required.")> _
    Public Property MedicationID As Nullable(Of Integer)

End Class
