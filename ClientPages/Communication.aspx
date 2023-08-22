<%@ Page Title="Communication" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Communication.aspx.vb" Inherits="TBTracing.Communication" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Communication</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Communication</h1>
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
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="communication" />

                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="demographics">

                        <asp:FormView ID="ForViewCommunication" runat="server" ItemType="TBTracing.client_Communication" UpdateMethod="ForViewCommunication_UpdateItem"
                            DefaultMode="insert" InsertMethod="ForViewCommunication_InsertItem" SelectMethod="ForViewCommunication_GetItem" RenderOuterTable="false">
                            <EditItemTemplate>

                                <!-- Contact Details Panel -->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title"><span>Communication Attempt Details</span></h3>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-8 col-md-offset-2">
                                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="form-group col-lg-4">
                                                    <label>Communication Date</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control datetimepicker" Text='<%# Bind("CommunicationDateTime", "{0:dd-MMM-yyyy hh:mm tt}")%>' placeholder=""></asp:TextBox>
                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                    </div>
                                                </div>
                                                <div class="form-group col-lg-4">
                                                    <label>Method</label>
                                                    <asp:DropDownList CssClass="form-control" ID="ddMethod" runat="server" AppendDataBoundItems="true" SelectedValue="<%# BindItem.MethodID%>"
                                                        DataSourceID="dsCommunicationMethod" DataTextField="ContactMethod" DataValueField="ID">
                                                        <asp:ListItem Text="Please select" Value=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group col-lg-4">
                                                    <label>Reason</label>
                                                    <asp:DropDownList CssClass="form-control" ID="ddReason" runat="server" AppendDataBoundItems="true" SelectedValue="<%# BindItem.ReasonID %>"
                                                        DataSourceID="dsCommunicationReason" DataTextField="CommunicationReason" DataValueField="ID">
                                                        <asp:ListItem Text="Please select" Value=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="form-group col-lg-4">
                                                    <label>Result</label>
                                                    <asp:DropDownList CssClass="form-control" ID="ddResult" runat="server" AppendDataBoundItems="true" SelectedValue='<%# BindItem.ResultID %>'
                                                        DataSourceID="dsCommResults" DataTextField="CommunicationResult" DataValueField="ID">
                                                        <asp:ListItem Text="Please select" Value=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group col-lg-4">
                                                    <label>Contacted By</label>
                                                    <asp:DropDownList CssClass="form-control" ID="ddContactedBy" runat="server" AppendDataBoundItems="true" SelectedValue="<%# BindItem.ContactedBy%>"
                                                        DataSourceID="dsContactedBy" DataTextField="NameLabel" DataValueField="UserID">
                                                        <asp:ListItem Text="Please select" Value=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <%--<div class="form-group col-lg-4">
                                                    <label>Other Contacted By</label>
                                                    <asp:TextBox CssClass="form-control" ID="tbContactOther" Text="<%# BindItem.ContactedByName %>" runat="server"></asp:TextBox>
                                                </div>--%>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="form-group col-lg-12">
                                                    <label>Notes:</label>
                                                    <asp:TextBox ID="tbOtherInformation" Text="<%# BindItem.Comments%>" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="pull-right">
                                            <asp:LinkButton ID="addButton" ClientIDMode="Static" CommandName="Insert" runat="server" CssClass="btn btn-primary"><i class="fa fa-plus"></i> Add</asp:LinkButton>
                                            <asp:LinkButton ID="updateButton" ClientIDMode="Static"  CommandName="Update" runat="server" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                            <asp:Hyperlink ID="lnkCancelButton" ClientIDMode="Static"  runat="server" NavigateURL="~/ClientPages/CommunicationHistory?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
                                        </div>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:FormView>
                    </div>
                </div>
            </div>
    </section>

    <asp:EntityDataSource ID="dsCommunicationMethod" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_CommunicationMethod"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsCommunicationReason" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_CommunicationReason"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsContactedBy" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TBUser" OrderBy="it.NameLabel ASC"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsCommResults" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_CommunicationResult"></asp:EntityDataSource>

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
