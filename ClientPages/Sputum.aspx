<%@ Page Title="Sputum Test" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Sputum.aspx.vb" Inherits="TBTracing.Sputum" MaintainScrollPositionOnPostback="true" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>    
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Sputum Test</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Sputum Test</h1>
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

                    <asp:FormView ID="SputumFormView" runat="server" ItemType="TBTracing.client_SputumModel" 
                                    DefaultMode="Insert" InsertMethod="SputumFormView_InsertItem" SelectMethod="SputumFormView_GetItem"
                                    UpdateMethod="SputumFormView_UpdateItem" RenderOuterTable="False">
                        <EditItemTemplate>

                            <div role="tabpanel" class="tab-pane active margin-top-10" id="sputumxray">
                             
                                <!-- Sputum Test Details Panel -->                                
                                <div class="panel-group" id="accordion-details" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a id="detailsToggle" data-toggle="collapse" data-parent="#accordion-details" href="#collapseDetails" aria-expanded="true" aria-controls="collapseDetails">Sputum Test Details</a></h3>
                                        </div>
                                        <div id="collapseDetails" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingDetails">
                                            <div class="panel-body">
                                                <div class="form">
                                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                                        <!-- Details -->
                                                        <div class="row">
                                                            <div class="col-lg-3 col-md-6 col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="tbDateCollected">Requested Date</label>
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="tbCollectedDate" runat="server" Text='<%# Bind("sputumData.CollectedDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </div>  
                                                            </div>
                                                            <div class="col-lg-3 col-md-6 col-sm-6">
                                                                <div class="form-group">
                                                                    <label>Requested By</label>                                                        
                                                                    <asp:DropDownList CssClass="form-control" ID="ddCompletedBy" DataSourceID="dsApplicationUsers" SelectedValue='<%# BindItem.sputumData.CompletedByID %>'
                                                                        DataTextField="Username" DataValueField="ID" runat="server" AppendDataBoundItems="true" >
                                                                        <asp:ListItem Text="Please Select" Value="" />
                                                                    </asp:DropDownList>
                                                                </div> 
                                                            </div>
                                                            <div class="col-lg-3 col-md-6 col-sm-6">
                                                                <div class="form-group">
                                                                    <label>Ordered By</label>                                                        
                                                                    <asp:DropDownList CssClass="form-control" ID="ddRequestedBy" DataSourceID="dsRequestBy" SelectedValue='<%# BindItem.sputumData.RequestedByID %>'
                                                                        DataTextField="RequestedBy" DataValueField="ID" runat="server" AppendDataBoundItems="true" >
                                                                        <asp:ListItem Text="Please Select" Value="" />
                                                                    </asp:DropDownList>
                                                                </div> 
                                                            </div>
                                                            <div class="col-lg-3 col-md-6 col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="tbDateResult">Result date</label>
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="tbResultDate" runat="server" Text='<%# Bind("sputumData.ResultDate", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </div>  
                                                            </div>
                                                        </div>
                                                        <!-- Status -->
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="form-group">                                                      
                                                                    <label>Status</label>  
                                                                    <div class="panel panel-sub"> 
                                                                        <div class="panel-body">
                                                                            <label class="checkbox-inline"><asp:CheckBox ID="cbRefused" runat="server" Checked='<%# BindItem.sputumData.StatusRefused%>' Text="Refused" /></label>
                                                                            <label class="checkbox-inline"><asp:CheckBox ID="cbUnableToProduce" runat="server" Checked='<%# BindItem.sputumData.StatusUnableToProduce%>' Text="Unable to Produce" /></label>
                                                                            <%--<label class="checkbox-inline"><asp:CheckBox ID="cbCollected" runat="server" Checked='<%# BindItem.sputumData.StatusCollected%>' Text="Collected" /></label>--%>
                                                                            <label class="checkbox-inline"><asp:CheckBox ID="cbInduced" runat="server" Checked='<%# BindItem.sputumData.StatusInduced%>' Text="Induced" /></label>
                                                                            <%--<label class="checkbox-inline"><asp:CheckBox ID="cbNotResulted" runat="server" Checked='<%# BindItem.sputumData.StatusNotResulted%>' Text="Not Resulted" /></label>
                                                                            <label class="checkbox-inline"><asp:CheckBox ID="cbSmearComplete" runat="server" Checked='<%# BindItem.sputumData.StatusSmearComplete%>' Text="Smear Complete" /></label>
                                                                            <label class="checkbox-inline"><asp:CheckBox ID="cbPendingCulture" runat="server" Checked='<%# BindItem.sputumData.StatusPendingCulture%>' Text="Pending Culture" /></label>
                                                                            <label class="checkbox-inline"><asp:CheckBox ID="cbComplete" runat="server" Checked='<%# BindItem.sputumData.StatusComplete%>' Text="Complete" /></label>--%>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <label>Comments</label>
                                                                <asp:TextBox ID="tbComments" runat="server" Text="<%# BindItem.sputumData.Comments %>" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- End of Sputum Test Details panel -->
                                                                
                                <!-- Smear Panel -->
                                <div class="panel-group" id="accordion-smear" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a id="smearToggle" data-toggle="collapse" data-parent="#accordion-smear" href="#collapseSmear" aria-expanded="true" aria-controls="collapseSmear">Smear</a></h3>
                                        </div>
                                        <div id="collapseSmear" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingSmear">
                                            <div class="panel-body">
                                                <div class="form-group"> 
                                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                                        <label>Result</label>  
                                                        <div class="panel panel-sub"> 
                                                            <div class="panel-body">
                                                                <asp:RadioButtonList ID="rblSmearResults" runat="server" CssClass="radio-list" SelectedValue="<%# BindItem.sputumData.SmearResultID%>" AppendDataBoundItems="true"
                                                                    DataSourceID="dsSmearResults" DataTextField="SmearResult" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Text="Select" Value=""  Enabled="False" style="display:none;" />
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- End of Smear panel -->
                        
                                <!-- Culture Panel -->
                                <div class="panel-group" id="accordion-culture" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a id="cultureToggle" data-toggle="collapse" data-parent="#accordion-culture" href="#collapseCulture" aria-expanded="true" aria-controls="collapseCulture">Culture</a></h3>
                                        </div>
                                        <div id="collapseCulture" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingCulture">
                                            <div class="panel-body">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-lg-8 col-md-8 col-sm-8">
                                                            <label>Result</label>
                                                            <div class="panel panel-sub">
                                                                <div class="panel-body">
                                                                    <asp:RadioButtonList ID="rblCultureResults" runat="server" CssClass="radio-list" SelectedValue="<%# BindItem.sputumData.CultureResultID%>" AppendDataBoundItems="true"
                                                                        DataSourceID="dsCultureResults" DataTextField="CultureResult" DataValueField="ID" RepeatLayout="Table" RepeatDirection="Horizontal">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display: none;" />
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-4 col-md-4 col-sm-4">
                                                            
                                                                <label for="tbDateResult">Culture Result Date</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="tbCutlureDate" runat="server" Text='<%# Bind("sputumData.CultureResultData", "{0:dd-MMM-yyyy}")%>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                </div>
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group"> 
                                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                                        <label>Antibiotic Resistance</label>                         
                                                        <div class="panel panel-sub"> 
                                                            <div class="panel-body">
                                                                <div class="row">                                                            
                                                                    <div class="col-md-12">
                                                                        <asp:CheckBoxList ID="cblAntibioticResistance" runat="server" CssClass="checkbox-list checkbox-list-four"
                                                                            DataSourceID="dsAntibiotic" DataTextField="AntibioticName" DataValueField="ID" OnDataBound="cblAntibioticResistance_DataBound"
                                                                            RepeatColumns="4" RepeatDirection="Horizontal" RepeatLayout="Table">
                                                                        </asp:CheckBoxList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- End of Culture Panel -->
                                
                                <!-- Reason For Testing Panel -->
                                <div class="panel-group" id="accordion-reason" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a id="reasonToggle" data-toggle="collapse" data-parent="#accordion-reason" href="#collapseReason" aria-expanded="true" aria-controls="collapseReason">Reason For Sputum Testing</a></h3>
                                        </div>
                                        <div id="collapseReason" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingReason">
                                            <div class="panel-body">
                                                <div class="form-group">
                                                    <div class="form-group col-lg-4 col-md-6 col-sm-8">
                                                        <label>Reason for Sputum Test</label>
                                                        <asp:DropDownList ID="ddReasonForTesting" runat="server" DataSourceID="dsReasons" DataValueField="ID" DataTextField="TestReason" AppendDataBoundItems="true"
                                                            SelectedValue="<%#BindItem.sputumData.ReasonForTestingID%>" CssClass="form-control" OnTextChanged="ddReasonForTesting_TextChanged" AutoPostBack="True">
                                                            <asp:ListItem Text="Please Select" Value="" />
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="form-group col-lg-8 col-md-6 col-sm-8">
                                                        <label>If Other</label>
                                                        <asp:TextBox ID="tbOtherTestReason" CssClass="form-control" Text="<%# BindItem.sputumData.ReasonForTestingOther%>" Enabled="false" runat="server"></asp:TextBox>
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
                                            <asp:LinkButton ID="addButton"  ClientIDMode="Static"  runat="server" CommandName="Insert" CssClass="btn btn-primary"><i class="fa fa-save"></i> Add</asp:LinkButton>
                                            <asp:Hyperlink ID="lnkCancelButton" ClientIDMode="Static"  runat="server" NavigateURL="~/ClientPages/SputumXRayHistory?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
                                        </div>
                                    </div>
                                </div>

                            </div><!-- end of tabpanel -->

                        </EditItemTemplate>
                    </asp:FormView>

                </div>
            </div>
        </div>
    </section>

    <!-- Dictionary DS -->
    <asp:EntityDataSource ID="dsApplicationUsers" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Clinicians"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsRequestBy" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_SputumRequestBy"></asp:EntityDataSource>
    <asp:EntityDataSource OnSelecting="dsReasons_Selecting" ID="dsReasons" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TestReason" Where="it.TypeID = @sputumtype"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsSmearResults" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_SputumSmearResult"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsCultureResults" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_SputumCultureResult"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsAntibiotic" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Antibiotic"></asp:EntityDataSource>

    <script type="text/javascript">
$(function () {    


    var changeBoolean = new Boolean();
    changeBoolean = false;

    var allowButtonsWhiteList = new Array("updateButton", "addButton", "lnkCancelButton", "detailsToggle", "smearToggle", "cultureToggle", "reasonToggle", "navtoggle", "toggleLogout");

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
