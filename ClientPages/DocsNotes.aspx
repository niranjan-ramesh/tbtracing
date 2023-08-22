<%@ Page Title="Docs/Notes" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="DocsNotes.aspx.vb" Inherits="TBTracing.DocsNotes" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Attachments</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Attachments</h1>
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

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="docsnotes">
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

                        <!-- Documents List Panel -->
                        <div class="panel-group" id="accordion-documents" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a id="attToggle" data-toggle="collapse" data-parent="#accordion-documents" href="#collapseDocuments" aria-expanded="true" aria-controls="collapseDocuments">Attachments</a></h3>
                                </div>
                                <div id="collapseDocuments" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingDocuments">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <!-- Documents Gridview -->
                                                    <asp:GridView ID="gvDocumentsHistory" runat="server" 
                                                        ItemType="TBTracing.DocumentsGridLineItem" 
                                                        SelectMethod="gvDocumentsHistory_GetData"
                                                        UpdateMethod="gvDocumentsHistory_DeleteItem"
                                                        DataKeyNames="ID" 
                                                        AutoGenerateColumns="false"
                                                        CssClass="table table-striped table-bordered table-hover table-condensed" 
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Documents Added</div></div>">
                                                        <Columns>
                                                            <asp:BoundField DataField="DocumentName" HeaderText="Document Name" NullDisplayText=" " ItemStyle-CssClass="expand" />
                                                            <asp:BoundField DataField="Active"  Visible="False" />
                                                            <asp:BoundField DataField="strDateAdded" HeaderText="Date Added" HeaderStyle-CssClass="text-center shrink" ItemStyle-CssClass="text-center shrink" NullDisplayText=" " />
                                                            <asp:BoundField DataField="DocumentType" HeaderText="Document Type" NullDisplayText=" " HeaderStyle-CssClass="text-center text-nowrap" ItemStyle-CssClass="text-center shrink" />
                                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkViewDoc" runat="server" CommandName="SelectDoc" CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" CssClass="btn btn-info btn-table"><i class='fa fa-download'></i> Download</asp:LinkButton>
                                                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return confirmDelete('Are you sure you want to delete this document?');" CommandName="Update" CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" CssClass="btn btn-danger btn-table"><i class='fa fa-trash-o'></i> Delete</asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>

                                            <!-- Document Upload -->
                                            <div class="row">
                                                <div class="col-lg-12 col-md-12 col-sm-12">
                                                    <div class="panel panel-primary">
                                                        <div class="panel-heading"><h3 class="panel-title">Upload Document</h3></div>
                                                        <div class="panel-body">
                                                            <asp:ValidationSummary ID="docValidationSummary" runat="server" CssClass="alert alert-danger"
                                                                HeaderText="<strong>Add a New Attachment Errors:</strong>" ValidationGroup="UploadDoc" />

                                                            <asp:FormView ID="DocumentFormView" runat="server" ItemType="TBTracing.client_Document" 
                                                                            DefaultMode="Insert" InsertMethod="DocumentFormView_InsertItem"  RenderOuterTable="False">
                                                                <InsertItemTemplate>
                                                                    <div class="form-inline">
                                                                        <div class="form-group file-upload margin-bottom-0">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon">File Name: </div>
                                                                                <asp:TextBox ID="tbFileName" runat="server" CssClass="form-control" Text="<%# BindItem.DocumentName%>" ValidationGroup="UploadDoc" />
                                                                                <asp:RequiredFieldValidator ID="fileNameValidator" runat="server" ErrorMessage="File Name is required" ControlToValidate="tbFileName" ValidationGroup="UploadDoc" Display="None"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                            <asp:FileUpload ID="fuAddDocument" runat="server" ValidationGroup="UploadDoc" />   
                                                                            <asp:RequiredFieldValidator ID="fileAddValidator" runat="server" ErrorMessage="File is required, please select your file" ControlToValidate="fuAddDocument" Display="None" ValidationGroup="UploadDoc"></asp:RequiredFieldValidator>                                                             
                                                                            <asp:CustomValidator ID="fileUploadValidator" runat="server" ErrorMessage=" " Display="None" ControlToValidate="fuAddDocument" ValidationGroup="UploadDoc" />
                                                                            <asp:LinkButton ID="lnkAddDocument" runat="server" CommandName="Insert" CssClass="btn btn-success" ValidationGroup="UploadDoc"><i class="fa fa-cloud-upload"></i> Add New Document</asp:LinkButton>
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
                        </div>
                                               
                        <!-- Notes Panel -->
                        <div class="panel-group" id="accordion-notes" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-notes" href="#collapseNotes" aria-expanded="true" aria-controls="collapseNotes">Notes</a></h3>
                                </div>
                                <div id="collapseNotes" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingNotes">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <!-- Notes Gridview -->
                                                    <asp:GridView ID="gvNotesHistory" runat="server" 
                                                        ItemType="TBTracing.NotesGridLineItem" 
                                                        SelectMethod="gvNotesHistory_GetData"
                                                        DeleteMethod="gvNotesHistory_DeleteItem"
                                                        DataKeyNames="ID" 
                                                        AutoGenerateColumns="false"
                                                        CssClass="table table-striped table-bordered table-hover table-condensed" 
                                                        EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No Notes Entered</div></div>">
                                                        <Columns>
                                                            <asp:BoundField DataField="strAddedDate" HeaderText="Date Added" HeaderStyle-CssClass="text-center shrink" ItemStyle-CssClass="text-center shrink" NullDisplayText=" " />
                                                            <asp:BoundField DataField="noteLabel" HeaderText="Label" NullDisplayText=" " ItemStyle-CssClass="expand" />
                                                            <asp:TemplateField HeaderText="" ItemStyle-CssClass="text-center shrink">
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="lnkViewNote" runat="server" NavigateUrl='<%# String.Format("~/ClientPages/Notes?noteid={0}&clientid={1}", Item.id, Item.clientID)%>' CssClass="btn btn-info btn-table" ><i class='fa fa-eye'></i> View</asp:HyperLink>
                                                                    <asp:LinkButton ID="lnkDeleteNote" runat="server" OnClientClick="return confirmDelete('Are you sure you want to delete this note?');" CommandName="Delete" CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" CssClass="btn btn-danger btn-table"><i class='fa fa-trash-o'></i> Delete</asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="pull-right">
                                                        <asp:HyperLink ID="lnkAddNote" runat="server" NavigateUrl="~/ClientPages/Notes?clientid={0}" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Note</asp:HyperLink>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Forms Panel
                        <div class="panel-group" id="accordion-forms" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-forms" href="#collapseForms" aria-expanded="true" aria-controls="collapseForms">Forms</a></h3>
                                </div>
                                <div id="collapseForms" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingForms">
                                    <div class="panel-body">
                                        <div class="form">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <ul class="sans-bullet-list">
                                                        <li><a href="#">Sample Form Link #1</a></li>
                                                        <li><a href="#">Sample Form Link #2</a></li>
                                                        <li><a href="#">Sample Form Link #3</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
 -->
                    </div>
                </div>


            </div>
        </div>

        <!-- Delete Document Confirm Modal -->
        <div class="modal fade" id="deleteDocumentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Delete Document?</h4>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this document?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"><i class="fa fa-trash-o"></i> Delete</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i>Close</button>
                    </div>
                </div>
            </div>
        </div>

<script type="text/javascript">
    function confirmDelete(message) {
        return confirm(message);
        //return confirm("Are you sure you want to delete this document?");
    }
</script> 

    </section>

</asp:Content>
