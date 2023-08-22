Imports System
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Microsoft.AspNet.Identity.Owin
Imports System.ComponentModel.DataAnnotations
Imports Owin

Public Class _Default1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GetUserList()
            GetUserCount()
            GetRoleList()
        End If
    End Sub

    Protected Sub GetUserList()
        Dim dTable As New DataTable()
        dTable.Columns.Add("UserID", GetType(String))
        dTable.Columns.Add("UserName", GetType(String))
        dTable.Columns.Add("FirstName", GetType(String))
        dTable.Columns.Add("LastName", GetType(String))
        dTable.Columns.Add("Email", GetType(String))
        dTable.Columns.Add("isUser", GetType(String))
        dTable.Columns.Add("isAdmin", GetType(String))

        Dim manager = New UserManager()
        Dim userContext As New ApplicationDbContext()

        For Each u As ApplicationUser In userContext.Users.ToList()
            Dim dRow As DataRow = dTable.NewRow()
            dRow("UserID") = u.Id
            dRow("UserName") = u.UserName
            dRow("FirstName") = u.FirstName
            dRow("LastName") = u.LastName
            dRow("Email") = u.EmailAddr

            'Dim roles = userContext.Roles.ToList()

            dRow("isUser") = If(manager.IsInRole(u.Id, "TBUser"), True, False)
            dRow("isAdmin") = If(manager.IsInRole(u.Id, "TBAdmin"), True, False)

            dTable.Rows.Add(dRow)
        Next

        gvUserList.DataSource = dTable
        gvUserList.DataBind()
    End Sub

    Private Sub GetUserCount()
        Dim userContext As New ApplicationDbContext()
        userCount.Text = userContext.Users.Count()
    End Sub

    Private Sub GetRoleList()
        Dim RoleManager = New RoleManager(Of IdentityRole)(New RoleStore(Of IdentityRole)(New ApplicationDbContext()))
        Dim appContext As New ApplicationDbContext()
        Dim roleList = appContext.Roles.ToList()

        cblRoles.DataTextField = "Name"
        cblRoles.DataValueField = "ID"
        cblRoles.DataSource = roleList
        cblRoles.DataBind()
    End Sub

    Private Sub gvUserList_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvUserList.RowCommand
        If e.CommandName.ToString <> "Sort" And e.CommandName.ToString <> "Page" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim selectedUserID As String = gvUserList.DataKeys(index).Value
            Dim selectedUserName As String = gvUserList.Rows(index).Cells(1).Text
            Dim manager = New UserManager()
            Dim selectedUser As ApplicationUser = manager.FindByName(selectedUserName)
            Select Case e.CommandName.ToString
                Case "ResetUserPassword"
                    btnAddNew.Visible = False
                    userGridviewPanel.Visible = False
                    ChangePasswordPanel.Visible = True
                    userDetailPanel.Visible = False
                    hdnChangePasswordUserID.Value = selectedUserID
                    litUserName.Text = selectedUserName
                    ViewState.Add("Mode", "")
                Case "EditUser"
                    Username.Text = selectedUserName
                    Username.ReadOnly = True
                    Password.ReadOnly = True
                    ConfirmPassword.ReadOnly = True
                    Password.Text = "123456"
                    ConfirmPassword.Text = "123456"
                    Email.Text = selectedUser.EmailAddr
                    FirstName.Text = selectedUser.FirstName
                    LastName.Text = selectedUser.LastName

                    PasswordRFV.Enabled = False
                    ConfirmPasswordRFV.Enabled = False

                    'Roles
                    Dim usersRoles = manager.GetRoles(selectedUserID)
                    For Each roleItem As ListItem In cblRoles.Items
                        If usersRoles.Contains(roleItem.Text.ToString()) Then
                            roleItem.Selected = True
                        Else
                            roleItem.Selected = False
                        End If
                    Next

                    btnAddNew.Visible = False
                    userGridviewPanel.Visible = False
                    ChangePasswordPanel.Visible = False
                    userDetailPanel.Visible = True
                    ViewState.Add("Mode", "Edit")
                Case "InactivateUser"

            End Select
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSave.Click
        Page.Validate("User")
        StatusMessagePanel.Visible = False
        If Page.IsValid Then
            Dim uName As String = Username.Text
            Dim emailAddr As String = Email.Text.ToString()
            Dim fName As String = FirstName.Text.ToString()
            Dim lName As String = LastName.Text.ToString()
            Dim manager = New UserManager()

            ' Override to allow periods in username
            manager.UserValidator = New UserValidator(Of ApplicationUser)(manager) With {
                .AllowOnlyAlphanumericUserNames = False
            }

            If ViewState("Mode") = "New" Then
                Dim user = New ApplicationUser() With {.UserName = uName, .EmailAddr = emailAddr, .FirstName = fName, .LastName = lName}
                Dim result = manager.Create(user, Password.Text)
                If result.Succeeded Then
                    ' Add user to all checked Roles
                    For Each roleItem As ListItem In cblRoles.Items
                        If roleItem.Selected = True Then
                            Dim roleName As String = roleItem.Text
                            manager.AddToRole(user.Id, roleName)
                        End If
                    Next

                    Using db As New TBTracingEntities()
                        Dim tbUser As common_TBUser = New common_TBUser()
                        tbUser.Active = True
                        tbUser.NameLabel = fName & " " & lName
                        tbUser.AspNetID = user.Id

                        Dim objClinician As common_Clinicians = New common_Clinicians
                        objClinician.Active = True
                        objClinician.Username = fName & " " & lName
                        tbUser.common_Clinicians = objClinician
                        db.common_TBUser.Add(tbUser)
                        db.SaveChanges()
                    End Using

                    'resetUserDetail()
                    'btnAddNew.Visible = False
                    'userDetailPanel.Visible = False
                    Response.Redirect(Request.RawUrl, False)
                Else
                    ErrorMessage.Text = result.Errors.FirstOrDefault()
                End If
            ElseIf ViewState("Mode") = "Edit" Then
                Dim selectedUser As ApplicationUser = manager.FindByName(uName)
                selectedUser.EmailAddr = emailAddr
                selectedUser.FirstName = fName
                selectedUser.LastName = lName
                manager.Update(selectedUser)

                ' Check Roles
                For Each roleItem As ListItem In cblRoles.Items
                    Dim roleName As String = roleItem.Text
                    If roleItem.Selected = True Then
                        manager.AddToRole(selectedUser.Id, roleName)
                    Else
                        manager.RemoveFromRole(selectedUser.Id, roleName)
                    End If
                Next

                Using db As New TBTracingEntities()
                    Dim tbUser As common_TBUser = (From objUser In db.common_TBUser _
                                                  Where objUser.AspNetID = selectedUser.Id _
                                                  Select objUser).FirstOrDefault()

                    If Not IsNothing(tbUser) Then
                        tbUser.NameLabel = fName & " " & lName
                        tbUser.common_Clinicians.Username = fName & " " & lName
                        db.SaveChanges()
                    End If

                End Using

                'resetUserDetail()
                'btnAddNew.Visible = False
                'userDetailPanel.Visible = False
                Response.Redirect(Request.RawUrl, False)
            End If
        Else
            StatusMessagePanel.Visible = True
        End If
    End Sub

    Private Sub CreateRole_Click(sender As Object, e As EventArgs) Handles CreateRole.Click
        Dim roleName As String = Role.Text
        Dim RoleManager = New RoleManager(Of IdentityRole)(New RoleStore(Of IdentityRole)(New ApplicationDbContext()))

        Try
            If RoleManager.RoleExists(roleName) Then
                'Msg.Text = "Role '" & Server.HtmlEncode(roleName) & "' already exists. Please specify a different role name."
                Return
            End If

            RoleManager.Create(New IdentityRole(roleName))
            'Msg.Text = "Role '" & Server.HtmlEncode(roleName) & "' created."

            ' Re-bind Role List
            cblRoles.DataBind()
        Catch ex As Exception
            'Msg.Text = "Role '" & Server.HtmlEncode(roleName) & "' <u>not</u> created."
        End Try
    End Sub

    Private Sub btnAddNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddNew.Click
        resetUserDetail()
        btnAddNew.Visible = False
        userGridviewPanel.Visible = False
        ChangePasswordPanel.Visible = False
        userDetailPanel.Visible = True
        Username.ReadOnly = False
        Password.ReadOnly = False
        ConfirmPassword.ReadOnly = False
        ViewState.Add("Mode", "New")
    End Sub

    Private Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click, btnCancelPassword.Click
        resetUserDetail()
        userDetailPanel.Visible = False
        btnAddNew.Visible = True
        userGridviewPanel.Visible = True
        ChangePasswordPanel.Visible = False
    End Sub

    Protected Sub btnSavePassword_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSavePassword.Click
        Page.Validate("ChangePassword")
        ChangePasswordStatusMessagePanel.Visible = False
        If Page.IsValid Then
            Try
                Dim manager = New UserManager()
                manager.RemovePassword(hdnChangePasswordUserID.Value)
                manager.AddPassword(hdnChangePasswordUserID.Value, txtPassword.Text)
                Response.Redirect(Request.RawUrl, False)
            Catch ex As Exception
                ' display message stating username is already in use
                Dim err As New CustomValidator
                err.ValidationGroup = "User"
                err.IsValid = False
                err.ErrorMessage = "An exception occurred: " & Server.HtmlEncode(ex.Message) & ". Please re-enter your values and try again."
                Page.Validators.Add(err)
                ChangePasswordValidation.Visible = True
            End Try
        Else
            ChangePasswordStatusMessagePanel.Visible = True
        End If
    End Sub

    Private Sub resetUserDetail()
        StatusMessagePanel.Visible = False
        userGridviewPanel.Visible = True
        btnAddNew.Visible = True
        Username.Text = String.Empty
        Password.Text = String.Empty
        ConfirmPassword.Text = String.Empty
        Email.Text = String.Empty
        FirstName.Text = String.Empty
        LastName.Text = String.Empty
        For Each cbItem As ListItem In cblRoles.Items
            cbItem.Selected = False
        Next
    End Sub

    Private Sub gvUserList_PreRender(sender As Object, e As EventArgs) Handles gvUserList.PreRender
        If gvUserList.Rows.Count > 0 Then
            gvUserList.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

End Class