<%@ Page Title="TB Outcome" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AddOutcome.aspx.vb" Inherits="TBTracing.AddOutcome" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i>Home</a></li>
            <li>Patient Record</li>
            <li class="active">Add Outcome</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> TB Outcome</h1>
                    </div>
                    <div class="pull-right">
                        <uc:clientinfo id="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">

                <!-- Nav tabs -->
                <uc:clienttabs id="ClientTabsControl" runat="server" activetab="diagnosis" />

                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="demographics">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-skindetails" href="#collapseSkinTestDetails" aria-expanded="true" aria-controls="collapseSkinTestDetails">Outcome Details</a></h3>
                            </div>
                            <div id="collapseSkinTestDetails" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingSkinTestDetails">
                                <div class="panel-body">
                                    <asp:FormView ID="fvTBOutcome" runat="server" ItemType="TBTracing.client_Outcome" DefaultMode="Insert" OnDataBound="fvTBOutcome_DataBound"
                                         InsertMethod="fvTBOutcome_InsertItem" SelectMethod="fvTBOutcome_GetItem" UpdateMethod="fvTBOutcome_UpdateItem" RenderOuterTable="False">
                                        <EditItemTemplate>
                                            <div class="form">
                                                <div class="row">
                                                <div class="col-lg-2 col-md-4 col-sm-6">
                                                    <div class="form-group">
                                                        <label for="tbDatePlaced">Outcome/Diagnosis Date</label>
                                                        <div class="input-group">
                                                            <asp:TextBox ID="tbDatePlaced" runat="server" Text='<%# Bind("OutcomeDeterminationDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%--<div class="col-lg-3 col-md-4 col-sm-6">
                                                    <div class="form-group">
                                                        <label>Outcome/Diagnosis Assessed By</label>
                                                        <asp:DropDownList CssClass="form-control" ID="ddAdminBy" DataSourceID="dsUsers" SelectedValue='<%# BindItem.DeterminedByID %>'
                                                            DataTextField="Username" DataValueField="ID" runat="server" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="Please Select" Value="" />
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>--%>
                                                <div class="col-lg-8 col-md-4 col-sm-6">
                                                    <div class="form-group">
                                                        <label>Outcome</label>
                                                        <asp:RadioButtonList OnSelectedIndexChanged="rbOutcome_SelectedIndexChanged" OnDataBound="rbOutcome_DataBound" ID="rbOutcome" SelectedValue='<%# BindItem.Outcome %>' runat="server" DataSourceID="dsOutcome" DataTextField="TBOutcome" DataValueField="ID" AutoPostBack="True" CssClass="radio-list"></asp:RadioButtonList>
                                                        <div class="row">
                                                            <div class="col-lg-10">
                                                                <div class="form-group">
                                                                    <%--<label>Transferred To</label>--%>
                                                                    <asp:TextBox Enabled="false" ID="tbTransferredTo" runat="server" Text='<%# BindItem.TransferDestination%>' CssClass="form-control input-sm" placeholder="Transferred To" ClientIDMode="Static"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:Panel ID="pnlActivePick" runat="server" Visible="false">
                                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                                        <div class="form-group">
                                                            <label>TB Type</label>
                                                            <asp:DropDownList CssClass="form-control" ID="ddTBTypes" DataSourceID="dsTBTypes" SelectedValue='<%# BindItem.TBType %>'
                                                                DataTextField="TBType" DataValueField="ID" runat="server" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Please Select" Value="" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                                    <%--<div class="col-lg-2 col-md-4 col-sm-6">
                                                        <div class="form-group">
                                                            <label>Outcome Details</label>
                                                            <asp:DropDownList CssClass="form-control" ID="DropDownList1"  DataTextField="TBType" DataValueField="ID" runat="server" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Please Select" Value="" />
                                                                <asp:ListItem Text="Ongoing" Value=""></asp:ListItem>
                                                                <asp:ListItem Text="Incomplete, Discontinued" Value=""></asp:ListItem>
                                                                <asp:ListItem Text="Incomplete, Noncompliant" Value=""></asp:ListItem>
                                                                <asp:ListItem Text="Incomplete, Absconded/lost to follow up; Please specify" Value=""></asp:ListItem>
                                                                <asp:ListItem Text="Incomplete, Other; specify" Value=""></asp:ListItem>
                                                                <asp:ListItem Text="Refused" Value=""></asp:ListItem>
                                                                <asp:ListItem Text="Absconded/lost to follow up; Please specify" Value=""></asp:ListItem>
                                                                <asp:ListItem Text="Complete" Value=""></asp:ListItem>

                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                                        <div class="form-group">
                                                            <label>Explanation</label>
                                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" ></asp:TextBox>
                                                        </div>
                                                    </div>--%>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-3">
                                                        <div class="form-group">
                                                            <label for="tbDatePlaced">Date, if Client died before/during treatment</label>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="tbDateOfDeath" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"
                                                                    Text='<%# Bind("ClientDeathDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
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

                                                <div class="row">
                                                    <div class="col-lg-12 col-md-8 col-sm-12">
                                                        <div class="form-group">
                                                            <label>Comments</label>
                                                            <asp:TextBox ID="tbResultsComments" runat="server" CssClass="form-control" Text="<%# BindItem.Comments%>" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                                

                                                <!-- Command Buttons -->
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="pull-right">
                                                            <asp:LinkButton ID="updateButton" runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                                            <asp:LinkButton ID="addButton" runat="server" CommandName="Insert" CssClass="btn btn-primary"><i class="fa fa-save"></i> Add</asp:LinkButton>
                                                            <asp:HyperLink ID="lnkCancelButton" runat="server" NavigateUrl="~/ClientPages/OutcomeHistory?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:HyperLink>
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
    <asp:EntityDataSource ID="dsOutcome" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TBOutcome" OrderBy="it.SortOrder"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsTBTypes" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TBTypes"></asp:EntityDataSource>
</asp:Content>
