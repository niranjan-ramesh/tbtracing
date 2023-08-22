<%@ Page Title="Follow-Ups" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AllFollowups.aspx.vb" Inherits="TBTracing.AllFollowups" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li class="active">Follow Ups</li>
        </ol>
    </section>

    <section class="content">

        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Follow-ups</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row margin-top-20">
            <div class="col-xs-12">

                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                    </div>
                </div>

                <!-- Add New Symptom Panel -->
                <div class="panel-group" id="accordion-scheduled" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-scheduled" href="#collapseScheduled" aria-expanded="true" aria-controls="collapseScheduled">Scheduled Follow-ups</a></h3>
                        </div>
                        <div id="collapseScheduled" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingScheduled">
                            <div class="panel-body">
                                <div class="form">
                                    <div class="row">
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="tbMCP">From Date</label>
                                                <div class="input-group">
                                                    <asp:TextBox ID="tbFromDate" CssClass="form-control datepickerFuture" runat="server"  placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="tbFirstName">To Date</label>
                                                <div class="input-group">
                                                    <asp:TextBox ID="tbToDate" runat="server" CssClass="form-control datepickerFuture" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="col-lg-3 col-md-8 col-sm-8">
                                            <div class="form-group">
                                                <label for="ddStatus">Responsibility</label>
                                                <asp:DropDownList ID="ddResponsible" AppendDataBoundItems="true" runat="server" CssClass="form-control" DataSourceID="dsUsers" DataTextField="NameLabel" DataValueField="UserID">
                                                    <asp:ListItem Text="All" Value=""></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                         <div class="col-lg-3 col-md-8 col-sm-8">
                                            <div class="form-group">
                                                <label for="ddStatus">Followup Type</label>
                                                <asp:DropDownList ID="ddFollowUpType" AppendDataBoundItems="true" runat="server" CssClass="form-control" DataSourceID="dsFollowType" DataTextField="FollowupType" DataValueField="ID">
                                                    <asp:ListItem Text="All" Value=""></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-lg-1 col-md-4 col-sm-3">
                                            <div class="form-group">
                                                <label for="lbSearch">&nbsp;</label>
                                                <div>
                                                    <asp:LinkButton ID="lbSearch" runat="server" CssClass="btn btn-primary"><i class="fa fa-search"></i> Search</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <asp:GridView ID="gvFollowUps" runat="server" ShowHeaderWhenEmpty="True" ShowHeader="true"
                                                DataKeyNames="ID,ClientID" ItemType="TBTracing.FollowUpGridLineItem" AllowPaging="True" PageSize="8" AllowSorting="True" UpdateMethod="gvFollowUps_UpdateItem"
                                                CssClass="table table-striped table-bordered table-hover table-condensed" SelectMethod="gvFollowUps_GetData" AutoGenerateColumns="False"
                                                EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No follow-ups scheduled</div></div>">
                                                <Columns>
                                                    <asp:TemplateField ItemStyle-Width="10%" HeaderText="Client" SortExpression="strClientName" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <asp:Label ID="Label7" runat="server" Text='<%# BindItem.strClientName%>'></asp:Label>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label6" runat="server" Text='<%# BindItem.strClientName%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-Width="10%" HeaderText="Responsibility" SortExpression="strResponsibility" HeaderStyle-CssClass="text-center">
                                                        <EditItemTemplate>
                                                            <asp:DropDownList CssClass="form-control" SelectedValue='<%# BindItem.PhysicianID%>' ID="DropDownList2" runat="server" DataSourceID="dsUsers" DataTextField="NameLabel" DataValueField="UserID"></asp:DropDownList>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# BindItem.strResponsibility%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-Width="8%" HeaderText="Reminder Date" SortExpression="ReminderDate" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                        <EditItemTemplate>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="TextBox1" CssClass="form-control datepicker" runat="server" Text='<%# Bind("ReminderDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("ReminderDate", "{0:dd-MMM-yyyy}")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-Width="8%" HeaderText="Due Date" SortExpression="FollowupDate" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                        <EditItemTemplate>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="TextBox2" CssClass="form-control datepicker" runat="server" Text='<%# Bind("FollowupDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("FollowupDate", "{0:dd-MMM-yyyy}")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-Width="24%" HeaderText="Comments" SortExpression="Comments" HeaderStyle-CssClass="text-center">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server" Text='<%# BindItem.Comments%>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label4" runat="server" Text='<%# BindItem.Comments%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-Width="10%" HeaderText="Follow-up Type" SortExpression="strFollowupType" HeaderStyle-CssClass="text-center">
                                                        <EditItemTemplate>
                                                            <asp:DropDownList CssClass="form-control" SelectedValue='<%# BindItem.FollowupType%>' ID="DropDownList3" runat="server" DataSourceID="dsFollowType" DataTextField="FollowupType" DataValueField="ID"></asp:DropDownList>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label5" runat="server" Text='<%# BindItem.strFollowupType%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-Width="10%" HeaderText="Complete?" SortExpression="Complete" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked="<%# BindItem.Complete %>" />
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox Enabled="false" Checked="<%#BindItem.Complete%>" ID="CheckBox2" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-Width="10%" HeaderText="Completed Date" SortExpression="CompletedDate" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <div class="input-group">
                                                                <asp:TextBox CssClass="form-control datepicker" ID="TextBox4" runat="server" Text='<%# Bind("CompletedDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("CompletedDate", "{0:dd-MMM-yyyy}")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:CommandField ItemStyle-Width="10%" ShowEditButton="true" ItemStyle-CssClass="text-center"
                                                        ButtonType="Link"
                                                        CancelText="<span class='btn btn-default btn-table'><i class='fa fa-times'></i> Cancel</span>"
                                                        UpdateText="<span class='btn btn-success btn-table'><i class='fa fa-check'></i> Update</span>"
                                                        EditText="<span class='btn btn-primary btn-table'><i class='fa fa-pencil-square-o'></i> Edit</span>" />
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End of Scheduled Follow-ups Panel -->

                <!-- Add New Follow-up Panel -->
                <%--<div class="panel-group" id="accordion-addfollowup" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-addfollowup" href="#collapseAddFollowup" aria-expanded="true" aria-controls="collapseAddFollowup">Add New Follow-up</a></h3>
                        </div>
                        <div id="collapseAddFollowup" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingAddFollowup">
                            <div class="panel-body">
                                <div class="form">

                                    <asp:FormView ID="fvAddFollowUp" runat="server" ItemType="TBTracing.client_Followup" DefaultMode="Insert"
                                        InsertMethod="fvAddFollowUp_InsertItem" RenderOuterTable="false">
                                        <InsertItemTemplate>
                                            <div class="row">
                                                <div class="col-lg-2">
                                                    <div class="form-group">
                                                        <label for="tbDatePlaced">Responsibility</label>
                                                        <asp:DropDownList SelectedValue="<%# BindItem.PhysicianID %>" ID="ddResponsibility" CssClass="form-control" runat="server"
                                                            DataSourceID="dsUsers" DataTextField="NameLabel" DataValueField="UserID" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="Please select..." Value="" />
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-lg-2">
                                                    <div class="form-group">
                                                        <label for="tbDatePlaced">Reminder Date</label>
                                                        <div class="input-group">
                                                            <asp:TextBox ID="tbReminderDate" Text="<%# BindItem.ReminderDate %>" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-2">
                                                    <div class="form-group">
                                                        <label for="tbDatePlaced">Due Date</label>
                                                        <div class="input-group">
                                                            <asp:TextBox ID="tbDueDate" Text="<%# BindItem.FollowupDate %>" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="form-group">
                                                        <label for="tbDatePlaced">Notes</label>
                                                        <asp:TextBox ID="tbNotes" Text="<%# BindItem.Comments %>" runat="server" CssClass="form-control" placeholder="Notes here"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-lg-2">
                                                    <div class="form-group">
                                                        <label for="tbDatePlaced">Type</label>
                                                        <asp:DropDownList ID="DropDownList1" SelectedValue="<%# BindItem.FollowupType  %>" CssClass="form-control" runat="server"
                                                            DataSourceID="dsFollowType" DataTextField="FollowupType" DataValueField="ID" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="Please select..." Value="" />
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="pull-right">
                                                        <asp:LinkButton CommandName="Insert" ID="addNew" runat="server" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Followup</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </InsertItemTemplate>
                                    </asp:FormView>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
    </section>
    <asp:EntityDataSource ID="dsFollowType" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Followup"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsUsers" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TBUser"></asp:EntityDataSource>
</asp:Content>
