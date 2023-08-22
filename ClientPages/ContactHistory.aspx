<%@ Page Title="Contact Tracing" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ContactHistory.aspx.vb" Inherits="TBTracing.ContactHistory" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Contact Tracing</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Contact Tracing</h1>
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
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="contacts" />
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" >
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
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                            </div>
                        </div>
                        <!-- Contact History Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-history" href="#collapseHistory" aria-expanded="true" aria-controls="collapseHistory">Contact History</a></h3>
                            </div>
                            <div id="collapseHistory" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingHistory">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <asp:GridView ID="gvHistory" runat="server" ItemType="TBTracing.ContactTracingHistoryGrid" AutoGenerateColumns="false" SelectMethod="gvHistory_GetData" AllowSorting="true"
                                                AllowPaging="true" PageSize="15" DataKeyNames="TraceID" DeleteMethod="gvHistory_DeleteItem"
                                                EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Contacts Listed</div></div>" 
                                                ShowHeaderWhenEmpty="false" CssClass="table table-striped table-bordered table-hover table-condensed" OnPreRender="gvHistory_PreRender">
                                                <Columns>
                                                    <asp:BoundField DataField="FromDate" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="From Date" SortExpression="FromDate" HeaderStyle-CssClass="text-center shrink" ItemStyle-CssClass="text-center shrink"></asp:BoundField>
                                                    <asp:BoundField DataField="ToDate" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="To Date" SortExpression="ToDate" HeaderStyle-CssClass="text-center shrink" ItemStyle-CssClass="text-center shrink"></asp:BoundField>
                                                    <asp:BoundField DataField="ContactName" HeaderText="Contact Name" SortExpression="ContactName" HeaderStyle-CssClass="text-center"></asp:BoundField>
                                                    <asp:BoundField DataField="TraceType" HeaderText="Type" SortExpression="TraceType" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink"></asp:BoundField>
                                                    <asp:BoundField DataField="Relationship" HeaderText="Relation" SortExpression="RelationShip" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink"></asp:BoundField>
                                                    <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink"></asp:BoundField>
                                                    <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" HeaderStyle-CssClass="text-center"></asp:BoundField>
                                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:HyperLink runat="server" CssClass="btn btn-info btn-table" NavigateUrl='<%# String.Format("~/ClientPages/ContactTracingAdd.aspx?traceid={0}&clientid={1}&contactid={2}", Eval("TraceID"), Eval("ClientID"), Eval("ContactID"))%>'><i class='fa fa-eye'></i> View</asp:HyperLink>
                                                            <asp:LinkButton ID="lbDelete" CommandName="Delete" runat="server" CssClass="btn btn-danger btn-table">Delete</asp:LinkButton>
                                                            
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="pull-right">
                                                <asp:HyperLink ID="lnkAddNew" runat="server" NavigateUrl="~/ClientPages/ContactTracingSearch.aspx?clientid={0}" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Contact</asp:HyperLink>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- Contact Notes Panel -->  
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-notes" href="#collapseNotes" aria-expanded="true" aria-controls="collapseNotes">Contact Notes</a></h3>
                            </div>
                            <div id="collapseNotes" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingNotes">
                                <div class="panel-body">
                                    <div class="form">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <asp:GridView ID="gvNotes" ItemType="TBTracing.client_ContactNote" runat="server" AutoGenerateColumns="False" DeleteMethod="gvNotes_DeleteItem"
                                                    EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Notes</div></div>"
                                                    CssClass="table table-striped table-bordered table-hover table-condensed" SelectMethod="gvNotes_GetData" DataKeyNames="ID" UpdateMethod="gvNotes_UpdateItem" OnPreRender="gvNotes_PreRender">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Date" SortExpression="DateEntered" HeaderStyle-CssClass="text-center shrink" ItemStyle-CssClass="text-center shrink">
                                                            <EditItemTemplate>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DateEntered", "{0:dd-MMM-yyyy}") %>' CssClass="form-control datepicker"></asp:TextBox>
                                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                </div>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("DateEntered", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                                            </ItemTemplate>

                                                            <HeaderStyle CssClass="text-center shrink"></HeaderStyle>

                                                            <ItemStyle CssClass="text-center shrink"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Note" HeaderText="Note" SortExpression="Note" ControlStyle-CssClass="form-control" HeaderStyle-CssClass="text-center expand">
                                                            <ControlStyle CssClass="form-control"></ControlStyle>

                                                            <HeaderStyle CssClass="text-center expand"></HeaderStyle>
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                            <EditItemTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="<span class='btn btn-success btn-table'><i class='fa fa-check'></i>Update</span>"></asp:LinkButton>
                                                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="&lt;span class='btn btn-default btn-table'&gt;&lt;i class='fa fa-times'&gt;&lt;/i&gt; Cancel&lt;/span&gt;"></asp:LinkButton>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                                     CssClass="btn btn-primary btn-table"><i class='fa fa-check'></i> Edit</asp:LinkButton>&nbsp;
                                                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete"
                                                                    OnClientClick="return confirm('Are you certain you want to delete this note?');"   CssClass="btn btn-danger btn-table"><i class='fa fa-trash-o'></i> Delete</asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="text-center" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>                                    
                                        <asp:FormView DefaultMode="Insert" ID="fvContactNotes" runat="server" ItemType="TBTracing.client_ContactNote" InsertMethod="fvContactNotes_InsertItem" RenderOuterTable="False">
                                            <InsertItemTemplate>
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                        <div class="form-group">
                                                            <label for="tbDatePlaced">Note Date</label>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="tbReminderDate" Text="<%# BindItem.DateEntered%>" runat="server" CssClass="form-control datepickerFuture" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-10">
                                                        <div class="form-group">
                                                            <label for="tbDatePlaced">Notes</label>
                                                            <asp:TextBox ID="tbNotes" Text="<%# BindItem.Note%>" runat="server" CssClass="form-control" placeholder="Notes here"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="pull-right">
                                                            <asp:LinkButton CommandName="Insert" ID="addNew" runat="server" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add Note</asp:LinkButton>
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
        </div>
    </section>
</asp:Content>