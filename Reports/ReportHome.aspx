<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ReportHome.aspx.vb" Inherits="TBTracing.ReportHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="content-header">
        <ol class="breadcrumb">
            <li><%--<a href="~/" runat="server"><i class="fa fa-tachometer"></i> Dashboard</a>--%></li>
        </ol>
    </section>

    <section class="content">

        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-tachometer"></i> Reports Home</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">

                <div class="panel panel-default margin-top-20">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span>Excel Exports</span></h3>
                    </div>
                    <div class="panel-body">
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
                            <asp:LinkButton ID="LinkButton1" runat="server">
                                <div class="info-box bg-aqua">
                                    <span class="info-box-icon"><i class="fa fa-users"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-total"><asp:Label ID="lblClientCount" runat="server" Text=""></asp:Label></span>
                                        <span class="info-box-footer">Demographics</span>
                                    </div>
                                </div>
                            </asp:LinkButton>
                        </div>                   
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
