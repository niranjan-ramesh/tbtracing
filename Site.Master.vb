Imports System
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports System.ComponentModel.DataAnnotations
Imports Owin

Public Class SiteMaster
    Inherits MasterPage
    Private Const AntiXsrfTokenKey As String = "__AntiXsrfToken"
    Private Const AntiXsrfUserNameKey As String = "__AntiXsrfUserName"
    Private _antiXsrfTokenValue As String

    Protected Sub Page_Init(sender As Object, e As EventArgs)
        'Live/Test styles
        PageBody.Attributes("class") = My.Settings.LiveTestStyle
        ltTest.Text = My.Settings.LiveTestHeader

        ''Stop Caching in IE
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache)

        ''Stop Caching in Firefox
        Response.Cache.SetNoStore()

        ' The code below helps to protect against XSRF attacks
        Dim requestCookie = Request.Cookies(AntiXsrfTokenKey)
        Dim requestCookieGuidValue As Guid
        If requestCookie IsNot Nothing AndAlso Guid.TryParse(requestCookie.Value, requestCookieGuidValue) Then
            ' Use the Anti-XSRF token from the cookie
            _antiXsrfTokenValue = requestCookie.Value
            Page.ViewStateUserKey = _antiXsrfTokenValue
        Else
            ' Generate a new Anti-XSRF token and save to the cookie
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N")
            Page.ViewStateUserKey = _antiXsrfTokenValue

            Dim responseCookie = New HttpCookie(AntiXsrfTokenKey) With { _
                 .HttpOnly = True, _
                 .Value = _antiXsrfTokenValue _
            }
            If FormsAuthentication.RequireSSL AndAlso Request.IsSecureConnection Then
                responseCookie.Secure = True
            End If
            Response.Cookies.[Set](responseCookie)
        End If

        AddHandler Page.PreLoad, AddressOf master_Page_PreLoad
    End Sub

    Protected Sub master_Page_PreLoad(sender As Object, e As EventArgs)
        If Not IsPostBack Then
            ' Set Anti-XSRF token
            ViewState(AntiXsrfTokenKey) = Page.ViewStateUserKey
            ViewState(AntiXsrfUserNameKey) = If(Context.User.Identity.Name, [String].Empty)
        Else
            ' Validate the Anti-XSRF token
            If DirectCast(ViewState(AntiXsrfTokenKey), String) <> _antiXsrfTokenValue OrElse DirectCast(ViewState(AntiXsrfUserNameKey), String) <> (If(Context.User.Identity.Name, [String].Empty)) Then
                Throw New InvalidOperationException("Validation of Anti-XSRF token failed.")
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Form.Attributes.Add("autocomplete", "off")
        Dim cookie As HttpCookie = Request.Cookies.Item("sidebar")

        If Not IsNothing(cookie) Then
            Dim currentClass As String = PageBody.Attributes.Item("class")

            'If cookie is set to collapse and body doesn't have style then add it.
            If cookie.Value.Equals("collapse") AndAlso Not currentClass.Contains("sidebar-collapse") Then
                currentClass += " sidebar-collapse"
            ElseIf cookie.Value.Equals("expand") AndAlso currentClass.Contains("sidebar-collapse") Then
                currentClass = currentClass.Remove("sidebar-collapse")
            End If

            PageBody.Attributes.Remove("class")
            PageBody.Attributes.Add("class", currentClass)
        End If

        'If HttpContext.Current.User.Identity.IsAuthenticated Then
        'Dim manager = New UserManager()
        'Dim selectedUser As ApplicationUser = manager.FindByName(HttpContext.Current.User.Identity.Name)
        'Dim userDisplayName As String = selectedUser.FirstName & " " & selectedUser.LastName
        'displayName.Text = userDisplayName
        displayName.Text = "User1"

        Dim RoleManager = New RoleManager(Of IdentityRole)(New RoleStore(Of IdentityRole)(New ApplicationDbContext()))
        Dim appContext As New ApplicationDbContext()
        'Dim roleList = appContext.Roles.ToList()

        'If Roles.IsUserInRole("TBAdmin") Then
        AdminMenuPH.Visible = True
        'Else
        'AdminMenuPH.Visible = False
        'End If
        'If manager.IsInRole(selectedUser.Id, "TBAdmin") Then
        '    AdminMenuPH.Visible = True
        'Else
        '    AdminMenuPH.Visible = False
        'End If
        'End If

        If Not Page.IsPostBack Then
            Dim userName As String = "N/A"
            'If Not IsNothing(HttpContext.Current.User) Then
            'userName = HttpContext.Current.User.Identity.Name
            'End If
            'TBAudit.addAudit(TBAudit.PageView, "PageView - User:" & userName, "Page: " & Request.RawUrl, Nothing)



        End If

    End Sub

    Protected Sub Unnamed_LoggingOut(sender As Object, e As LoginCancelEventArgs)
        Context.GetOwinContext().Authentication.SignOut()
    End Sub

End Class