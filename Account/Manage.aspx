<%@ Page Title="Manage" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Manage.aspx.vb" Inherits="TBTracing.Manage" %>

<%@ Import Namespace="TBTracing" %>
<%@ Import Namespace="Microsoft.AspNet.Identity" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li class="active">Change Password</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-key"></i> Change Password</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6 col-lg-offset-3">
                
                <div>
                    <asp:PlaceHolder runat="server" ID="SuccessMessagePlaceHolder" Visible="false" ViewStateMode="Disabled">
                        <div class="alert alert-success margin-top-20"><i class='fa fa-check-circle fa-2x'></i>&nbsp;&nbsp; <%: SuccessMessage %></div>
                    </asp:PlaceHolder>
                </div>

                <div class="panel panel-default margin-top-20">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span>Change Password for <strong><%: HttpContext.Current.User.Identity.Name%></strong></span></h3>
                    </div>
                    <div class="panel-body">

                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="alert alert-danger" ValidationGroup="ChangePassword" />

                        <div class="form-horizontal">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="col-sm-5 control-label">Current password</label>
                                        <div class="col-sm-5">
                                            <asp:TextBox runat="server" ID="CurrentPassword" TextMode="Password" CssClass="form-control" />
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                                CssClass="text-danger" ErrorMessage="The current password field is required."
                                                ValidationGroup="ChangePassword" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="col-sm-5 control-label">New password</label>
                                        <div class="col-sm-5">
                                            <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" />
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                                CssClass="text-danger" ErrorMessage="The new password is required."
                                                ValidationGroup="ChangePassword" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="col-sm-5 control-label">Confirm new password</label>
                                        <div class="col-sm-5">
                                            <asp:TextBox runat="server" ID="ConfirmNewPassword" TextMode="Password" CssClass="form-control" />
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                                CssClass="text-danger" Display="Dynamic" ErrorMessage="Confirm new password is required."
                                                ValidationGroup="ChangePassword" />
                                            <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The new password and confirmation password do not match."
                                                ValidationGroup="ChangePassword" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="col-md-offset-5 col-md-7">
                                        <asp:Button runat="server" Text="Change password" OnClick="ChangePassword_Click" CssClass="btn btn-primary" ValidationGroup="ChangePassword" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>

