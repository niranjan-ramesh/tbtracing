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

Partial Public Class client_Investigation
    Public Property ID As Integer
    Public Property CollectedDate As Nullable(Of Date)
    Public Property ResultDate As Nullable(Of Date)
    Public Property BranchialWashResult As Nullable(Of Integer)
    Public Property BranchialWashResultNotes As String
    Public Property GIWash As Nullable(Of Integer)
    Public Property GIWashNotes As String
    Public Property NodeBiopsy As Nullable(Of Integer)
    Public Property NodeBiopsyNotes As String
    Public Property Urine As Nullable(Of Integer)
    Public Property UrineNotes As String
    Public Property CSF As Nullable(Of Integer)
    Public Property CSFNotes As String
    Public Property Other As Nullable(Of Integer)
    Public Property OtherNotes As String
    Public Property Comments As String
    Public Property InvestigationTypeID As Nullable(Of Integer)
    Public Property ClientID As Nullable(Of Integer)
    Public Property CollectedByID As Nullable(Of Integer)

    Public Overridable Property client_Profile As client_Profile
    Public Overridable Property common_InvestigationType As common_InvestigationType
    Public Overridable Property common_TBUser As common_TBUser
    Public Overridable Property common_YesNoNotdoneUnknown As common_YesNoNotdoneUnknown
    Public Overridable Property common_YesNoNotdoneUnknown1 As common_YesNoNotdoneUnknown
    Public Overridable Property common_YesNoNotdoneUnknown2 As common_YesNoNotdoneUnknown
    Public Overridable Property common_YesNoNotdoneUnknown3 As common_YesNoNotdoneUnknown
    Public Overridable Property common_YesNoNotdoneUnknown4 As common_YesNoNotdoneUnknown
    Public Overridable Property common_YesNoNotdoneUnknown5 As common_YesNoNotdoneUnknown

End Class