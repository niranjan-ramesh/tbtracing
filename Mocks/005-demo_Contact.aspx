<%@ Page Title="Client Demographics" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="005-demo_Contact.aspx.vb" Inherits="TBTracing._005_demo_Contact" %>

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


                        <div class="callout callout-danger" role="alert">
                            <h4><i class="icon fa fa-ban"></i> Alert!</h4>
                            This is an error
                        </div>
                        <div class="callout callout-info" role="alert">
                            This is an info
                        </div>
                        <div class="callout callout-success" role="alert">
                            This is an success
                        </div>
                        <div class="callout callout-warning" role="alert">
                            This is an warning
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="pull-left">
                                    <div class="well well-info">
                                        Identity Confirmed: 
                                        <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">Yes</label>
                                        <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">No</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="pull-right">
                                    <div class="well well-info">
                                        <label class="checkbox-inline"><input type="checkbox" value="option1"> Employee?</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Name / Identity Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Name / Identity</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-3 col-md-5 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbFirstName">First Name</label>
                                            <asp:TextBox ID="tbFirstName" runat="server" CssClass="form-control" placeholder="First Name"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbMiddleInitial">Initial</label>
                                            <asp:TextBox ID="tbMiddleInitial" runat="server" CssClass="form-control" placeholder="Initial"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-5 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbLastName">Last Name</label>
                                            <asp:TextBox ID="tbLastName" runat="server" CssClass="form-control" placeholder="Last Name"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbAlias">Alias, Maiden Name, Nickname</label>
                                            <asp:TextBox ID="tbAlias" runat="server" CssClass="form-control" placeholder="Alias, Maiden Name, Nickname"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-5 col-md-6 col-sm-12">
                                        <div class="form-group">
                                            <label>Language (Click all that apply)</label>                                                                 
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
    <!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> EN</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> FR</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> Innu</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> Inuttitut</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbMCP">MCP (Health Care Number)</label>
                                            <asp:TextBox ID="tbMCP" runat="server" CssClass="form-control" placeholder="MCP"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbOtherNumber">Other</label>
                                            <asp:TextBox ID="tbOtherNumber" runat="server" CssClass="form-control" placeholder="Other"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Address Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Address</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-6 col-sm-6">
                                        <div class="form-group ">
                                            <label for="tbStreetAddress">Street Address</label>
                                            <asp:TextBox ID="tbStreetAddress" runat="server" CssClass="form-control" placeholder="Street Address"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbCommunity">Community</label>
                                            <asp:TextBox ID="tbCommunity" runat="server" CssClass="form-control" placeholder="Community"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbPostalCode">Postal Code</label>
                                            <asp:TextBox ID="tbPostalCode" runat="server" CssClass="form-control" placeholder="Postal Code"></asp:TextBox>
                                        </div>   
                                    </div>           
                                    <div class="col-lg-3 col-sm-6">                      
                                        <div class="form-group">
                                            <label for="tbProvince">Province/Country</label>
                                            <asp:TextBox ID="tbProvince" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-12 col-sm-12">
                                        <div class="form-group">                                                      
                                            <label>Area</label>  
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
    <!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> LGH</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> EH</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> CH</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> WH</label>
                                                    <label class="checkbox-inline"><input type="checkbox" value="option1"> Out of Province</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

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
                    
                        <!-- Demographics Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Demographics</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <div class="form-group">
                                            <label for="tbDOB">Date of Birth</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control isDatePicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-6 col-sm-12">
                                        <div class="form-group">
                                            <label for="tbAge">Age</label>
                                            <asp:TextBox ID="tbAge" runat="server" CssClass="form-control" placeholder="Age"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-7 col-md-12 col-sm-12">
                                        <div class="form-group">
                                            <label for="tbOccupation">Occupation</label>
                                            <asp:TextBox ID="tbOccupation" runat="server" CssClass="form-control" placeholder="Occupation"></asp:TextBox>
                                        </div>
                                    </div>
                                    
<!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                    <div class="col-lg-6 col-md-12 col-sm-12">
                                        <label>Ethnicity</label>                         
                                        <div class="panel panel-sub"> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-3 col-lg-offset-0 col-md-6 col-sm-6">
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Caucasian</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Black</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Asian</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-6">
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Arab/West Asian</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">South Asian</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">First Nations</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-5 col-md-6 col-sm-6">
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Latin American</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Inuit</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value=""><asp:TextBox ID="tbEthnicityOther" runat="server" CssClass="form-control input-sm" placeholder="Other" ReadOnly="True"></asp:TextBox></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>    
                                    
<!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                    <div class="col-lg-3 col-md-6 col-sm-6">
                                        <label>Gender</label>                         
                                        <div class="panel panel-sub"> 
                                            <div class="panel-body">
                                                <div class="radio">
                                                    <label><input type="radio" name="optionsRadios" value="option1">Male</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="optionsRadios" value="option1">Female</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="optionsRadios" value="option1">Transgender</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="optionsRadios" value="option1">Unknown</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>  
                                      
<!-- NEED TO CONVERT TO ASP ELEMENTS -->
                                    <div class="col-lg-3 col-md-6 col-sm-6">
                                        <label>Pregnant</label>                         
                                        <div class="panel panel-sub"> 
                                            <div class="panel-body">
                                                <div class="radio">
                                                    <label><input type="radio" name="optionsRadios" value="option1">Yes</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="optionsRadios" value="option1">No</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="optionsRadios" value="option1">Unknown</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="optionsRadios" value="option1">Not Applicable</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>            
                                </div>
                            </div>
                        </div>
                        
                        <!-- Other Information Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Other Information</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-lg-2 col-md-3 col-sm-4">
                                                <div class="form-group">
                                                    <label for="tbBodyWeight">Body Weight (lbs)</label>
                                                    <asp:TextBox ID="tbBodyWeight" runat="server" CssClass="form-control" placeholder="Body Weight"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group col-lg-12">
                                        <asp:TextBox ID="tbOtherInformation" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                    </div>                                                 
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <div class="pull-left">
                                    <asp:LinkButton ID="lbHistory" runat="server" CssClass="btn btn-default"><i class="fa fa-clock-o"></i> View History</asp:LinkButton>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="pull-right">
                                    <asp:LinkButton ID="lbUpdate" runat="server" CssClass="btn btn-primary"><i class="fa fa-check"></i> Update</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>                    

                    <div role="tabpanel" class="tab-pane" id="profile">...</div>
                    <div role="tabpanel" class="tab-pane" id="messages">...</div>
                    <div role="tabpanel" class="tab-pane" id="settings">...</div>
                </div>

            </div>
        </div>

    </section>
</asp:Content>