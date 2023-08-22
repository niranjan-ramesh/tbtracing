Imports System
Imports System.Globalization
Imports System.ComponentModel.DataAnnotations

<AttributeUsage(AttributeTargets.[Property] Or AttributeTargets.Field, AllowMultiple:=False)> _
Public NotInheritable Class RestrictXSS
    Inherits ValidationAttribute

    Public Overrides Function IsValid(ByVal value As Object) As Boolean
        Dim doTheCheck As Boolean = My.Settings.InternallXSSCheck
        If doTheCheck AndAlso Not String.IsNullOrEmpty(value) Then
            For Each tmpString In value


                Dim valid As Boolean = Regex.IsMatch(tmpString, "^[A-Za-z0-9!@#$%^&*()?/\\\[\]{},.`~' \+=-]*$")
                If Not valid Then
                    Return False
                End If
            Next
            Return True
        Else
            Return True
        End If
    End Function

End Class