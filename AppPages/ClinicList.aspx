<%@ Page Title="Clinic List" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ClinicList.aspx.vb" Inherits="TBTracing.ClinicList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="~/AppPages/ClinicList" runat="server">Clinics</a></li>
            <li class="active">Clinic List</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-hospital-o"></i> Clinic List</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row margin-top-20">
            <div class="col-xs-12">
                <asp:GridView ID="gvClinicList" runat="server" ItemType="TBTracing.ClinicListGridLineItem" AutoGenerateColumns="false" SelectMethod="gvClinicList_GetData"
                    ShowHeaderWhenEmpty="false" CssClass="table table-striped table-bordered table-hover table-condensed"
                    EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Clinics Entered</div></div>" >
                    <Columns>
                        <asp:TemplateField HeaderText="Clinic Date" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                            <ItemTemplate>
                                <asp:Label ID="lblClinicDate" runat="server" Text='<%# Bind("ClinicDate", "{0:dd-MMM-yyyy}")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Start Time" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                            <ItemTemplate>
                                <asp:Label ID="lblStartTime" runat="server" Text='<%# Bind("StartTime", "{0:hh\:mm}")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="End Time" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                            <ItemTemplate>
                                <asp:Label ID="lblEndTime" runat="server" Text='<%# Bind("EndTime", "{0:hh\:mm}")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Physician" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                            <ItemTemplate>
                                <asp:Label ID="lblPhysician" runat="server" Text='<%# BindItem.strPhysicianName%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="# Appointments" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                            <ItemTemplate>
                                <asp:Label ID="lblAppointments" runat="server" Text='<%# BindItem.intNumberOfAppointments%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:HyperLink runat="server" CssClass="btn btn-info btn-table" NavigateUrl='<%# String.Format("~/AppPages/Clinic?clinicid={0}", Eval("ID"))%>'><i class='fa fa-eye'></i> View Details</asp:HyperLink>
                                <asp:HyperLink runat="server" CssClass="btn btn-warning btn-table" NavigateUrl='<%# String.Format("~/AppPages/ClinicAppointments?clinicid={0}", Eval("ID"))%>'><i class="fa fa-calendar"></i> Appointments</asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="pull-right">
                    <asp:HyperLink ID="lnkAddClinic" runat="server" NavigateUrl="~/AppPages/Clinic" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Clinic</asp:HyperLink>
                </div>
            </div>
        </div>

    </section>

</asp:Content>
