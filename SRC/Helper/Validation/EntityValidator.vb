Imports System.Data.Entity.Validation
Imports System.Data.Entity

Public Class EntityValidator

    Public Function validateEntity(ByRef entityToValidate As Object) As List(Of String)
        Dim results As List(Of String) = Nothing
        Try
            Using db As New TBTracingEntities
                Dim validationResults As DbEntityValidationResult = db.Entry(entityToValidate).GetValidationResult()
                If Not IsNothing(validationResults) Then
                    results = New List(Of String)
                    For Each validationError In validationResults.ValidationErrors
                        results.Add(validationError.ErrorMessage)
                    Next
                    Return results
                Else
                    Return Nothing
                End If
            End Using
        Catch ex As Exception
            Throw New EntityValidationException("Error validating data.", ex)
        End Try
    End Function
End Class