<%@ Page Title="Symptoms" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Symptoms.aspx.vb" Inherits="TBTracing.Symptoms" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Symptoms</li>
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
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-xs-12">

                <!-- Nav tabs -->
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="symptoms" />

                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="tabpanel">
                        
                        <!-- Add New Symptom Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><span>Symptom Details</span></h3>
                            </div>
                            <div class="row">
                                <div class="col-md-8 col-md-offset-2">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                                </div>
                            </div>
                            <div class="panel-body">
                                <asp:FormView ID="FormViewSymptoms" runat="server" DefaultMode="Insert" ItemType="TBTracing.client_Symptoms" RenderOuterTable="false"
                                     InsertMethod="FormViewSymptoms_InsertItem" UpdateMethod="FormViewSymptoms_UpdateItem" SelectMethod="FormViewSymptoms_GetItem">
                                    <EditItemTemplate>

                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-4 col-md-5 col-sm-6">
                                                    <div class="form-group">
                                                        <label for="">Completed By</label>
                                                        <asp:DropDownList CssClass="form-control" ID="ddCompletedBy" runat="server" SelectedValue='<%# BindItem.InterviewByID %>'
                                                            DataSourceID="dsUsers" DataTextField="Username" DataValueField="ID" AppendDataBoundItems="true" >
                                                            <asp:ListItem Text="Please Select" Value="" />
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4 col-md-2 col-sm-6">
                                                    <div class="form-group">
                                                        <label for="">How Completed</label>
                                                        <asp:DropDownList ID="ddHowCompleted" runat="server"
                                                            CssClass="form-control" DataSourceID="dsCompletionMethod" DataTextField="CompletionMethod" 
                                                            selectedValue="<%# BindItem.CompletionMethod %>" DataValueField="ID">
                                                        </asp:DropDownList>                                                        
                                                    </div>
                                                </div>
                                                <div class="col-lg-4 col-md-2 col-sm-6">
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
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="rblCough3Weeks" runat="server" SelectedValue="<%# BindItem.CoughGreat3Weeks%>" DataSourceID="dsYesNoUnknownRefused"
                                                                         DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="True">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="tbStartDate" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("CoughGreat3WeeksStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="tbEndDate" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("CoughGreat3WeeksEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.CoughGreat3WeeksNotes%>" ID="tbNotes" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Shortness of Breath</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList1" runat="server" SelectedValue="<%# BindItem.ShortnessBreath%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("ShortnessBreathStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("ShortnessBreathEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.ShortnessBreathNotes%>" ID="TextBox3" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>  
                                                            <tr>
                                                                <td>Fever</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList2" runat="server" SelectedValue="<%# BindItem.Fever%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true" >
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("FeverStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("FeverEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.FeverNotes%>" ID="TextBox6" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr> 
                                                            <tr>
                                                                <td>Night Sweats</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList3" runat="server" SelectedValue="<%# BindItem.NightSweats%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("NightSweatsStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("NightSweatsEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.NightSweatsNotes%>" ID="TextBox9" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Hemoptysis</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList4" runat="server" SelectedValue="<%# BindItem.Hemoptysis%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox10" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("HemoptysisStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox11" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("HemoptysisEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.HemoptysisNotes%>" ID="TextBox12" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Weight Loss</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList5" runat="server" SelectedValue="<%# BindItem.WeightLoss%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox13" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("WeightLossStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox14" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("WeightLossEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.WeightLossNotes%>" ID="TextBox15" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Loss of Appetite</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList6" runat="server" SelectedValue="<%# BindItem.LossAppetite%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox16" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("LossAppetiteStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox17" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("LossAppetiteEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.LossAppetiteNotes%>" ID="TextBox18" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr> 
                                                            <tr>
                                                                <td>Fatigue</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList7" runat="server" SelectedValue="<%# BindItem.Fatigue%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox19" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("FatigueStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox20" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("FatigueEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.FatigueNotes%>" ID="TextBox21" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Chest Pain</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList8" runat="server" SelectedValue="<%# BindItem.Chestpain%>" DataSourceID="dsYesNoUnknownRefused"
                                                                         DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox22" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("ChestpainStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox23" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("ChestpainEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.ChestpainNotes%>" ID="TextBox24" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>    
                                                            <tr>
                                                                <td>Failure to Thrive</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList9" runat="server" SelectedValue="<%# BindItem.FailureToThrive%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox26" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("FailureToThriveStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox27" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("FailureToThriveEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.FailureToThriveNotes%>" ID="TextBox28" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr> 
                                                            <tr>
                                                                <td>Rash</td>
                                                                <td class="nowrap">
                                                                    <asp:RadioButtonList  ID="RadioButtonList10" runat="server" SelectedValue="<%# BindItem.Rash%>" DataSourceID="dsYesNoUnknownRefused" 
                                                                        DataTextField="Value" DataValueField="ID" CssClass="radio-list" RepeatLayout="table" RepeatDirection="Horizontal" AppendDataBoundItems="true">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                    </asp:RadioButtonList>                                                                    
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox29" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("RashStart", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-2">
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="TextBox30" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("RashEnd", "{0:dd-MMM-yyyy }")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </td>
                                                                <td class="col-md-3">
                                                                    <asp:TextBox Text="<%# BindItem.RashNotes%>" ID="TextBox31" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                                                </td>
                                                            </tr>                                                       
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <label>Comments</label>
                                                    <asp:TextBox ID="tbComments" Text="<%# BindItem.Comments %>" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="row margin-top-10">
                                                <div class="col-lg-12">
                                                    <div class="pull-right">
                                                        <asp:LinkButton CommandName="Insert" ID="addButton" ClientIDMode="Static" runat="server" CssClass="btn btn-primary"><i class="fa fa-plus"></i> Add</asp:LinkButton>
                                                        <asp:LinkButton CommandName="Update" ID="updateButton" ClientIDMode="Static" runat="server" CssClass="btn btn-primary"><i class="fa fa-save"></i> Update</asp:LinkButton>
                                                        <asp:Hyperlink ID="lnkCancelButton" ClientIDMode="Static" runat="server" NavigateURL="~/ClientPages/SymptomHistory?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
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
