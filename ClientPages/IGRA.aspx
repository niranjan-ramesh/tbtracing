<%@ Page Title="IGRA" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="IGRA.aspx.vb" Inherits="TBTracing.IGRA" MaintainScrollPositionOnPostback="true" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">IGRA</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> IGRA</h1>
                    </div>
                    <div class="pull-right">
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">

                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="investigation" />

                <!-- Tab panes -->
                <div class="tab-content">
                    
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                        </div>
                    </div>

                    <asp:FormView ID="IGRAFormView" runat="server" ItemType="TBTracing.client_IGRA" OnDataBound="IGRAFormView_DataBound"
                                    DefaultMode="Insert" InsertMethod="IGRAFormView_InsertItem" SelectMethod="IGRAFormView_GetItem"
                                    UpdateMethod="IGRAFormView_UpdateItem" RenderOuterTable="False">
                        <EditItemTemplate>

                            <div role="tabpanel" class="tab-pane active margin-top-10" id="investigation">
                                
                                <!-- IGRA Details Panel -->
                                <div class="panel-group" id="accordion-igra" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-igra" href="#collapseIgra" aria-expanded="true" aria-controls="collapseIgra">IGRA Details</a></h3>
                                        </div>
                                        <div id="collapseIgra" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingIgra">
                                            <div class="panel-body">
                                                <div class="form">
                                                    <div class="row">
                                                        <div class="col-lg-3 col-md-3 col-sm-6">
                                                            <div class="form-group">
                                                                <label for="tbCollectionDate">Collected Date</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="tbCollectionDate" runat="server" Text='<%# Bind("CollectionDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                </div>
                                                            </div>  
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-sm-6">
                                                            <div class="form-group">
                                                                <label for="tbResultDate">Result Date</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="tbResultDate" runat="server" Text='<%# Bind("ResultDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                </div>
                                                            </div>  
                                                        </div>
                                                        <div class="col-lg-6 col-md-6 col-sm-12">
                                                            <div class="form-group">
                                                                <label>Qualitative Test Interpretation</label> 
                                                                <div class="panel panel-sub"> 
                                                                    <div class="panel-body">
                                                                        <asp:RadioButtonList ID="rblIGRAResults" runat="server" CssClass="radio-list" SelectedValue="<%# BindItem.ResultID%>" AppendDataBoundItems="true"
                                                                            DataSourceID="dsIGRAResults" DataTextField="IGRATestResult" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal">
                                                                            <asp:ListItem Text="Select" Value=""  Enabled="False" style="display:none;" />
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Comments -->
                                                    <div class="row">
                                                        <div class="col-lg-12 col-md-12 col-sm-12">
                                                            <div class="form-group">
                                                                <label>Comments</label>
                                                                <asp:TextBox ID="tbComments" runat="server" CssClass="form-control" Text="<%# BindItem.Comments%>" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                            </div> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- end of IGRA Details Panel -->
                                
                                <!-- Reason For Testing Panel -->
                                <div class="panel-group" id="accordion-reason" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-reason" href="#collapseReason" aria-expanded="true" aria-controls="collapseReason">Reason For Testing</a></h3>
                                        </div>
                                        <div id="collapseReason" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingReason">
                                            <div class="panel-body">
                                                <div class="form-group">
                                                    <div class="form-group col-lg-4 col-md-6 col-sm-8">
                                                        <label>Test Reason</label>
                                                        <asp:DropDownList ID="ddReasonForTesting" runat="server" DataSourceID="dsReasons" DataValueField="ID" DataTextField="TestReason"
                                                            SelectedValue="<%#BindItem.ReasonForTestingID%>" CssClass="form-control" AppendDataBoundItems="true" AutoPostBack="true" OnTextChanged="ddReasonForTesting_TextChanged">
                                                            <asp:ListItem Text="Please Select" Value="" />
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="form-group col-lg-8 col-md-6 col-sm-8">
                                                        <label>If Other</label>
                                                        <asp:TextBox Enabled="true" ID="tbReasonOther" CssClass="form-control" Text="<%# BindItem.ReasonForTestingOther%>" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- End of Reason For Testing panel -->

                                <!-- Add/Update Button -->
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="pull-right">
                                            <asp:LinkButton ID="updateButton" runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                            <asp:LinkButton ID="addButton" runat="server" CommandName="Insert" CssClass="btn btn-primary"><i class="fa fa-save"></i> Add</asp:LinkButton>
                                            <asp:Hyperlink ID="lnkCancelButton" runat="server" NavigateURL="~/ClientPages/InvestigationHistory?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
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
    
    <!-- Dictionary DS -->
    <asp:EntityDataSource ID="dsReasons" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TestReason" Where="it.TypeID = @igratype" OnSelecting="dsReasons_Selecting"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsIGRAResults" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_IGRAResult"></asp:EntityDataSource>

</asp:Content>
