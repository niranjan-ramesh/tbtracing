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

Partial Public Class client_Followup
    Public Property ID As Integer
    Public Property ClientID As Integer
    Public Property FollowupType As Integer
    Public Property FollowupDate As Nullable(Of Date)
    Public Property ReminderDate As Nullable(Of Date)
    Public Property PhysicianID As Integer
    Public Property CompletedDate As Nullable(Of Date)
    Public Property Comments As String
    Public Property Complete As Nullable(Of Boolean)

    Public Overridable Property client_Profile As client_Profile
    Public Overridable Property common_Followup As common_Followup
    Public Overridable Property common_TBUser As common_TBUser

End Class
