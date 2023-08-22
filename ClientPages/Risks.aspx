<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Risks.aspx.vb" Inherits="TBTracing.Risks" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Risk Factors</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title">Risks</h1>
                    </div>
                    <div class="pull-right">
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-xs-12">

                <!-- Nav tabs -->
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="risks" />

                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="tabpanel">
                        
                        <!-- Add New Symptom Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span>Risk Details</span></h3>
                            </div>
                            <div class="row">
                                <div class="col-md-8 col-md-offset-2">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                                </div>
                            </div>
                            <div class="panel-body">

                                <asp:FormView ID="FormViewRisks" runat="server" DefaultMode="Insert" ItemType="TBTracing.client_RiskFactors" Width="100%" 
                                    InsertMethod="FormViewRisks_InsertItem" SelectMethod="FormViewRisks_GetItem" UpdateMethod="FormViewRisks_UpdateItem" >
                                    <EditItemTemplate>

                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-4 col-md-5 col-sm-6">
                                                    <div class="form-group">
                                                        <label for="">Completed By</label>
                                                        <asp:DropDownList CssClass="form-control" ID="ddCompletedBy" runat="server" SelectedValue='<%# BindItem.InterviewByID %>'
                                                            DataSourceID="dsUsers" DataTextField="Username" DataValueField="ID" AppendDataBoundItems="True" >
                                                            <asp:ListItem Text="Please Select" Value="" />
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                
                                                <div class="col-lg-2 col-md-2 col-sm-6">
                                                    <div class="form-group">
                                                        <label for="">Interview Date</label>
                                                        <div class="input-group">
                                                        <asp:TextBox ID="TextBox25" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("InterviewDate", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                    </div>
                                                </div>
                                            </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <table class="table table-striped table-bordered table-hover table-condensed">
                                                        <thead>
                                                            <tr>
                                                                <th class="text-center">Risk</th>
                                                                <th class="text-center">Result</th>
                                                                <th class="text-center">Notes</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td class="col-md-3">Contact with person with active TB in past 2 yrs</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList ID="rblCough3Weeks" runat="server" SelectedValue="<%# BindItem.ContactActiveTB2Yrs%>" 
                                                                        DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" 
                                                                        RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.ContactActiveTB2YrsNotes%>" ID="tbNotes" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr> 
                                                            <tr>
                                                                <td class="col-md-3">Diabetes mellitus type 1 or 2</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList1" runat="server" SelectedValue="<%# BindItem.DiabetesMellitusType1or2%>" AppendDataBoundItems="true"
                                                                        DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.DiabetesMellitusType1or2Notes%>" ID="TextBox1" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr> 
                                                            <tr>
                                                                <td class="col-md-3">End-stage renal disease</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList2" runat="server" SelectedValue="<%# BindItem.EndStageRenalDisease%>" AppendDataBoundItems="true"
                                                                        DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.EndStageRenalDiseaseNotes%>" ID="TextBox2" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr> 
                                                            <tr>
                                                                <td class="col-md-3">Underlying medical conditions</td>
                                                                <td class="col-md-3 nowrap"">
                                                                    <asp:RadioButtonList  ID="RadioButtonList3" runat="server" SelectedValue="<%# BindItem.UnderlyingMedicalonditions%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.UnderlyingMedicalonditionsNotes%>" ID="TextBox3" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-3">Homeless (at diagnosis or within past 12 mnths)</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList4" runat="server" SelectedValue="<%# BindItem.Homeless%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.HomelessNotes%>" ID="TextBox4" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>       
                                                            
                                                            <tr>
                                                                <td class="col-md-3">Lives in correctional facility at time of diagnosis</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList5" runat="server" SelectedValue="<%# BindItem.CorrectionalFacilityAtTimeDiag%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.CorrectionalFacilityAtTimeDiagNotes%>" ID="TextBox5" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-3">Previous abnormal chest xray</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList6" runat="server" SelectedValue="<%# BindItem.PreviousAbnormalChestXray%>"  AppendDataBoundItems="true"
                                                                        DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.PreviousAbnormalChestXrayNotes%>" ID="TextBox6" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-3">Substance abuse (known or suspected)</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList7" runat="server" SelectedValue="<%# BindItem.SubstanceAbuse%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true"> 
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.SubstanceAbuseNotes%>" ID="TextBox7" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-3">Tobacco User</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList8" runat="server" SelectedValue="<%# BindItem.TobaccoSmoker%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.TobaccoSmokerNotes%>" ID="TextBox8" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-3">Cannabis User</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList18" runat="server" SelectedValue="<%# BindItem.CannabisUser%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.CannabisNotes%>" ID="TextBox18" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-3">Smoking Device Use</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList33" runat="server" SelectedValue="<%# BindItem.SmokingDeviceUse%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.SmokingDeviceNotes%>" ID="TextBox33" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>   
                                                            
                                                             <tr>
                                                                <td class="col-md-3">Transplant related immunosuppression</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList9" runat="server" SelectedValue="<%# BindItem.TransplantRelatedImmunosuppression%>" AppendDataBoundItems="true" 
                                                                        DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.TransplantRelatedImmunosuppressionNotes%>" ID="TextBox9" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                             <tr>
                                                                <td class="col-md-3">HIV </td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList10" runat="server" SelectedValue="<%# BindItem.HIV%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.HIVNotes%>" ID="TextBox10" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-3">AIDS</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList11" runat="server" SelectedValue="<%# BindItem.AIDS%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.AIDSNotes%>" ID="TextBox11" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-3">Cancer</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList12" runat="server" SelectedValue="<%# BindItem.Cancer%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.CancerNotes%>" ID="TextBox12" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            
                                                            <tr>
                                                                <td class="col-md-3">Taking immunosuppressive drugs</td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList13" runat="server" SelectedValue="<%# BindItem.ImmunosuppressiveDrugs%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.ImmunosuppressiveDrugsNotes%>" ID="TextBox13" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>  
                                                            <tr>
                                                                <td class="col-md-3">Travel to high incidence country in last 2 years.  </td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList14" runat="server" SelectedValue="<%# BindItem.TravelHighIncidenceCountry2yrs%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.TravelHighIncidenceCountry2yrsNotes%>" ID="TextBox14" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>  


                                                            <tr>
                                                                <td class="col-md-3">Travel to another region of Inuit Nunagat in previous 2 years  </td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList20" runat="server" SelectedValue="<%# BindItem.TravelInuitNunaGutPrev2Years%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.TravelInuitNunaGutPrev2YearsNotes%>" ID="TextBox20" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>  

                                                            <tr>
                                                                <td class="col-md-3">Out of town visitors (staying in household) from high incidence country OR from other region of Inuit Nunagat in previous 2 years  </td>
                                                                <td class="col-md-3 nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList21" runat="server" SelectedValue="<%# BindItem.VisitorsFrHighIncidenceRegion%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.VisitorsFrHighIncidenceRegionNotes%>" ID="TextBox21" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>  

                                                            <tr>
                                                                <td class="col-md-3">Age when infected <= 5 years</td>
                                                                <td class="col-md-3 nowrap"">
                                                                    <asp:RadioButtonList  ID="RadioButtonList15" runat="server" SelectedValue="<%# BindItem.AgeWhenInfectedLessThanEqual5yrs%>" AppendDataBoundItems="true"
                                                                        DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.AgeWhenInfectedLessThanEqual5yrsNotes%>" ID="TextBox15" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>  

                                                            <tr>
                                                                <td class="col-md-3">Inactive disease not adequately treated</td>
                                                                <td class="col-md-3 nowrap"">
                                                                    <asp:RadioButtonList  ID="RadioButtonList16" runat="server" SelectedValue="<%# BindItem.InactiveDiseaseNotAdequatelyTreated%>" AppendDataBoundItems="true"
                                                                        DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.InactiveDiseaseNotAdequatelyTreatedNotes%>" ID="TextBox16" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr> 
                                                            <tr>
                                                                <td class="col-md-3">LTBI, refused DOP</td>
                                                                <td class="col-md-3 nowrap"">
                                                                    <asp:RadioButtonList  ID="RadioButtonList17" runat="server" SelectedValue="<%# BindItem.LTBIRrefusedDOP%>" DataSourceID="dsYesNoUnknownRefused" AppendDataBoundItems="true"
                                                                         DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.LTBIRrefusedDOPNotes%>" ID="TextBox17" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-md-3">Not Eligible For Treatment</td>
                                                                <td class="col-md-3 nowrap"">
                                                                    <asp:RadioButtonList  ID="RadioButtonList19" runat="server" SelectedValue="<%# BindItem.NotEligibleForTreatment%>" DataSourceID="dsYesNoUnknownRefused" AppendDataBoundItems="true"
                                                                         DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-6">
                                                                    <asp:TextBox Text="<%# BindItem.NotEligibleForTreatmentNotes%>" ID="TextBox19" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>                                                                                                                                                                                                                                           
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <label>Family History / Comments</label>
                                                    <asp:TextBox ID="tbComments" Text="<%# BindItem.FamilyHistory%>" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="row margin-top-10">
                                                <div class="col-lg-12">
                                                    <div class="pull-right">
                                                        <asp:LinkButton CommandName="Insert" ClientIDMode="Static" ID="addButton" runat="server" CssClass="btn btn-primary"><i class="fa fa-plus"></i> Add Risk</asp:LinkButton>
                                                        <asp:LinkButton CommandName="Update" ClientIDMode="Static"  ID="updateButton" runat="server" CssClass="btn btn-primary"><i class="fa fa-save"></i> Update</asp:LinkButton>
                                                        <asp:Hyperlink ID="lnkCancelButton" ClientIDMode="Static"  runat="server" NavigateURL="~/ClientPages/RiskHistory?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
                                                    </div>
                                                </div>
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
    <asp:EntityDataSource ID="dsUsers" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Clinicians"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsCompletionMethod" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_CompletionMethod"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsYesNoUnknownRefused" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_YesNoUnknownRefused" Where="it.Active = True"></asp:EntityDataSource>

    <script type="text/javascript">
        $(function () {
            var changeBoolean = new Boolean();
            changeBoolean = false;

            var allowButtonsWhiteList = new Array("addButton", "updateButton", "lnkCancelButton", "navtoggle", "toggleLogout");

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
