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

Partial Public Class common_Status
    Public Property ID As Integer
    Public Property Status As String

    Public Overridable Property client_Profile As ICollection(Of client_Profile) = New HashSet(Of client_Profile)
    Public Overridable Property common_TBOutcome As ICollection(Of common_TBOutcome) = New HashSet(Of common_TBOutcome)

End Class
