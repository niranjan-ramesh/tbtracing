<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="003-ClientList.aspx.vb" Inherits="TBTracing._003_ClientList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li class="active">Clients</li>
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
                        <h3 class="panel-title">Search Criteria</h3>
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
                                        <label for="">&nbsp;</label>
                                        <select class="form-control">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
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
                        <asp:GridView ID="gvContacts" runat="server" Style="margin-top: 5px;" 
                            AutoGenerateColumns="False" EmptyDataText="No Results." 
                            CssClass="table table-striped table-bordered table-hover table-condensed">
                            <Columns>
                                <asp:BoundField DataField="firstName" HeaderText="First Name" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="lastName" HeaderText="Last Name" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="mcp" HeaderText="MCP" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="caseStatus" HeaderText="Status" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbViewClient" runat="server" 
                                            NavigateUrl='<%# "~/AddCase.aspx?ClientID="&Eval("ClientID") %>' 
                                            Text='<i class="fa fa-eye"></i> View'
                                            CssClass="btn btn-success btn-table">
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField> 
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="pull-right">
                            <asp:LinkButton ID="lbHome" runat="server" CssClass="btn btn-default"><i class="fa fa-home"></i> Home</asp:LinkButton>
                            <asp:LinkButton ID="lbAddClient" runat="server" CssClass="btn btn-primary"><i class="fa fa-plus"></i> Add New Client</asp:LinkButton>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>
