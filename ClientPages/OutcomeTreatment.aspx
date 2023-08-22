<%@ Page Title="Treatment" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="OutcomeTreatment.aspx.vb" Inherits="TBTracing.OutcomeTreatment" MaintainScrollPositionOnPostback="true" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i>Home</a></li>
            <li>Patient Record</li>
            <li class="active">TB Treatment</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title">TB Treatment Record</h1>
                    </div>
                    <div class="pull-right">
                        <uc:ClientInfo ID="ClientInfo1" runat="server" />
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
                    <div role="tabpanel" class="tab-pane active" id="tabpanel">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                            </div>
                        </div>                            

                                                <!-- Add New Medication Panel -->
                        <div class="panel-group" id="accordion-addfollowup collapse" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" class="collapsed" data-parent="#accordion-addfollowup" href="#collapseAddFollowup" aria-expanded="true" aria-controls="collapseAddFollowup">Treatment Regimen</a></h3>
                                </div>
                                <div id="collapseAddFollowup" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingAddFollowup">
                                    <div class="panel-body">
                                        <div class="form">

                                            <div class="row">
                                                <div class="col-lg-12">
                                                    
                                                    <asp:GridView ID="gvTreatments" runat="server" ShowHeaderWhenEmpty="True"
                                                        DataKeyNames="ID" ItemType="TBTracing.OutcomeTreatmentGridLineItem" AllowPaging="True" PageSize="8" 
                                                        AllowSorting="True" SelectMethod="gvFollowUps_GetData" UpdateMethod="gvTreatments_UpdateItem"
                                                        CssClass="table table-striped table-bordered table-hover table-condensed"  AutoGenerateColumns="False"
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Medications Prescribed</div></div>">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Drug" SortExpression="strMedicationName" HeaderStyle-CssClass="text-center">
                                                                <EditItemTemplate>
                                                                    <asp:DropDownList CssClass="form-control" SelectedValue='<%# BindItem.MedicationID%>' ID="DropDownList2" runat="server" DataSourceID="dsMedications" DataTextField="MedicationName" DataValueField="ID"></asp:DropDownList>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbMedName" runat="server" Text='<%# BindItem.strMedicationName%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Start" SortExpression="StartDate" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="tbStartDate" CssClass="form-control datepickerFuture" runat="server" Text='<%# Bind("StartDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbStart" runat="server" Text='<%# Bind("StartDate", "{0:dd-MMM-yyyy}")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="End" SortExpression="EndDate" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="tbEndDate" CssClass="form-control datepickerFuture" runat="server" Text='<%# Bind("EndDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbEnd" runat="server" Text='<%# Bind("EndDate", "{0:dd-MMM-yyyy}")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Doseage (mg)" SortExpression="Doseage" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="tbDoseage" CssClass="form-control" runat="server" Text='<%# BindItem.Doseage%>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbDosage" runat="server" Text='<%# BindItem.Doseage%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Frequency" SortExpression="strFrequency" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                <EditItemTemplate>
                                                                    <asp:DropDownList ID="dFreq" runat="server" CssClass="form-control" DataSourceID="dsFrequency" DataTextField="Frequency" DataValueField="ID" SelectedValue='<%# BindItem.FrequencyID%>'></asp:DropDownList>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbFreq" runat="server" Text='<%# BindItem.strFrequency%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Status" SortExpression="strStatus" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                <EditItemTemplate>
                                                                    <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control" DataSourceID="dsTreatStatus" DataTextField="MedicationStatus" DataValueField="ID" SelectedValue='<%# BindItem.StatusID%>'></asp:DropDownList>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbStatus" runat="server" Text='<%# BindItem.strStatus%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Number Doses" SortExpression="NumberDoses" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="tbNumDoses" CssClass="form-control" runat="server" Text='<%# BindItem.NumberDoses%>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbNumberDoses" runat="server" Text='<%# BindItem.NumberDoses%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Notes" SortExpression="Notes" HeaderStyle-CssClass="text-center">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="tbNotes" CssClass="form-control" runat="server" Text='<%# BindItem.Notes%>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbNotes" runat="server" Text='<%# BindItem.Notes%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:CommandField ShowEditButton="true" ItemStyle-CssClass="text-center"
                                                                ButtonType="Link"
                                                                CancelText="<span class='btn btn-default btn-table'><i class='fa fa-times'></i> Cancel</span>"
                                                                UpdateText="<span class='btn btn-success btn-table'><i class='fa fa-check'></i> Update</span>"
                                                                EditText="<span class='btn btn-primary btn-table'><i class='fa fa-pencil-square-o'></i> Edit</span>" />
                                                        </Columns>
                                                    </asp:GridView>

                                                </div>
                                            </div>
                                               
                                            <div class="panel panel-primary">
                                                <div class="panel-heading"><h3 class="panel-title">Add New Medication Regimen</h3></div>
                                                <div class="panel-body">      
                                                    <asp:FormView ID="fvAddMedicatin" runat="server" ItemType="TBTracing.client_OutcomeTreatmentRegimen" DefaultMode="Insert"
                                                        InsertMethod="fvAddMedicatin_InsertItem" RenderOuterTable="false">
                                                        <InsertItemTemplate>
                                                            <div class="row vdivide">

                                                                <div class="col-lg-2">
                                                                    <div class="form-group">
                                                                        <label for="tbDatePlaced">Start Date</label>
                                                                        <div class="input-group">
                                                                            <asp:TextBox ID="tbReminderDate" Text="<%# BindItem.StartDate %>" runat="server" CssClass="form-control datepickerFuture" placeholder="dd-mmm-yyyy">
                                                                            </asp:TextBox>
                                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-2">
                                                                    <div class="form-group">
                                                                        <label for="tbDatePlaced">End Date</label>
                                                                        <div class="input-group">
                                                                            <asp:TextBox ID="tbDueDate" Text="<%# BindItem.EndDate%>" runat="server" CssClass="form-control datepickerFuture" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-2">
                                                                    <div class="form-group">
                                                                        <label for="tbDatePlaced">Medication</label>
                                                                        <asp:DropDownList SelectedValue='<%# BindItem.MedicationID %>' ID="ddMedication" CssClass="form-control" runat="server"
                                                                            DataSourceID="dsMedications" DataTextField="MedicationName" DataValueField="ID" AppendDataBoundItems="true">
                                                                            <asp:ListItem Text="Please select..." Value="" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-2">
                                                                    <div class="form-group">
                                                                        <label for="tbDatePlaced">Frequency</label>
                                                                        <asp:DropDownList SelectedValue="<%# BindItem.FrequencyID%>" ID="ddFrequency" CssClass="form-control" runat="server"
                                                                            DataSourceID="dsFrequency" DataTextField="Frequency" DataValueField="ID" AppendDataBoundItems="true">
                                                                            <asp:ListItem Text="Please select..." Value="" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-2">
                                                                    <div class="form-group">
                                                                        <label for="tbDatePlaced">Dosage</label>
                                                                        <div class="input-group">
                                                                            <asp:TextBox ID="tbDosage" Text="<%# BindItem.Doseage%>" runat="server" CssClass="form-control" placeholder="Dosage"></asp:TextBox>
                                                                            <div class="input-group-addon">mg</div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <%--<div class="col-lg-2">
                                                                    <div class="form-group">
                                                                        <label for="tbDatePlaced"># Doses</label>
                                                                        <asp:TextBox ID="tbDoses" Text="<%# BindItem.NumberDoses%>" runat="server" CssClass="form-control" placeholder="Notes here"></asp:TextBox>
                                                                    </div>
                                                                </div>--%>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-lg-2">
                                                                    <div class="form-group">
                                                                        <label for="tbDatePlaced">Status</label>
                                                                        <asp:DropDownList SelectedValue='<%# BindItem.StatusID %>' ID="DropDownList1" CssClass="form-control" runat="server"
                                                                            AppendDataBoundItems="true" DataSourceID="dsTreatStatus" DataTextField="MedicationStatus" DataValueField="ID">
                                                                            <asp:ListItem Text="Please select..." Value="" />
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-10">
                                                                    <div class="form-group">
                                                                        <label for="tbNotes">Comments</label>
                                                                        <asp:TextBox ID="tbNotes" Text="<%# BindItem.Notes%>" runat="server" CssClass="form-control" placeholder="Notes here"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <div class="pull">
                                                                        <%--<asp:HyperLink CssClass="btn btn-info" ID="lnkDOT" runat="server" NavigateUrl="~/ClientPages/OutcomeTreatmentSchedule.aspx?clientid={0}&treatid={1}&outcomeid={2}"><i class="fa fa-eye"></i> View DOT / DOP Schedule</asp:HyperLink>--%>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6">
                                                                    <div class="pull-right">
                                                                        <asp:LinkButton CommandName="Insert" ID="addNew" runat="server" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Medication Regimen</asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </InsertItemTemplate>
                                                    </asp:FormView>      
                                                </div>
                                            </div>                                  
                                                                                                                             
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Treatment Details Panel -->
                        <div class="panel-group" id="accordion-treatmentdetails collapse" role="tablist" aria-multiselectable="true">
                            <asp:FormView ID="fvTreatmentOutcomeDetails" runat="server" ItemType="TBTracing.client_OutcomeTreatment" DefaultMode="Edit" OnDataBound="fvTreatmentOutcomeDetails_DataBound"
                                 SelectMethod="fvTreatmentOutcomeDetails_GetItem" DataKeyNames="ID" UpdateMethod="fvTreatmentOutcomeDetails_UpdateItem" RenderOuterTable="false">
                                <EditItemTemplate>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a data-toggle="collapse" class="collapsed" data-parent="#accordion-treatmentdetails" href="#collapseAddDetails" aria-expanded="true" aria-controls="collapseAddFollowup">Treatment - General Information</a></h3>
                                        </div>
                                        <div id="collapseAddDetails" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingAddFollowup">
                                            <div class="panel-body">
                                                <div class="form">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label for="tbDatePlaced">Treatment Mode</label>
                                                                <div class="well well-info">
                                                                    <asp:RadioButtonList CssClass="radio-list" ID="rblStatus" RepeatLayout="Table" AppendDataBoundItems="true" SelectedValue="<%# BindItem.TreatmentModeID%>"
                                                                        RepeatDirection="Horizontal" runat="server" DataSourceID="dsTreatmentMode" DataTextField="ModeTreatment" DataValueField="ID">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display: none;" />
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label for="tbDatePlaced">Adherence</label>
                                                                <div class="well well-info">
                                                                    <asp:RadioButtonList CssClass="radio-list" ID="RadioButtonList1" RepeatLayout="Table" AppendDataBoundItems="true" SelectedValue="<%# BindItem.AdherenceID%>"
                                                                        RepeatDirection="Horizontal" runat="server" DataSourceID="dsAdherence" DataTextField="Adherence" DataValueField="ID">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display: none;" />
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--<div class="col-md-12">
                                                            <div class="form-group">
                                                                <label for="tbDatePlaced">Outcome</label>
                                                                <div class="well well-info">
                                                                    <asp:RadioButtonList CssClass="radio-list" ID="RadioButtonList2" RepeatLayout="Table" AppendDataBoundItems="true" SelectedValue="<%# BindItem.OutcomeID%>"
                                                                        RepeatDirection="Horizontal" runat="server" DataSourceID="dsOutcome" DataTextField="TBOutcome" DataValueField="ID">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display: none;" />
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                        <%--<div class="col-md-12">
                                                            <div class="row">
                                                                <div class="col-lg-3">
                                                                    <div class="form-group">
                                                                        <label for="tbDatePlaced">Date, if Client died before/during treatment</label>
                                                                        <div class="input-group">
                                                                            <asp:TextBox ID="tbDateOfDeath" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" 
                                                                                Text='<%# Bind("ClientDateDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-9">
                                                                    <div class="form-group">
                                                                        <label for="tbDatePlaced">Did TB contribute to death</label>
                                                                        <div class="well well-info">
                                                                            <asp:CheckBox ID="CheckBox1" runat="server" Text="TB was cause of death" CssClass="checkbox-inline" Checked="<%# BindItem.ClientDeathTBCause%>" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="CheckBox2" runat="server" Text="TB contributed to death but not underlying cause" CssClass="checkbox-inline" Checked="<%# BindItem.ClientDeathTBContribute%>" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="CheckBox3" runat="server" Text="TB did not contribute" CssClass="checkbox-inline" Checked="<%# BindItem.ClientDeathTBNoContribute%>" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                        <div class="col-lg-12 col-md-8 col-sm-12">
                                                            <div class="form-group">
                                                                <label>Comments</label>
                                                                <asp:TextBox ID="tbComments" runat="server" CssClass="form-control" Text="<%# BindItem.Comments %>" placeholder="Add notes here..." Rows="4" TextMode="MultiLine" ></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12">
                                                            <div class="pull-right">
                                                                <asp:LinkButton ID="updateButton" runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>                                                                    
                                                                <asp:HyperLink ID="lnkCancelButton" runat="server" NavigateUrl="~/ClientPages/TreatmentHistory?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:HyperLink>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                </EditItemTemplate>
                            </asp:FormView>
                            
                        </div>
                        <!-- End Treatment Details Panel -->


                    </div>
                </div>

            </div>
        </div>
    </section>
    <asp:EntityDataSource ID="dsMedications" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Medication" OrderBy="it.MedicationName ASC"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsFrequency" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_MedicationFrequency"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsTreatStatus" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_MedicationStatus"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsTreatmentMode" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TreatmentMode"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsAdherence" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TreatmentAdherence"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsOutcome" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TBOutcome"></asp:EntityDataSource>
</asp:Content>
