Public Class UserAdministration
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        userCount.Text = Membership.GetAllUsers.Count()
        gvUserList.DataSource = Membership.GetAllUsers()
        gvUserList.DataBind()
    End Sub

#Region "UI Helpers"
    Private Sub resetPage()
        passwordPanel.Visible = False
        userDetailPanel.Visible = False
        userGridviewPanel.Visible = True
        litUserName.Text = ""
        txtPassword.Text = ""
        btnAddUser.Visible = True
    End Sub

    Private Sub clearUserSlate()
        FirstName.Text = String.Empty
        Username.Text = String.Empty
        Email.Text = String.Empty
        Password.Text = String.Empty
        ConfirmPassword.Text = String.Empty
    End Sub

    Private Sub populateRolesCBL()
        cblRoles.DataSource = Roles.GetAllRoles()
        cblRoles.DataBind()
    End Sub
#End Region

#Region "GV Row Command"

    Protected Sub gvUserList_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvUserList.RowCommand
        'Get the row which was selected in the gridview
        litUserName.Text = ""
        txtPassword.Text = ""

        Dim index As Integer = Convert.ToInt32(e.CommandArgument)
        Dim strUserName As String = gvUserList.Rows(index).Cells(0).Text

        If e.CommandName.Equals("ResetPassword") Then
            passwordPanel.Visible = True
            userDetailPanel.Visible = False
            userGridviewPanel.Visible = False
            litUserName.Text = strUserName
            btnAddUser.Visible = False
        ElseIf e.CommandName.Equals("EditUser") Then
            passwordPanel.Visible = False
            userDetailPanel.Visible = True
            userGridviewPanel.Visible = False
            btnAddUser.Visible = False

            'Clear slate and repopulate
            clearUserSlate()

            Dim userToUpdate As MembershipUser = Membership.GetUser(strUserName)

            If Not IsNothing(userToUpdate) Then
                'Dummy out passwords

                Username.Text = strUserName
                Username.ReadOnly = True
                Password.ReadOnly = True
                ConfirmPassword.ReadOnly = True
                Password.Text = "123456789"
                ConfirmPassword.Text = "123456789"

                PasswordRFV.Enabled = False
                ConfirmPasswordRFV.Enabled = False
                minLengthValidation.Enabled = False

                Email.Text = userToUpdate.Email

                Dim strKey = userToUpdate.ProviderUserKey.ToString()
                Dim aspID As Guid = Guid.Parse(strKey)

                Using db As New TBTracingEntities()
                    Dim tbUser As common_TBUser = (From objUser In db.common_TBUser _
                                                  Where objUser.AspNetUserID = aspID _
                                                  Select objUser).FirstOrDefault()

                    If Not IsNothing(tbUser) Then
                        FirstName.Text = tbUser.NameLabel
                    End If
                End Using

                'Populate Roles.
                populateRolesCBL()
                For Each cblRole As ListItem In cblRoles.Items
                    If Roles.IsUserInRole(strUserName, cblRole.Value) Then
                        cblRole.Selected = True
                    Else
                        cblRole.Selected = False
                    End If
                Next

            Else
                Session.Add("ErrorMessage", "Error retrieving user")
                Response.Redirect("~/ErrorPage.aspx", False)
            End If
        End If
    End Sub

#End Region

#Region "Password Button Clicks"
    Protected Sub btnCancelPassword_Click(sender As Object, e As EventArgs) Handles btnCancelPassword.Click
        resetPage()
    End Sub

    Protected Sub btnSavePassword_Click(sender As Object, e As EventArgs) Handles btnSavePassword.Click
        If Page.IsValid Then
            Try
                Dim user As MembershipUser = Membership.GetUser(litUserName.Text)
                user.ChangePassword(user.ResetPassword, txtPassword.Text)
                Response.Redirect(Request.RawUrl)
            Catch ex As Exception
                Dim errMsg As String = ex.Message()
                updateValidation.ErrorMessage = errMsg & " Please try again."
                updateValidation.IsValid = False
                LogHelper.LogError("Error reseting password.", "UserManagement", ex)
            End Try
            If Not Page.IsValid Then
                'Input failed validation.  Display validation summary.
                noteValidationSummary.Visible = True
            End If
        End If
    End Sub
#End Region

#Region "User Button Clicks"
    Protected Sub addUser_Click(sender As Object, e As EventArgs) Handles btnAddUser.Click
        passwordPanel.Visible = False
        userDetailPanel.Visible = True
        userGridviewPanel.Visible = False
        btnAddUser.Visible = False
        Username.ReadOnly = False
        Password.ReadOnly = False
        ConfirmPassword.ReadOnly = False
        PasswordRFV.Enabled = True
        ConfirmPasswordRFV.Enabled = True
        minLengthValidation.Enabled = True
        populateRolesCBL()
        clearUserSlate()
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        resetPage()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        If Page.IsValid Then
            'If user name is read-only its an update.  Otherwise its an add
            If Username.ReadOnly Then
                Try
                    Dim userToUpdate As MembershipUser = Membership.GetUser(Username.Text)
                    If Not IsNothing(userToUpdate) Then
                        userToUpdate.Email = Email.Text

                        ' Check Roles
                        For Each roleItem As ListItem In cblRoles.Items
                            Dim roleName As String = roleItem.Text
                            If roleItem.Selected = True AndAlso Not Roles.IsUserInRole(userToUpdate.UserName, roleItem.Value) Then
                                Roles.AddUserToRole(userToUpdate.UserName, roleItem.Value)
                            ElseIf Not roleItem.Selected AndAlso Roles.IsUserInRole(userToUpdate.UserName, roleItem.Value) Then
                                Roles.RemoveUserFromRole(userToUpdate.UserName, roleItem.Value)
                            End If
                        Next

                        Dim strKey = userToUpdate.ProviderUserKey.ToString()
                        Dim aspID As Guid = Guid.Parse(strKey)

                        Using db As New TBTracingEntities()
                            Dim tbUser As common_TBUser = (From objUser In db.common_TBUser _
                                                          Where objUser.AspNetUserID = aspID _
                                                          Select objUser).FirstOrDefault()

                            If Not IsNothing(tbUser) Then
                                tbUser.NameLabel = FirstName.Text
                                tbUser.common_Clinicians.Username = FirstName.Text
                                db.SaveChanges()
                            End If
                        End Using

                        Response.Redirect(Request.RawUrl, False)
                    Else
                        Session.Add("ErrorMessage", "Error retrieving user")
                        Response.Redirect("~/ErrorPage.aspx", False)
                    End If
                Catch ex As Exception
                    LogHelper.LogError("User admin", "Error updating user.", ex)
                    Session.Add("ErrorMessage", "Error updating User")
                    Response.Redirect("~/ErrorPage.aspx", False)
                End Try

            Else
                'Add the user
                Try
                    Dim user As MembershipUser = Membership.CreateUser(Username.Text, Password.Text, Email.Text)
                    If Not IsNothing(user) Then
                        'Now add the Roles.
                        For Each cbRole As ListItem In cblRoles.Items
                            If cbRole.Selected Then
                                Roles.AddUserToRole(user.UserName, cbRole.Value)
                            End If
                        Next

                        Using db As New TBTracingEntities()
                            Dim tbUser As common_TBUser = New common_TBUser()
                            tbUser.Active = True
                            tbUser.NameLabel = FirstName.Text
                            Dim strKey = Membership.GetUser(Username.Text).ProviderUserKey.ToString()
                            tbUser.AspNetUserID = Guid.Parse(strKey)

                            Dim objClinician As common_Clinicians = New common_Clinicians
                            objClinician.Active = True
                            objClinician.Username = FirstName.Text
                            tbUser.common_Clinicians = objClinician
                            db.common_TBUser.Add(tbUser)
                            db.SaveChanges()
                        End Using

                        Response.Redirect(Request.RawUrl, False)
                    Else
                        Session.Add("ErrorMessage", "Error Retrieving Note")
                        Response.Redirect("~/ErrorPage.aspx", False)
                    End If
                Catch ex As Exception
                    LogHelper.LogError("User admin", "Error adding user.", ex)
                    Session.Add("ErrorMessage", "Error Adding User")
                    Response.Redirect("~/ErrorPage.aspx", False)
                End Try

            End If

        Else
            StatusMessagePanel.Visible = True
        End If
    End Sub
#End Region

#Region "Validations"
    Protected Sub minLengthValidation_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles minLengthValidation.ServerValidate
        If Password.Text.Length < Membership.MinRequiredPasswordLength Then
            minLengthValidation.IsValid = False
            minLengthValidation.ErrorMessage = "Password must be at least " & Membership.MinRequiredPasswordLength.ToString() & " characters."
            args.IsValid = False
        End If
    End Sub
#End Region

#Region "Gridview Role Binding"
    Protected Sub gvUserList_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvUserList.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim cell As TableCell = e.Row.Cells(4)
            Dim userName As String = gvUserList.DataKeys(e.Row.RowIndex).Value.ToString()
            cell.Text = String.Join(", ", Roles.GetRolesForUser(userName))
        End If

    End Sub
#End Region

#Region "Gridview PreRender"
    Private Sub gvUserList_PreRender(sender As Object, e As EventArgs) Handles gvUserList.PreRender
        If Not IsNothing(gvUserList) AndAlso Not IsNothing(gvUserList.HeaderRow) Then gvUserList.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub
#End Region

End Class