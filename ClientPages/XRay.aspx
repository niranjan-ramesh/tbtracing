<%@ Page Title="X-Ray" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="XRay.aspx.vb" Inherits="TBTracing.XRay" MaintainScrollPositionOnPostback="true" %>
    
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="#">Patient Record</a></li>
            <li class="active">X-Ray</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> <asp:Label ID="lblHeaderType" runat="server" Text=""></asp:Label> X-Ray</h1>
                    </div>
                    <div class="pull-right">
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">

                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="sputumxray" />

                <!-- Tab panes -->
                <div class="tab-content">
                    
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                        </div>
                    </div>

                    <asp:FormView ID="XRayFormView" runat="server" ItemType="TBTracing.client_XRay" 
                                    DefaultMode="Insert" InsertMethod="XRayFormView_InsertItem" SelectMethod="XRayFormView_GetItem"
                                    UpdateMethod="XRayFormView_UpdateItem" RenderOuterTable="False">
                        <EditItemTemplate>

                            <div role="tabpanel" class="tab-pane active margin-top-10" id="sputumxray">

                                <!-- X-Ray Details Panel -->
                                <div class="panel-group" id="accordion-details" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a id="detailsToggle" data-toggle="collapse" data-parent="#accordion-details" href="#collapseDetails" aria-expanded="true" aria-controls="collapseDetails">X-Ray Details</a></h3>
                                        </div>
                                        <div id="collapseDetails" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingDetails">
                                            <div class="panel-body">
                                                <div class="form">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label for="tbDateCollected">Exam Date</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="tbExamDate" runat="server" Text='<%# Bind("ExamDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                </div>
                                                            </div>  
                                                        </div>
                                                        <div class="col-lg-2 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>Area</label>                                                        
                                                                <asp:DropDownList CssClass="form-control" ID="ddXrayArea" DataSourceID="dsXrayArea" selectedValue="<%# BindItem.AreaID%>" 
                                                                    DataTextField="XrayArea" DataValueField="ID" runat="server" AppendDataBoundItems="true" OnDataBound="ddXrayArea_DataBound">
                                                                    <asp:ListItem Text="Please Select" Value="" />
                                                                </asp:DropDownList>
                                                            </div> 
                                                        </div>
                                                        <div class="col-lg-2 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>View</label>                                                        
                                                                <asp:DropDownList CssClass="form-control" ID="ddXrayView" DataSourceID="dsXrayView" selectedValue="<%# BindItem.ViewID%>" 
                                                                    DataTextField="XrayView" DataValueField="ID" runat="server" AppendDataBoundItems="true" OnDataBound="ddXrayView_DataBound">
                                                                    <asp:ListItem Text="Please Select" Value="" />
                                                                </asp:DropDownList>
                                                            </div> 
                                                        </div>
                                                        <div class="col-lg-3 col-md-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>Indication</label>                                                        
                                                                <asp:DropDownList CssClass="form-control" ID="ddXrayIndication" ItemType="TBTracing.common_XrayIndication" SelectMethod="fvXrayIndication_GetItem" selectedValue="<%# BindItem.IndicationID%>" 
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
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- X-Ray Findings Grid -->
                                                <asp:Panel ID="pnlFindingGrid" Visible="True" runat="server">
                                                    <div class="row margin-top-20">
                                                        <div class="col-lg-12">
                                                            <table class="table table-striped table-bordered table-hover table-condensed">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="shrink">Finding</th>
                                                                        <th class="shrink text-center">Result <small>(check all that apply)</small></th>
                                                                        <th class="expand">Comments</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td class="shrink">Infiltrate</td>
                                                                        <td class="shrink text-center">
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox ID="cbInfiltrateYesNo" runat="server" Checked='<%# BindItem.InfiltrateYesNo%>' Text="" /></label></td>
                                                                        <td class="expand">
                                                                            <asp:TextBox ID="tbInfiltrate" runat="server" CssClass="form-control" Text='<%# BindItem.InfiltrateYesNoNotes%>'></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="shrink">Any cavitary lesion</td>
                                                                        <td class="shrink text-center">
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox ID="cbCavitaryLession" runat="server" Checked='<%# BindItem.CavitaryLession%>' Text="" /></label></td>
                                                                        <td class="expand">
                                                                            <asp:TextBox ID="tbCavitaryLession" runat="server" CssClass="form-control" Text='<%# BindItem.CavitaryLessionNotes%>'></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="shrink">Nodule with poorly defined margins</td>
                                                                        <td class="shrink text-center">
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox ID="cbNodule" runat="server" Checked='<%# BindItem.Nodule%>' Text="" /></label></td>
                                                                        <td class="expand">
                                                                            <asp:TextBox ID="tbNodule" runat="server" CssClass="form-control" Text='<%# BindItem.NoduleNotes%>'></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="shrink">Pleural effusion</td>
                                                                        <td class="shrink text-center">
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox ID="cbPleuralEffusion" runat="server" Checked='<%# BindItem.PleuralEffusion%>' Text="" /></label></td>
                                                                        <td class="expand">
                                                                            <asp:TextBox ID="tbPleuralEffusion" runat="server" CssClass="form-control" Text='<%# BindItem.PleuralEffusionNotes%>'></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="shrink">Hilar or mediastinal Lymphadenopathy</td>
                                                                        <td class="shrink text-center">
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox ID="cbHilarLymphadenopathy" runat="server" Checked='<%# BindItem.HilarLymphadenopathy%>' Text="" /></label></td>
                                                                        <td class="expand">
                                                                            <asp:TextBox ID="tbHilarLymphadenopathy" runat="server" CssClass="form-control" Text='<%# BindItem.HilarLymphadenopathyNotes%>'></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="shrink">Linear interstital disease</td>
                                                                        <td class="shrink text-center">
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox ID="cbLinearDisease" runat="server" Checked='<%# BindItem.LinearDisease%>' Text="" /></label></td>
                                                                        <td class="expand">
                                                                            <asp:TextBox ID="tbLinearDisease" runat="server" CssClass="form-control" Text='<%# BindItem.LinearDiseaseNotes%>'></asp:TextBox></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                                <!-- Comments -->
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-8 col-sm-12">
                                                        <div class="form-group">
                                                            <label><asp:Label ID="lblCommentsFindings" runat="server" Text=""></asp:Label></label>
                                                            <asp:TextBox ID="tbComments" runat="server" CssClass="form-control" Text="<%# BindItem.Comments%>" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
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
                                            <h3 class="panel-title"><a id="reasonToggle" data-toggle="collapse" data-parent="#accordion-reason" href="#collapseReason" aria-expanded="true" aria-controls="collapseReason">Reason For Testing</a></h3>
                                        </div>
                                        <div id="collapseReason" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingReason">
                                            <div class="panel-body">
                                                <div class="form">                                    
                                                    <div class="form-group col-lg-4 col-md-6 col-sm-8">
                                                        <label>Test Reason</label>
                                                        <asp:DropDownList ID="ddReasonForTesting" runat="server" DataSourceID="dsReasons" DataValueField="ID" DataTextField="TestReason"
                                                            SelectedValue="<%#BindItem.ReasonForTestingID%>" CssClass="form-control" OnTextChanged="ddReasonForTesting_TextChanged" AppendDataBoundItems="true" AutoPostBack="True">
                                                            <asp:ListItem Text="Please Select" Value="" />
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="form-group col-lg-8 col-md-6 col-sm-8">
                                                        <label>If Other</label>
                                                        <asp:TextBox Enabled="false" ID="tbOtherReason" CssClass="form-control" Text="<%# BindItem.ReasonForTestingOther%>" runat="server"></asp:TextBox>
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
                                            <asp:LinkButton ID="updateButton" ClientIDMode="Static" runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                            <asp:LinkButton ID="addButton" ClientIDMode="Static"  runat="server" CommandName="Insert" CssClass="btn btn-primary"><i class="fa fa-save"></i> Add</asp:LinkButton>
                                            <asp:Hyperlink ID="lnkCancelButton" ClientIDMode="Static"  runat="server" NavigateURL="~/ClientPages/SputumXRayHistory?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
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
    <asp:EntityDataSource ID="dsXrayView" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_XrayView"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsXrayIndication" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_XrayIndication"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsXrayResult" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_XrayResult"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsReasons" OnSelecting="dsReasons_Selecting" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TestReason" Where="it.TypeID = @xraytype"></asp:EntityDataSource>

    <script type="text/javascript">
        $(function () {


            var changeBoolean = new Boolean();
            changeBoolean = false;

            var allowButtonsWhiteList = new Array("updateButton", "addButton", "lnkCancelButton", "detailsToggle", "reasonToggle", "navtoggle", "toggleLogout");

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
