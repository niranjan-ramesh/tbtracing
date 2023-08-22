<%@ Page Title="Contact Tracing - Search" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ContactTracingSearch.aspx.vb" Inherits="TBTracing.ContactTracingSearch" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> TB Tracing</a></li>
            <li><a href="#">Contact Tracing</a></li>
            <li class="active">Add New</li>
        </ol>
    </section>
    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Patient Record</h1>
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
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="contacts" />
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active">
                        <asp:Panel ID="pnlSuccess" Visible="false" runat="server" ClientIDMode="Static">
                        <div class="row">
                            <div class="col-lg-6 col-lg-offset-3">
                                <div class="alert alert-success alert-save text-center">
                                    <i class="fa fa-check-circle"></i> <asp:Label ID="lblSuccessMessage" runat="server" Text="Label"></asp:Label>
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

                        <!-- Clinic Details Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span>Search Criteria</span></h3>
                            </div>



                            <div class="panel-body">
                                <div class="form">
                                    <div class="row">
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="tbMCP">MCP</label>
                                                <asp:TextBox ID="tbMCP" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="tbFirstName">First Name</label>
                                                <asp:TextBox ID="tbFirstName" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="tbLastName">Last Name</label>
                                                <asp:TextBox ID="tbLastName" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="tbDOB">DOB</label>
                                                <div class="input-group">
                                                    <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                    <div class="input-group-addon datepickericon"><i class="fa fa-calendar"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-md-8 col-sm-9">
                                            <div class="form-group">
                                                <label for="">TB Status</label>
                                                <asp:DropDownList ID="ddStatus" AppendDataBoundItems="true" runat="server" CssClass="form-control"
                                                    DataSourceID="dsStatus" DataTextField="Status" DataValueField="ID">
                                                    <asp:ListItem Text="Select..." Value=""></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-lg-1 col-md-4 col-sm-3">
                                            <div class="form-group">
                                                <label for="">&nbsp;</label>
                                                <asp:LinkButton ID="lbSearch" runat="server" CssClass="btn btn-primary"><i class="fa fa-search"></i> Search</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                        <!-- Search Results Grid -->
                        <h3>Results</h3>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:GridView ID="gvClients" runat="server" Style="margin-top: 5px;"
                                    AutoGenerateColumns="False" EmptyDataText="No Results." ItemType="TBTracing.vwClients" PageSize="10" PagerStyle-CssClass="pagination"
                                    CssClass="table table-striped table-bordered table-hover table-condensed" DataSourceID="dsClientList" AllowPaging="True">
                                    <Columns>
                                        <asp:BoundField DataField="FirstName" HeaderText="First Name" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="LastName" HeaderText="Last Name" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="HealthCareNumber" HeaderText="MCP" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="strDOB" HeaderText="DOB" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />

                                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="lnkViewDemo" runat="server" CssClass="btn btn-success btn-table"
                                                    NavigateUrl='<%# String.Format("~/ClientPages/ContactTracingAdd.aspx?clientID={0}&contactid={1}", Request.Item("clientid") ,Item.ClientID)%>'>
                                            <i class="fa fa-check"></i> Select
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="pull-right">
                                    <!--<asp:HyperLink ID="lnkHome" runat="server" CssClass="btn btn-default" NavigateUrl="~/Default.aspx"><i class="fa fa-home"></i> Home</asp:HyperLink>-->
                                    <asp:HyperLink ID="lnkAddNewClient" runat="server" CssClass="btn btn-primary" NavigateUrl="~/ClientPages/ClientDemographic.aspx?sourceclientid={0}"><i class="fa fa-plus"></i> Add New Client</asp:HyperLink>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>


    </section>
    <asp:EntityDataSource ID="dsStatus" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Status"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsClientList" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="vwClients"></asp:EntityDataSource>

</asp:Content>
