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

Partial Public Class client_OutcomeTreatmentDOT
    Public Property ID As Integer
    Public Property DOTDate As Nullable(Of Date)
    Public Property CompletedBy As Nullable(Of Integer)
    Public Property ClientNoShow As Nullable(Of Boolean)
    Public Property Active As Nullable(Of Boolean)
    Public Property TreatmentID As Integer

    Public Overridable Property client_OutcomeTreatment As client_OutcomeTreatment
    Public Overridable Property common_Clinicians As common_Clinicians
    Public Overridable Property common_Medication As ICollection(Of common_Medication) = New HashSet(Of common_Medication)
    Public Overridable Property common_Symptoms As ICollection(Of common_Symptoms) = New HashSet(Of common_Symptoms)

End Class
