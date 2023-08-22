Imports System
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports System.ComponentModel.DataAnnotations
Imports Owin

Public Class _Default
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        LogHelper.LogInfo("Entering the default page.", "Default.aspx")

        'Show/Hide Admin panels based on user roles.
        'If HttpContext.Current.User.Identity.IsAuthenticated Then
        'Dim manager = New UserManager()
        'Dim selectedUser As ApplicationUser = manager.FindByName(HttpContext.Current.User.Identity.Name)

        'Dim RoleManager = New RoleManager(Of IdentityRole)(New RoleStore(Of IdentityRole)(New ApplicationDbContext()))
        'Dim appContext As New ApplicationDbContext()
        'Dim roleList = appContext.Roles.ToList()

        'If Roles.IsUserInRole("TBAdmin") Then
        AdminBlockPH.Visible = True
        LotBlockPH.Visible = True
        'Else
        'AdminBlockPH.Visible = False
        'LotBlockPH.Visible = False
        'End If
        'If Not IsNothing(selectedUser) AndAlso manager.IsInRole(selectedUser.Id, "TBAdmin") Then
        '    AdminBlockPH.Visible = True
        'Else
        '    AdminBlockPH.Visible = False
        'End If
        'End If


        Try
            'Populate stat labels.
            Using db As New TBTracingEntities
                lblClientCount.Text = db.vwClients.Count()
                'lblClinicCount.Text = db.clinic_TBClinic.Count()
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error populating default page.", "default.aspx", ex)
            Session.Add("ErrorMessage", "Error populating default page.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try

    End Sub
End Class