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

Partial Public Class common_TestReason
    Public Property ID As Integer
    Public Property TestReason As String
    Public Property TypeID As Integer

    Public Overridable Property client_Bloodwork As ICollection(Of client_Bloodwork) = New HashSet(Of client_Bloodwork)
    Public Overridable Property client_DiagnosticImage As ICollection(Of client_DiagnosticImage) = New HashSet(Of client_DiagnosticImage)
    Public Overridable Property client_IGRA As ICollection(Of client_IGRA) = New HashSet(Of client_IGRA)
    Public Overridable Property client_SkinTest As ICollection(Of client_SkinTest) = New HashSet(Of client_SkinTest)
    Public Overridable Property client_Sputum As ICollection(Of client_Sputum) = New HashSet(Of client_Sputum)
    Public Overridable Property client_Xray As ICollection(Of client_Xray) = New HashSet(Of client_Xray)
    Public Overridable Property common_TestReasonType As common_TestReasonType

End Class
