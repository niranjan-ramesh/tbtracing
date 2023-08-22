<%@ Page Title="User Management" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="UserAdministration.aspx.vb" Inherits="TBTracing.UserAdministration" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/" runat="server"><i class="fa fa-home"></i>Home</a></li>
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

        <div class="row">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-lg-12 col-lg-offset-3">
                        <div>
                            <asp:ValidationSummary ID="noteValidationSummary" runat="server" CssClass="validation error" HeaderText="<strong>User Management Errors:</strong>" />
                        </div>
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
                    <li class="add-new pull-right"><asp:LinkButton ID="btnAddUser" runat="server" CausesValidation="False"><i class="fa fa-plus"></i> Add New User</asp:LinkButton></li>
                </ul>
        
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active" id="userList">

                        <!-- User List Gridview Panel -->
                        <asp:Panel ID="userGridviewPanel" runat="server">
                            Total Users: <asp:Literal ID="userCount" runat="server"></asp:Literal>
                            <asp:GridView ID="gvUserList" runat="server" AutoGenerateColumns="false" DataKeyNames="Username"
                                CssClass="table table-striped table-bordered table-hover table-condensed">
                                <AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
                                <Columns>
                                    <asp:BoundField DataField="Username" HeaderText="Username" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                    <asp:BoundField DataField="LastActivityDate" HeaderText="Last Activity Date" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                    <asp:CheckBoxField DataField="IsOnline" HeaderText="Is Online?" ReadOnly="True" SortExpression="IsOnline" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                    <asp:BoundField DataField="LastLoginDate" HeaderText="Last Login Date" SortExpression="LastLoginDate" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                    <asp:TemplateField HeaderText="Roles" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                         <ItemTemplate>
                                           <%# Container.DataItem.ToString() %>
                                         </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                        <ItemTemplate>
                                            <asp:LinkButton CausesValidation="false" ID="ResetPasswordButton" runat="server" ControlStyle-CssClass="btn btn-success btn-sm"
                                                CommandName="ResetPassword" CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>"                                    
                                                Text="<span><i class='fa fa-repeat fa-lg'></i> Reset Password</span>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                        <ItemTemplate>
                                            <asp:LinkButton CausesValidation="false" ID="EditUserButton" runat="server" ControlStyle-CssClass="btn btn-info btn-sm"
                                                CommandName="EditUser" CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>"
                                                Text="<span><i class='fa fa-pencil fa-lg'></i> Edit User</span>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>

                        <!-- Reset Password Panel -->
                        <asp:Panel ID="passwordPanel" runat="server" Visible="False">
                            <div class="row">
                                <div class="col-lg-6 col-lg-offset-3">
                                    <div class="main-box">
                                        <div class="panel panel-default margin-top-20">
                                            <div class="panel-heading">
                                                <h3 class="panel-title"><span>Reset Password for <strong><asp:Literal ID="litUserName" runat="server" Text=""></asp:Literal></strong></span></h3>
                                            </div>
                                            <div class="panel-body">
                                                <div class="form-horizontal">
                                                    <div class="form-group">  
                                                        <label for="tbUserEmail" class="col-sm-5 control-label">New Password</label> 
                                                        <div class="col-sm-6">     
                                                            <div>                                     
                                                                <asp:TextBox ID="txtPassword" runat="server" class="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group"> 
                                                        <div class="col-lg-offset-5 col-lg-6"> 
                                                                <asp:LinkButton ID="btnSavePassword" runat="server" Text="" CssClass="btn btn-primary" ViewStateMode="Enabled"><i class="fa fa-floppy-o fa-lg"></i> Save</asp:LinkButton>
                                                                <asp:LinkButton ID="btnCancelPassword" runat="server" Text="" CssClass="btn btn-default" ViewStateMode="Enabled" CausesValidation="False"><i class="fa fa-times fa-lg"></i> Cancel</asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    
                        <!-- Add/Edit Form Panel -->
                        <asp:Panel ID="userDetailPanel" runat="server" Visible="False">
                            <div id="add-new" class="row">
                                <div class="col-lg-12">
                                    <div class="main-box">
                                        <h3 class="main-box-title"><asp:Literal ID="userDetailFormTitle" runat="server" Text="Add a New User"></asp:Literal></h3>

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
                                                                        ControlToValidate="Username" Display="None" ErrorMessage="<strong>Username</strong> is required" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-4 control-label">Password</asp:Label>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" />
                                                                    <asp:RequiredFieldValidator ID="PasswordRFV" runat="server" ValidationGroup="User" EnableClientScript="False"
                                                                        ControlToValidate="Password" Display="None" ErrorMessage="<strong>Password</strong> is required." />
                                                                    <asp:CustomValidator ID="minLengthValidation" runat="server" CssClass="form-control" EnableClientScript="false" 
                                                                         ValidationGroup="User"  Display="None" ErrorMessage="Password Length"></asp:CustomValidator>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-4 control-label">Confirm Password</asp:Label>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" />
                                                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRFV" runat="server" ValidationGroup="User" EnableClientScript="False"
                                                                        ControlToValidate="ConfirmPassword" Display="None" ErrorMessage="<strong>Confirm Password</strong> field is required." />
                                                                    <asp:CompareValidator ID="PasswordCV" runat="server" ValidationGroup="User" EnableClientScript="False"
                                                                        ControlToValidate="ConfirmPassword" ControlToCompare="Password" Display="None" ErrorMessage="<strong>Password</strong> and <strong>Confirm password</strong> do not match." />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4">
                                                            <div class="form-group">
                                                                <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-4 control-label">Email</asp:Label>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                                                                    <asp:RequiredFieldValidator ID="emailrfv" runat="server" ValidationGroup="User" EnableClientScript="False"
                                                                        ControlToValidate="email" Display="none" ErrorMessage="<strong>Email<strong> is required." />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <asp:Label runat="server" AssociatedControlID="FirstName" CssClass="col-md-4 control-label">Full Name</asp:Label>
                                                                <div class="col-md-8">
                                                                    <asp:TextBox runat="server" ID="FirstName" CssClass="form-control" />
                                                                    <asp:RequiredFieldValidator ID="FirstNameRFV" runat="server" ValidationGroup="User" EnableClientScript="False"
                                                                        ControlToValidate="FirstName" Display="None" ErrorMessage="<strong>Full Name</strong> is required." />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4">
                                                            <div class="well">
                                                                <h3 class="main-box-title">Roles</h3>
                                                                <div class="row">
                                                                    <div class="col-lg-7">
                                                                        <div class="checkbox">
                                                                            <asp:CheckBoxList ID="cblRoles" runat="server" CssClass="checkbox"></asp:CheckBoxList>
                                                                        </div>
                                                                    </div>
                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <div class="col-sm-6 col-sm-offset-6">
                                                            <asp:LinkButton ID="btnSave" runat="server" Text="" CssClass="btn btn-primary" ViewStateMode="Enabled" ValidationGroup="User"><i class="fa fa-check fa-lg"></i> Save</asp:LinkButton>
                                                            <asp:LinkButton ID="btnCancel" runat="server" Text="" CssClass="btn btn-default" ViewStateMode="Enabled" CausesValidation="False"><i class="fa fa-times fa-lg"></i> Cancel</asp:LinkButton>
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

    <asp:RequiredFieldValidator ID="newPasswordReq" runat="server"
        ErrorMessage="Password Required." ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
    <asp:CustomValidator ID="updateValidation" runat="server" Display="None"
        EnableClientScript="False"></asp:CustomValidator>
</asp:Content>
