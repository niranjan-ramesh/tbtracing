<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Default.aspx.vb" Inherits="TBTracing._Default1" %>

<%@ Import Namespace="Microsoft.AspNet.Identity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="~/Admin/" runat="server">Admin</a></li>
            <li class="active">User Management</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-users"></i> User Management</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row margin-top-10">
            <div class="col-xs-12">

                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist" id="Tabs">
                    <li role="presentation" class="active">
                        <asp:LinkButton ID="lbTabUserList" runat="server" href="#userList" aria-controls="home" role="tab" data-toggle="tab">User List</asp:LinkButton>
                    </li>
                    <li class="add-new pull-right"><asp:LinkButton ID="btnAddNew" runat="server"><i class="fa fa-plus"></i> Add New User</asp:LinkButton></li>
                </ul>

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active" id="userList">   
                        
                    <!-- User List Gridview -->
                    <asp:Panel ID="userGridviewPanel" runat="server">
                        Total Users: <asp:Literal ID="userCount" runat="server"></asp:Literal>
                        <asp:GridView ID="gvUserList" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-striped table-bordered table-hover table-condensed" DataKeyNames="UserID"
                            AlternatingRowStyle-CssClass="alt" PagerStyle-CssClass="pagination"
                            EmptyDataText="Sorry, no users found." EmptyDataRowStyle-CssClass="notice">
                            <Columns>
                                <asp:BoundField DataField="UserID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="UserID" Visible="False" />
                                <asp:BoundField DataField="UserName" HeaderText="User Name" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="FirstName" HeaderText="First Name" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="LastName" HeaderText="Last Name" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Email" HeaderText="Email" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="User?" ShowHeader="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="isAdmin" runat="server" Checked='<%# Convert.ToBoolean(Eval("isUser"))%>' Enabled="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Admin?" ShowHeader="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="isITAdmin" runat="server" Checked='<%# Convert.ToBoolean(Eval("isAdmin"))%>' Enabled="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditUser" runat="server" ControlStyle-CssClass="btn btn-info btn-sm" 
                                            CommandName="EditUser" ItemStyle-VerticalAlign="Middle" ItemStyle-CssClass="button"
                                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>"
                                            Text="<span><i class='fa fa-pencil fa-lg'></i> Edit</span>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnResetPassword" runat="server" ControlStyle-CssClass="btn btn-success btn-sm" 
                                        CommandName="ResetUserPassword" ItemStyle-VerticalAlign="Middle"
                                        CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>"
                                        Text="<span><i class='fa fa-repeat fa-lg'></i> Reset Password</span>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>   
                        </asp:GridView>
                    </asp:Panel>

                    <!-- Add/Edit Form Panel -->
                    <asp:Panel ID="userDetailPanel" runat="server" Visible="False">
                        <div id="add-new" class="row">
                            <div class="col-lg-12">
                                <div class="main-box"> 
                                    <h3><asp:Literal ID="userDetailFormTitle" runat="server" Text="Add a New User"></asp:Literal></h3>

                                    <div class="row">                                    
                                        <div class="col-lg-12">
                                            <div class="form-horizontal">
                                                <p class="text-danger">
                                                    <asp:Literal runat="server" ID="ErrorMessage" />
                                                </p>

                                                <asp:Panel ID="StatusMessagePanel" Visible="False" runat="server" CssClass="alert alert-danger">
                                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                                    <asp:ValidationSummary ID="UserValidation" runat="server" ShowSummary="true" ClientIDMode="Static"
                                                        DisplayMode="BulletList" CssClass="alert" ForeColor="" HeaderText="<strong>Please correct the following:</strong>"
                                                        ValidationGroup="User" />
                                                </asp:Panel>

                                                <div class="row">
                                                    <div class="col-lg-4">
                                                        <div class="form-group">
                                                            <asp:Label runat="server" AssociatedControlID="Username" CssClass="col-md-4 control-label">Username</asp:Label>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="Username" runat="server" CssClass="form-control" />
                                                                <asp:RequiredFieldValidator ID="UsernameRFV" runat="server" ValidationGroup="User" EnableClientScript="False" 
                                                                    ControlToValidate="Username" Display="None" ErrorMessage="<strong>Username</strong> is required"  />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-4 control-label">Password</asp:Label>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" />
                                                                <asp:RequiredFieldValidator ID="PasswordRFV" runat="server" ValidationGroup="User" EnableClientScript="False"
                                                                    ControlToValidate="Password" Display="None" ErrorMessage="<strong>Password</strong> is required." />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-4 control-label">Confirm Password</asp:Label>
                                                            <div class="col-md-8">
                                                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" />
                                                                <asp:RequiredFieldValidator ID="ConfirmPasswordRFV" runat="server" ValidationGroup="User" EnableClientScript="False" 
                                                                    ControlToValidate="ConfirmPassword" Display="None" ErrorMessage="<strong>Confirm Password</strong> field is required." />
                                                                <asp:CompareValidator ID="PasswordCV" runat="server" ValidationGroup="User" EnableClientScript="False" 
                                                                    ControlToValidate="ConfirmPassword" ControlToCompare="Password"  Display="None" ErrorMessage="<strong>Password</strong> and <strong>Confirm password</strong> do not match."  />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <div class="form-group">
                                                            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-4 control-label">Email</asp:Label>
                                                            <div class="col-md-8">
                                                                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                                                                <asp:requiredfieldvalidator id="emailrfv" runat="server" validationgroup="User" EnableClientScript="False" 
                                                                    controltovalidate="email" display="none" errormessage="<strong>Email<strong> is required." />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <asp:Label runat="server" AssociatedControlID="FirstName" CssClass="col-md-4 control-label">First Name</asp:Label>
                                                            <div class="col-md-8">
                                                                <asp:TextBox runat="server" ID="FirstName" CssClass="form-control" />
                                                                <asp:RequiredFieldValidator ID="FirstNameRFV" runat="server" ValidationGroup="User" EnableClientScript="False" 
                                                                    ControlToValidate="FirstName" Display="None" ErrorMessage="<strong>First Name</strong> is required." />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <asp:Label runat="server" AssociatedControlID="LastName" CssClass="col-md-4 control-label">Last Name</asp:Label>
                                                            <div class="col-md-8">
                                                                <asp:TextBox runat="server" ID="LastName" CssClass="form-control" />
                                                                <asp:RequiredFieldValidator ID="LastNameRFV" runat="server" ValidationGroup="User" EnableClientScript="False" 
                                                                    ControlToValidate="LastName" Display="None" ErrorMessage="<strong>Last Name</strong> is required." />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <div class="well">
                                                            <h3>Roles</h3>
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="checkbox">
                                                                        <asp:CheckBoxList ID="cblRoles" runat="server" CssClass="checkbox"></asp:CheckBoxList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6">
                                                                    <div class="text-right">
                                                                        <a class="btn btn-primary btn-lg" data-toggle="modal" data-target="#addRoleModal">Add New Role</a> 
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-sm-6 col-sm-offset-6">
                                                        <asp:LinkButton ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" ViewStateMode="Enabled" ValidationGroup="User"><i class="fa fa-check fa-lg"></i> Save</asp:LinkButton>
                                                        <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" ViewStateMode="Enabled"><i class="fa fa-times fa-lg"></i> Cancel</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <!-- Change Password Panel -->
                    <asp:Panel ID="ChangePasswordPanel" runat="server" Visible="False">
                        <div class="row">
                            <div class="col-lg-6 col-lg-offset-3">
                                <div class="main-box">

                                    <div class="panel panel-default margin-top-20">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><span>Reset Password for <strong><asp:Literal ID="litUserName" runat="server" Text=""></asp:Literal></strong></span></h3>
                                        </div>
                                        <div class="panel-body">                                            
                                            <asp:HiddenField ID="hdnChangePasswordUserID" runat="server" />
                                            <asp:Panel ID="ChangePasswordStatusMessagePanel" Visible="False" runat="server" CssClass="message-box alert alert-danger" ClientIDMode="Static">
                                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                                <asp:ValidationSummary ID="ChangePasswordValidation" runat="server" ShowSummary="true" ClientIDMode="Static" ValidationGroup="ChangePassword"
                                                    DisplayMode="BulletList" CssClass="alert" ForeColor="" HeaderText="<strong>Validation Errors:</strong>" />    
                                            </asp:Panel>
                                            <div class="form-horizontal">
                                                <div class="form-group">  
                                                    <label for="tbUserEmail" class="col-sm-5 control-label">New Password</label> 
                                                    <div class="col-sm-6">    
                                                        <div>                                     
                                                            <asp:TextBox ID="txtPassword" runat="server" class="form-control" />
                                                            <asp:RequiredFieldValidator ID="tbPasswordRFV" runat="server" ValidationGroup="ChangePassword" 
                                                                ControlToValidate="txtPassword" Display="None" ErrorMessage="Please input a password"  />
                                                        </div>
                                                    </div>  
                                                </div>
                                                <div class="form-group"> 
                                                    <div class="col-lg-offset-5 col-lg-6">
                                                        <asp:LinkButton ID="btnSavePassword" runat="server" Text="" CssClass="btn btn-primary" ViewStateMode="Enabled"><i class="fa fa-floppy-o fa-lg"></i> Save</asp:LinkButton>
                                                        <asp:LinkButton ID="btnCancelPassword" runat="server" Text="" CssClass="btn btn-default" ViewStateMode="Enabled"><i class="fa fa-times fa-lg"></i> Cancel</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    </div>
                </div>  
            </div>
        </div>
    </section>
    <!-- Modal -->
    <div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">Add a New Role</h4>
          </div>
          <div class="modal-body">
            <div class="form-horizontal">

                <asp:ValidationSummary runat="server" CssClass="text-danger" ValidationGroup="AddNewRole" />

                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Role" CssClass="col-md-4 control-label">Role</asp:Label>
                            <div class="col-md-8">
                                <asp:TextBox runat="server" ID="Role" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Role" CssClass="text-danger" ErrorMessage="Role is required." ValidationGroup="AddNewRole" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
          </div>
          <div class="modal-footer">
            <asp:LinkButton ID="CreateRole" runat="server" CssClass="btn btn-primary" ValidationGroup="AddNewRole"><i class="fa fa-floppy-o"></i> Save Role</asp:LinkButton>
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Close</button>
          </div>
        </div>
      </div>
    </div>

<script type="text/javascript">
    $(function () {
        $('#StatusMessagePanel').hide();
    });
</script>
</asp:Content>
