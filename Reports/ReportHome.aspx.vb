Imports System.Data.SqlClient
Imports ClosedXML.Excel
Imports System.IO

Public Class ReportHome
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub LinkButton1_Click(sender As Object, e As EventArgs) Handles LinkButton1.Click
        Try
            'SQL to Excel.
            Dim strSQL As String = "select p.FirstName, p.LastName,  d.RhaOtherText, " & _
                                    "d.CaseNumber, d.MiddleInitial, d.Alias_MaidenName_Nickname, common_Gender.Gender, " & _
                                    "d.HealthCareNumber, d.StreetAddress,common_Community.Community, d.CommunityOther, d.PostalCode,common_Province.Province, d.OtherProvinceStateIdentifier, " & _
                                    "d.MobilePhone, d.HomePhone, d.OtherPhone, d.Email, " & _
                                    "d.DateofBirth, d.Occupation, d.BodyWeight,  d.OtherIdentifier,common_PregnancyStatus.PregnantStatus, " & _
                                    "stuff((SELECT ' - '+ allEthnicities.Ethnicity" & _
                                    "           FROM common_Ethnicity As allEthnicities" & _
                                    "           INNER JOIN client_DemographicEthnicity as clientEths ON clientEths.EthnicityID = allEthnicities.ID" & _
                                    "           WHERE clientEths.ClientID = d.id " & _
                                    "     for xml path('')),1,3,'') clientEthniticiesList, d.EthnicityOther, " & _
                                    "Case when p.Confirmed = 1 then 'Yes'  when p.Confirmed = 0 then 'No' Else '' End As ""Confirmed?"", " & _
                                    "Case when d.RhaEH = 1 then 'Yes'  when d.RhaEH = 0 then 'No' Else '' End As ""Eastern Health?"", " & _
                                    "Case when d.RhaCH = 1 then 'Yes'  when d.RhaCH = 0 then 'No' Else '' End As ""Central Health?"", " & _
                                    "Case when d.RhaWG = 1 then 'Yes'  when d.RhaWG = 0 then 'No' Else '' End As ""Western Health?"", " & _
                                    "Case when d.RhaLG = 1 then 'Yes'  when d.RhaLG= 0 then 'No' Else '' End As ""Labrador Gren.?"", " & _
                                    "Case when p.Employee = 1 then 'Yes'  when p.Employee = 0 then 'No' Else '' End As ""Employee?"" " & _
                                    "from client_Profile as p " & _
                                    "INNER JOIN client_Demographic as d ON p.id = d.ClientID " & _
                                    "INNER JOIN common_Status ON p.StatusID = common_Status.id " & _
                                    "LEFT OUTER JOIN common_Community ON d.CommunityID = common_Community.ID " & _
                                    "LEFT OUTER JOIN common_Province on d.ProvinceID = common_Province.id " & _
                                    "LEFT OUTER JOIN common_Gender on d.GenderID = common_Gender.id " & _
                                    "LEFT OUTER JOIN common_PregnancyStatus on d.PregnancyStatus = common_PregnancyStatus.id " & _
                                    "where d.Active = 'true' "

            Dim fileName As String = "ClientData-" & DateTime.Now.ToString() & ".xlsx"
            Dim dtDemographics As DataTable = New DataTable()

            Dim constr As String = ConfigurationManager.ConnectionStrings("TBConnection").ConnectionString
            Dim strResult As String = Nothing
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand(strSQL)
                    Using sda As New SqlDataAdapter()
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        sda.Fill(dtDemographics)
                    End Using
                End Using
            End Using

            Using wb As New XLWorkbook()
                Dim ws = wb.Worksheets.Add(dtDemographics, "Client Demographics")
                Dim rngTable = ws.Range("A1:Z1")
                rngTable.Style.Font.Bold = True
                'rngTable.Style.Fill.BackgroundColor = XLColor.LightGray
                ws.Tables.FirstOrDefault().ShowAutoFilter = False


                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Dim headerDisposition As String = "attachment;filename=" & fileName
                Response.AddHeader("content-disposition", headerDisposition)

                Using MyMemoryStream As New MemoryStream()
                    wb.SaveAs(MyMemoryStream)
                    MyMemoryStream.WriteTo(Context.Response.OutputStream)
                    'Response.Flush()
                    'Response.End()
                    HttpContext.Current.Response.Flush()
                    HttpContext.Current.Response.SuppressContent = True
                    HttpContext.Current.ApplicationInstance.CompleteRequest()

                End Using
            End Using

        Catch ex As Exception
            LogHelper.LogError("Error generating demographics data", "ReportHome.aspx", ex)
            Session.Add("ErrorMessage", "Error generating demographics report.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
End Class