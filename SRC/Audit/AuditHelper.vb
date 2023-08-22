Imports System.Data.Entity
Imports System.Data.Entity.Core.Objects

Public Class AuditHelper

    Public Function getAuditStringForContext(ByRef DB As DbContext, ByVal returnHtml As Boolean) As String
        Try
            Dim lineBreak As String = Environment.NewLine
            If returnHtml Then
                lineBreak = "<br />"
            End If
            Dim results As StringBuilder = New StringBuilder()

            Dim entries = DB.ChangeTracker.Entries
            For Each entry In entries
                If entry.State = EntityState.Modified Then
                    Dim strEntityType As String = ObjectContext.GetObjectType(entry.Entity.GetType()).Name
                    results.Append(lineBreak & "Edited Entity: " & strEntityType & lineBreak)
                    For Each strProperty In entry.OriginalValues.PropertyNames
                        If Not Object.Equals(entry.OriginalValues(strProperty), entry.CurrentValues(strProperty)) Then
                            results.Append("Modified Property: " & strProperty & ", Original Value: " & entry.OriginalValues(strProperty) & lineBreak)
                            results.Append("New Value: " & entry.CurrentValues(strProperty) & lineBreak)
                        End If
                    Next
                ElseIf entry.State = EntityState.Added Then
                    Dim strEntityType As String = ObjectContext.GetObjectType(entry.Entity.GetType()).Name
                    results.Append(lineBreak & "Added Entity: " & strEntityType & lineBreak)
                    For Each strProperty In entry.CurrentValues.PropertyNames
                        If Not IsNothing(entry.CurrentValues(strProperty)) Then
                            results.Append("Added Property: " & strProperty & ", Value: " & entry.CurrentValues(strProperty) & lineBreak)
                        End If

                    Next
                ElseIf entry.State = EntityState.Deleted Then
                    Dim strEntityType As String = ObjectContext.GetObjectType(entry.Entity.GetType()).Name
                    results.Append(lineBreak & "Deleted Entity: " & strEntityType & lineBreak)
                    For Each strProperty In entry.OriginalValues.PropertyNames
                        results.Append("Deleted Property: " & strProperty & ", Value: " & entry.OriginalValues(strProperty) & lineBreak)
                    Next
                End If

            Next
            Return results.ToString
        Catch ex As Exception
            LogHelper.LogError("Error formatting audit changes.", "Audit Error", ex)
            Throw New DataException("Error getting Context Audit String.", ex)
        End Try
    End Function

End Class
