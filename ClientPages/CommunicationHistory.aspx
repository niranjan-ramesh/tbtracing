<%@ Page Title="Communication" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="CommunicationHistory.aspx.vb" Inherits="TBTracing.CommunicationHistory" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Communication</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Communication History</h1>
                    </div>
                    <div class="pull-right">
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-xs-12">

                <!-- Nav tabs -->
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="communication" />

                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="demographics">
                         <!-- Success/Failure Panel -->
                        <asp:Panel ID="pnlSuccess" Visible="true" runat="server" ClientIDMode="Static">
                        <div class="row">
                            <div class="col-lg-6 col-lg-offset-3">
                                <div class="alert alert-success alert-save text-center">
                                    <i class="fa fa-check-circle"></i> Changes have been successfully saved
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                            </div>
                        </div>
                        </asp:Panel>
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                            </div>
                        </div>
                        <!-- Contact Details Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span>Contact Details</span></h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-3 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbHomePhone">Home Phone</label>
                                            <asp:TextBox ID="tbHomePhone" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbMobilePhone">Mobile Phone</label>
                                            <asp:TextBox ID="tbMobilePhone" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                        </div>
                                    </div>
                                    
                                    <div class="col-lg-3 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbOtherPhone">Other Phone</label>
                                            <asp:TextBox ID="tbOtherPhone" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                        </div>  
                                    </div>
                                    <div class="col-lg-3 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbEmail">Email</label>
                                            <asp:TextBox ID="tbEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Contact Bulletin -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span>Further Contact Information</span></h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <asp:TextBox ID="tbContactBulletin" runat="server" CssClass="form-control" Rows="4" TextMode="MultiLine"></asp:TextBox>
                                        </div> 
                                    </div>
                                    
                                    <div class="col-lg-12">
                                        <div class="pull-right">
                                            <asp:LinkButton ID="lbSaveBulletin" runat="server" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>                                            
                                        </div>
                                    </div>                        
                                </div>
                            </div>
                        </div>

                        <asp:GridView ID="gvHistory" runat="server" ItemType="TBTracing.CommunicationGridLineItem"  AutoGenerateColumns="false" 
                                    EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Communication Attempts</div></div>" 
                                    ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered table-hover table-condensed"> 
                            <Columns>
                                <asp:TemplateField HeaderText="Date" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCommDate" runat="server" Text='<%# BindItem.commDateTiem%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Reason" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReas" runat="server" Text='<%# BindItem.commReason%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Method" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMethod" runat="server" Text='<%# BindItem.commMethod%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Result" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblResult" runat="server" Text='<%# BindItem.commResult%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Contacted By" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblContactedBy" runat="server" Text='<%# BindItem.contactedBy%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="lnkViewCommunication" runat="server"  NavigateUrl='<%# String.Format("~/ClientPages/Communication?commid={0}&clientid={1}", Item.commId, Item.clientID)%>' Text="<i class='fa fa-eye'></i> View" CssClass="btn btn-info btn-table" ></asp:HyperLink>                                            
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>                       
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="pull-right">
                                    <asp:HyperLink ID="lnkAddNew" runat="server" NavigateUrl="~/ClientPages/Communication.aspx?clientid={0}" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Communication</asp:HyperLink>
                                    
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>

    </section>

</asp:Content>
