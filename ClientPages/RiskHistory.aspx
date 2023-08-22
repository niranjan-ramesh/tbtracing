<%@ Page Title="Risk History" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="RiskHistory.aspx.vb" Inherits="TBTracing.RiskHistory" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
            <li>Patient Record</li>
            <li class="active">Risk History</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Risk History</h1>
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
                        <!-- Success/Failure Panel -->
                        <asp:Panel ID="pnlSuccess" Visible="true" runat="server" ClientIDMode="Static">
                        <div class="row">
                            <div class="col-lg-6 col-lg-offset-3">
                                <div class="alert alert-success alert-save text-center">
                                    <i class="fa fa-check-circle"></i> Changes have been successfully saved
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                            </div>
                        </div>
                        </asp:Panel>
                        <!-- Add New Symptom Panel -->
                        <div class="panel-body">
                            <asp:Panel ID="pnlEmptyRisks" runat="server">
                                <div class="row">
                                    <div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Risks Entered</div></div>
                                </div>
                            </asp:Panel>
                            <asp:Repeater ID="rptDetails" runat="server" ItemType="TBTracing.RisksItem" SelectMethod="rptDetails_GetData">
                                <ItemTemplate>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-completed<%# String.Format("{0}", Item.riskID.ToString())%>" href="#collapseCompleted<%# String.Format("{0}", Item.riskID.ToString())%>" aria-expanded="true" aria-controls="collapseCompleted<%# String.Format("{0}", Item.riskID.ToString())%>">Completed By: <asp:Literal ID="litDetails" runat="server" Text="<%# BindItem.completedBy%>" />, on: <asp:Literal ID="litDateAdded" runat="server" Text="<%# BindItem.strDateAdded %>" /></a></h3>
                                        </div>
                                        <div id="collapseCompleted<%# String.Format("{0}", Item.riskID.ToString())%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingCompleted%# String.Format("{0}", Item.riskID.ToString())%">
                                            <div class="panel-body">
                                                <div class="form">
                                                    <!--RISK DETAILS START-->
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
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false"  ID="rblCough3Weeks" runat="server" SelectedValue="<%# BindItem.objRisk.ContactActiveTB2Yrs%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" 
                                                                                RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>

                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.ContactActiveTB2YrsNotes%>" ID="tbNotes" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr> 
                                                                    <tr>
                                                                        <td class="col-md-3">Diabetes mellitus type 1 or 2</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList1" runat="server" SelectedValue="<%# BindItem.objRisk.DiabetesMellitusType1or2%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.DiabetesMellitusType1or2Notes%>" ID="TextBox1" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr> 
                                                                    <tr>
                                                                        <td class="col-md-3">End-stage renal disease</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList2" runat="server" SelectedValue="<%# BindItem.objRisk.EndStageRenalDisease%>" AppendDataBoundItems="true"
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.EndStageRenalDiseaseNotes%>" ID="TextBox2" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr> 
                                                                    <tr>
                                                                        <td class="col-md-3">Underlying medical conditions</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList3" runat="server" SelectedValue="<%# BindItem.objRisk.UnderlyingMedicalonditions%>"
                                                                                 DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" AppendDataBoundItems="true"
                                                                                CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.UnderlyingMedicalonditionsNotes%>" ID="TextBox3" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr> 
                                                                    <tr>
                                                                        <td class="col-md-3">Homeless (at diagnosis or within past 12 mnths)</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList4" runat="server" SelectedValue="<%# BindItem.objRisk.Homeless%>"  AppendDataBoundItems="true"
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                                                 CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.HomelessNotes%>" ID="TextBox4" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>       
                                                            
                                                                    <tr>
                                                                        <td class="col-md-3">Lives in correctional facility at time of diagnosis</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList5" runat="server" SelectedValue="<%# BindItem.objRisk.CorrectionalFacilityAtTimeDiag%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" AppendDataBoundItems="true"
                                                                                 CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.CorrectionalFacilityAtTimeDiagNotes%>" ID="TextBox5" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="col-md-3">Previous abnormal chest xray</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList6" runat="server" SelectedValue="<%# BindItem.objRisk.PreviousAbnormalChestXray%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" AppendDataBoundItems="true"
                                                                                 CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.PreviousAbnormalChestXrayNotes%>" ID="TextBox6" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="col-md-3">Substance abuse (known or suspected)</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList7" runat="server" SelectedValue="<%# BindItem.objRisk.SubstanceAbuse%>"  AppendDataBoundItems="true"
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                                                 CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.SubstanceAbuseNotes%>" ID="TextBox7" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="col-md-3">Tobacco User</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList8" runat="server" SelectedValue="<%# BindItem.objRisk.TobaccoSmoker%>"  AppendDataBoundItems="true"
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.TobaccoSmokerNotes%>" ID="TextBox8" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                     <tr>
                                                                        <td class="col-md-3">Cannibis User</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList18" runat="server" SelectedValue="<%# BindItem.objRisk.CannabisUser%>"  AppendDataBoundItems="true"
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.CannabisNotes%>" ID="Label1" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                            
                                                                    <tr>
                                                                        <td class="col-md-3">Smoking Device Use</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList33" runat="server" SelectedValue="<%# BindItem.objRisk.SmokingDeviceUse%>" DataSourceID="dsYesNoUnknownRefused"
                                                                                DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display: none;" />
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:TextBox Text="<%# BindItem.objRisk.SmokingDeviceNotes%>" ID="TextBox33" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                        </td>
                                                                    </tr>



                                                                    <tr>
                                                                        <td class="col-md-3">Transplant related immunosuppression</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList9" runat="server" SelectedValue="<%# BindItem.objRisk.TransplantRelatedImmunosuppression%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" AppendDataBoundItems="true"
                                                                                CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.TransplantRelatedImmunosuppressionNotes%>" ID="TextBox9" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                     <tr>
                                                                        <td class="col-md-3">HIV </td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList10" runat="server" SelectedValue="<%# BindItem.objRisk.HIV%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" AppendDataBoundItems="true"
                                                                                RepeatDirection="Horizontal" CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.HIVNotes%>" ID="TextBox10" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                     <tr>
                                                                        <td class="col-md-3">AIDS</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList11" runat="server" SelectedValue="<%# BindItem.objRisk.AIDS%>" AppendDataBoundItems="true"
                                                                                 DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.AIDSNotes%>" ID="TextBox11" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                     <tr>
                                                                        <td class="col-md-3">Cancer</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false"  ID="RadioButtonList12" runat="server" SelectedValue="<%# BindItem.objRisk.Cancer%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" AppendDataBoundItems="true"
                                                                                RepeatDirection="Horizontal" CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.CancerNotes%>" ID="TextBox12" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                            
                                                                    <tr>
                                                                        <td class="col-md-3">Taking immunosuppressive drugs</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList13" runat="server" SelectedValue="<%# BindItem.objRisk.ImmunosuppressiveDrugs%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal"  AppendDataBoundItems="true"
                                                                                CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.ImmunosuppressiveDrugsNotes%>" ID="TextBox13" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>  
                                                                    <tr>
                                                                        <td class="col-md-3">Travel to high incidence country in last 2 years.  </td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList14" runat="server" SelectedValue="<%# BindItem.objRisk.TravelHighIncidenceCountry2yrs%>"
                                                                                 DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table"  AppendDataBoundItems="true"
                                                                                RepeatDirection="Horizontal" CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.TravelHighIncidenceCountry2yrsNotes%>" ID="TextBox14" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>  

                                                                    <tr>
                                                                        <td class="col-md-3">Travel to another region of Inuit Nunagat in previous 2 years   </td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList19" runat="server" SelectedValue="<%# BindItem.objRisk.TravelInuitNunaGutPrev2Years%>"
                                                                                 DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table"  AppendDataBoundItems="true"
                                                                                RepeatDirection="Horizontal" CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.TravelInuitNunaGutPrev2YearsNotes%>" ID="Label2" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>  

                                                                    <tr>
                                                                        <td class="col-md-3">Out of town visitors (staying in household) from high incidence country OR from other region of Inuit Nunagat in previous 2 years </td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList20" runat="server" SelectedValue="<%# BindItem.objRisk.VisitorsFrHighIncidenceRegion%>"
                                                                                 DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table"  AppendDataBoundItems="true"
                                                                                RepeatDirection="Horizontal" CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.VisitorsFrHighIncidenceRegionNotes%>" ID="Label3" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>  

                                                                    <tr>
                                                                        <td class="col-md-3">Age when infected <= 5 years</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList15" runat="server" SelectedValue="<%# BindItem.objRisk.AgeWhenInfectedLessThanEqual5yrs%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" AppendDataBoundItems="true"
                                                                                RepeatDirection="Horizontal" CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.AgeWhenInfectedLessThanEqual5yrsNotes%>" ID="TextBox15" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>  

                                                                    <tr>
                                                                        <td class="col-md-3">Inactive disease not adequately treated</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList16" runat="server" SelectedValue="<%# BindItem.objRisk.InactiveDiseaseNotAdequatelyTreated%>"
                                                                                 DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" AppendDataBoundItems="true"
                                                                                 RepeatDirection="Horizontal" CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.InactiveDiseaseNotAdequatelyTreatedNotes%>" ID="TextBox16" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr> 
                                                                    <tr>
                                                                        <td class="col-md-3">LTBI, refused DOP</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList17" runat="server" SelectedValue="<%# BindItem.objRisk.LTBIRrefusedDOP%>" AppendDataBoundItems="true"
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.LTBIRrefusedDOPNotes%>" ID="TextBox17" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr> 
                                                                    <tr>
                                                                        <td class="col-md-3">Not Eligible For Treatment</td>
                                                                        <td class="col-md-3">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList21" runat="server" SelectedValue="<%# BindItem.objRisk.NotEligibleForTreatment%>" AppendDataBoundItems="true"
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False"  style="display:none;"/>
                                                                            </asp:RadioButtonList>                                                                    
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label Text="<%# BindItem.objRisk.NotEligibleForTreatmentNotes%>" ID="Label4" runat="server" CssClass="form-control" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>                                                                                                                                                                                                                                          
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <label>Family History / Comments</label>
                                                            <asp:TextBox ReadOnly="true" ID="tbComments" Text="<%# BindItem.objRisk.FamilyHistory%>" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12 margin-top-10">
                                                            <div class="pull-right">
                                                                <asp:HyperLink NavigateUrl='<%# String.Format("~/ClientPages/Risks.aspx?clientid={0}&riskid={1}", Item.objRisk.ClientID, Item.riskID)%>' ID="lnkUpdateSymptom" runat="server" CssClass="btn btn-primary"><i class="fa fa-save"></i> Update</asp:HyperLink>                                                                                                                               
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--RISK DETAILS END-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="pull-right">
                                    <asp:HyperLink ID="lnkAddNew" runat="server" CssClass="btn btn-success" NavigateUrl="~/ClientPages/Risks.aspx?clientid={0}"><i class="fa fa-plus"></i> Add New Risk</asp:HyperLink>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <asp:EntityDataSource ID="dsYesNoUnknownRefused" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_YesNoUnknownRefused" Where="it.Active = True"></asp:EntityDataSource>
</asp:Content>
