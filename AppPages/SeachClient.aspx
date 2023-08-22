<%@ Page Title="Client Search" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SeachClient.aspx.vb" Inherits="TBTracing.SeachClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li class="active">Client Search</li>
        </ol>
    </section>

    <section class="content">

        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Client Search</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row margin-top-20">
            <div class="col-xs-12">

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
                                        <asp:TextBox ID="tbMCP" runat="server" CssClass="form-control" placeholder="MCP"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbMCP">Other Identifier</label>
                                        <asp:TextBox ID="tbOtherIdentifier" runat="server" CssClass="form-control" placeholder="Other Identifier"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbFirstName">First Name</label>
                                        <asp:TextBox ID="tbFirstName" runat="server" CssClass="form-control" placeholder="First Name"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbLastName">Last Name</label>
                                        <asp:TextBox ID="tbLastName" runat="server" CssClass="form-control" placeholder="Last Name"></asp:TextBox>
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
                                <div class="col-lg-2 col-md-6 col-sm-6">
                                    <div class="form-group">
                                        <label for="ddStatus">TB Status</label>
                                        <asp:DropDownList ID="ddStatus" AppendDataBoundItems="true" runat="server" CssClass="form-control"
                                            DataSourceID="dsStatus" DataTextField="Status" DataValueField="ID">
                                            <asp:ListItem Text="Select..." Value=""></asp:ListItem>
                                        </asp:DropDownList>                                        
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbLastName">Case Number</label>
                                        <asp:TextBox ID="tbCaseNumber" runat="server" CssClass="form-control" placeholder="Case Number"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbLastName">Community</label>
                                        <asp:DropDownList ID="ddCommunity" AppendDataBoundItems="true" runat="server" CssClass="form-control"
                                            DataSourceID="dsCommunities" DataTextField="Community" DataValueField="ID">
                                            <asp:ListItem Text="Select..." Value=""></asp:ListItem>
                                        </asp:DropDownList> 
                                    </div>
                                </div>
                                <div class="col-lg-1 col-md-2 col-sm-2">
                                    <div class="form-group">
                                        <label for="lbSearch">&nbsp;</label>
                                        <div>
                                            <asp:LinkButton ID="lbSearch" runat="server" CssClass="btn btn-primary"><i class="fa fa-search"></i> Search</asp:LinkButton>
                                        </div>
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
                        <asp:GridView ID="gvClients" runat="server" Style="margin-top: 5px;" ShowHeaderWhenEmpty="true" 
                            AutoGenerateColumns="False" AllowCustomPaging="true"
                            EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Matching Clients</div></div" 
                            CssClass="table table-striped table-bordered table-hover table-condensed" AllowPaging="True" PagerStyle-CssClass="pagination">
                            <Columns>
                                <asp:BoundField DataField="CaseNumber" HeaderText="Case Number" HeaderStyle-CssClass="text-center" />
                                <asp:BoundField DataField="FirstName" HeaderText="First Name" HeaderStyle-CssClass="text-center" />
                                <asp:BoundField DataField="LastName" HeaderText="Last Name" HeaderStyle-CssClass="text-center" />
                                <asp:BoundField DataField="HealthCareNumber" HeaderText="MCP" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                <asp:BoundField DataField="OtherIdentifier" HeaderText="OtherIdentifier" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" />
                                <asp:BoundField DataField="strDOB" HeaderText="DOB" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink" DataFormatString="{0:dd-MMM-yyyy}" />
                                <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />

                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="lnkViewDemo" runat="server" CssClass="btn btn-info btn-table"
                                            NavigateUrl='<%# String.Format("~/ClientPages/ClientDemographic.aspx?clientID={0}", Eval("ClientID"))%>'>
                                                        
                                            <i class="fa fa-eye"></i> View
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
                            <asp:HyperLink ID="lnkHome" runat="server" CssClass="btn btn-default" NavigateUrl="~/Default.aspx"><i class="fa fa-home"></i> Home</asp:HyperLink>
                            <asp:HyperLink ID="lnkAddNewClient" runat="server" CssClass="btn btn-success" NavigateUrl="~/ClientPages/ClientDemographic.aspx"><i class="fa fa-plus"></i> Add New Client</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <asp:EntityDataSource ID="dsStatus" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Status"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsClientList" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="vwClientList"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsCommunities" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Community"></asp:EntityDataSource>

</asp:Content>
