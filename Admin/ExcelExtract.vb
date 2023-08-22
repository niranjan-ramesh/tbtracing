Imports System.Web
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports DocumentFormat.OpenXml.Spreadsheet
Imports ClosedXML.Excel
Imports System.Data.SqlClient
Imports System.IO

Public Class ExcelExtract
    Implements IHttpHandler

    ''' <summary>
    '''  You will need to configure this handler in the Web.config file of your 
    '''  web and register it with IIS before being able to use it. For more information
    '''  see the following link: http://go.microsoft.com/?linkid=8101007
    ''' </summary>
#Region "IHttpHandler Members"

    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            ' Return false in case your Managed Handler cannot be reused for another request.
            ' Usually this would be false in case you have some state information preserved per request.
            Return True
        End Get
    End Property

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Using wb As New XLWorkbook()

            Dim demoSql As String = "SELECT client_Demographic.FirstName, client_Demographic.LastName,client_Profile.ID, " & _
                                            "client_Demographic.DateofBirth, client_Demographic.CaseNumber, common_Status.Status, " & _
                                            "client_Demographic.HealthCareNumber, common_Gender.Gender, common_Community.Community, " & _
                                            "(select DATEDIFF(yy, client_Demographic.DateofBirth, getdate())) As Age, " & _
                                            "STUFF((SELECT ','+ commonEth.Ethnicity " & _
                                                    "FROM client_DemographicEthnicity  As clientEth " & _
                                                    "INNER JOIN common_Ethnicity as commonEth ON clientEth.EthnicityID = commonEth.ID " & _
                                                    "WHERE client_Demographic.ID = clientEth.ClientID " & _
                                                    "FOR XML PATH(''), TYPE).value('.','VARCHAR(max)'), 1, 1, '') As ethniticiesList      " & _
                                            "FROM client_Profile " & _
                                            "LEFT JOIN common_Status on client_Profile.StatusID = common_Status.ID  " & _
                                            "INNER JOIN client_Demographic ON client_Profile.ID = client_Demographic.ClientID  " & _
                                            "LEFT JOIN common_Gender ON client_Demographic.GenderID = common_Gender.ID  " & _
                                            "LEFT JOIN common_Community ON client_Demographic.CommunityID = common_Community.ID  " & _
                                            "WHERE client_Demographic.Active = 'True' " & _
                                            "And client_Demographic.ClientID = @parmID "

            Dim dtDemographic As DataTable = New DataTable()
            PopulateDataTable(demoSql, 95, dtDemographic)


            wb.Worksheets.Add(dtDemographic, "Demographics")
            'Response.Clear()
            'Response.Buffer = True
            'Response.Charset = ""
            'Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            'Response.AddHeader("content-disposition", "attachment;filename=SqlExport.xlsx")
            'Using MyMemoryStream As New MemoryStream()
            '    wb.SaveAs(MyMemoryStream)
            '    MyMemoryStream.WriteTo(Response.OutputStream)
            '    Response.Flush()
            '    Response.End()
            'End Using

            context.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            context.Response.AddHeader("content-disposition", "attachment;filename=SqlExport.xlsx")
            'context.Response.Write(csvContents.ToString())

            Using MyMemoryStream As New MemoryStream()
                wb.SaveAs(MyMemoryStream)
                MyMemoryStream.WriteTo(context.Response.OutputStream)
                context.Response.Flush()
                context.Response.End()
            End Using


        End Using




    End Sub

#End Region


    Private Sub PopulateDataTable(ByRef strSql As String, ByRef parmID As Integer, ByRef results As DataTable)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("TBConnection").ConnectionString
            Dim strResult As String = Nothing
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand(strSql)
                    Dim prmClientID As New SqlParameter("@parmID", parmID)
                    cmd.Parameters.Add(prmClientID)

                    Using sda As New SqlDataAdapter()
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        sda.Fill(results)
                        'Using dt As New DataTable()
                        '    sda.Fill(dt)
                        'Append blank column
                        'results.Append(",")
                        'For Each column As DataColumn In dt.Columns
                        '    'Add the Header row for CSV file.
                        '    results.Append(column.ColumnName & ",")
                        'Next
                        'results.Append(lineReturn)

                        'For Each row As DataRow In dt.Rows
                        '    'Add blank column for formatting.
                        '    results.Append(",")
                        '    strResult = Nothing
                        '    For Each column As DataColumn In dt.Columns
                        '        'Add the Data rows.
                        '        If column.DataType = System.Type.GetType("System.DateTime") Then
                        '            Dim objDateTime As Nullable(Of DateTime) = Nothing
                        '            If Not IsDBNull(row(column.ColumnName)) Then
                        '                objDateTime = row(column.ColumnName)
                        '            End If

                        '            If Not IsNothing(objDateTime) Then
                        '                results.Append(objDataHelper.convertDateToStringText(objDateTime) & ",")
                        '            Else
                        '                results.Append(" -- ,")
                        '            End If
                        '        ElseIf column.DataType = System.Type.GetType("System.Date") Then
                        '            Dim objDateTime As Nullable(Of Date) = Nothing
                        '            If Not IsDBNull(row(column.ColumnName)) Then
                        '                objDateTime = row(column.ColumnName)
                        '            End If

                        '            If Not IsNothing(objDateTime) Then
                        '                results.Append(objDataHelper.convertDateToStringText(objDateTime) & ",")
                        '            Else
                        '                results.Append(" -- ,")
                        '            End If
                        '        Else
                        '            strResult = row(column.ColumnName).ToString()
                        '            If Not String.IsNullOrEmpty(strResult) Then
                        '                results.Append(strResult.Replace(",", ";") & ",")
                        '            Else
                        '                results.Append(" -- ,")
                        '            End If

                        '            'results.Append & ",")
                        '        End If
                        '    Next
                        '    results.Append(lineReturn)
                        'Next
                        'End Using
                    End Using
                End Using
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting data for client report.", "DataExtractHandler", ex)
        End Try
    End Sub

End Class
