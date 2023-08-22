Imports System.Reflection

Public Class DataHelper

    Public Function getSelectedCheckBoxesAsInteger(ByRef cbl As CheckBoxList) As List(Of Integer)
        Dim results As List(Of Integer) = Nothing
        Try
            If Not IsNothing(cbl) Then
                results = New List(Of Integer)

                For Each cb As ListItem In cbl.Items
                    If cb.Selected Then
                        results.Add(Integer.Parse(cb.Value))
                    End If
                Next
            End If
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error extracting check box list selection.", "DataHelper", ex)
            Throw New DataHelperException("Error getting check box selections.", ex)
        End Try
    End Function

    Public Function convertStringToDate(ByVal dateInput As String) As Nullable(Of DateTime)
        Try
            Dim dateFormat As String = My.Settings.DateFormat
            Dim returnDate As Nullable(Of DateTime)
            If Not String.IsNullOrEmpty(dateInput) Then
                returnDate = DateTime.ParseExact(dateInput, dateFormat, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None)
            Else
                returnDate = Nothing
            End If
            Return returnDate
        Catch ex As Exception
            LogHelper.LogError("Error converting string to date.", "DataHelper", ex)
            Throw New DataHelperException("Error converting string to date.", ex)
        End Try

    End Function

    Public Function convertDateToStringText(ByVal dateInput As DateTime) As String
        Try
            Dim returnString As String = Nothing
            If Not IsNothing(dateInput) Then
                returnString = dateInput.ToString(My.Settings.DateFormat)
            End If
            Return returnString
        Catch ex As Exception
            LogHelper.LogError("Error converting date to string.", "DataHelper", ex)
            Throw New DataHelperException("Error converting date to string.", ex)
        End Try
    End Function

    Public Function calculateAgeFromBirthday(ByVal birthday As DateTime)
        Dim age As Integer
        age = Today.Year - birthday.Year
        If (birthday > Today.AddYears(-age)) Then age -= 1
        Return age
    End Function

End Class
