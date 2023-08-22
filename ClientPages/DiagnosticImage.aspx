<%@ Page Title="Investigations" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="DiagnosticImage.aspx.vb" Inherits="TBTracing.DiagnosticImage" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">Patient Record</a></li>
            <li class="active">Investigations</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> <asp:Label ID="lblHeaderType" runat="server" Text=""></asp:Label> Investigations</h1>
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

                    <asp:FormView ID="fvDiagnosticImage" runat="server" ItemType="TBTracing.client_DiagnosticImage" InsertMethod="fvDiagnosticImage_InsertItem" UpdateMethod="fvDiagnosticImage_UpdateItem"
                                    DefaultMode="Insert" SelectMethod="fvDiagnosticImage_GetItem"  RenderOuterTable="False" OnDataBound="fvDiagnosticImage_DataBound">
                        <EditItemTemplate>

                            <div role="tabpanel" class="tab-pane active margin-top-10" id="sputumxray">

                                <!-- X-Ray Details Panel -->
                                <div class="panel-group" id="accordion-details" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-details" href="#collapseDetails" aria-expanded="true" aria-controls="collapseDetails">Diagnostic Tests</a></h3>
                                        </div>
                                        <div id="collapseDetails" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingDetails">
                                            <div class="panel-body">
                                                <div class="form">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label for="tbDateCollected">Investigation Date</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="tbExamDate" runat="server" Text='<%# Bind("ExamDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                </div>
                                                            </div>  
                                                        </div>
                                                        <%--<div class="col-lg-2 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>Area</label>                                                        
                                                                <asp:DropDownList CssClass="form-control" ID="ddXrayArea" DataSourceID="dsXrayArea" selectedValue="<%# BindItem.AreaID%>" 
                                                                    DataTextField="XrayArea" DataValueField="ID" runat="server" AppendDataBoundItems="true" >
                                                                    <asp:ListItem Text="Please Select" Value="" />
                                                                </asp:DropDownList>
                                                            </div> 
                                                        </div>--%>
                                                        <div class="col-lg-2 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>Procedure</label>                                                        
                                                                <asp:DropDownList CssClass="form-control" ID="ddXrayView" DataSourceID="dsXrayView" selectedValue="<%# BindItem.ViewID%>" 
                                                                    DataTextField="XrayView" DataValueField="ID" runat="server" AppendDataBoundItems="true" >
                                                                    <asp:ListItem Text="Please Select" Value="" />
                                                                </asp:DropDownList>
                                                            </div> 
                                                        </div>


                                                        <div class="col-lg-8 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>If Other</label>
                                                                <asp:TextBox ID="TextBox1" CssClass="form-control" Text="<%# BindItem.OtherProcedure%>" runat="server"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                        
                                                        <%--<div class="col-lg-3 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>Indication</label>                                                        
                                                                <asp:DropDownList CssClass="form-control" ID="ddXrayIndication" DataSourceID="dsXrayIndication" selectedValue="<%# BindItem.IndicationID%>" 
                                                                    DataTextField="XrayIndication" DataValueField="ID" runat="server" AppendDataBoundItems="true">
                                                                    <asp:ListItem Text="Please Select" Value="" />
                                                                </asp:DropDownList>
                                                            </div> 
                                                        </div>
                                                        <div class="col-lg-3 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>Result</label>                                                        
                                                                <asp:DropDownList CssClass="form-control" ID="ddXrayResult" DataSourceID="dsXrayResult" selectedValue="<%# BindItem.ResultID%>" 
                                                                    DataTextField="XrayResult" DataValueField="ID" runat="server" AppendDataBoundItems="true">
                                                                    <asp:ListItem Text="Please Select" Value="" />
                                                                </asp:DropDownList>
                                                            </div> 
                                                        </div>--%>
                                                    </div>
                                                </div>

                                                
                                                <!-- Comments -->
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-8 col-sm-12">
                                                        <div class="form-group">
                                                            <label>Findings</label>
                                                            <asp:TextBox ID="tbComments" runat="server" CssClass="form-control" Text="<%# BindItem.Findings%>" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                        </div> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Reason For Testing Panel -->
                                <div class="panel-group" id="accordion-reason" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-reason" href="#collapseReason" aria-expanded="true" aria-controls="collapseReason">Reason For Testing</a></h3>
                                        </div>
                                        <div id="collapseReason" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingReason">
                                            <div class="panel-body">
                                                <div class="form">                                    
                                                    <div class="form-group col-lg-4 col-md-6 col-sm-8">
                                                        <label>Reason For Investigation</label>
                                                        <asp:DropDownList ID="ddReasonForTesting" runat="server" DataSourceID="dsReasons" DataValueField="ID" DataTextField="TestReason" AppendDataBoundItems="true"
                                                            SelectedValue="<%#BindItem.ReasonForTesting%>" CssClass="form-control" AutoPostBack="true" OnTextChanged="ddReasonForTesting_TextChanged">
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
    <asp:EntityDataSource ID="dsXrayArea" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_XrayArea"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsXrayView" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_XrayView" OrderBy="it.XrayView"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsXrayIndication" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_XrayIndication"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsXrayResult" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_XrayResult"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsReasons" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TestReason" Where="it.TypeID = @ditype" OnSelecting="dsReasons_Selecting"></asp:EntityDataSource>
</asp:Content>
