<%@ Page Title="Bloodwork" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Bloodwork.aspx.vb" Inherits="TBTracing.Bloodwork" MaintainScrollPositionOnPostback="true" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Bloodwork</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Bloodwork</h1>
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

                    <asp:FormView ID="BloodworkFormView" runat="server" ItemType="TBTracing.client_Bloodwork" OnDataBound="BloodworkFormView_DataBound"
                                    DefaultMode="Insert" InsertMethod="BloodworkFormView_InsertItem" SelectMethod="BloodworkFormView_GetItem"
                                    UpdateMethod="BloodworkFormView_UpdateItem" RenderOuterTable="False">
                        <EditItemTemplate>

                            <div role="tabpanel" class="tab-pane active margin-top-10" id="investigation">

                                <!-- Bloodwork Details Panel -->
                                <div class="panel-group" id="accordion-bloodwork" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-bloodwork" href="#collapseBloodwork" aria-expanded="true" aria-controls="collapseBloodwork">Bloodwork Details</a></h3>
                                        </div>
                                        <div id="collapseBloodwork" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingBloodwork">
                                            <div class="panel-body">
                                                <div class="form">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-sm-6">
                                                            <div class="form-group">
                                                                <label for="tbCollectedDate">Requested Date</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="tbCollectedDate" runat="server" Text='<%# Bind("CollectedDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                </div>
                                                            </div>  
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-sm-6">
                                                            <div class="form-group">
                                                                <label for="tbResultDate">Result Date</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="tbResultDate" runat="server" Text='<%# Bind("ResultDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                </div>
                                                            </div>  
                                                        </div>
                                                        <%--<div class="col-lg-4 col-md-3 col-sm-6">
                                                            <div class="form-group">
                                                                <label>Collected By</label>
                                                                <asp:DropDownList CssClass="form-control" ID="ddCollectedBy" DataSourceID="ApplicationUsers" SelectedValue='<%# BindItem.CollectedBy %>'
                                                                    DataTextField="Username" DataValueField="ID" runat="server" AppendDataBoundItems="true" >
                                                                    <asp:ListItem Text="Please Select" Value="" />
                                                                </asp:DropDownList>
                                                            </div>  
                                                        </div>
                                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                                            <div class="form-group">
                                                                <label>Collection Method</label> 
                                                                <div class="panel panel-sub"> 
                                                                    <div class="panel-body">
                                                                        <asp:RadioButtonList ID="rblCollectionMethod" runat="server" CssClass="radio-list" SelectedValue="<%# BindItem.CollectionMethodID%>" AppendDataBoundItems="true"
                                                                            DataSourceID="dsCollectionMethod" DataTextField="CollectionMethod" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal">
                                                                            <asp:ListItem Text="Select" Value=""  Enabled="False" style="display:none;" />
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-4 col-md-4 col-sm-12">
                                                            <div class="form-group">
                                                                <label for="tbDose">ALT</label>
                                                                <asp:TextBox ID="tbAlt" runat="server" CssClass="form-control" placeholder="ALT" Text="<%# BindItem.Alt%>"></asp:TextBox>                                                
                                                            </div>   
                                                        </div>
                                                        <div class="col-lg-4 col-md-4 col-sm-12">
                                                            <div class="form-group">
                                                                <label for="tbDose">AST</label>
                                                                <asp:TextBox ID="tbAst" runat="server" CssClass="form-control" placeholder="AST" Text="<%# BindItem.Ast%>"></asp:TextBox>                                                
                                                            </div>   
                                                        </div>
                                                        <div class="col-lg-4 col-md-4 col-sm-12">
                                                            <div class="form-group">
                                                                <label for="tbDose">Serum Bilirubin</label>
                                                                <asp:TextBox ID="tbSerumBilirubin" runat="server" CssClass="form-control" placeholder="Serum Bilirubin" Text="<%# BindItem.SerumBilirubin%>"></asp:TextBox>                                                
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
                                </div><!-- end of Bloodwork Details Panel -->
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
                                                            SelectedValue="<%#BindItem.ReasonForTestingID%>" AutoPostBack="true" OnTextChanged="ddReasonForTesting_TextChanged" CssClass="form-control" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="Please Select" Value="" />
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="form-group col-lg-8 col-md-6 col-sm-8">
                                                        <label>If Other</label>
                                                        <asp:TextBox Enabled="false" ID="tbTestReasonOther" CssClass="form-control" Text="<%# BindItem.ReasonForTestingOther%>" runat="server"></asp:TextBox>
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
                                            <asp:LinkButton ID="updateButton"  runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                            <asp:LinkButton ID="addButton"  runat="server" CommandName="Insert" CssClass="btn btn-primary"><i class="fa fa-save"></i> Add</asp:LinkButton>
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
    <asp:EntityDataSource ID="dsReasons" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TestReason" Where="it.TypeID = @bloodtype" OnSelecting="dsReasons_Selecting" OrderBy="it.TestReason asc"></asp:EntityDataSource>
    <asp:EntityDataSource ID="ApplicationUsers" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Clinicians" OrderBy="'it.Username asc" Where="it.active = true" ></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsCollectionMethod" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_BloodworkCollectionMethod" ></asp:EntityDataSource>


</asp:Content>
