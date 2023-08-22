Public Class FollowUpGridLineItem
    Inherits client_Followup

    Public Property strResponsibility As String
    Public Property strFollowupType As String
    Public Property strClientName As String

    Public Sub New(ByRef baseClass As client_Followup)
        MyBase.ID = baseClass.ID
        MyBase.ClientID = baseClass.ClientID
        MyBase.FollowupType = baseClass.FollowupType
        MyBase.FollowupDate = baseClass.FollowupDate
        MyBase.ReminderDate = baseClass.ReminderDate
        MyBase.PhysicianID = baseClass.PhysicianID
        MyBase.CompletedDate = baseClass.CompletedDate
        MyBase.Comments = baseClass.Comments
        MyBase.Complete = baseClass.Complete
    End Sub

    Public Sub New()

    End Sub

End Class
