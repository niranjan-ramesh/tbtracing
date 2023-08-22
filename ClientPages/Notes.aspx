<%@ Page Title="Notes" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Notes.aspx.vb" Inherits="TBTracing.Notes" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">    

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Notes</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Notes</h1>
                    </div>
                    <div class="pull-right">
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">

                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="docsnotes" />

                <!-- Tab panes -->
                <div class="tab-content">
                    
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                        </div>
                    </div>

                    <asp:FormView ID="NotesFormView" runat="server" ItemType="TBTracing.client_Notes"  OnDataBound="NotesFormView_DataBound"
                                    DefaultMode="Insert" InsertMethod="NotesFormView_InsertItem" SelectMethod="NotesFormView_GetItem"
                                    UpdateMethod="NotesFormView_UpdateItem" RenderOuterTable="False">
                        <EditItemTemplate>

                            <div role="tabpanel" class="tab-pane active" id="sputumxray">

                                <!-- Note Details Panel -->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title"><span>Note Details</span></h3>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="col-lg-12 col-md-12 col-sm-12">
                                                <!-- ARE THESE NECESSARY??? OR SHOULD THIS BE DONE A DIFFERENT WAY??? -->
                                                <asp:HiddenField ID="hdnDateAdded" runat="server" Value='<%# BindItem.DateAdded%>' />
                                                <asp:HiddenField ID="hdnActive" runat="server" Value='<%# BindItem.Active%>' />
                                                <!-- Label -->
                                                <div class="row">
                                                    <div class="col-lg-6 col-md-6 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="tbNoteLabel">Label</label>
                                                            <asp:TextBox ID="tbNoteLabel" runat="server" Text='<%# Bind("NoteLabel")%>' CssClass="form-control" placeholder="Label"></asp:TextBox>
                                                        </div>  
                                                    </div>
                                                </div>                                                
                                                <!-- Comments -->
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                                        <div class="form-group">
                                                            <label for="tbNoteText">Notes</label>
                                                            <asp:TextBox ID="tbNoteText" runat="server" CssClass="form-control" Text="<%# BindItem.NoteText%>" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                        </div> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>                
                                <!-- Add/Update Button -->
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="pull-right">
                                            <asp:LinkButton ID="updateButton" ClientIDMode="Static"  runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                            <asp:LinkButton ID="addButton" ClientIDMode="Static"   runat="server" CommandName="Insert" CssClass="btn btn-primary"><i class="fa fa-save"></i> Add</asp:LinkButton>
                                            <asp:Hyperlink ID="lnkCancelButton" ClientIDMode="Static"  runat="server" NavigateURL="~/ClientPages/DocsNotes?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </EditItemTemplate>
                    </asp:FormView>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
$(function () {    


    var changeBoolean = new Boolean();
    changeBoolean = false;

    var allowButtonsWhiteList = new Array("updateButton", "addButton", "lnkCancelButton", "navtoggle", "toggleLogout");

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
