<%@ Page Title="Investigations" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="InvestigationHistory.aspx.vb" Inherits="TBTracing.InvestigationHistory" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Investigation History</li>
        </ol>
    </section>
    
    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Investigation History</h1>
                    </div>
                    <div class="pull-right">
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">

                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="investigation" />

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active margin-top-10" id="investigation">
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

                        <!-- IGRA History Panel -->
                        <div class="panel-group" id="accordion-igra" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-igra" href="#collapseIgra" aria-expanded="true" aria-controls="collapseIgra">IGRA</a></h3>
                                </div>
                                <div id="collapseIgra" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingIgra">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <asp:GridView ID="gvIGRAHistory" runat="server" ItemType="TBTracing.IGRAGridLineItem" AutoGenerateColumns="false"
                                                        CssClass="table table-striped table-bordered table-hover table-condensed" 
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No IGRA Entered</div></div>">
                                                        <Columns>
                                                            <asp:BoundField DataField="strDateCollection" HeaderText="Date" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="reason" HeaderText="Reason" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center expand" />
                                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="lnkViewIGRA" runat="server" NavigateUrl='<%# String.Format("~/ClientPages/IGRA?testid={0}&clientid={1}", Item.id, Item.clientID)%>' CssClass="btn btn-info btn-table" ><i class='fa fa-eye'></i> View Details</asp:HyperLink>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="pull-right">
                                                        <!-- PERRY - NEED TO PASS CLIENT ID -->
                                                        <asp:HyperLink ID="lnkAddIGRA" runat="server" NavigateUrl="~/ClientPages/IGRA?clientid={0}" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New IGRA</asp:HyperLink>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Blood Work History Panel -->
                        <div class="panel-group" id="accordion-blood" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-blood" href="#collapseBlood" aria-expanded="true" aria-controls="collapseBlood">Blood Work</a></h3>
                                </div>
                                <div id="collapseBlood" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingBlood">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <asp:GridView ID="gvBloodworkHistory" runat="server" ItemType="TBTracing.BloodworkGridLineItem" AutoGenerateColumns="false"
                                                        CssClass="table table-striped table-bordered table-hover table-condensed"
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Bloodwork Entered</div></div>">
                                                        <Columns>
                                                            <asp:BoundField DataField="strDateCollected" HeaderText="Date" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" NullDisplayText=" " />
                                                            <asp:BoundField DataField="alt" HeaderText="ALT" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="ast" HeaderText="AST" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="serumBilirubin" HeaderText="Serum Bilirubin" NullDisplayText=" " HeaderStyle-CssClass="text-center text-nowrap" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="reason" HeaderText="Reason" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center expand" />
                                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="lnkViewBloodwork" runat="server" NavigateUrl='<%# String.Format("~/ClientPages/Bloodwork?testid={0}&clientid={1}", Item.id, Item.clientID)%>' CssClass="btn btn-info btn-table" ><i class='fa fa-eye'></i> View Details</asp:HyperLink>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="pull-right">
                                                        <asp:HyperLink ID="lnkAddBloodwork" runat="server" NavigateUrl="~/ClientPages/Bloodwork?clientid={0}" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Bloodwork</asp:HyperLink>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Diagnostic Imaging Panel -->
                        <div class="panel-group" id="accordion-diagnosticimage" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-diagnosticimage" href="#collapseDiagnosticimage" aria-expanded="true" aria-controls="collapseDiagnosticimage">Other Diagnostic Tests</a></h3>
                                </div>
                                <div id="collapseDiagnosticimage" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingXray">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <asp:GridView ID="gvDiagnosticImages" runat="server" ItemType="TBTracing.XRayGridLineItem" AutoGenerateColumns="false"
                                                        CssClass="table table-striped table-bordered table-hover table-condensed"  OnPreRender="gvDiagnosticImages_PreRender"
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Diagnostic Images Entered</div></div>">
                                                        <Columns>
                                                            <asp:BoundField DataField="strExamDate" HeaderText="Exam Date" HeaderStyle-CssClass="text-center text-nowrap" ItemStyle-CssClass="text-center shrink" NullDisplayText=" " />
                                                            <%--<asp:BoundField DataField="location" HeaderText="Location" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="result" HeaderText="Results" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />--%>
                                                            <asp:BoundField DataField="view" HeaderText="Procedure" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                                            <%--<asp:BoundField DataField="area" HeaderText="Area" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />--%>
                                                            <asp:BoundField DataField="reason" HeaderText="Reason" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center expand" />
                                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="lnkViewSputumTest" runat="server" NavigateUrl='<%# String.Format("~/ClientPages/DiagnosticImage?testid={0}&clientid={1}", Item.id, Item.clientID)%>' CssClass="btn btn-info btn-table" ><i class='fa fa-eye'></i> View Details</asp:HyperLink>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="pull-right">
                                                        <asp:HyperLink ID="lnkAddDiagnosticImage" runat="server" NavigateUrl="~/ClientPages/DiagnosticImage?clientid={0}" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add Other Investigation</asp:HyperLink>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

<%--                        <!-- Microscopy History Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Microscopy</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <!-- insert gridview -->
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="pull-right">
                                                <!-- PERRY - NEED TO PASS CLIENT ID -->
                                                <asp:HyperLink ID="lnkAddMicroscopy" runat="server" NavigateUrl="~/ClientPages/Microscopy?clientid=2" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Microscopy</asp:HyperLink>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Culture History Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Culture</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <!-- insert gridview -->
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="pull-right">
                                                <!-- PERRY - NEED TO PASS CLIENT ID -->
                                                <asp:HyperLink ID="lnkAddCulture" runat="server" NavigateUrl="~/ClientPages/Cultre?clientid=2" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Culture</asp:HyperLink>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
