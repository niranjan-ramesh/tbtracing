<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="006a-contactattempts_Contact.aspx.vb" Inherits="TBTracing._006a_contactattempts_Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">Patient Record</a></li>
            <li class="active">Communication</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Patient Record</h1>
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
                    <li role="presentation"><a href="#demographics" aria-controls="demographics" role="tab" data-toggle="tab">Demographics</a></li>
                    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Symptoms</a></li>
                    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">TST</a></li>
                    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Sputum/XRay</a></li>
                    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Investigations</a></li>
                    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Diagnosis/Treatment</a></li>
                    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Risk Factors</a></li>
                    <li role="presentation" class="active"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Communication</a></li>
                    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Contact Tracing</a></li>
                    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Docs/Notes</a></li>
                    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Follow-Ups</a></li>
                    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Geno</a></li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="demographics">

                        <!-- Contact Details Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Contact Details</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-3 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbMobilePhone">Mobile Phone</label>
                                            <asp:TextBox ID="tbMobilePhone" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbHomePhone">Home Phone</label>
                                            <asp:TextBox ID="tbHomePhone" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbOtherPhone">Other Phone</label>
                                            <asp:TextBox ID="tbOtherPhone" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                        </div>  
                                    </div>
                                    <div class="col-lg-3 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbEmail">Email</label>
                                            <asp:TextBox ID="tbEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Contact Bulletin -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Contact Bulletin</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <asp:TextBox ID="tbContactBulletin" runat="server" CssClass="form-control" Rows="4" TextMode="MultiLine"></asp:TextBox>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>

                        <table class="table table-striped table-bordered table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Method</th>
                                    <th>Contact By</th>
                                    <th>Result</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Jan-01-2016</td>
                                    <td>2:33 PM</td>
                                    <td>Cell Phone</td>
                                    <td>John Doe</td>
                                    <td>No Answer</td>
                                </tr>
                                <tr>
                                    <td>Jan-01-2016</td>
                                    <td>2:33 PM</td>
                                    <td>Cell Phone</td>
                                    <td>John Doe</td>
                                    <td>No Answer</td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="pull-right">
                                    <asp:LinkButton ID="lbAddNew" runat="server" CssClass="btn btn-primary" data-toggle="modal" data-target="#addNew"><i class="fa fa-plus"></i> Add New Communication</asp:LinkButton>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>

    </section>

    <!-- Modal -->
    <div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog modal-dialog-50" role="document">
        <div class="modal-content">

          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">Add Contact Attempt Detail</h4>
          </div>

          <div class="modal-body">
            <div class="row">
                <div class="form">
                    <asp:ValidationSummary ID="modalAddNewValidationSummary" runat="server" CssClass="text-danger" ValidationGroup="AddNew" />
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group col-lg-4">
                                <label>Date of Birth</label>
                                <div class="input-group">
                                    <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control isDatePicker" placeholder=""></asp:TextBox>
                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                            <div class="form-group col-lg-4 ">
                                <label>Time</label>
                                <asp:TextBox ID="tbTime" runat="server" CssClass="form-control" placeholder="Time"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-lg-4">
                        <label>Method</label>
                        <select class="form-control">
                          <option>1</option>
                          <option>2</option>
                          <option>3</option>
                          <option>4</option>
                          <option>5</option>
                        </select>
                    </div>                
                    <div class="form-group col-lg-4">
                        <label>Reason</label>
                        <select class="form-control">
                          <option>1</option>
                          <option>2</option>
                          <option>3</option>
                          <option>4</option>
                          <option>5</option>
                        </select>
                    </div>
                    <div class="form-group col-lg-4">
                        <label>Contacted By</label>
                        <select class="form-control">
                          <option>1</option>
                          <option>2</option>
                          <option>3</option>
                          <option>4</option>
                          <option>5</option>
                        </select>
                    </div>

                    <div class="form-group col-lg-12">
                        <label>Notes:</label>
                        <asp:TextBox ID="tbOtherInformation" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                    </div> 
                </div>
            </div>
          </div>

          <div class="modal-footer">
            <asp:LinkButton ID="CreateRole" runat="server" CssClass="btn btn-primary" ValidationGroup="AddNew"><i class="fa fa-floppy-o"></i> Save</asp:LinkButton>
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Close</button>
          </div>

        </div>
      </div>
    </div>

</asp:Content>
