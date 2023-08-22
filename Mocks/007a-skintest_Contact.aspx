<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="007a-skintest_Contact.aspx.vb" Inherits="TBTracing._007a_skintest_Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li class="active">Patient Record</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Skin Test History</h1>
                    </div>
                    <div class="pull-right">
                        <ul class="patient-block">
                            <li class="green">
                                <i class="fa fa-user"></i>
                                <div class="details">
                                    <span class="big">John Doe</span>
                                    <span><b>Status:</b> Confirmed Case</span>
                                    <span><b>Last Update:</b> Jan-12-2016</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-xs-12">

                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#demographics" aria-controls="demographics" role="tab" data-toggle="tab">Demographics</a></li>
                    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Symptoms</a></li>
                    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">TST</a></li>
                    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Sputum/XRay</a></li>
                    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Investigations</a></li>
                    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Diagnosis/Treatment</a></li>
                    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Risk Factors</a></li>
                    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Communication</a></li>
                    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Contact Tracing</a></li>
                    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Docs/Notes</a></li>
                    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Follow-Ups</a></li>
                    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Geno</a></li>
                </ul>

                
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="demographics">

                        <!-- Search Results Grid -->
                        <h3>Skin Test History</h3>
                        <div class="row">
                            <div class="col-lg-12">
                                <table class="table table-striped table-bordered table-hover table-condensed">
                                    <thead>
                                        <tr>
                                            <th>Lot No</th>
                                            <th>Dose</th>
                                            <th>Route</th>
                                            <th>Site</th>
                                            <th>Where Admin</th>
                                            <th>Date Read</th>
                                            <th>Induration</th>
                                            <th>Test Strength</th>
                                            <th>X-Ray Rec?</th>
                                            <th>IGRA?</th>
                                            <th>Comments</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>2345634</td>
                                            <td>1</td>
                                            <td>Arm</td>
                                            <td>Right</td>
                                            <td>Not sure</td>
                                            <td>Jan-01-2016</td>
                                            <td>12 mm</td>
                                            <td>Strong</td>
                                            <td>No</td>
                                            <td>No</td>
                                            <td>Some Comments</td>
                                            <td><asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-success btn-table"><i class="fa fa-plus"></i> View</asp:LinkButton></td>
                                        </tr>
                                        <tr>
                                            <td>2345634</td>
                                            <td>1</td>
                                            <td>Arm</td>
                                            <td>Right</td>
                                            <td>Not sure</td>
                                            <td>Jan-01-2016</td>
                                            <td>12 mm</td>
                                            <td>Strong</td>
                                            <td>No</td>
                                            <td>No</td>
                                            <td>Some Comments</td>
                                            <td><asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success btn-table"><i class="fa fa-plus"></i> View</asp:LinkButton></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Name / Identity Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">BCG Status</h3>
                            </div>
                            <div class="panel-body">

                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>
