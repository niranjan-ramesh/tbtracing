Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_FollowupMeta))> _
Partial Public Class client_Followup

End Class

Public Class client_FollowupMeta

    <Required(ErrorMessage:="Follow up type required.")> _
    Public Property FollowupType As Nullable(Of Integer)

    <DataType(DataType.Date, ErrorMessage:="Invalid Followup Date.")> _
    <Required(ErrorMessage:="Follow up date required.")> _
    Public Property FollowupDate As Nullable(Of Date)

    <DataType(DataType.Date, ErrorMessage:="Invalid Reminder Date.")> _
    Public Property ReminderDate As Nullable(Of Date)

    <Required(ErrorMessage:="Responsible person required.")> _
    Public Property PhysicianID As Nullable(Of Integer)

    <DataType(DataType.Date, ErrorMessage:="Invalid Completed Date.")> _
    Public Property CompletedDate As Nullable(Of Date)

    <RestrictXSS(ErrorMessage:="Invalid characters in followup notes.")> _
    <StringLength(5000, ErrorMessage:="Followup notes must be 5000 characters or less.")> _
    Public Property Comments As String

End Class
