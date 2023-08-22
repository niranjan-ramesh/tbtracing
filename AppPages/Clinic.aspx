<%@ Page Title="Clinic" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Clinic.aspx.vb" Inherits="TBTracing.Clinic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="~/AppPages/ClinicList" runat="server">Clinics</a></li>
            <li class="active">Clinic</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-hospital-o"></i> Clinic</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row margin-top-20">
            <div class="col-xs-12">

                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                    </div>
                </div>

                <asp:FormView ID="ClinicFormView" runat="server" ItemType="TBTracing.clinic_TBClinic" 
                                DefaultMode="Insert" InsertMethod="ClinicFormView_InsertItem" SelectMethod="ClinicFormView_GetItem"
                                UpdateMethod="ClinicFormView_UpdateItem" RenderOuterTable="False">
                    <EditItemTemplate>
                        <!-- Clinic Details Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span>Clinic Details</span></h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <!-- Clinic Details -->
                                    <div class="row">
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="tbClinicDate">Clinic Date</label>
                                                <div class="input-group">
                                                    <asp:TextBox ID="tbClinicDate" runat="server" Text='<%# Bind("ClinicDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepickerFuture" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                    <div class="input-group-addon datepickericon"><i class="fa fa-calendar"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="tbStartTime">Start Time</label>
                                                <div class="input-group">
                                                    <asp:TextBox ID="tbStartTime" runat="server" Text='<%# Bind("StartTime", "{0:hh\:mm}")%>' CssClass="form-control timepicker" placeholder="hh:mm"></asp:TextBox>
                                                    <div class="input-group-addon"><i class="fa fa-clock-o"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="tbEndTime">End Time</label>
                                                <div class="input-group">
                                                    <asp:TextBox ID="tbEndTime" runat="server" Text='<%# Bind("EndTime", "{0:hh\:mm}")%>' CssClass="form-control timepicker" placeholder="hh:mm"></asp:TextBox>
                                                    <div class="input-group-addon"><i class="fa fa-clock-o"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-8 col-sm-9">
                                            <div class="form-group">        
                                                <label for="">Physician</label>                                               
                                                <asp:DropDownList CssClass="form-control" ID="ddPhysician" DataSourceID="dsApplicationUsers" selectedValue="<%# BindItem.PhysicianID%>"
                                                    DataTextField="NameLabel" DataValueField="UserID" runat="server" AppendDataBoundItems="true">
                                                    <asp:ListItem Text="Please Select" Value="" />
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-3">
                                            <div class="form-group">
                                                <label for="tbMaxAppointments">Max Appointments</label>
                                                <asp:TextBox ID="tbMaxAppointments" runat="server" Text="<%# BindItem.MaxAppointments%>" CssClass="form-control" placeholder=""></asp:TextBox>
                                            </div>
                                        </div>      
                                    </div> 
                            
                                    <!-- Comments -->
                                    <div class="row">                     
                                        <div class="col-lg-12 col-md-12 col-sm-12">
                                            <div class="form-group">
                                                <label>Comments</label>
                                                <asp:TextBox ID="tbComments" runat="server" Text="<%# BindItem.Comments%>" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                            </div> 
                                        </div>  
                                    </div>
                            
                                    <!-- Add/Update Button -->
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="pull-right">
                                                <asp:LinkButton ID="updateButton"  runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save Clinic</asp:LinkButton>
                                                <asp:LinkButton ID="addButton"  runat="server" CommandName="Insert" CssClass="btn btn-success"><i class="fa fa-save"></i> Add Clinic</asp:LinkButton>
                                                <asp:Hyperlink ID="lnkCancelButton" runat="server" NavigateURL="~/AppPages/ClinicList" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </EditItemTemplate>
                </asp:FormView>


            </div>
        </div>
    </section>

    <!-- Dictionary DS -->
    <asp:EntityDataSource ID="dsApplicationUsers" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TBUser" ></asp:EntityDataSource>

</asp:Content>
