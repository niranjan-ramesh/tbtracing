Public Class SeachClient
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindGridView()
        End If

    End Sub

    Protected Sub gvContacts_PreRender(sender As Object, e As EventArgs) Handles gvClients.PreRender
        If Not IsNothing(gvClients) AndAlso Not IsNothing(gvClients.HeaderRow) Then gvClients.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub

    'Protected Sub dsClientList_Selecting(sender As Object, e As EntityDataSourceSelectingEventArgs) Handles dsClientList.Selecting
    '    Try

    '        Dim strFirstName As String = tbFirstName.Text.Trim()
    '        Dim strDOB As String = tbDOB.Text.Trim()
    '        Dim strLastName As String = tbLastName.Text.Trim()
    '        Dim strStatus As String = ddStatus.SelectedValue
    '        Dim strMCP As String = tbMCP.Text.Trim()
    '        Dim strOtherId As String = tbOtherIdentifier.Text.Trim()
    '        Dim strCaseNumber As String = tbCaseNumber.Text.Trim()

    '        Dim whereParameter As StringBuilder = New StringBuilder()
    '        Dim isFirst As Boolean = True

    '        'Generate the where clause
    '        If Not String.IsNullOrEmpty(strFirstName) Then
    '            whereParameter.Append("it.FirstName LIKE '%'+@FirstName+'%' ")
    '            isFirst = False
    '        End If
    '        If Not String.IsNullOrEmpty(strDOB) Then
    '            If isFirst Then
    '                whereParameter.Append("it.DateofBirth = @DateofBirth ")
    '                isFirst = False
    '            Else
    '                whereParameter.Append("and it.DateofBirth = @DateofBirth ")
    '            End If
    '        End If
    '        If Not String.IsNullOrEmpty(strLastName) Then
    '            If isFirst Then
    '                whereParameter.Append("it.LastName LIKE '%'+@LastName+'%' ")
    '                isFirst = False
    '            Else
    '                whereParameter.Append("AND it.LastName LIKE '%'+@LastName+'%' ")
    '            End If
    '        End If
    '        If Not String.IsNullOrEmpty(strCaseNumber) Then
    '            If isFirst Then
    '                whereParameter.Append("it.CaseNumber LIKE '%'+@CaseNumber+'%' ")
    '                isFirst = False
    '            Else
    '                whereParameter.Append("AND it.CaseNumber LIKE '%'+@CaseNumber+'%' ")
    '            End If
    '        End If
    '        If Not String.IsNullOrEmpty(strStatus) Then
    '            If isFirst Then
    '                whereParameter.Append("it.StatusID = @StatusID ")
    '                isFirst = False
    '            Else
    '                whereParameter.Append("AND it.StatusID = @StatusID ")
    '            End If
    '        End If
    '        If Not String.IsNullOrEmpty(strMCP) Then
    '            If isFirst Then
    '                whereParameter.Append("it.HealthCareNumber LIKE '%'+@HealthCareNumber+'%' ")
    '                isFirst = False
    '            Else
    '                whereParameter.Append("AND it.HealthCareNumber LIKE '%'+@HealthCareNumber+'%' ")
    '            End If
    '        End If
    '        If Not String.IsNullOrEmpty(strOtherId) Then
    '            If isFirst Then
    '                whereParameter.Append("it.OtherIdentifier LIKE '%'+@OtherIdentifier+'%'")
    '                isFirst = False
    '            Else
    '                whereParameter.Append("AND it.OtherIdentifier LIKE '%'+@OtherIdentifier+'%'")
    '            End If
    '        End If

    '        'Set the where parameters
    '        dsClientList.Where = whereParameter.ToString()

    '        'Now add the parameters
    '        If Not String.IsNullOrEmpty(strMCP) Then
    '            dsClientList.WhereParameters("HealthCareNumber") = New Parameter("HealthCareNumber", DbType.String, strMCP)
    '        End If

    '        If Not String.IsNullOrEmpty(strOtherId) Then
    '            dsClientList.WhereParameters("OtherIdentifier") = New Parameter("OtherIdentifier", DbType.String, strOtherId)
    '        End If

    '        If Not String.IsNullOrEmpty(strFirstName) Then
    '            dsClientList.WhereParameters("FirstName") = New Parameter("FirstName", DbType.String, strFirstName)
    '        End If

    '        If Not String.IsNullOrEmpty(strLastName) Then
    '            dsClientList.WhereParameters("LastName") = New Parameter("LastName", DbType.String, strLastName)
    '        End If

    '        If Not String.IsNullOrEmpty(strCaseNumber) Then
    '            dsClientList.WhereParameters("CaseNumber") = New Parameter("CaseNumber", DbType.String, strCaseNumber)
    '        End If

    '        If Not String.IsNullOrEmpty(strDOB) Then
    '            Dim objDataHelper As DataHelper = New DataHelper()
    '            Dim dob As DateTime = objDataHelper.convertStringToDate(strDOB)
    '            dsClientList.WhereParameters("DateofBirth") = New Parameter("DateofBirth", DbType.DateTime, dob.ToString())
    '        End If

    '        If Not String.IsNullOrEmpty(strStatus) AndAlso IsNumeric(strStatus) Then
    '            Dim intStatus As Integer = Integer.Parse(strStatus)
    '            dsClientList.WhereParameters("StatusID") = New Parameter("StatusID", DbType.Int32, intStatus.ToString())
    '        End If



    '        'LogHelper.LogInfo("DEBUG SEARCH " & whereParameter.ToString() & "Last: " & strLastName & " First:" & strFirstName, "DEBUG IGNORE")
    '        'Dim testString As String = dsClientList.CommandText

    '        'LogHelper.LogInfo("Debug: " & testString, "IGNORE")

    '    Catch ex As Exception
    '        LogHelper.LogError("Error filtering grid view for client list.", "SearchClient.aspx", ex)
    '        Session.Add("ErrorMessage", "Error searching for client.")
    '        Response.Redirect("~/ErrorPage.aspx")
    '    End Try
    'End Sub

    Protected Sub lbSearch_Click(sender As Object, e As EventArgs) Handles lbSearch.Click
        Try
            'dsClientList.WhereParameters.Clear()
            'gvClients.DataBind()
            gvClients.PageIndex = 0

            BindGridView()
        Catch ex As Exception
            LogHelper.LogError("Where parms won't clear for client search.", "SearchClient.aspx", ex)
            Session.Add("ErrorMessage", "Error searching for client.")
            Response.Redirect("~/ErrorPage.aspx")
        End Try
    End Sub

    'Protected Sub dsClientList_QueryCreated(sender As Object, e As QueryCreatedEventArgs) Handles dsClientList.QueryCreated
    '    LogHelper.LogInfo("SQL: " & dsClientList.CommandText, "DEBUG")
    '    LogHelper.LogInfo("Where: " & dsClientList.Where, "Debug")
    'End Sub


    Private Sub BindGridView()
        Using db As New TBTracingEntities()

            Dim clientListQuery = From clients In db.client_Demographic Where clients.Active = True

            If Not String.IsNullOrEmpty(tbFirstName.Text.Trim()) Then
                clientListQuery = clientListQuery.Where(Function(p) p.FirstName.ToLower().Contains(tbFirstName.Text.Trim().ToLower()))
            End If

            If Not String.IsNullOrEmpty(tbLastName.Text.Trim()) Then
                clientListQuery = clientListQuery.Where(Function(p) p.LastName.ToLower().Contains(tbLastName.Text.Trim().ToLower()))
            End If

            If Not String.IsNullOrEmpty(tbMCP.Text.Trim()) Then
                Dim strSanitizedMCP As String = tbMCP.Text.Replace(" ", "")
                clientListQuery = clientListQuery.Where(Function(p) p.HealthCareNumber.Replace(" ", "").Contains(strSanitizedMCP))
            End If

            If Not String.IsNullOrEmpty(tbOtherIdentifier.Text.Trim()) Then
                clientListQuery = clientListQuery.Where(Function(p) p.OtherIdentifier.Contains(tbOtherIdentifier.Text.Trim()))
            End If

            If Not String.IsNullOrEmpty(tbDOB.Text.Trim()) Then
                Dim objDataHelper As DataHelper = New DataHelper()
                Dim dob As DateTime = objDataHelper.convertStringToDate(tbDOB.Text.Trim())
                clientListQuery = clientListQuery.Where(Function(p) p.DateofBirth = dob)
            End If

            If Not String.IsNullOrEmpty(tbCaseNumber.Text.Trim()) Then
                clientListQuery = clientListQuery.Where(Function(p) p.CaseNumber.Contains(tbCaseNumber.Text.Trim()))
            End If

            If Not String.IsNullOrEmpty(ddStatus.SelectedValue) AndAlso IsNumeric(ddStatus.SelectedValue) Then
                Dim status As Integer = Integer.Parse(ddStatus.SelectedValue)
                clientListQuery = clientListQuery.Where(Function(p) p.client_Profile.StatusID = status)
            End If

            If Not String.IsNullOrEmpty(ddCommunity.SelectedValue) AndAlso IsNumeric(ddCommunity.SelectedValue) Then
                Dim community As Integer = Integer.Parse(ddCommunity.SelectedValue)
                clientListQuery = clientListQuery.Where(Function(p) p.CommunityID = community)
            End If

            Dim results = From clientData In clientListQuery _
                          Order By clientData.FirstName, clientData.LastName _
                          Select New With {.id = clientData.ID, .FirstName = clientData.FirstName, _
                                           .LastName = clientData.LastName, .CaseNumber = clientData.CaseNumber, _
                                           .HealthCareNumber = clientData.HealthCareNumber, .OtherIdentifier = clientData.OtherIdentifier, _
                                           .strDOB = clientData.DateofBirth, .Status = clientData.client_Profile.common_Status.Status, _
                                           .ClientID = clientData.ClientID}

            Dim resultSize As Integer = results.Count()
            Dim takeSize As Integer = gvClients.PageSize
            Dim skipSize As Integer = takeSize * gvClients.PageIndex

            Dim strSQl As String = results.Skip(skipSize).Take(takeSize).ToString()
            Dim listResults = results.Skip(skipSize).Take(takeSize).ToList()

            gvClients.VirtualItemCount = resultSize
            gvClients.DataSource = listResults
            gvClients.DataBind()
        End Using

    End Sub

    Protected Sub gvClients_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvClients.PageIndexChanging
        gvClients.PageIndex = e.NewPageIndex
        BindGridView()
    End Sub
End Class