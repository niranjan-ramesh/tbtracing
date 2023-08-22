<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="007b-skintest_new_Contact.aspx.vb" Inherits="TBTracing._007b_skintest_new_Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">Patient Record</a></li>
            <li class="active">Skin Test</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Add New Skin Test</h1>
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
                    <li role="presentation" class="active"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">TST</a></li>
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

                        <!-- Skin Test Details Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Skin Test Details</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbDatePlaced">Date Placed</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbDatePlaced" runat="server" CssClass="form-control isDatePicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Placed By</label>
                                            <select class="form-control">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div> 
                                    </div>

                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Site</label>
                                            <select class="form-control">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div>   
                                    </div>   
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Lot #</label>
                                            <select class="form-control">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div>   
                                    </div>                                           
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Where Administered</label>
                                            <select class="form-control">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div>  
                                    </div>                                        
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Administered By</label>
                                            <select class="form-control">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div> 
                                    </div>  
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbDateRead">Date Read</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbDateRead" runat="server" CssClass="form-control isDatePicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>  
                                    </div>
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Read By</label>
                                            <select class="form-control">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div>  
                                    </div>
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbInduration">Induration</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbInduration" runat="server" CssClass="form-control col-lg-3 col-md-4 col-sm-6" placeholder="Email"></asp:TextBox>
                                                <div class="input-group-addon">mm</div>
                                            </div>
                                        </div>  
                                    </div>
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Result</label>
                                            <select class="form-control">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-8 col-sm-12">
                                        <div class="form-group">                                                     
                                            <label>&nbsp;</label>  
                                            <div class="panel panel-clear"> 
<!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                                <div class="panel-body">
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> X-Ray Recommended</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> IGRA Recommended</label>
                                                </div>
                                            </div>
                                        </div>  
                                    </div>
                                    <div class="col-lg-12 col-md-8 col-sm-12">
                                        <div class="form-group">
                                            <label>Comments</label>
                                            <asp:TextBox ID="tbComments" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                        </div> 
                                    </div>  

                                </div>
                            </div>
                        </div>

                        <!-- Consent Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Consent</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <div class="form-group">                                                      
                                            <label>Fact Sheet Provided</label>  
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
<!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> Yes</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> No</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <div class="form-group">                                                      
                                            <label>Benefits and Risks Understood</label>  
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
<!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> Yes</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> No</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <div class="form-group">                                                      
                                            <label>Agree to Return 48-72 hrs</label>  
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
<!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> Yes</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> No</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <div class="form-group">
                                            <label for="tbDateOfConsent">Date of Consent</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbDateOfConsent" runat="server" CssClass="form-control isDatePicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Follow-up TST -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Follow-up TST</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="form-group col-lg-12 col-md-12 col-sm-12">  
                                        <div class="panel panel-clear"> 
                                            <div class="panel-body">
                                                <div class="form-inline">
                                                    <!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> Follow-up Required?</label>    
                                                    If yes, please select date:&nbsp;&nbsp; 
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control isDatePicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Reason For Testing Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Reason For Testing</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">                                    
                                    <div class="form-group col-lg-4 col-md-6 col-sm-8">
                                        <label>Test Reason</label>
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
                        </div>

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="pull-right">
                                    <asp:LinkButton ID="lbUpdate" runat="server" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </section>

</asp:Content>
