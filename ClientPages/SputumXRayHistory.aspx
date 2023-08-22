<%@ Page Title="Sputum/X-Ray History" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SputumXRayHistory.aspx.vb" Inherits="TBTracing.SputumXRayHistory" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Sputum/X-Ray History</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Sputum/X-Ray History</h1>
                    </div>
                    <div class="pull-right">
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>
         
        <div class="row">
            <div class="col-xs-12">

                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="sputumxray" />

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="sputumxray">
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

                        <!-- Sputum History Panel -->
                        <div class="panel-group margin-top-10" id="accordion-forms" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-sputum" href="#collapseSputum" aria-expanded="true" aria-controls="collapseSputum">Sputum History</a></h3>
                                </div>
                                <div id="collapseSputum" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingSputum">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <asp:GridView ID="gvSputumHistory" runat="server" ItemType="TBTracing.SputumGridLineItem" AutoGenerateColumns="false"
                                                        CssClass="table table-striped table-bordered table-hover table-condensed" 
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Sputum Entered</div></div>" >
                                                        <Columns>
                                                            <asp:BoundField DataField="strCollectedDate" HeaderText="Date" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" NullDisplayText=" " />
                                                            <asp:BoundField DataField="smearResult" HeaderText="Smear Result" NullDisplayText=" " HeaderStyle-CssClass="text-center nowrap" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="cultureResult" HeaderText="Culture Result" NullDisplayText=" " HeaderStyle-CssClass="text-center nowrap" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="reason" HeaderText="Reason" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center expand" />
                                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="lnkViewSputumTest" runat="server" NavigateUrl='<%# String.Format("~/ClientPages/Sputum?testid={0}&clientid={1}",Item.id,Item.clientID)%>' CssClass="btn btn-info btn-table" ><i class='fa fa-eye'></i> View Details</asp:HyperLink>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="pull-right">
                                                        <asp:HyperLink ID="lnkAddSputum" runat="server" NavigateUrl="~/ClientPages/Sputum?clientid={0}" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Sputum</asp:HyperLink>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>             
                                
                        <!-- Chest X-Ray History Panel -->
                        <div class="panel-group" id="accordion-chest" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-chest" href="#collapseChest" aria-expanded="true" aria-controls="collapseChest">Chest X-Ray History</a></h3>
                                </div>
                                <div id="collapseChest" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingChest">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <asp:GridView ID="gvChestXrayHistory" runat="server" ItemType="TBTracing.XRayGridLineItem" AutoGenerateColumns="false"
                                                        CssClass="table table-striped table-bordered table-hover table-condensed" 
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Chest X-Rays Entered</div></div>">
                                                        <Columns>
                                                            <asp:BoundField DataField="strExamDate" HeaderText="Exam Date" HeaderStyle-CssClass="text-center text-nowrap" ItemStyle-CssClass="text-center shrink" NullDisplayText=" " />
                                                            <asp:BoundField DataField="result" HeaderText="Result" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="reason" HeaderText="Reason" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center expand" />
                                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="lnkViewSputumTest" runat="server" NavigateUrl='<%# String.Format("~/ClientPages/XRay?testid={0}&clientid={1}&type=c", Item.id, Item.clientID)%>' CssClass="btn btn-info btn-table" ><i class='fa fa-eye'></i> View Details</asp:HyperLink>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="pull-right">
                                                        <asp:HyperLink ID="lnkAddChestXRay" runat="server" NavigateUrl="~/ClientPages/XRay?type=c&clientid={0}" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Chest X-Ray</asp:HyperLink>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- X-Ray History Panel -->
                        <div class="panel-group" id="accordion-xray" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-xray" href="#collapseXray" aria-expanded="true" aria-controls="collapseXray">Non-Chest X-Ray History</a></h3>
                                </div>
                                <div id="collapseXray" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingXray">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <asp:GridView ID="gvXrayHistory" runat="server" ItemType="TBTracing.XRayGridLineItem" AutoGenerateColumns="false"
                                                        CssClass="table table-striped table-bordered table-hover table-condensed" 
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No X-Rays Entered</div></div>">
                                                        <Columns>
                                                            <asp:BoundField DataField="strExamDate" HeaderText="Exam Date" HeaderStyle-CssClass="text-center text-nowrap" ItemStyle-CssClass="text-center shrink" NullDisplayText=" " />
                                                            <asp:BoundField DataField="location" HeaderText="Location" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="result" HeaderText="Results" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:BoundField DataField="reason" HeaderText="Reason" NullDisplayText=" " HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center expand" />
                                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="lnkViewSputumTest" runat="server" NavigateUrl='<%# String.Format("~/ClientPages/XRay?type=nc&testid={0}&clientid={1}", Item.id, Item.clientID)%>' CssClass="btn btn-info btn-table" ><i class='fa fa-eye'></i> View Details</asp:HyperLink>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="pull-right">
                                                        <asp:HyperLink ID="lnkAddXRay" runat="server" NavigateUrl="~/ClientPages/XRay?type=nc&clientid={0}" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New X-Ray</asp:HyperLink>
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

</asp:Content>
