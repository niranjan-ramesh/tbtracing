<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AddEditLot.aspx.vb" Inherits="TBTracing.AddEditLot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/" runat="server"><i class="fa fa-home"></i>Home</a></li>
            <li><a href="~/Admin/" runat="server">Admin</a></li>
            <li class="active">Vaccine Lot Management</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-users"></i>Lot Management</h1>
                    </div>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlSuccess" Visible="true" runat="server" ClientIDMode="Static">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3">
                    <div class="alert alert-success alert-save text-center">
                        <i class="fa fa-check-circle"></i>
                        <asp:Literal ID="ltStatusMessage" runat="server"></asp:Literal>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <div class="row">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-lg-12 col-lg-offset-3">
                        <div>
                            <asp:ValidationSummary ID="noteValidationSummary" runat="server" CssClass="validation error" HeaderText="<strong>User Management Errors:</strong>" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row margin-top-10">
            <div class="col-md-2">
                <div class="form-group">
                    <label class="control-label">Choose Lot</label>
                    <asp:DropDownList ID="ddLots" OnTextChanged="ddLots_TextChanged" runat="server" DataSourceID="dsLots" DataTextField="LotNumber" DataValueField="ID" CssClass="form-control" AppendDataBoundItems="true" AutoPostBack="True">
                        <asp:ListItem Text="Add New" Value="Add"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="row margin-top-20">
            <div class="col-xs-12">

                <!-- Clinic Details Panel -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span>Lot Details</span></h3>
                    </div>
                    <div class="panel-body">
                        <div class="form">
                            <div class="row">
                                <asp:FormView Width="100%" DataKeyNames="ID" ID="fvLot" ItemType="TBTracing.common_MedicalLot" DefaultMode="Insert" runat="server" InsertMethod="fvLot_InsertItem" SelectMethod="fvLot_GetItem" UpdateMethod="fvLot_UpdateItem">
                                    <InsertItemTemplate>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label">Lot Name</label>
                                                    <asp:TextBox ID="tbFirstName" PlaceHolder="First Name" CssClass="form-control" Text='<%# BindItem.LotNumber%>' runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label">Exp Date</label>
                                                    <asp:TextBox ID="tbExpDate" PlaceHolder="Exp Date" CssClass="form-control datepickerFuture" Text='<%# Bind("ExpDate", "{0:dd-MMM-yyyy}") %>' runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="btn-set pull-left">
                                                <asp:LinkButton ID="addButton" runat="server" CssClass="btn btn-primary" CommandName="Insert" CausesValidation="true"><i class="fa fa-check"></i> Add New Lot</asp:LinkButton>
                                            </div>
                                        </div>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label">Lot Name</label>
                                                    <asp:TextBox ID="tbFirstName" PlaceHolder="First Name" CssClass="form-control" Text='<%# BindItem.LotNumber%>' runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label">Exp Date</label>
                                                    <asp:TextBox ID="tbExpDate" PlaceHolder="Exp Date" CssClass="form-control datepickerFuture" Text='<%# Bind("ExpDate", "{0:dd-MMM-yyyy}") %>' runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="btn-set pull-left">
                                                <asp:LinkButton ID="addButton" runat="server" CssClass="btn btn-primary" CommandName="Update" CausesValidation="true"><i class="fa fa-check"></i> Update Lot</asp:LinkButton>
                                            </div>
                                        </div>

                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>

    <asp:SqlDataSource ID="dsLots" runat="server" ConnectionString='<%$ ConnectionStrings:TBConnection %>' SelectCommand="SELECT [ID], [LotNumber], [ExpDate] FROM [common_MedicalLot] ORDER BY [LotNumber]"></asp:SqlDataSource>
</asp:Content>
