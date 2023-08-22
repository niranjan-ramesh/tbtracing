﻿<%@ Page Title="Diagnosis History" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="OutcomeHistory.aspx.vb" Inherits="TBTracing.OutcomeHistory" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Outcome / Diagnosis History</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Outcome/Diagnosis History</h1>
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
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="diagnosis" />
                
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="demographics">

                        <!-- Success/Failure Panel -->
                        <asp:Panel ID="pnlSuccess" Visible="true" runat="server" ClientIDMode="Static">
                        <div class="row">
                            <div class="col-lg-6 col-lg-offset-3">
                                <div class="alert alert-success alert-save text-center">
                                    <i class="fa fa-check-circle"></i> <asp:Literal ID="ltStatusMessage" runat="server"></asp:Literal>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                            </div>
                        </div>
                        </asp:Panel>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-identity" href="#collapseIdentity" aria-expanded="true" aria-controls="collapseIdentity">Outcome History</a></h3>
                            </div>
                            <div id="collapseIdentity" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingIdentity">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <asp:GridView ID="gvHistory" runat="server" ItemType="TBTracing.OutcomeGridLineItem" AutoGenerateColumns="false" AllowSorting="true" SelectMethod="gvHistory_GetData"
                                                EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Outcomes Listed</div></div>"
                                                ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered table-hover table-condensed" OnPreRender="gvHistory_PreRender">
                                                <Columns>
                                                    <asp:BoundField DataField="DeterminationDate" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Outcome/Diagnosis Date" SortExpression="DeterminationDate" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center"></asp:BoundField>
                                                    <asp:BoundField DataField="strDeterminedBy" HeaderText="Outcome/Diagnosis Assessed By" SortExpression="strDeterminedBy" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center"></asp:BoundField>
                                                    <asp:BoundField DataField="strOutcome" HeaderText="Outcome" SortExpression="strOutcome" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center"></asp:BoundField>
                                                    <asp:BoundField DataField="strType" HeaderText="TB Type (if applicable)" SortExpression="strType" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center"></asp:BoundField>

                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:HyperLink runat="server" CssClass="btn btn-info btn-table" Text="<i class='fa fa-eye'></i> View" NavigateUrl='<%# String.Format("~/ClientPages/AddOutcome.aspx?clientid={0}&outcomeid={1}", Eval("intClientID"), Eval("intPK"))%>' />                                                           
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="pull-right">
                                                <asp:HyperLink ID="lnkAddNew" runat="server" CssClass="btn btn-success" NavigateUrl="~/ClientPages/AddOutcome.aspx?clientid={0}"><i class="fa fa-plus"></i> Add New Outcome</asp:HyperLink>
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

</asp:Content>



