<%@ Page Title="Patient Demographics" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ClientDemographic.aspx.vb" Inherits="TBTracing.ClientDemographic" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
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
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-xs-12">

                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="demographics" />

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                        </div>
                    </div>
                    <!-- Success/Failure Panel -->
                    <asp:Panel ID="pnlSuccess" Visible="false" runat="server" ClientIDMode="Static">
                        <div class="row">
                            <div class="col-lg-6 col-lg-offset-3">
                                <div class="alert alert-success alert-save text-center">
                                    <i class="fa fa-check-circle"></i>Changes have been successfully saved
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:FormView ID="DemographicFormView" runat="server" ItemType="TBTracing.client_DemographicModel" UpdateMethod="DemographicFormView_UpdateItem" 
                                SelectMethod="DemographicFormView_GetItem" OnDataBound="DemographicFormView_DataBound1" 
                                DefaultMode="Insert" InsertMethod="DemographicFormView_InsertItem">
                    <EditItemTemplate>

                    <div role="tabpanel" class="tab-pane active" id="demographics">
                        <div class="row">
                            <div class="col-lg-2 col-md-6 col-sm-6">
                                <div class="pull-left">
                                    <div class="well well-info">
                                        <asp:CheckBox ID="cbConfirmed" runat="server" Enabled="false" CssClass="checkbox-inline" Text="Identify Confirmed?" Checked="<%# BindItem.idConfirmed%>" /> <span " data-toggle="tooltip" data-placement="top" title="Identify is confirmed if there are two of the following three variables: name, DOB, Health Card Number."><i class="fa fa-lg fa-question-circle text-primary"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-1 col-md-6 col-sm-6">
                                <div class="pull-left">
                                    <div class="well well-info">
                                        <asp:CheckBox ID="cbEmployee" runat="server" CssClass="checkbox-inline" Text="Employee?" Checked="<%# BindItem.employee%>" />
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-9 col-md-12 col-sm-12">
                                <div class="pull-right">
                                    <div class="well well-info">
                                        <asp:RadioButtonList ID="rblStatus" CssClass="radio-list" selectedValue='<%# BindItem.statusID%>' AppendDataBoundItems="true" Enabled="false"
                                             RepeatLayout="Table" RepeatDirection="Horizontal" runat="server" DataSourceID="StatusDictionary" DataTextField="Status" DataValueField="ID">
                                            <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Name / Identity Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="nameToggle" data-toggle="collapse" data-parent="#accordion-identity" href="#collapseIdentity" aria-expanded="true" aria-controls="collapseIdentity">Name / Identity</a></h3>
                            </div>
                            <div id="collapseIdentity" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingIdentity">
                                <div class="panel-body">
                                    <div class="form">
                                        <div class="form-group col-lg-2 col-md-5 col-sm-6">
                                            <label for="tbFirstName">Case Number</label>                                        
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# BindItem.demoData.CaseNumber%>' ReadOnly="true"  CssClass="form-control" placeholder="Case #"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-3 col-md-5 col-sm-6">
                                            <label for="tbFirstName">First Name</label>                                        
                                            <asp:TextBox ID="tbFirstName" runat="server" Text='<%# BindItem.demoData.FirstName %>'  CssClass="form-control" placeholder="First Name"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-1 col-md-1 col-sm-6">
                                            <label for="tbMiddleInitial">Initial</label>
                                            <asp:TextBox ID="tbMiddleInitial" runat="server" Text='<%# BindItem.demoData.MiddleInitial%>' CssClass="form-control" placeholder="Initial"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-3 col-md-5 col-sm-6">
                                            <label for="tbLastName">Last Name</label>
                                            <asp:TextBox ID="tbLastName" runat="server" Text='<%# BindItem.demoData.LastName%>' CssClass="form-control" placeholder="Last Name"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-3 col-md-6 col-sm-6">
                                            <label for="tbAlias">Alias, Maiden Name, Nickname</label>
                                            <asp:TextBox ID="tbAlias" runat="server" Text='<%# BindItem.demoData.Alias_MaidenName_Nickname%>' CssClass="form-control" placeholder="Alias, Maiden Name, Nickname"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-5 col-md-6 col-sm-12">
                                            <label>Language (Click all that apply)</label>                                                                 
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbSpeaksEnglish" runat="server" Text="EN" Checked='<%# BindItem.demoData.SpeaksEN%>' /></label>
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbSpeaksFrench" runat="server" Text="FR" Checked='<%# BindItem.demoData.SpeaksFR%>' /></label>
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbSpeaksInnu" runat="server" Text="Innuaimun" Checked='<%# BindItem.demoData.SpeaksInnu%>' /></label>
                                                    <label class="checkbox-inline"><asp:CheckBox ID="cbSpeaksInuttitut" runat="server" Text="Inuttitut" Checked='<%# BindItem.demoData.SpeaksInuttitut%>' /></label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group col-lg-3 col-md-6 col-sm-6">
                                            <label for="tbMCP">MCP (Health Care Number)</label>
                                            <asp:TextBox ID="tbMCP" runat="server" CssClass="form-control" placeholder="MCP" Text='<%# BindItem.demoData.HealthCareNumber%>'></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-4 col-md-6 col-sm-6">
                                            <label for="tbOtherNumber">Other Identifier (band number, etc.)</label>
                                            <asp:TextBox ID="tbOtherNumber" runat="server" CssClass="form-control" placeholder="Other Identifier" Text="<%# BindItem.demoData.OtherIdentifier %>"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Demographics Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="demoToggle" data-toggle="collapse" data-parent="#accordion-demo" href="#collapseDemo" aria-expanded="true" aria-controls="collapseDemo">Demographics</a></h3>
                            </div>
                            <div id="collapseDemo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingDemo">
                                <div class="panel-body">
                                    <div class="form">
                                        <div class="form-group col-lg-3 col-sm-3">
                                            <label for="tbDOB">Date of Birth</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("demoData.DateofBirth", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                        <div class="form-group col-lg-1 col-sm-2">
                                            <label for="tbAge">Age</label>
                                            <asp:TextBox ID="tbAge" runat="server" CssClass="form-control" placeholder="Age" ReadOnly="True" Text="<%# BindItem.strAge %>" ></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-8 col-sm-7">
                                            <label for="tbOccupation">Occupation</label>
                                            <asp:TextBox ID="tbOccupation" runat="server" CssClass="form-control" placeholder="Occupation" Text='<%# BindItem.demoData.Occupation%>'></asp:TextBox>
                                        </div>
                                    
                                        <div class="col-lg-6 col-md-12 col-sm-12">
                                            <label>Ethnicity</label>
                                            <div class="panel panel-sub">
                                                <div class="panel-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <div class="">
                                                                <asp:CheckBoxList DataValueField="ID" ID="cblEthnicity" runat="server" DataSourceID="EthnicDictionary"
                                                                    CssClass="checkbox-list checkbox-list-three"  OnDataBound="cblEthnicity_DataBound"
                                                                    DataTextField="Ethnicity" RepeatColumns="3" RepeatDirection="Horizontal" RepeatLayout="Table" >
                                                                </asp:CheckBoxList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-6 col-md-8 col-sm-12">
                                                            <div class="checkbox">
                                                                <input id="cbEthnicityOther" type="checkbox" value="">
                                                                <asp:TextBox ID="tbEthnicityOther" runat="server" Text='<%# BindItem.demoData.EthnicityOther%>' CssClass="form-control input-sm" placeholder="Other" ClientIDMode="Static"></asp:TextBox>
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-6">
                                        <label>Gender</label>                         
                                        <div class="panel panel-sub"> 
                                            <div class="panel-body">
                                                <asp:RadioButtonList ID="cblGender" runat="server" DataSourceID="GenderDictionary"  AppendDataBoundItems="true"
                                                    DataTextField="Gender" DataValueField="ID" selectedValue='<%# BindItem.demoData.GenderID%>' CssClass="radio-list">
                                                    <asp:ListItem Text="Select" Value=""  Enabled="False" style="display:none;" />
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                    </div>  
                                    <div class="col-lg-3 col-md-6 col-sm-6">
                                        <label>Pregnant</label>                         
                                        <div class="panel panel-sub"> 
                                            <div class="panel-body">
                                                <asp:RadioButtonList ID="rblPregnancyStatus" runat="server" DataSourceID="PregnancyDictionary"  
                                                    DataValueField="ID"  DataTextField="PregnantStatus"  AppendDataBoundItems="true"
                                                    selectedValue='<%# BindItem.demoData.PregnancyStatus%>'  CssClass="radio-list">
                                                    <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                    </div>            
                                </div>
                            </div>
                        </div>
                        
                        <!-- Address Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="addrToggle" data-toggle="collapse" data-parent="#accordion-address" href="#collapseAddress" aria-expanded="true" aria-controls="collapseAddress">Address</a></h3>
                            </div>
                            <div id="collapseAddress" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingAddress">
                                <div class="panel-body">
                                    <div class="form">
                                        <div class="form-group col-lg-5 col-sm-5">
                                            <label for="tbStreetAddress">Street Address</label>
                                            <asp:TextBox ID="tbStreetAddress" runat="server" CssClass="form-control" placeholder="Street Address" Text='<%# BindItem.demoData.StreetAddress%>'></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-3 col-sm-3">
                                            <label for="tbCommunity">Community</label>
                                            <asp:DropDownList ID="ddCommunity" CssClass="form-control" runat="server" selectedvalue="<%# BindItem.demoData.CommunityID%>" DataSourceID="Communities" DataTextField="Community" DataValueField="ID" AppendDataBoundItems="true">
                                                <asp:ListItem Text="Please Select" Value="" />
                                            </asp:DropDownList>
                                            <%--<asp:TextBox ID="tbCommunity" runat="server" CssClass="form-control" placeholder="Community" Text='<%# BindItem.demoData.Community%>'></asp:TextBox>--%>
                                        </div>
                                        <div class="form-group col-lg-4 col-sm-4">
                                            <label for="tbStreetAddress">Other Community (if applicable)</label>
                                            <asp:TextBox ID="tbCommunityOther" runat="server" CssClass="form-control" placeholder="Other Community" Text='<%# BindItem.demoData.CommunityOther%>'></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-3 col-sm-6">
                                            <label for="tbPostalCode">Postal Code</label>
                                            <asp:TextBox ID="tbPostalCode" runat="server" CssClass="form-control" placeholder="Postal Code" Text='<%# BindItem.demoData.PostalCode%>'></asp:TextBox>
                                        </div>                                    
                                        <div class="form-group col-lg-3 col-sm-6">
                                            <label for="tbProvince">Province</label>
                                            <asp:DropDownList ID="ddProvince" CssClass="form-control" runat="server" DataSourceID="ProvinceDictionary"  OnDataBound="ddProvince_DataBound"
                                                DataTextField="Province" DataValueField="ID" AppendDataBoundItems="true" selectedvalue="<%#BindItem.demoData.ProvinceID%>">
                                                <asp:ListItem Text="Please Select..." Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                        </div> 
                                         <div class="form-group col-lg-6 col-sm-6">
                                            <label for="tbPostalCode">Not Canada? Other Info</label>
                                            <asp:TextBox ID="tbOtherIdentifier" runat="server" CssClass="form-control" placeholder="Other..." Text='<%# BindItem.demoData.OtherProvinceStateIdentifier%>'></asp:TextBox>
                                        </div>   
                                        <div class="form-group col-lg-6 col-md-12 col-sm-12">                                                      
                                            <label>Area</label>  
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
                                                    <label class="radio-inline"><asp:RadioButton ID="cbLG" runat="server" Checked='<%# BindItem.demoData.RhaLG%>' Text="LGH" GroupName="AreaGroup" /></label>
                                                    <label class="radio-inline"><asp:RadioButton ID="cbEH" runat="server" Checked='<%# BindItem.demoData.RhaEH%>' Text="EH" GroupName="AreaGroup" /></label>
                                                    <label class="radio-inline"><asp:RadioButton ID="cbCH" runat="server" Checked='<%# BindItem.demoData.RhaCH%>' Text="CH" GroupName="AreaGroup" /></label>
                                                    <label class="radio-inline"><asp:RadioButton ID="cbWH" runat="server" Checked='<%# BindItem.demoData.RhaWG%>' Text="WH" GroupName="AreaGroup" /></label>
                                                    <label class="radio-inline"><asp:RadioButton ID="cbOther" runat="server" Checked='<%# BindItem.demoData.RhaOther%>' Text="Out of Province" GroupName="AreaGroup" /></label>
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
                                <h3 class="panel-title"><a id="contactToggle" data-toggle="collapse" data-parent="#accordion-contact" href="#collapseContact" aria-expanded="true" aria-controls="collapseContact">Contact Details</a></h3>
                            </div>
                            <div id="collapseContact" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingContact">
                                <div class="panel-body">
                                    <div class="form">
                                        <div class="form-group col-lg-3 col-sm-6">
                                            <label for="tbHomePhone">Home Phone</label>
                                            <asp:TextBox ID="tbHomePhone" runat="server" CssClass="form-control" Text='<%# BindItem.demoData.HomePhone%>' placeholder="Home Phone"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-3 col-sm-6">
                                            <label for="tbMobilePhone">Mobile Phone</label>
                                            <asp:TextBox ID="tbMobilePhone" runat="server" CssClass="form-control" Text='<%# BindItem.demoData.MobilePhone%>' placeholder="Mobile Phone"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-lg-3 col-sm-6">
                                            <label for="tbOtherPhone">Other Phone</label>
                                            <asp:TextBox ID="tbOtherPhone" runat="server" CssClass="form-control" Text='<%# BindItem.demoData.OtherPhone%>' placeholder="Other Phone"></asp:TextBox>
                                        </div>                                    
                                        <div class="form-group col-lg-3 col-sm-6">
                                            <label for="tbEmail">Email</label>
                                            <asp:TextBox ID="tbEmail" runat="server" CssClass="form-control" Text='<%# BindItem.demoData.Email%>' placeholder="Email"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                        <!-- Other Information Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="otherToggle" data-toggle="collapse" data-parent="#accordion-other" href="#collapseOther" aria-expanded="true" aria-controls="collapseOther">Other Information</a></h3>
                            </div>
                            <div id="collapseOther" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOther">
                                <div class="panel-body">
                                    <div class="form">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="form-group col-lg-2 col-md-3 col-sm-4">
                                                    <label for="tbBodyWeight">Body Weight (kg)</label>
                                                    <asp:TextBox ID="tbBodyWeight" runat="server" CssClass="form-control" placeholder="Body Weight" Text='<%# BindItem.demoData.BodyWeight%>'></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group col-lg-12">
                                            <asp:TextBox ID="tbOtherInformation" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine" Text='<%# BindItem.demoData.Comments%>' ></asp:TextBox>
                                        </div>                                                 
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <div class="pull-left">
                                    <asp:HyperLink ID="lnkHistory" ClientIDMode="Static" NavigateUrl="~/ClientPages/ClientDemographicHistory.aspx?clientid={0}" CssClass="btn btn-default" runat="server"><i class="fa fa-clock-o"></i> View History</asp:HyperLink>   
                                    <asp:LinkButton  ID="dlButton" ClientIDMode="Static"  Visible="false" runat="server" CssClass="btn btn-default" CommandName="Download" CausesValidation="true" OnClick="dlButton_Click" ><i class="fa fa-download"></i> Download</asp:LinkButton>                                 
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="pull-right">
                                    <asp:LinkButton  ID="addButton" ClientIDMode="Static"  runat="server" CssClass="btn btn-primary" CommandName="Insert" CausesValidation="true" ><i class="fa fa-check"></i> Add</asp:LinkButton>
                                    <asp:LinkButton  ID="updateButton" ClientIDMode="Static"  runat="server" CssClass="btn btn-primary" CommandName="Update" CausesValidation="true" ><i class="fa fa-check"></i> Update</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>                    

                    </EditItemTemplate>
                    </asp:FormView>
                </div>
            </div>
        </div>

    </section>
    <!-- Dictionary DS -->
    <asp:EntityDataSource ID="Communities" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Community"></asp:EntityDataSource>
    <asp:EntityDataSource ID="EthnicDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Ethnicity" EntityTypeFilter="common_Ethnicity"></asp:EntityDataSource>
    <asp:EntityDataSource ID="GenderDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Gender" EntityTypeFilter="common_Gender"></asp:EntityDataSource>
    <asp:EntityDataSource ID="PregnancyDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_PregnancyStatus"></asp:EntityDataSource>
    <asp:EntityDataSource ID="StatusDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Status"></asp:EntityDataSource>
    <asp:EntityDataSource ID="ProvinceDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Province"></asp:EntityDataSource>

<script type="text/javascript">
$(function () {    
    // Demographic - Ethnicity Other
    if ($('#tbEthnicityOther').val() == null || $('#tbEthnicityOther').val() == '') {
        $('#cbEthnicityOther').prop('checked', false);
        $('#tbEthnicityOther').attr("disabled", "disabled");
        $('#tbEthnicityOther').attr('value', '');
    } else {
        $('#cbEthnicityOther').prop('checked', true);
        $('#tbEthnicityOther').removeAttr("disabled");
    }

    $('#cbEthnicityOther').click(function () {

        if ($('#cbEthnicityOther').is(':checked')) {
            $('#tbEthnicityOther').removeAttr("disabled");
        } else {
            $('#tbEthnicityOther').val('');
            $('#tbEthnicityOther').attr("disabled", "disabled");
            
        }
    })


    var changeBoolean = new Boolean();
    changeBoolean = false;

    var allowButtonsWhiteList = new Array("lnkHistory", "dlButton", "addButton", "updateButton", "nameToggle", "demoToggle", "addrToggle", "contactToggle", "otherToggle", "navtoggle", "toggleLogout");

    $('input').change(function () {
        changeBoolean = true;
    });

    $('select').change(function () {
        changeBoolean = true;
    });

    $('textarea').change(function () {
        changeBoolean = true;
    });

    $("a").click(function (event) {
        var linkID = event.currentTarget.id;
        var intCheck = $.inArray(linkID, allowButtonsWhiteList);
        if (intCheck < 0) {
            if (changeBoolean) {
                var r = confirm("You have entered client changes that have not been saved.  Click 'OK' to proceed anyways without saving.  To stay on this screen click 'Cancel' ");
                if (r == true) {
                    return true;
                } else {
                    return false;
                }             
            } else {
                return true;
            }
        }
        else {
            return true;
        }
    });
})
</script>
</asp:Content>
