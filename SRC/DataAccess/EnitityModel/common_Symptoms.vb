'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated from a template.
'
'     Manual changes to this file may cause unexpected behavior in your application.
'     Manual changes to this file will be overwritten if the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Imports System
Imports System.Collections.Generic

Partial Public Class common_Symptoms
    Public Property ID As Integer
    Public Property Symptom As String
    Public Property Active As Nullable(Of Boolean)

    Public Overridable Property client_OutcomeTreatmentDOT As ICollection(Of client_OutcomeTreatmentDOT) = New HashSet(Of client_OutcomeTreatmentDOT)

End Class