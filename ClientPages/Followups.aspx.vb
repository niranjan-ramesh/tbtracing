Imports System.Data.SqlClient
Imports System.Linq

Public Class Followups
    Inherits System.Web.UI.Page

    Private intClientID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If
    End Sub
#End Region

#Region "Followup CRUD"
    Public Sub gvFollowUps_UpdateItem()
        Dim item As FollowUpGridLineItem = New FollowUpGridLineItem()

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                item.ClientID = intClientID
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

            Dim clientFollowList As List(Of FollowUpGridLineItem) = db.GetFollowups(intClientID)

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
        Dim item = New TBTracing.client_Followup()
        item.ClientID = intClientID

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.AddFollowup(item)
                gvFollowUps.DataBind()
            Catch ex As Exception
                LogHelper.LogError("Error adding follow-up", "Followups.aspx", ex)
                Session.Add("ErrorMessage", "Error adding client followup.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "Gridview Table Render"
    Private Sub gvFollowUps_PreRender(sender As Object, e As EventArgs) Handles gvFollowUps.PreRender
        If gvFollowUps.Rows.Count > 0 Then
            gvFollowUps.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub
#End Region

End Class