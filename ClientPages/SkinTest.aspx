<%@ Page Title="Skin Test" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SkinTest.aspx.vb" Inherits="TBTracing.SkinTest" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">Skin Test</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> Skin Test</h1>
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
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="tst" />

                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="demographics">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                            </div>
                        </div>
                        <asp:FormView ID="SkinTestFormView" runat="server" ItemType="TBTracing.client_SkinTest" 
                                       DefaultMode="Insert" InsertMethod="SkinTestFormView_InsertItem" SelectMethod="SkinTestFormView_GetItem"
                                       UpdateMethod="SkinTestFormView_UpdateItem">
                        <EditItemTemplate>

                        <!-- Skin Test Details Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="detailsToggle" data-toggle="collapse" data-parent="#accordion-skindetails" href="#collapseSkinTestDetails" aria-expanded="true" aria-controls="collapseSkinTestDetails">Skin Test Details</a></h3>
                            </div>
                            <div id="collapseSkinTestDetails" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingSkinTestDetails">
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbDatePlaced">Date Placed</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbDatePlaced" runat="server" Text='<%# Bind("DatePlaced", "{0:dd-MMM-yyyy}") %>' CssClass="form-control datepicker" placeholder="dd-mmm-yyyy"></asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Administered By</label>
                                            <asp:DropDownList CssClass="form-control" ID="ddAdminBy" DataSourceID="dsClinicians" SelectedValue='<%# BindItem.AdministeredByID %>'
                                                DataTextField="Username" DataValueField="ID" runat="server" AppendDataBoundItems="true" >
                                                <asp:ListItem Text="Please Select" Value="" />
                                            </asp:DropDownList>
                                            
                                        </div> 
                                    </div>  
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Location Administered</label>
                                            <asp:DropDownList ID="ddWhereAdmin" selectedValue="<%# BindItem.SiteAdministered %>" CssClass="form-control" AppendDataBoundItems="true" DataSourceID="dsLocationAdministered" DataTextField="SiteName" DataValueField="ID" runat="server">
                                                <asp:ListItem Text="Please Select" Value="" />
                                            </asp:DropDownList>                                            
                                        </div>  
                                    </div>  
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>If Other, Please Specify</label>
                                            <asp:TextBox ID="tbSiteAdminOther" CssClass="form-control" Text="<%# BindItem.SiteAdministeredOther%>" runat="server" placeholder="Other Site(if applicable)"></asp:TextBox>                                           
                                        </div>   
                                    </div> 
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Product</label>
                                            <asp:DropDownList ID="ddproduct" selectedValue="<%# BindItem.ProductID %>" CssClass="form-control" AppendDataBoundItems="true" DataSourceID="dsProduct" DataTextField="ProductName" DataValueField="ID" runat="server">
                                                <asp:ListItem Text="Please Select" Value="" />
                                            </asp:DropDownList>                                            
                                        </div>  
                                    </div>   
                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Lot #</label>
                                            <asp:DropDownList CssClass="form-control" ID="ddLotNumbers" DataSourceID="dsMedicalLot" runat="server" AppendDataBoundItems="true" DataTextField="LotNumber" DataValueField="ID" selectedValue="<%# BindItem.LotID %>">
                                                <asp:ListItem Text="Please Select" Value="" />
                                            </asp:DropDownList>                                           
                                        </div>   
                                    </div>
                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label for="tbDose">Dose</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbDose" runat="server" CssClass="form-control" placeholder="Dose" Text="<%# BindItem.Dose%>"></asp:TextBox>                                                
                                                <div class="input-group-addon">mL</div>
                                            </div>                                       
                                        </div>   
                                    </div>
                                    <div class="col-lg-3 col-lg-offset-1 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Route</label>
                                            <asp:DropDownList selectedvalue="<%# BindItem.RouteID %>" CssClass="form-control" ID="ddRoute" DataSourceID="dsRoute" runat="server" AppendDataBoundItems="true" DataTextField="Route" DataValueField="ID">
                                                <asp:ListItem Text="Please Select" Value="" />
                                            </asp:DropDownList>                                           
                                        </div>   
                                    </div>
                                    <%--<div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Placed By</label>
                                            <asp:DropDownList CssClass="form-control" ID="ddPlacedBy" DataSourceID="ApplicationUsers" SelectedValue="<%# BindItem.PlacedBy%>"
                                                DataTextField="NameLabel" DataValueField="UserID" runat="server" AppendDataBoundItems="true">
                                                <asp:ListItem Text="Please Select" Value="" />
                                            </asp:DropDownList>
                                        </div> 
                                    </div>--%>

                                    <div class="col-lg-3 col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label>Site</label>
                                            <asp:DropDownList CssClass="form-control" selectedvalue="<%# BindItem.SiteID %>" AppendDataBoundItems="true" ID="ddSite" runat="server" DataSourceID="dsSite" DataValueField="ID" DataTextField="SkinTestSite">
                                                <asp:ListItem Text="Please Select" Value="" />
                                            </asp:DropDownList>                                           
                                        </div>   
                                    </div>   
                                      
                                    <div class="col-lg-12 col-md-8 col-sm-12">
                                        <div class="form-group">
                                            <label>Comments</label>
                                            <asp:TextBox ID="tbComments" runat="server" CssClass="form-control" Text="<%# BindItem.Comments%>" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                        </div> 
                                    </div>

                                </div>
                            </div>
                        </div>
                        </div>

                        <!-- Consent Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="consentToggle" data-toggle="collapse" data-parent="#accordion-skinconsent" href="#collapseSkinConsent" aria-expanded="true" aria-controls="collapseSkinConsent">Consent</a></h3>
                            </div>
                            <div id="collapseSkinConsent" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingSkinConsent">
                            <div class="panel-body">
                                <div class="form">
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <div class="form-group">                                                      
                                            <label>Fact Sheet Provided</label>  
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">                    
                                                    <label class="radio-inline"><asp:RadioButton ID="rbFactSheetYes" runat="server" Checked='<%#BindItem.ConsentFactSheetProvided%>' GroupName="FactSheetGroup" /> Yes</label>
                                                    <label class="radio-inline"><asp:RadioButton ID="rbFactSheetNo" runat="server" Checked='<%#BindItem.ConsentFactSheetProvidedNo%>' GroupName="FactSheetGroup" /> No</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <div class="form-group">                                                      
                                            <label>Benefits and Risks Understood</label>  
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
                                                    <label class="radio-inline"><asp:RadioButton ID="rbBenefitsUnderstood" Checked="<%# BindItem.ConsentBenefitsRisksUnderstood%>" runat="server" GroupName="BenefitsRisksGroup" />Yes</label>
                                                    <label class="radio-inline"><asp:RadioButton ID="rbBenefitsUnderstoodNo" Checked="<%# BindItem.ConsentBenefitsRisksUnderstoodNo%>" runat="server" GroupName="BenefitsRisksGroup" />No</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <div class="form-group">                                                      
                                            <label>Agree to Return 48-72 hrs</label>  
                                            <div class="panel panel-sub"> 
                                                <div class="panel-body">
                                                    <label class="radio-inline"><asp:RadioButton ID="rbReturn48_72_Hrs" Checked="<%# BindItem.Return4872Hours%>" runat="server" GroupName="AgreeReturnGroup" />Yes</label>
                                                    <label class="radio-inline"><asp:RadioButton ID="rbReturn48_72_HrsNo" Checked="<%# BindItem.Return4872HoursNo%>" runat="server" GroupName="AgreeReturnGroup" />No</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12">
                                        <div class="form-group">
                                            <label for="tbDateOfConsent">Date of Consent</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="tbDateOfConsent" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("ConsentDate", "{0:dd-MMM-yyyy}") %>'></asp:TextBox>
                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>

                        <!-- Skin Test Results Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="resToggle" data-toggle="collapse" data-parent="#accordion-skinresults" href="#collapseSkinResults" aria-expanded="true" aria-controls="collapseSkinResults">Skin Test Results/Outcome</a></h3>
                            </div>
                            <div id="collapseSkinResults" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingSkinResults">
                            <div class="panel-body">   
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label for="tbDateRead">Date Read/Outcome</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="tbDateRead" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("DateRead", "{0:dd-MMM-yyyy}") %>'></asp:TextBox>
                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>  
                                </div>
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label>Read By</label>
                                        <%--<asp:TextBox ID="tbReadBy" runat="server" CssClass="form-control" Text="<%# BindItem.ReadByText%>"></asp:TextBox>--%>
                                        <%--<asp:DropDownList CssClass="form-control" ID="ddReadBy" DataSourceID="dsClinicians" SelectedValue="<%# BindItem.ReadBy %>"
                                            DataTextField="Username" DataValueField="ID" runat="server" AppendDataBoundItems="true">
                                            <asp:ListItem Text="Please Select" Value="" />
                                        </asp:DropDownList>--%>
                                        <asp:DropDownList CssClass="form-control" ID="DropDownList1" DataSourceID="dsClinicians" SelectedValue='<%# BindItem.ReadByID%>'
                                            DataTextField="Username" DataValueField="ID" runat="server" AppendDataBoundItems="true">
                                            <asp:ListItem Text="Please Select" Value="" />
                                        </asp:DropDownList>
                                    </div>  
                                </div>
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label>Location Read</label>
                                        <asp:DropDownList ID="ddLocationRead" selectedValue="<%# BindItem.SiteRead%>" CssClass="form-control" AppendDataBoundItems="true" DataSourceID="dsLocationAdministered" DataTextField="SiteName" DataValueField="ID" runat="server">
                                            <asp:ListItem Text="Please Select" Value="" />
                                        </asp:DropDownList>                                            
                                    </div>  
                                </div>  
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label>Location Read, If Other</label>
                                        <asp:TextBox CssClass="form-control" Text="<%# BindItem.SiteOther %>" ID="tbOtherLocRead" runat="server" placeholder="Location Read"></asp:TextBox>                                           
                                    </div>  
                                </div> 
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label for="tbInduration">Induration</label>
                                        <div class="input-group">
                                                <asp:TextBox ID="tbInduration" runat="server" CssClass="form-control col-lg-3 col-md-4 col-sm-6" placeholder="Induration" Text="<%# BindItem.Iduration%>"></asp:TextBox>
                                            <div class="input-group-addon">mm</div>
                                        </div>
                                    </div>  
                                </div>
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label>Result/Outcome</label>
                                        <asp:DropDownList ID="ddResult" AppendDataBoundItems="true" runat="server" DataSourceID="dsResult" CssClass="form-control"
                                                        DataValueField="ID" DataTextField="SkinTestResult" SelectedValue="<%# BindItem.ResultID %>">
                                            <asp:ListItem Text="Please Select" Value="" />
                                        </asp:DropDownList>

                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-8 col-sm-12">
                                    <div class="form-group">                                                     
                                        <label>Recommendations</label>  
                                        <div class="panel panel-clear"> 
                                            <div class="panel-body">
                                                <label class="checkbox-inline"><asp:CheckBox ID="cbXray" runat="server" Checked='<%#BindItem.XrayRecommended%>' /> X-Ray</label>
                                                <label class="checkbox-inline"><asp:CheckBox ID="cbIgra" runat="server" Checked='<%#BindItem.IGRARecommended%>' /> IGRA</label>
                                                <label class="checkbox-inline"><asp:CheckBox ID="CheckBox1" runat="server" Checked='<%#BindItem.SputumRecommended%>' /> Sputum</label>
                                                <label class="checkbox-inline"><asp:CheckBox ID="CheckBox2" runat="server" Checked='<%#BindItem.SymptomInquiryRecommended%>' /> Symptom Inquiry</label>
                                            </div>
                                        </div>
                                    </div>  
                                </div>
                                <div class="col-lg-12 col-md-8 col-sm-12">
                                    <div class="form-group">
                                        <label>Comments</label>
                                        <asp:TextBox ID="tbResultsComments" runat="server" CssClass="form-control" Text="<%# BindItem.CommentsResult%>" placeholder="Add notes here..." Rows="4" TextMode="MultiLine"></asp:TextBox>
                                    </div> 
                                </div>
                            </div>
                        </div>
                        </div>

                        <!-- Follow-up TST Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="followupToggle" data-toggle="collapse" data-parent="#accordion-skinfollowup" href="#collapseSkinFollowUp" aria-expanded="true" aria-controls="collapseSkinFollowUp">Follow-up TST</a></h3>
                            </div>
                            <div id="collapseSkinFollowUp" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingSkinFollowUp">
                                <div class="panel-body">
                                    <div class="form">
                                        <div class="form-group col-lg-12 col-md-12 col-sm-12">
                                            <div class="form-inline">
                                                <div class="col-lg-2 col-md-6 col-sm-12">
                                                    <div class="form-group">
                                                        <label>Follow-up Needed</label>
                                                        <div class="panel panel-sub"> 
                                                            <div class="panel-body">
                                                                <asp:RadioButtonList ID="rblFollowTstReq" SelectedValue="<%# BindItem.FollowUpTestRequired%>" runat="server"
                                                                    RepeatDirection="Horizontal" CssClass="radio-list">
                                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                                    <asp:ListItem Text="" Value="" Enabled="False" style="display: none;"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-6 col-sm-12">
                                                    <div class="form-group">
                                                        <label>If yes, please select date:<br />
                                                        <em>(add manual follow-up if needed)</em>&nbsp;&nbsp;;</label>                                                        
                                                        <div class="input-group">
                                                            <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control datepickerFuture" placeholder="dd-mmm-yyyy" Text='<%# Bind("FollowUpDate", "{0:dd-MMM-yyyy}") %>'></asp:TextBox>
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                        </div>                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        </div>
                        <!-- Reason For Testing Panel -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a id="reasonToggle" data-toggle="collapse" data-parent="#accordion-reason" href="#collapseReason" aria-expanded="true" aria-controls="collapseReason">Reason For TST Testing</a></h3>
                            </div>
                            <div id="collapseReason" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingReason">
                            <div class="panel-body">
                                <div class="form">                                    
                                    <div class="form-group col-lg-4 col-md-6 col-sm-8">
                                        <label>Reason for Skin Test</label>
                                        <asp:DropDownList ID="ddReasonForTest" DataSourceID="dsReasons" DataValueField="ID" DataTextField="TestReason"
                                            SelectedValue="<%#BindItem.TestReasonID%>" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                                            <asp:ListItem Text="Please Select" Value="" />
                                        </asp:DropDownList>
                                        </div> 
                                    </div>
                                    <div class="form-group col-lg-8 col-md-6 col-sm-8">
                                        <label>If other</label>
                                        <asp:TextBox ID="tbOtherReason" CssClass="form-control" Text="<%# BindItem.TestReasonOther%>" runat="server"></asp:TextBox>
                                        </div> 
                                    </div>  
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="pull-right">
                                    <asp:LinkButton ID="updateButton" ClientIDMode="Static"  runat="server" CommandName="Update" CssClass="btn btn-primary"><i class="fa fa-save"></i> Save</asp:LinkButton>
                                    <asp:LinkButton ID="addButton"  ClientIDMode="Static"   runat="server" CommandName="Insert" CssClass="btn btn-primary"><i class="fa fa-save"></i> Add</asp:LinkButton>
                                    <asp:Hyperlink ID="lnkCancelButton" ClientIDMode="Static"   runat="server" NavigateURL="~/ClientPages/SkinTestHistory?clientid={0}" CssClass="btn btn-default"><i class="fa fa-times"></i> Cancel</asp:Hyperlink>
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
    <asp:EntityDataSource ID="dsMedicalLot" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_MedicalLot"></asp:EntityDataSource>    
    <asp:EntityDataSource ID="dsLocationAdministered" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_GeographicLocation" OrderBy="it.SiteName ASC"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsResult" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_SkinTestResult"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsProduct" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Product"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsSite" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_SkinTestSite"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsRoute" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_InjectionRoute"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsReasons" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TestReason" Where="it.TypeID = @tsttype" OrderBy="it.TestReason ASC"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsClinicians" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Clinicians" OrderBy="it.Username ASC" Where="it.Active = true"></asp:EntityDataSource>

    <script type="text/javascript">
$(function () {    

    var changeBoolean = new Boolean();
    changeBoolean = false;

    var allowButtonsWhiteList = new Array("updateButton", "addButton", "lnkCancelButton", "detailsToggle", "followupToggle", "consentToggle", "reasonToggle", "resToggle", "navtoggle", "toggleLogout");

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