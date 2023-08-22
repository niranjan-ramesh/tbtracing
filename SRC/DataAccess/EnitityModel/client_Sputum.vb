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

Partial Public Class client_Sputum
    Public Property ID As Integer
    Public Property CollectedDate As Nullable(Of Date)
    Public Property ResultDate As Nullable(Of Date)
    Public Property CompletedByID As Nullable(Of Integer)
    Public Property RequestedByID As Nullable(Of Integer)
    Public Property StatusRefused As Nullable(Of Boolean)
    Public Property StatusUnableToProduce As Nullable(Of Boolean)
    Public Property StatusCollected As Nullable(Of Boolean)
    Public Property StatusNotResulted As Nullable(Of Boolean)
    Public Property StatusSmearComplete As Nullable(Of Boolean)
    Public Property StatusPendingCulture As Nullable(Of Boolean)
    Public Property StatusComplete As Nullable(Of Boolean)
    Public Property StatusInduced As Nullable(Of Boolean)
    Public Property SmearResultID As Nullable(Of Integer)
    Public Property CultureResultID As Nullable(Of Integer)
    Public Property ReasonForTestingID As Nullable(Of Integer)
    Public Property ClientID As Nullable(Of Integer)
    Public Property Comments As String
    Public Property ReasonForTestingOther As String
    Public Property CultureResultData As Nullable(Of Date)

    Public Overridable Property client_Profile As client_Profile
    Public Overridable Property common_SputumSmearResult As common_SputumSmearResult
    Public Overridable Property common_SputumCultureResult As common_SputumCultureResult
    Public Overridable Property common_SputumSmearResult1 As common_SputumSmearResult
    Public Overridable Property common_SputumRequestBy As common_SputumRequestBy
    Public Overridable Property common_Clinicians As common_Clinicians
    Public Overridable Property common_TestReason As common_TestReason
    Public Overridable Property common_Antibiotic As ICollection(Of common_Antibiotic) = New HashSet(Of common_Antibiotic)

End Class
