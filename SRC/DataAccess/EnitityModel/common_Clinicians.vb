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

Partial Public Class common_Clinicians
    Public Property ID As Integer
    Public Property Username As String
    Public Property Active As Nullable(Of Boolean)

    Public Overridable Property client_Bloodwork As ICollection(Of client_Bloodwork) = New HashSet(Of client_Bloodwork)
    Public Overridable Property client_RiskFactors As ICollection(Of client_RiskFactors) = New HashSet(Of client_RiskFactors)
    Public Overridable Property client_SkinTest As ICollection(Of client_SkinTest) = New HashSet(Of client_SkinTest)
    Public Overridable Property client_SkinTest1 As ICollection(Of client_SkinTest) = New HashSet(Of client_SkinTest)
    Public Overridable Property client_Sputum As ICollection(Of client_Sputum) = New HashSet(Of client_Sputum)
    Public Overridable Property client_Symptoms As ICollection(Of client_Symptoms) = New HashSet(Of client_Symptoms)
    Public Overridable Property common_TBUser As ICollection(Of common_TBUser) = New HashSet(Of common_TBUser)
    Public Overridable Property client_Outcome As ICollection(Of client_Outcome) = New HashSet(Of client_Outcome)
    Public Overridable Property client_OutcomeTreatmentDOT As ICollection(Of client_OutcomeTreatmentDOT) = New HashSet(Of client_OutcomeTreatmentDOT)

End Class
