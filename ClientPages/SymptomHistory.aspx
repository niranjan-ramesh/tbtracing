<%@ Page Title="Symptom History" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SymptomHistory.aspx.vb" Inherits="TBTracing.SymptomHistory" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Symptom History</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Symptom History</h1>
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
                            <asp:Panel ID="pnlEmptySymptoms" runat="server">
                                <div class="row">
                                    <div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Symptoms Entered</div></div>
                                </div>
                            </asp:Panel>
                            <asp:Repeater ID="rptDetails" runat="server" ItemType="TBTracing.SymptomsItem" SelectMethod="rptDetails_GetData">                                
                                <ItemTemplate>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-completed<%# String.Format("{0}",Item.symptomID.ToString()) %>" href="#collapseCompleted<%# String.Format("{0}",Item.symptomID.ToString()) %>" aria-expanded="true" aria-controls="collapseCompleted<%# String.Format("{0}",Item.symptomID.ToString()) %>">Completed By: <asp:Literal ID="litDetails" runat="server" Text="<%# BindItem.completedBy%>" />, on: <asp:Literal ID="litDateAdded" runat="server" Text="<%# BindItem.strDateAdded %>" /></a></h3>
                                        </div>
                                        <div id="collapseCompleted<%# String.Format("{0}",Item.symptomID.ToString()) %>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingCompleted<%# String.Format("{0}",Item.symptomID.ToString()) %>">
                                            <div class="panel-body">
                                                <div class="form">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <table class="table table-striped table-bordered table-hover table-condensed">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="text-center">Findings</th>
                                                                        <th class="text-center">Result</th>
                                                                        <th class="text-center shrink">Start Date</th>
                                                                        <th class="text-center shrink">End Date</th>
                                                                        <th class="text-center shrink">Notes</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Cough longer than 3 weeks</td>
                                                                        <td class="nowrap">
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList2" runat="server" SelectedValue="<%# BindItem.objSymptom.CoughGreat3Weeks%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="tbStartDate" runat="server" placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.CoughGreat3WeeksStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="tbEndDate" runat="server" placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.CoughGreat3WeeksEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.CoughGreat3WeeksNotes%>" ID="tbNotes" runat="server" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Shortness of Breath</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ID="RadioButtonList1" runat="server" SelectedValue="<%# BindItem.objSymptom.ShortnessBreath%>"
                                                                                 DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox1" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.ShortnessBreathStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox2" runat="server" placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.ShortnessBreathEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.ShortnessBreathNotes%>" ID="TextBox3" runat="server" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fever</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ReadOnly="true" ID="rblFever" runat="server" SelectedValue="<%# BindItem.objSymptom.Fever%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox4" runat="server" placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.FeverStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox5" runat="server" placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.FeverEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.FeverNotes%>" ID="TextBox6" runat="server"  placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Night Sweats</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ReadOnly="true" ID="RadioButtonList3" runat="server" SelectedValue="<%# BindItem.objSymptom.NightSweats%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox7" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.NightSweatsStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox8" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.NightSweatsEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.NightSweatsNotes%>" ID="TextBox9" runat="server" placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Hemoptysis</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ReadOnly="true" ID="RadioButtonList4" runat="server" SelectedValue="<%# BindItem.objSymptom.Hemoptysis%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                                                 CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox10" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.HemoptysisStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox11" runat="server" placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.HemoptysisEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.HemoptysisNotes%>" ID="TextBox12" runat="server"  placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Weight Loss</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ReadOnly="true" ID="RadioButtonList5" runat="server" SelectedValue="<%# BindItem.objSymptom.WeightLoss%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox13" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.WeightLossStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox14" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.WeightLossEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.WeightLossNotes%>" ID="TextBox15" runat="server"  placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Loss of Appetite</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ReadOnly="true" ID="RadioButtonList6" runat="server" SelectedValue="<%# BindItem.objSymptom.LossAppetite%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal" 
                                                                                CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox16" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.LossAppetiteStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox17" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.LossAppetiteEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.LossAppetiteNotes%>" ID="TextBox18" runat="server"  placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fatigue</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ReadOnly="true" ID="RadioButtonList7" runat="server" SelectedValue="<%# BindItem.objSymptom.Fatigue%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                                                 CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox19" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.FatigueStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox20" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.FatigueEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.FatigueNotes%>" ID="TextBox21" runat="server"  placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Chest Pain</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ReadOnly="true" ID="RadioButtonList8" runat="server" SelectedValue="<%# BindItem.objSymptom.Chestpain%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                                                 CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox22" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.ChestpainStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="TextBox23" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.ChestpainEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.ChestpainNotes%>" ID="TextBox24" runat="server"  placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Failure to Thrive</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ReadOnly="true" ID="RadioButtonList9" runat="server" SelectedValue="<%# BindItem.objSymptom.FailureToThrive%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                                                 CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="Label1" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.FailureToThriveStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="Label2" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.FailureToThriveEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.FailureToThriveNotes%>" ID="Label3" runat="server"  placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Rash</td>
                                                                        <td>
                                                                            <asp:RadioButtonList Enabled="false" ReadOnly="true" ID="RadioButtonList10" runat="server" SelectedValue="<%# BindItem.objSymptom.Rash%>" 
                                                                                DataSourceID="dsYesNoUnknownRefused" DataTextField="Value" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                                                 CssClass="radio-list" AppendDataBoundItems="true">
                                                                                <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="Label4" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.RashStart", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-2 text-center shrink">
                                                                            <asp:Label ReadOnly="true" ID="Label5" runat="server"  placeholder="dd-mmm-yyyy" Text='<%# Bind("objSymptom.RashEnd", "{0:dd-MMM-yyyy }")%>'></asp:Label>
                                                                        </td>
                                                                        <td class="col-md-3 text-center shrink">
                                                                            <asp:Label ReadOnly="true" Text="<%# BindItem.objSymptom.RashNotes%>" ID="Label6" runat="server"  placeholder=""></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <label>Comments</label>
                                                            <asp:TextBox ReadOnly="true" ID="tbComments" Text="<%# BindItem.objSymptom.Comments %>" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12 margin-top-10">
                                                            <div class="pull-right">
                                                                <asp:HyperLink NavigateUrl='<%# String.Format("~/ClientPages/Symptoms.aspx?clientid={0}&symptomid={1}", Item.objSymptom.ClientID, Item.symptomID)%>' ID="lnkUpdateSymptom" runat="server" CssClass="btn btn-primary"><i class="fa fa-save"></i> Update</asp:HyperLink>                                                                                                                               
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="pull-right">
                                        <asp:HyperLink ID="lnkAddNew" runat="server" CssClass="btn btn-success" NavigateUrl="~/ClientPages/Symptoms.aspx?clientid={0}"><i class="fa fa-plus"></i> Add Symptoms</asp:HyperLink>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <asp:EntityDataSource ID="dsYesNoUnknownRefused" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_YesNoUnknownRefused"></asp:EntityDataSource>
</asp:Content>
