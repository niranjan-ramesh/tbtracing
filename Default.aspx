<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="TBTracing._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
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
                        <h1 class="page-title"><i class="fa fa-tachometer"></i> Dashboard</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">

                <div class="panel panel-default margin-top-20">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span>Tuberculosis Functions</span></h3>
                    </div>
                    <div class="panel-body">
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
                            <a href="~/AppPages/SeachClient" runat="server">
                                <div class="info-box bg-aqua">
                                    <span class="info-box-icon"><i class="fa fa-users"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-total"><asp:Label ID="lblClientCount" runat="server" Text=""></asp:Label></span>
                                        <span class="info-box-footer">Clients</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
                            <a href="~/AppPages/AllFollowups" runat="server">
                                <div class="info-box bg-yellow">
                                    <span class="info-box-icon"><i class="fa fa-calendar-check-o"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-total"></span>
                                        <span class="info-box-footer">Follow-Ups</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
                            <a href="~/AppPages/ClinicList" runat="server">
                                <div class="info-box bg-red">
                                    <span class="info-box-icon"><i class="fa fa-hospital-o"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-total"><asp:Label ID="lblClinicCount" runat="server" Text=""></asp:Label></span>
                                        <span class="info-box-footer">Clinics</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <asp:PlaceHolder ID="AdminBlockPH" runat="server" Visible="False">
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
                            <a href="~/Admin/UserAdministration.aspx" runat="server">
                                <div class="info-box bg-purple">
                                    <span class="info-box-icon"><i class="fa fa-cogs"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-total"></span>
                                        <span class="info-box-footer">Administration</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="LotBlockPH" runat="server" Visible="False">
                        <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
                            <a href="~/Admin/AddEditLot.aspx" runat="server">
                                <div class="info-box bg-green">
                                    <span class="info-box-icon"><i class="fa fa-medkit"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-total"></span>
                                        <span class="info-box-footer">Lot Administration</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        </asp:PlaceHolder>
                    </div>
                </div>
    
<%--                <div class="panel panel-default margin-top-40">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span>Reports</span></h3>
                    </div>
                    <div class="panel-body">
                        <ul class="tiles">
                            <li class="teal">
								<a href="~/" runat="server">
									<span><i class="fa fa-bar-chart"></i></span>
									<span class="name">Report A</span>
								</a>
							</li>
                            <li class="purple">
								<a href="~/" runat="server">
									<span><i class="fa fa-area-chart"></i></span>
									<span class="name">Report B</span>
								</a>
							</li>
                            <li class="green">
								<a href="~/" runat="server">
									<span><i class="fa fa-line-chart"></i></span>
									<span class="name">Report C</span>
								</a>
							</li>
                            <li class="brown">
								<a href="~/" runat="server">
									<span><i class="fa fa-pie-chart"></i></span>
									<span class="name">Report D</span>
								</a>
							</li>
                        </ul>
                    </div>
                </div>--%>

            </div>
        </div>
    </section>

</asp:Content>
