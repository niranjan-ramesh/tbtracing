<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="004a-AddClinic.aspx.vb" Inherits="TBTracing._004a_AddClinic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li class="active">Clinics</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Add Clinic</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row margin-top-20">
            <div class="col-xs-12">

                <!-- Clinic Details Panel -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Clinic Details</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form">
                            <div class="row">
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbClinicDate">Clinic Date</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="tbClinicDate" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                            <div class="input-group-addon datepickericon"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbStartTime">Start Time</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="tbStartTime" runat="server" CssClass="form-control timepicker" placeholder="hh:mm"></asp:TextBox>
                                            <div class="input-group-addon"><i class="fa fa-clock-o"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <label for="tbEndTime">End Time</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="tbEndTime" runat="server" CssClass="form-control timepicker" placeholder="hh:mm"></asp:TextBox>
                                            <div class="input-group-addon"><i class="fa fa-clock-o"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-8 col-sm-9">
                                    <div class="form-group">
                                        <label for="">Physician</label>
                                        <select class="form-control">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-3">
                                    <div class="form-group">
                                        <label for="tbMaxAppointments">Max Appointments</label>
                                        <asp:TextBox ID="tbMaxAppointments" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>
                                </div>      
                            </div> 
                            <div class="row">                     
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <div class="form-group">
                                        <label>Comments</label>
                                        <asp:TextBox ID="tbComments" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                    </div> 
                                </div>  
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="pull-right">
                            <asp:LinkButton ID="lbAdd" runat="server" CssClass="btn btn-primary"><i class="fa fa-plus"></i> Add Clinic</asp:LinkButton>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </section>

</asp:Content>
