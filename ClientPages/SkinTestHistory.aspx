<%@ Page Title="Skin Test History" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SkinTestHistory.aspx.vb" Inherits="TBTracing.SkinTestHistory" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Skin Test History</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Skin Test History</h1>
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
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="tst" />
                
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="demographics">

                        <!-- Success/Failure Panel -->
                        <asp:Panel ID="pnlSuccess" Visible="false" runat="server" ClientIDMode="Static">
                        <div class="row">
                            <div class="col-lg-6 col-lg-offset-3">
                                <div class="alert alert-success alert-save text-center">
                                    <i class="fa fa-check-circle"></i> Changes have been successfully saved
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                            </div>
                        </div>
                        </asp:Panel>

                        <!-- Skin Test History Panel -->
                        <div class="panel-group margin-top-10" id="accordion-forms" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-skintest" href="#collapseSkintest" aria-expanded="true" aria-controls="collapseSkintest">Skin Test History</a></h3>
                                </div>
                                <div id="collapseSkintest" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingSkintest">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <asp:GridView ID="gvHistory" runat="server" ItemType="TBTracing.SkinTestGridLineItem"  AutoGenerateColumns="false" 
                                                        CssClass="table table-striped table-bordered table-hover table-condensed"
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Skin Tests Entered</div></div>" > 
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Date Placed" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDatePlace" runat="server"  Text='<%# Bind("strDatePlace")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Dose" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDose" runat="server" Text='<%# Bind("dose")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Route" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblRoute" runat="server" Text='<%# Bind("route")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Site" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSite" runat="server" Text='<%# Bind("site")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Location" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("location")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Date Read" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDateRead" runat="server" Text='<%# Bind("strDateRead")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Induration" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblInduration" runat="server" Text='<%# Bind("induration")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Result" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblResult" runat="server" Text='<%# Bind("result")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Xray Rcmd?" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblXray" runat="server" Text='<%# Bind("xray")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="IGRA Rcmd?" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblIgra" runat="server" Text='<%# Bind("igra")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Sputum Rcmd?" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSputum" runat="server" Text='<%# Bind("sputum")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Symptom Rcmd?" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSymptom" runat="server" Text='<%# Bind("symptom")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="lnkViewTest" runat="server"  NavigateUrl='<%# String.Format("~/ClientPages/SkinTest?testid={0}&clientid={1}",Item.id,Item.clientID)%>' Text="<i class='fa fa-eye'></i> View" CssClass="btn btn-info btn-table" ></asp:HyperLink>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="pull-right">
                                                        <asp:HyperLink ID="lnkAddNew" runat="server" CssClass="btn btn-success" NavigateUrl="~/ClientPages/SkinTest.aspx?clientid={0}"><i class="fa fa-plus"></i> Add New Skin Test</asp:HyperLink>                                                                                                                
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Name / Identity Panel -->
                        <div class="row margin-top-20">
                            <div class="col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-bcg" href="#collapseBCG" aria-expanded="true" aria-controls="collapseBCG">BCG Status</a></h3>
                                    </div>                                    
                                    <div id="collapseBCG" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingBCG">
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-md-8 col-md-offset-2">
                                                    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="BCG" runat="server" CssClass="callout callout-danger" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-3 col-md-8 col-sm-12">
                                                    <div class="form-group">
                                                        <label>BCG Status</label> 
                                                        <div class="panel panel-sub"> 
                                                            <div class="panel-body">       
                                                                <asp:RadioButtonList ID="rblBCGStatus" runat="server" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true" DataSourceID="dsBCGStatus" DataTextField="StrValue" DataValueField="ID">
                                                                    <asp:ListItem Text="" Value="" Enabled="False" style="display: none;"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-8 col-sm-12">
                                                    <div class="form-group">
                                                        <label>If yes, immunization year:</label>
                                                        <asp:TextBox ID="tbImmuneDate" CssClass="form-control" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-3 pull-left">
                                                    <div class="form-group">
                                                        <asp:LinkButton ID="updateButton" runat="server" CssClass="btn btn-primary" ValidationGroup="BCG"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </section>
    <asp:RangeValidator ID="RangeValidator1" ControlToValidate="tbImmuneDate" ValidationGroup="BCG" runat="server" MinimumValue="1850" MaximumValue="3000" ErrorMessage="Invalid BCG Immunization year.  Must be 4 digit number." Display="None" EnableClientScript="False"></asp:RangeValidator>
    <asp:EntityDataSource ID="dsBCGStatus" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_YesNoUnknown"></asp:EntityDataSource>
</asp:Content>

