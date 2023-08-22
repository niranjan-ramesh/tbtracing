<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="009d-investigations_sputum_Contact.aspx.vb" Inherits="TBTracing._009d_investigations_sputum_Contact" %>

<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">Patient Record</a></li>
            <li class="active">Sputum Test</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Sputum Test</h1>
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

                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="sputumxray" />

                <!-- Tab panes -->
                <div class="tab-content">
                    
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                        </div>
                    </div>

                    <div role="tabpanel" class="tab-pane active" id="demographics">
                             
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Sputum Test Details</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form">

                                    <div class="col-lg-3 col-md-6 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbDateCollected">Collected Date/Time</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbCollectedDate" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>  
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbDateResult">Collected Date/Time</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbResultDate" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>  
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-6">
                                        <div class="form-group">
                                            <label>Completed By</label>
                                            <asp:DropDownList ID="ddlCompletedBy" runat="server" DataSourceID="TBUserDictionary" CssClass="form-control"></asp:DropDownList>
                                        </div> 
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-6">
                                        <div class="form-group">
                                            <label>Requested By</label>
                                            <asp:DropDownList ID="ddlRequestedBy" runat="server" DataSourceID="TBUserDictionary" CssClass="form-control"></asp:DropDownList>
                                        </div> 
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">                                                      
                                            <label>Status</label>  
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbRefused" runat="server" Checked='<%# BindItem.StatusRefused%>' Text="Refused" /></label>
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbUnableToProduce" runat="server" Checked='<%# BindItem.StatusUnableToProduce%>' Text="Unable to Produce" /></label>
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbCollected" runat="server" Checked='<%# BindItem.StatusCollected%>' Text="Collected" /></label>
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbNotResulted" runat="server" Checked='<%# BindItem.StatusNotResulted%>' Text="Not Resulted" /></label>
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbSmearComplete" runat="server" Checked='<%# BindItem.StatusSmearComplete%>' Text="Smear Complete" /></label>
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbPendingCulture" runat="server" Checked='<%# BindItem.StatusPendingCulture%>' Text="Pending Culture" /></label>
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbComplete" runat="server" Checked='<%# BindItem.StatusComplete%>' Text="Complete" /></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Smear Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Smear</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form-group"> 
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <label>Result</label>  
                                        <div class="panel panel-sub"> 
                                            <div class="panel-body">
                                                <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">Insufficient Sample</label>
                                                <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">Negative</label>
                                                <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">1+</label>
                                                <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">2+</label>
                                                <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">3+</label>
                                                <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">4+</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Culture Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Culture</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form-group"> 
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <label>Result</label>  
                                        <div class="panel panel-sub"> 
                                            <div class="panel-body">
                                                <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">Insufficient Sample</label>
                                                <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">Negative</label>
                                                <label class="radio-inline"><input type="radio" name="optionsRadios" value="option1">Positive</label>
                                            </div>
                                        </div>
                                    </div>                                                     
                                </div>
                                <div class="form-group"> 
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        <label>Antibiotic Resistence</label>                         
                                        <div class="panel panel-sub"> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-2 col-md-3 col-sm-6">
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">INH</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">EMB</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">RMP</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-sm-6">
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Strptomycin</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Kenamycin</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Capreomycin</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-sm-6">
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Ethionamide</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">PAS</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Rifabutin</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-sm-6">
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Maxifloxacin</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Oflaxacin</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">Amikacin</label>
                                                        </div>
                                                        <div class="checkbox">
                                                            <label><input type="checkbox" value="">PZA</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div> 

                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="pull-right">
                                    <asp:LinkButton  ID="addButton" runat="server" CssClass="btn btn-primary" CommandName="Insert" CausesValidation="true" ><i class="fa fa-check"></i> Add</asp:LinkButton>
                                    <asp:LinkButton  ID="updateButton" runat="server" CssClass="btn btn-primary" CommandName="Update" CausesValidation="true" ><i class="fa fa-check"></i> Update</asp:LinkButton>
                                </div>
                            </div>
                        </div>

                    </div>
    
                </div>

            </div>
        </div>

    </section>

    <!-- Dictionary DS -->
    <asp:EntityDataSource ID="TBUserDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TBUser" EntityTypeFilter="common_TBUser"></asp:EntityDataSource>

</asp:Content>
