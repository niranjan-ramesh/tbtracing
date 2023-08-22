<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="DiagnosisHome.aspx.vb" Inherits="TBTracing.DiagnosisHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i>Home</a></li>
            <li class="active">Client Search</li>
        </ol>
    </section>

    <section class="content">

        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i>Diagnosis Extract</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row margin-top-20">
            <div class="col-xs-12">

                <!-- Clinic Details Panel -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span>Extract Criteria</span></h3>
                    </div>
                    <div class="panel-body">
                        <div class="form">
                            <div class="row">
                                
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbDOB">From</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="tbFromDate" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                            <div class="input-group-addon datepickericon"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbDOB">From</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="tbToDate" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                            <div class="input-group-addon datepickericon"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-6">
                                    <div class="form-group">
                                        <label for="ddStatus">Outcome</label>
                                        <asp:CheckBoxList ID="cblOutcome" runat="server" DataSourceID="sqlOutcomeTypes" DataTextField="TBOutcome" DataValueField="ID" RepeatDirection="Vertical"></asp:CheckBoxList>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 col-sm-6">
                                    <div class="form-group">
                                        <label for="ddStatus">Report Fields</label>
                                        <asp:CheckBoxList ID="cblFiels" runat="server"  RepeatDirection="Vertical" RepeatColumns="2">
                                            <asp:ListItem Text="Determination Date" Value="DD"></asp:ListItem>
                                            <asp:ListItem Text="Comments" Value="Comments"></asp:ListItem>
                                            <asp:ListItem Text="Client First Name" Value="First Name"></asp:ListItem>
                                            <asp:ListItem Text="Client Last Name" Value="Last Name"></asp:ListItem>
                                            <asp:ListItem Text="Client MCP" Value="MCP"></asp:ListItem>
                                            <asp:ListItem Text="Case Number" Value="CN"></asp:ListItem>
                                            <asp:ListItem Text="TB Type (if applicable)" Value="TT"></asp:ListItem>
                                            <asp:ListItem Text="Treatment Type (if applicable)" Value="TreatType"></asp:ListItem>

                                        </asp:CheckBoxList>
                                    </div>
                                </div>
                                <div class="col-lg-1 col-md-2 col-sm-2">
                                    <div class="form-group">
                                        <label for="lbSearch">&nbsp;</label>
                                        <div>
                                            <asp:LinkButton ID="lbSearch" runat="server" CssClass="btn btn-primary"><i class="fa fa-search"></i> Get Report</asp:LinkButton>
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
    <asp:SqlDataSource ID="sqlOutcomeTypes" runat="server" ConnectionString='<%$ ConnectionStrings:TBConnection %>' SelectCommand="SELECT [ID], [TBOutcome] FROM [common_TBOutcome]"></asp:SqlDataSource>
</asp:Content>
