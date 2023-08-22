<%@ Page Title="Contact Tracing" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ContactTracingAdd.aspx.vb" Inherits="TBTracing.ContactTracingAdd" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">Patient Record</a></li>
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
                    <div role="tabpanel" class="tab-pane active" id="demographics">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                            </div>
                        </div>    
                        
                        <!-- In Contact With Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="contactToggle" data-toggle="collapse" data-parent="#accordion-contactWith" href="#collapseContactWith" aria-expanded="true" aria-controls="collapseContactWith">In Contact With</a></h3>
                            </div>
                            <div id="collapseContactWith" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingContactWith">
                                <div class="panel-body">
                                    <div class="form">
                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 col-sm-4">
                                                <div class="form-group">
                                                    <label for="tbMCP">Name</label>
                                                    <asp:TextBox ID="tbName" runat="server" ReadOnly="true" CssClass="form-control" placeholder=""></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-4 col-sm-4">
                                                <div class="form-group">
                                                    <label for="tbFirstName">MCP</label>
                                                    <asp:TextBox ID="tbMCP" runat="server" CssClass="form-control" placeholder="" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-4 col-sm-4">
                                                <div class="form-group">
                                                    <label for="tbLastName">DOB</label>
                                                    <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control" placeholder="" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-4 col-sm-4">
                                                <div class="form-group">
                                                    <label for="tbDOB">Alias</label>
                                                    <asp:TextBox ID="tbAliast" runat="server" CssClass="form-control" placeholder="" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 col-sm-4">
                                                <div class="form-group">
                                                    <label for="tbMCP">City</label>
                                                    <asp:TextBox ID="tbCity" runat="server" CssClass="form-control" placeholder="" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-4 col-sm-4">
                                                <div class="form-group">
                                                    <label for="tbMCP">Province</label>
                                                    <asp:TextBox ID="tbProv" runat="server" CssClass="form-control" placeholder="" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-4 col-sm-4">
                                                <div class="form-group">
                                                    <label for="tbFirstName">Address</label>
                                                    <asp:TextBox ID="tbAddress" runat="server" CssClass="form-control" placeholder="" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="row">
                                            <div class="col-lg-12 col-md-4 col-sm-4">
                                                <div class="form-group">
                                                    <label for="tbOutCome">Recent Outcome</label>
                                                    <asp:TextBox ID="tbOutCome" runat="server" CssClass="form-control" placeholder="" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Contact Details Panel -->
                        <asp:FormView ID="fvContactTracing" runat="server" ItemType="TBTracing.client_ContactTracing" DefaultMode="Insert" UpdateMethod="fvContactTracing_UpdateItem"
                             InsertMethod="fvContactTracing_InsertItem" OnDataBound="fvContactTracing_DataBound" SelectMethod="fvContactTracing_GetItem" DataKeys="ID,ClientID,ContactClientID" RenderOuterTable="False">
                            <EditItemTemplate>
                                
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title"><a id="detailsToggle" data-toggle="collapse" data-parent="#accordion-details" href="#collapseDetails" aria-expanded="true" aria-controls="collapseDetails">Contact Details</a></h3>
                                    </div>                                    
                                    <div id="collapseDetails" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingDetails">
                                        <div class="panel-body">
                                            <div class="form">
                                                <div class="row">
                                                    <%--<div class="col-lg-3 col-md-4 col-sm-6">
                                                        <div class="form-group">
                                                            <!-- <label>From</label> -->
                                                            <label>Date of Initial Contact<br /><em>(if Known/applicable)</em></label>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="tbDateRead" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("FromDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <!-- <label>To</label> -->
                                                            <label>Date of Last Known Contact<br /><em>(if unknown, enter date of diagnosis)</em></label>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("ToDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label>&nbsp;<br />Type of Contact</label>
                                                            <asp:DropDownList SelectedValue="<%# BindItem.ContactTypeID%>" ID="ddType" runat="server" CssClass="form-control" DataSourceID="dsContactType" DataTextField="ContactType" DataValueField="ID" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Please Select..." Value=""></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <%--<div class="col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label>&nbsp;<br />Reason</label>
                                                            <asp:DropDownList SelectedValue="<%# BindItem.ReasonTypeID %>" ID="ddReason" runat="server" CssClass="form-control" DataSourceID="dsReason" DataTextField="ContactReason" DataValueField="ID" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Please Select..." Value=""></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>--%>
                                               <%-- </div>
                                                <div class="row">--%>
                                                    <%--<div class="col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label>Priority of Contact <span " data-toggle="tooltip" data-placement="top" title="See below for descriptions"><i class="fa fa-lg fa-question-circle text-primary"></i></span></label>
                                                            <asp:DropDownList SelectedValue="<%# BindItem.PriorityID %>" ID="ddPriority" runat="server" CssClass="form-control" DataSourceID="dsPriority" DataTextField="Priority" DataValueField="ID" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Please Select..." Value=""></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>--%>
                                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label>&nbsp;<br />Relationship</label>
                                                            <asp:DropDownList SelectedValue="<%# BindItem.RelationshipID %>" ID="ddRelationship" runat="server" CssClass="form-control" ItemType="TBTracing.common_ContactRelationship" SelectMethod="ddRelationship_GetItem" DataTextField="RelationshipText" DataValueField="ID" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Please Select..." Value=""></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label>&nbsp;<br />Community of Contact</label>
                                                            <asp:DropDownList SelectedValue="<%# BindItem.CommunityID %>" ID="ddCommunity" runat="server" CssClass="form-control" DataSourceID="dsCommunity" DataTextField="Community" DataValueField="ID" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Please Select..." Value=""></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <%--<div class="col-lg-3 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label>Associated Diagnosis</label>
                                                            <asp:DropDownList SelectedValue="<%# BindItem.DiagnosisID %>" ID="ddAssociatedDiagnosis" runat="server" CssClass="form-control" DataSourceID="dsContactType" DataTextField="ContactType" DataValueField="ID" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Please Select..." Value=""></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>--%>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <label>Comments</label>
                                                        <asp:TextBox Text="<%# BindItem.Comments  %>" ID="tbComments" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="row margin-top-10">
                                                    <div class="col-lg-12">
                                                        <div class="panel panel-primary" id="priority">
                                                            <div class="panel-heading"><i class="fa fa-lg fa-question-circle"></i>&nbsp;&nbsp;Priority of Contact</div>
                                                            <div class="panel-body">
                                                                <strong>High priority:</strong> household contacts plus close non-household contacts who are immunologically vulnerable, such as children under 5 years.<br />
                                                                <strong>Medium priority:</strong> close non-household contacts with daily or almost daily exposure, including those at school and work.<br />
                                                                <strong>Low priority:</strong> casual contacts with lower amounts of exposure.
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="pull-right">
                                            <asp:LinkButton ID="updateButton" ClientIDMode="Static" runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                            <asp:LinkButton ID="addButton" ClientIDMode="Static"  runat="server" CommandName="Insert" CssClass="btn btn-primary"><i class="fa fa-save"></i> Add</asp:LinkButton>
                                            <asp:Hyperlink ID="lnkCancelButton" ClientIDMode="Static"  runat="server" NavigateURL="~/ClientPages/ContactHistory.aspx?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
                                        </div>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:FormView>
                    </div>
                </div>                              
            </div>
        </div>
    </section>
    <asp:EntityDataSource ID="dsContactType" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_ContactType"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsReason" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_ContactReason"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsPriority" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_ContactPriority"></asp:EntityDataSource>
<%--    <asp:EntityDataSource ID="dsRelationship" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_ContactRelationship" OrderBy="it.RelationshipText"></asp:EntityDataSource>--%>
    <asp:EntityDataSource ID="dsCommunity" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Community"></asp:EntityDataSource>

    <script type="text/javascript">
$(function () {    


    var changeBoolean = new Boolean();
    changeBoolean = false;

    var allowButtonsWhiteList = new Array("updateButton", "addButton", "lnkCancelButton", "contactToggle", "detailsToggle", "navtoggle", "toggleLogout");

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
