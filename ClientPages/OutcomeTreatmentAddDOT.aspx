<%@ Page Title="Diagnosis History" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="OutcomeTreatmentAddDOT.aspx.vb" Inherits="TBTracing.OutcomeTreatmentAddDOT" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Outcome / Diagnosis History</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Diagnosis History</h1>
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
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="treatment" />
                
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="demographics">
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
                                    <i class="fa fa-check-circle"></i> Changes have been successfully saved
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                            </div>
                        </div>
                        </asp:Panel>

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-checklist" href="#collapseChecklist" aria-expanded="true" aria-controls="collapseChecklist">DOT/DOP and Symptom Checklist</a></h3>
                            </div>
                            <div id="collapseChecklist" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingChecklist">
                                <div class="panel-body">

                        <asp:FormView ID="fvDOT" runat="server" OnDataBound="fvDOT_DataBound" ItemType="TBTracing.client_DotModel" RenderOuterTable="false"
                            InsertMethod="fvDOT_InsertItem"  SelectMethod="fvDOT_GetItem" UpdateMethod="fvDOT_UpdateItem" >
                            <EditItemTemplate>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label for="tbDatePlaced">Administration Date</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbReminderDate" runat="server" CssClass="form-control datetimepicker" 
                                                    Text='<%# Bind("dotItem.DOTDate", "{0:dd-MMM-yyyy hh:mm tt}")%>' placeholder="dd-mmm-yyyy">
                                                </asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label for="tbDatePlaced">Administered By</label>
                                            <asp:DropDownList ID="ddMedication" CssClass="form-control" SelectedValue="<%# BindItem.dotItem.CompletedBy %>" runat="server" AppendDataBoundItems="true" DataSourceID="dsUsers" DataTextField="Username" DataValueField="ID">
                                                <asp:ListItem Text="Please select..." Value="" />
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    
                               </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label for="tbDatePlaced">Medications</label>
                                            <div class="well well-info">
                                                <asp:CheckBoxList ItemType="TBTracing.common_Medication" ID="rblMedications" runat="server" CssClass="checkbox-inline"></asp:CheckBoxList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label for="tbDatePlaced">Symptoms</label>
                                            <div class="well well-info">
                                                <asp:CheckBoxList ItemType="TBTracing.common_Medication" ID="rblSymptoms" runat="server" DataSourceID="dsSymptoms" DataTextField="Symptom" DataValueField="ID" OnDataBound="rblSymptoms_DataBound" CssClass="checkbox-inline"></asp:CheckBoxList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label for="tbDatePlaced">&nbsp;</label>
                                            <div class="well well-info">
                                                <asp:CheckBox ID="CheckBox1" runat="server" Text="  Client Did Not Show " Checked="<%# BindItem.dotItem.ClientNoShow%>" CssClass="checkbox-inline" />
                                                <br />
                                                <%--<asp:CheckBox ID="CheckBox2" runat="server" Text="  Practitioner Went to Client "  Checked="<%# BindItem.dotItem.%>" CssClass="checkbox-inline" />
                                                <br />
                                                <asp:CheckBox ID="CheckBox3" runat="server" Text="  Client Intoxicated at Time of Medication Administration "  Checked="<%# BindItem.dotItem.IntoxicatedTimeMedication%>" CssClass="checkbox-inline" />--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="pull-right">
                                            <asp:LinkButton ID="updateButton" runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                            <asp:LinkButton ID="addButton" runat="server" CommandName="Insert" CssClass="btn btn-primary"><i class="fa fa-save"></i> Add</asp:LinkButton>
                                            <asp:HyperLink ID="lnkCancelButton" runat="server" NavigateUrl="~/ClientPages/OutcomeTreatmentSchedule?clientid={0}&treatid={1}&outcomeid={2}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:HyperLink>
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
        </div>
    </section>
    <asp:EntityDataSource ID="dsSymptoms" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Symptoms"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsUsers" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Clinicians" OrderBy="it.Username"></asp:EntityDataSource>
</asp:Content>
