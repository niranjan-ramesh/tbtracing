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

Partial Public Class clinic_TBClinic
    Public Property ID As Integer
    Public Property ClinicDate As Nullable(Of Date)
    Public Property StartTime As Nullable(Of System.TimeSpan)
    Public Property EndTime As Nullable(Of System.TimeSpan)
    Public Property PhysicianID As Nullable(Of Integer)
    Public Property MaxAppointments As Nullable(Of Integer)
    Public Property Comments As String

    Public Overridable Property clinic_TBClinicAppointments As ICollection(Of clinic_TBClinicAppointments) = New HashSet(Of clinic_TBClinicAppointments)
    Public Overridable Property common_TBUser As common_TBUser

End Class