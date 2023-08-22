Imports Microsoft.Practices.EnterpriseLibrary.Logging
Imports Microsoft.Practices.EnterpriseLibrary.Common.Configuration
Imports Microsoft.Practices.EnterpriseLibrary.Logging.ExtraInformation
Imports Microsoft.Practices.EnterpriseLibrary.Logging.Filters
Imports System.Web


Public Class LogHelper

    Private Shared ReadOnly defaultWriter As Object
    Public Shared ReadOnly infoType As Integer = 0
    Public Shared ReadOnly warningType As Integer = 1
    Public Shared ReadOnly errorType As Integer = 2
    Public Shared ReadOnly verboseType As Integer = 3
    Public Shared ReadOnly criticalType As Integer = 4

    'Static constructor to instantiate the log writer.  Static logger given scope is console application running batch
    Shared Sub New()
        defaultWriter = EnterpriseLibraryContainer.Current.GetInstance(Of LogWriter)()
    End Sub

    Public Shared Sub LogError(ByVal strMessage As String, ByVal strTitle As String, ByRef exObj As System.Exception)
        Dim logger As New LogHelper()
        logger.LogDetails(strMessage, strTitle, exObj, LogHelper.errorType)
    End Sub

    Public Shared Sub LogInfo(ByVal strMessage As String, ByVal strTitle As String)
        Dim logger As New LogHelper()
        logger.LogDetails(strMessage, strTitle, Nothing, LogHelper.infoType)
    End Sub

    Public Shared Sub LogVerbose(ByVal strMessage As String, ByVal strTitle As String)
        Dim logger As New LogHelper()
        logger.LogDetails(strMessage, strTitle, Nothing, LogHelper.verboseType)
    End Sub

    Public Shared Sub LogWarning(ByVal strMessage As String, ByVal strTitle As String, ByRef exObj As System.Exception)
        Dim logger As New LogHelper()
        logger.LogDetails(strMessage, strTitle, exObj, LogHelper.warningType)
    End Sub

    Public Shared Sub LogCritical(ByVal strMessage As String, ByVal strTitle As String, ByRef exObj As System.Exception)
        Dim logger As New LogHelper()
        logger.LogDetails(strMessage, strTitle, exObj, LogHelper.criticalType)
    End Sub


    Private Sub LogDetails(ByVal strMessage As String, ByVal strTitle As String, ByRef exObj As System.Exception, ByRef errorLevel As Integer)
        Dim logDetails As New LogEntry()
        logDetails.Message = strMessage
        logDetails.Title = strTitle
        logDetails.TimeStamp = DateTime.Now
        If errorLevel = 0 Then
            logDetails.Severity = TraceEventType.Information
        ElseIf errorLevel = 1 Then
            logDetails.Severity = TraceEventType.Warning
        ElseIf errorLevel = 2 Then
            logDetails.Severity = TraceEventType.Error
        ElseIf errorLevel = 3 Then
            logDetails.Severity = TraceEventType.Verbose
        ElseIf errorLevel = 4 Then
            logDetails.Severity = TraceEventType.Critical
        End If
        Dim strUrl As String = String.Empty
        If Not HttpContext.Current.Request.Url.AbsoluteUri Is Nothing Then
            strUrl = HttpContext.Current.Request.Url.AbsoluteUri
        End If
        logDetails.ProcessName = strUrl

        Dim dictionary As New Dictionary(Of String, Object)
        Dim userName As String = "N/A"
        If Not IsNothing(HttpContext.Current.User) Then
            userName = HttpContext.Current.User.Identity.Name
        End If
        dictionary.Add("User name: ", userName)
        If Not IsNothing(exObj) Then
            dictionary.Add("Stacktrace Message", exObj.Message)
            dictionary.Add("Stacktrace Inner", exObj.StackTrace)
            dictionary.Add("Exception Type", exObj.GetType.ToString)
            Dim innerException As Exception = exObj.InnerException
            If Not Information.IsNothing(innerException) Then
                dictionary.Add("Inner Stacktrace Message", innerException.Message)
                dictionary.Add("Inner Exception", innerException.ToString)
                dictionary.Add("Inner Stack", innerException.StackTrace)
                dictionary.Add("Inner Stacktracetype", innerException.GetType.ToString)
            End If
        End If
        logDetails.ExtendedProperties = dictionary

        defaultWriter.Write(logDetails)
    End Sub

End Class


