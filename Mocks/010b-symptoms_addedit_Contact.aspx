<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="010b-symptoms_addedit_Contact.aspx.vb" Inherits="TBTracing._010b_symptoms_addedit_Contact" %>

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
                        <h1 class="page-title">Symptoms</h1>
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
                    <li role="presentation" class="active"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Symptoms</a></li>
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
                    <div role="tabpanel" class="tab-pane active" id="tabpanel">
                        
                        <!-- Add New Symptom Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Add New Symptom</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="row">
                                        <div class="col-lg-4 col-md-5 col-sm-6">
                                            <div class="form-group">
                                                <label for="">Completed By</label>
                                                <select class="form-control">
                                                    <option>1</option>
                                                    <option>2</option>
                                                    <option>3</option>
                                                    <option>4</option>
                                                    <option>5</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-2 col-sm-6">
                                            <div class="form-group">
                                                <label for="">How Completed</label>
                                                <select class="form-control">
                                                    <option>1</option>
                                                    <option>2</option>
                                                    <option>3</option>
                                                    <option>4</option>
                                                    <option>5</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <table class="table table-striped table-bordered table-hover table-condensed">
                                                <thead>
                                                    <tr>
                                                        <th class="text-center">Findings</th>
                                                        <th class="text-center">Result</th>
                                                        <th class="text-center">Start Date</th>
                                                        <th class="text-center">End Date</th>
                                                        <th class="text-center">Notes</th>
                                                    </tr>
                                                </thead>
                                                <tbody>   
                                                    <tr>
                                                        <td>Cough longer than 3 weeks</td>
                                                        <td>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> Yes</label>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> No</label>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3"> Unknown</label>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio4" value="option3"> Refused</label>
                                                        </td>
                                                        <td class="col-md-2">
                                                            <div class="input-group">
                                                                <asp:TextBox ID="tbStartDate" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </td>
                                                        <td class="col-md-2">
                                                            <div class="input-group">
                                                                <asp:TextBox ID="tbEndDate" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </td>
                                                        <td class="col-md-3"><asp:TextBox ID="tbNotes" runat="server" CssClass="form-control" placeholder=""></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Fever</td>
                                                        <td>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> Yes</label>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> No</label>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3"> Unknown</label>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio4" value="option3"> Refused</label>
                                                        </td>
                                                        <td>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </td>
                                                        <td><asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder=""></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Night sweats</td>
                                                        <td>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> Yes</label>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> No</label>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3"> Unknown</label>
                                                            <label class="radio-inline"><input type="radio" name="inlineRadioOptions" id="inlineRadio4" value="option3"> Refused</label>
                                                        </td>
                                                        <td>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </td>
                                                        <td><asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" placeholder=""></asp:TextBox></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-12">
                                            <label>Comments</label>
                                            <asp:TextBox ID="tbComments" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="pull-right">
                                    <asp:LinkButton ID="lbSave" runat="server" CssClass="btn btn-primary"><i class="fa fa-floppy-o"></i> Save</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>
