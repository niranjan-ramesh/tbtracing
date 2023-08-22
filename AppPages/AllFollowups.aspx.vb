Public Class AllFollowups
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

#Region "Followup CRUD"
    Public Sub gvFollowUps_UpdateItem(ByVal ID As Integer, ByVal ClientID As Integer)
        Dim item As FollowUpGridLineItem = New FollowUpGridLineItem()

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                Dim objFollowup As client_Followup = item
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateFollowup(objFollowup)
            Catch ex As Exception
                LogHelper.LogError("Error updating follow-up", "Followups.aspx", ex)
                Session.Add("ErrorMessage", "Error updating client followup.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try

        End If
    End Sub

    Public Function gvFollowUps_GetData(ByVal direction As Nullable(Of SortDirection)) As IQueryable(Of FollowUpGridLineItem)
        Try
            Dim db As IClientDA = New ClientDAImpl()
            Dim results As IQueryable(Of FollowUpGridLineItem) = Nothing

            Dim frDate As Nullable(Of DateTime) = Nothing
            Dim toDate As Nullable(Of DateTime) = Nothing

            If Not String.IsNullOrEmpty(tbFromDate.Text) Then
                frDate = Date.ParseExact(tbFromDate.Text, "dd-MMM-yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None) + New TimeSpan(0, 0, 0)
            End If

            If Not String.IsNullOrEmpty(tbToDate.Text) Then
                toDate = Date.ParseExact(tbToDate.Text, "dd-MMM-yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None) + New TimeSpan(23, 59, 59)
            End If

            Dim clientFollowList As List(Of FollowUpGridLineItem) = db.GetAllFollowups(frDate, toDate, ddResponsible.SelectedValue, ddFollowUpType.SelectedValue)

            If Not IsNothing(clientFollowList) Then
                results = clientFollowList.AsQueryable()
            End If
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting follow-ups", "Followups.aspx", ex)
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub fvAddFollowUp_InsertItem()
        'Dim item = New TBTracing.client_Followup()
        'item.ClientID = intClientID

        'TryUpdateModel(item)
        'If ModelState.IsValid Then
        '    Try
        '        Dim db As IClientDA = New ClientDAImpl()
        '        db.AddFollowup(item)
        '        gvFollowUps.DataBind()
        '    Catch ex As Exception
        '        LogHelper.LogError("Error adding follow-up", "Followups.aspx", ex)
        '        Session.Add("ErrorMessage", "Error adding client followup.")
        '        Response.Redirect("~/ErrorPage.aspx", False)
        '    End Try
        'End If
    End Sub
#End Region

#Region "Gridview Table Render"
    Private Sub gvFollowUps_PreRender(sender As Object, e As EventArgs) Handles gvFollowUps.PreRender
        If gvFollowUps.Rows.Count > 0 Then
            gvFollowUps.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub
#End Region

#Region "Button Clicks"
    Protected Sub lbSearch_Click(sender As Object, e As EventArgs) Handles lbSearch.Click
        gvFollowUps.DataBind()
    End Sub
#End Region

End Class