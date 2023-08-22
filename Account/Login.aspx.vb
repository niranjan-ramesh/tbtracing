Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports System.Web
Imports System.Web.UI
Imports Microsoft.Owin.Security

Partial Public Class Login
    Inherits Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'RegisterHyperLink.NavigateUrl = "Register"
        'OpenAuthLogin.ReturnUrl = Request.QueryString("ReturnUrl")
        Dim returnUrl = HttpUtility.UrlEncode(Request.QueryString("ReturnUrl"))
        'If Not [String].IsNullOrEmpty(returnUrl) Then
        '    RegisterHyperLink.NavigateUrl += "?ReturnUrl=" & returnUrl
        'End If
    End Sub

    Protected Sub LogIn(sender As Object, e As EventArgs)
        If IsValid Then
            Try
                If Membership.ValidateUser(UserName.Text.Trim(), Password.Text.Trim()) Then
                    FormsAuthentication.SetAuthCookie(UserName.Text.Trim(), False)
                    'check to see if they have ever reset their password.
                    Dim currUser As MembershipUser = Membership.GetUser(UserName.Text.Trim())
                    FormsAuthentication.RedirectFromLoginPage(UserName.Text.Trim(), False)
                    TBAudit.addAudit(TBAudit.LoginType, "User login: " & UserName.Text.Trim(), "User Login", Nothing)
                Else
                    TBAudit.addAudit(TBAudit.LoginType, "Failed login: " & UserName.Text.Trim(), "User Login", Nothing)
                    FailureText.Text = "Invalid username or password."
                    ErrorMessage.Visible = True
                End If
            Catch ex As Exception
                LogHelper.LogError("Error on log in.", "Login Error", ex)
            End Try
        End If
    End Sub
End Class
