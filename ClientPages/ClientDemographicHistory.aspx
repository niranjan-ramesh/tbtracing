<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ClientDemographicHistory.aspx.vb" Inherits="TBTracing.ClientDemographicHistory" %>

<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i>Home</a></li>
            <li class="active">Patient Record</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i>Patient Record</h1>
                    </div>
                    <div class="pull-right">
                        <uc:ClientInfo ID="ClientInfoControl" runat="server" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">

                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="demographics" />

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                        </div>
                    </div>
                    <asp:Repeater ID="rptDemoDetails" runat="server" ItemType="TBTracing.client_Demographic" SelectMethod="rptDemoDetails_GetData" OnItemDataBound="rptDemoDetails_ItemDataBound">                        
                        <ItemTemplate>
                            <div role="tabpanel" class="tab-pane active" id="demographics">
                                <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-completed<%# String.Format("{0}", Item.ID.ToString())%>" href="#collapseCompleted<%# String.Format("{0}", Item.ID.ToString())%>" aria-expanded="true" aria-controls="collapseCompleted<%# String.Format("{0}", Item.ID.ToString())%>">
                                                From: <asp:Literal ID="litDetails" runat="server" Text='<%# Bind("ActiveFrom", "{0:dd-MMM-yyyy}")%>' />, To: <asp:Literal ID="litDateAdded" runat="server" Text='<%# Bind("ActiveTo", "{0:dd-MMM-yyyy}")%>' /></a>
                                            </h3>
                                        </div>
                                        <div id="collapseCompleted<%# String.Format("{0}", Item.ID.ToString())%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingCompleted<%# String.Format("{0}", Item.ID.ToString())%>">
                                            <div class="panel-body">
                                                <div class="form">

                                                <!-- Name / Identity Panel -->
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-identity" href="#collapseIdentity" aria-expanded="true" aria-controls="collapseIdentity">Name / Identity</a></h3>
                                                    </div>
                                                    <div id="collapseIdentity" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingIdentity">
                                                        <div class="panel-body">
                                                            <div class="form">
                                                                <div class="form-group col-lg-3 col-md-5 col-sm-6">
                                                                    <label for="tbFirstName">First Name</label>
                                                                    <asp:TextBox Enabled="false" ID="tbFirstName" runat="server" Text='<%# BindItem.FirstName%>' CssClass="form-control" placeholder="First Name"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-2 col-md-2 col-sm-6">
                                                                    <label for="tbMiddleInitial">Initial</label>
                                                                    <asp:TextBox Enabled="false" ID="tbMiddleInitial" runat="server" Text='<%# BindItem.MiddleInitial%>' CssClass="form-control" placeholder="Initial"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-3 col-md-5 col-sm-6">
                                                                    <label for="tbLastName">Last Name</label>
                                                                    <asp:TextBox Enabled="false" ID="tbLastName" runat="server" Text='<%# BindItem.LastName%>' CssClass="form-control" placeholder="Last Name"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-4 col-md-6 col-sm-6">
                                                                    <label for="tbAlias">Alias, Maiden Name, Nickname</label>
                                                                    <asp:TextBox Enabled="false" ID="tbAlias" runat="server" Text='<%# BindItem.Alias_MaidenName_Nickname%>' CssClass="form-control" placeholder="Alias, Maiden Name, Nickname"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-5 col-md-6 col-sm-12">
                                                                    <label>Language (Click all that apply)</label>
                                                                    <div class="panel panel-sub">
                                                                        <div class="panel-body">
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox Enabled="false" ID="cbSpeaksEnglish" runat="server" Text="EN" Checked='<%# BindItem.SpeaksEN%>' /></label>
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox Enabled="false" ID="cbSpeaksFrench" runat="server" Text="FR" Checked='<%# BindItem.SpeaksFR%>' /></label>
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox Enabled="false" ID="cbSpeaksInnu" runat="server" Text="Innu" Checked='<%# BindItem.SpeaksInnu%>' /></label>
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox Enabled="false" ID="cbSpeaksInuttitut" runat="server" Text="Inuttitut" Checked='<%# BindItem.SpeaksInuttitut%>' /></label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group col-lg-4 col-md-6 col-sm-6">
                                                                    <label for="tbMCP">MCP (Health Care Number)</label>
                                                                    <asp:TextBox Enabled="false" ID="tbMCP" runat="server" CssClass="form-control" placeholder="MCP" Text='<%# BindItem.HealthCareNumber%>'></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-3 col-md-6 col-sm-6">
                                                                    <label for="tbOtherNumber">Other Identifier</label>
                                                                    <asp:TextBox Enabled="false" ID="tbOtherNumber" runat="server" CssClass="form-control" placeholder="Other Identifier"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Demographics Panel -->
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-demo" href="#collapseDemo" aria-expanded="true" aria-controls="collapseDemo">Demographics</a></h3>
                                                    </div>
                                                    <div id="collapseDemo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingDemo">
                                                        <div class="panel-body">
                                                            <div class="form">
                                                                <div class="form-group col-lg-3 col-sm-3">
                                                                    <label for="tbDOB">Date of Birth</label>
                                                                    <div class="input-group">
                                                                        <asp:TextBox Enabled="false" ID="tbDOB" runat="server" CssClass="form-control datepicker" placeholder="dd-mmm-yyyy" Text='<%# Bind("DateofBirth", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group col-lg-1 col-sm-2">
                                                                    <label for="tbAge">Age</label>
                                                                    <asp:TextBox Enabled="false" ID="tbAge" runat="server" CssClass="form-control" placeholder="Age"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-8 col-sm-7">
                                                                    <label for="tbOccupation">Occupation</label>
                                                                    <asp:TextBox Enabled="false" ID="tbOccupation" runat="server" CssClass="form-control" placeholder="Occupation" Text='<%# BindItem.Occupation%>'></asp:TextBox>
                                                                </div>

                                                                <div class="col-lg-6 col-md-12 col-sm-12">
                                                                    <label>Ethnicity</label>
                                                                    <div class="panel panel-sub">
                                                                        <div class="panel-body">
                                                                            <div class="row">
                                                                                <div class="col-sm-12">
                                                                                    <div class="">
                                                                                        <asp:CheckBoxList Enabled="false" DataValueField="ID" ID="cblEthnicity" runat="server" DataSourceID="EthnicDictionary"
                                                                                            CssClass="checkbox-list checkbox-list-three"
                                                                                            DataTextField="Ethnicity" RepeatColumns="3" RepeatDirection="Horizontal" RepeatLayout="Table">
                                                                                        </asp:CheckBoxList>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-lg-6 col-md-8 col-sm-12">
                                                                                    <div class="checkbox">
                                                                                        <label>
                                                                                            <input type="checkbox" value="">
                                                                                            <asp:TextBox Enabled="false" ID="tbEthnicityOther" runat="server" CssClass="form-control input-sm" placeholder="Other" ReadOnly="True"></asp:TextBox>
                                                                                        </label>
                                                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-3 col-md-6 col-sm-6">
                                                                <label>Gender</label>
                                                                <div class="panel panel-sub">
                                                                    <div class="panel-body">
                                                                        <asp:RadioButtonList Enabled="false" ID="cblGender" runat="server" DataSourceID="GenderDictionary" AppendDataBoundItems="true"
                                                                            DataTextField="Gender" DataValueField="ID" SelectedValue='<%# BindItem.GenderID%>' CssClass="radio-list">
                                                                            <asp:ListItem Text="Select" Value="" Enabled="False" style="display: none;" />
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-3 col-md-6 col-sm-6">
                                                                <label>Pregnant</label>
                                                                <div class="panel panel-sub">
                                                                    <div class="panel-body">
                                                                        <asp:RadioButtonList Enabled="false" ID="rblPregnancyStatus" runat="server" DataSourceID="PregnancyDictionary"
                                                                            DataValueField="ID" DataTextField="PregnantStatus" AppendDataBoundItems="true"
                                                                            SelectedValue='<%# BindItem.PregnancyStatus%>' CssClass="radio-list">
                                                                            <asp:ListItem Text="Select" Value="" Enabled="False" style="display: none;" />
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Address Panel -->
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-address" href="#collapseAddress" aria-expanded="true" aria-controls="collapseAddress">Address</a></h3>
                                                    </div>
                                                    <div id="collapseAddress" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingAddress">
                                                        <div class="panel-body">
                                                            <div class="form">
                                                                <div class="form-group col-lg-6 col-sm-6">
                                                                    <label for="tbStreetAddress">Street Address</label>
                                                                    <asp:TextBox Enabled="false" ID="tbStreetAddress" runat="server" CssClass="form-control" placeholder="Street Address" Text='<%# BindItem.StreetAddress%>'></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-6 col-sm-6">
                                                                    <label for="tbCommunity">Community</label>
                                                                    <asp:DropDownList ID="ddCommunity" runat="server" AppendDataBoundItems="True" DataSourceID="Community" DataTextField="Community" DataValueField="ID"
                                                                         CssClass="form-control" selectedvalue="<%# BindItem.CommunityID %>">
                                                                        <asp:ListItem Text="Select" Value="" Enabled="False" style="display:none;"/>

                                                                    </asp:DropDownList>
                                                                    
                                                                    <%--<asp:TextBox Enabled="false" ID="tbCommunity" runat="server" CssClass="form-control" placeholder="Community" Text='<%# BindItem.Community%>'></asp:TextBox>--%>
                                                                </div>
                                                                <div class="form-group col-lg-3 col-sm-6">
                                                                    <label for="tbPostalCode">Postal Code</label>
                                                                    <asp:TextBox Enabled="false" ID="tbPostalCode" runat="server" CssClass="form-control" placeholder="Postal Code" Text='<%# BindItem.PostalCode%>'></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-3 col-sm-6">
                                                                    <label for="tbProvince">Province</label>
                                                                    <asp:DropDownList Enabled="false" ID="ddProvince" CssClass="form-control" runat="server" DataSourceID="ProvinceDictionary"
                                                                        DataTextField="Province" DataValueField="ID" AppendDataBoundItems="true" SelectedValue="<%#BindItem.ProvinceID%>">
                                                                        <asp:ListItem Text="Please Select..." Value=""></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="form-group col-lg-6 col-sm-6">
                                                                    <label for="tbPostalCode">Not Canada? Other Info</label>
                                                                    <asp:TextBox ID="tbOtherIdentifier" runat="server" CssClass="form-control" placeholder="Other..." Text='<%# BindItem.OtherProvinceStateIdentifier%>'></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-6 col-md-12 col-sm-12">
                                                                    <label>Area</label>
                                                                    <div class="panel panel-sub">
                                                                        <div class="panel-body">
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox Enabled="false" ID="cbLG" runat="server" Checked='<%# BindItem.RhaLG%>' Text="LGH" /></label>
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox Enabled="false" ID="cbEH" runat="server" Checked='<%# BindItem.RhaEH%>' Text="EH" /></label>
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox Enabled="false" ID="cbCH" runat="server" Checked='<%# BindItem.RhaCH%>' Text="CH" /></label>
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox Enabled="false" ID="cbWH" runat="server" Checked='<%# BindItem.RhaWG%>' Text="WH" /></label>
                                                                            <label class="checkbox-inline">
                                                                                <asp:CheckBox Enabled="false" ID="cbOther" runat="server" Checked='<%# BindItem.RhaLG%>' Text="Out of Province" /></label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Contact Details Panel -->
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-contact" href="#collapseContact" aria-expanded="true" aria-controls="collapseContact">Contact Details</a></h3>
                                                    </div>
                                                    <div id="collapseContact" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingContact">
                                                        <div class="panel-body">
                                                            <div class="form">
                                                                <div class="form-group col-lg-3 col-sm-6">
                                                                    <label for="tbHomePhone">Home Phone</label>
                                                                    <asp:TextBox  Enabled="false" ID="tbHomePhone" runat="server" CssClass="form-control" Text='<%# BindItem.HomePhone%>' placeholder="Home Phone"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-3 col-sm-6">
                                                                    <label for="tbMobilePhone">Mobile Phone</label>
                                                                    <asp:TextBox Enabled="false" ID="tbMobilePhone" runat="server" CssClass="form-control" Text='<%# BindItem.MobilePhone%>' placeholder="Mobile Phone"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-3 col-sm-6">
                                                                    <label for="tbOtherPhone">Other Phone</label>
                                                                    <asp:TextBox Enabled="false" ID="tbOtherPhone" runat="server" CssClass="form-control" Text='<%# BindItem.OtherPhone%>' placeholder="Other Phone"></asp:TextBox>
                                                                </div>
                                                                <div class="form-group col-lg-3 col-sm-6">
                                                                    <label for="tbEmail">Email</label>
                                                                    <asp:TextBox Enabled="false" ID="tbEmail" runat="server" CssClass="form-control" Text='<%# BindItem.Email%>' placeholder="Email"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Other Information Panel -->
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-other" href="#collapseOther" aria-expanded="true" aria-controls="collapseOther">Other Information</a></h3>
                                                    </div>
                                                    <div id="collapseOther" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOther">
                                                        <div class="panel-body">
                                                            <div class="form">
                                                                <div class="row">
                                                                    <div class="col-lg-12">
                                                                        <div class="form-group col-lg-2 col-md-3 col-sm-4">
                                                                            <label for="tbBodyWeight">Body Weight (lbs)</label>
                                                                            <asp:TextBox Enabled="false" ID="tbBodyWeight" runat="server" CssClass="form-control" placeholder="Body Weight" Text='<%# BindItem.BodyWeight%>'></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group col-lg-12">
                                                                    <asp:TextBox Enabled="false" ID="tbOtherInformation" runat="server" CssClass="form-control" placeholder="Add notes here..." Rows="4" TextMode="MultiLine" Text='<%# BindItem.Comments%>'></asp:TextBox>
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
                        </ItemTemplate>
                    </asp:Repeater>

                    <div class="row">
                        <div class="col-lg-6">
                            <div class="pull-left">
                                <asp:HyperLink ID="lnkHistory" NavigateUrl="~/ClientPages/ClientDemographic.aspx?clientid={0}" CssClass="btn btn-default" runat="server"><i class="fa fa-eye"></i> View Client</asp:HyperLink>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </section>
    <!-- Dictionary DS -->
    <asp:EntityDataSource ID="Community" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Community"></asp:EntityDataSource>
    <asp:EntityDataSource ID="EthnicDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Ethnicity" EntityTypeFilter="common_Ethnicity"></asp:EntityDataSource>
    <asp:EntityDataSource ID="GenderDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Gender" EntityTypeFilter="common_Gender"></asp:EntityDataSource>
    <asp:EntityDataSource ID="PregnancyDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_PregnancyStatus"></asp:EntityDataSource>
    <asp:EntityDataSource ID="StatusDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Status"></asp:EntityDataSource>
    <asp:EntityDataSource ID="ProvinceDictionary" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Province"></asp:EntityDataSource>
</asp:Content>
