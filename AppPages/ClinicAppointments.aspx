<%@ Page Title="Clinic Appointments" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ClinicAppointments.aspx.vb" Inherits="TBTracing.ClinicAppointments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li><a href="~/AppPages/ClinicList" runat="server">Clinics</a></li>
            <li class="active">Clinic Appointments</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-hospital-o"></i> Clinic Appointments</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <h4><strong>Clinic:</strong> <em><asp:Literal ID="litClinicDate" runat="server" Text="" /></em>&nbsp;&nbsp;<small>for</small> <em><asp:Literal ID="litPhysician" runat="server" Text="" /></em></h4>
            </div>
            <div class="col-lg-4">
                <div class="pull-right">
                    <asp:LinkButton ID="lnkClinicHomeTop" runat="server" CssClass="btn btn-default" PostBackUrl="~/AppPages/ClinicList.aspx"><i class="fa fa-hospital-o"></i> Back to Clinics</asp:LinkButton>
                </div>
            </div>
        </div>

        <div class="row margin-top-10">
            <div class="col-xs-12">
                <!-- Success/Failure Panel -->
                <asp:Panel ID="pnlSuccess" Visible="true" runat="server" ClientIDMode="Static">
                <div class="row">
                    <div class="col-lg-6 col-lg-offset-3">
                        <div class="alert alert-success alert-save text-center">
                            <i class="fa fa-check-circle"></i> Changes have been successfully saved
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                    </div>
                </div>
                </asp:Panel>

                <!-- Appointments Gridview Panel -->
                <div class="panel-group" id="accordion-scheduled" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-scheduled" href="#collapseScheduled" aria-expanded="true" aria-controls="collapseScheduled">Scheduled Appointments</a></h3>
                        </div>
                        <div id="collapseScheduled" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingScheduled">
                            <div class="panel-body">
                                <div class="form">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <asp:GridView ID="gvClinicAppointments" runat="server" ShowHeaderWhenEmpty="False" 
                                                ItemType="TBTracing.ClinicAppointmentGridLineItem" DataKeyNames="ID"
                                                UpdateMethod="gvClinicAppointments_UpdateItem" SelectMethod="gvClinicAppointments_GetData"
                                                CssClass="table table-striped table-bordered table-hover table-condensed" AutoGenerateColumns="False" 
                                                EmptyDataText="<div class='col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-12'><div class='alert-table alert-warning text-center margin-bottom-0'>No appointments scheduled</div></div>">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Time" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <div class="input-group">
                                                                <asp:TextBox ID="txtTime" CssClass="form-control timepicker" runat="server" Text='<%# Bind("Time", "{0:hh\:mm}")%>'></asp:TextBox>
                                                                <div class="input-group-addon datepickericon"><i class="fa fa-clock-o"></i></div>
                                                            </div>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTime" runat="server" Text='<%# Bind("Time", "{0:hh\:mm}")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Client" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <asp:DropDownList ID="ddClientName" runat="server" CssClass="form-control" selectedvalue='<%# Bind("ClientID")%>' 
                                                                DataSourceID="dsClientNames" DataTextField="FullName" DataValueField="ClientID"></asp:DropDownList>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblClientName" runat="server" Text='<%# BindItem.strClientName%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Physician" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <asp:DropDownList ID="ddApplicationUsers" CssClass="form-control" selectedvalue='<%# BindItem.PhysicianID%>' runat="server" DataSourceID="dsApplicationUsers" DataTextField="NameLabel" DataValueField="UserID"></asp:DropDownList>                                                            
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPhysician" runat="server" Text='<%# BindItem.strPhysicianName%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Reason" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <asp:DropDownList ID="ddReasons" CssClass="form-control" selectedvalue='<%# BindItem.Reason%>' runat="server" DataSourceID="dsReasons" DataTextField="ClinicReason" DataValueField="ID"></asp:DropDownList>                                                            
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblReason" runat="server" Text='<%# BindItem.strReason%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Lang" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <asp:DropDownList ID="ddLanguage" CssClass="form-control" selectedvalue='<%# BindItem.Language%>' runat="server" DataSourceID="dsLanguages" DataTextField="Language" DataValueField="ID"></asp:DropDownList>                                                            
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblLanguage" runat="server" Text='<%# BindItem.strLanguage%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Comments" SortExpression="Comments" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtComments" CssClass="form-control" runat="server" Text='<%# BindItem.Comments%>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblComments" runat="server" Text='<%# BindItem.Comments%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Complete?" SortExpression="Complete" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked="<%# BindItem.Complete %>" />
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox Enabled="false" Checked="<%#BindItem.Complete%>" ID="CheckBox2" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField HeaderText="Completed Date" SortExpression="CompletedDate" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <div class="input-group">
                                                                <asp:TextBox CssClass="form-control datepicker" ID="TextBox4" runat="server" Text='<%# Bind("CompletedDate", "{0:dd-MMM-yyyy}")%>'></asp:TextBox>
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("CompletedDate", "{0:dd-MMM-yyyy}")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Completed By" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center shrink">
                                                        <EditItemTemplate>
                                                            <asp:DropDownList ID="ddCompletedBy" CssClass="form-control" selectedvalue='<%# BindItem.CompletedByID%>' runat="server" DataSourceID="dsApplicationUsers" DataTextField="NameLabel" DataValueField="UserID" AppendDataBoundItems="true">
                                                                <asp:ListItem Text="Select..." Value=""></asp:ListItem>
                                                            </asp:DropDownList>                                                            
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCompletedBy" runat="server" Text='<%# BindItem.strCompletedByName%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:CommandField ShowEditButton="true" ItemStyle-CssClass="text-center" 
                                                        ButtonType="Link" 
                                                        CancelText="<span class='btn btn-default btn-table'><i class='fa fa-times'></i> Cancel</span>" 
                                                        UpdateText="<span class='btn btn-success btn-table'><i class='fa fa-check'></i> Update</span>" 
                                                        EditText="<span class='btn btn-primary btn-table'><i class='fa fa-pencil-square-o'></i> Edit</span>" />                                                    
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Add New Appointment Panel -->
                <div class="panel-group" id="accordion-addappointment" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default">                            
                        <div class="panel-heading">
                            <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-addappointment" href="#collapseAddAppointment" aria-expanded="true" aria-controls="collapseAddAppointment">Add New Appointment</a></h3>
                        </div>
                        <div id="collapseAddAppointment" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingAddAppointment">
                            <div class="panel-body">
                                <div class="form">
                                <div class="row">
                                    <div class="col-md-8 col-md-offset-2">
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="callout callout-danger" />
                                    </div>
                                </div>    
                                <asp:FormView ID="fvAddAppointment" runat="server" ItemType="TBTracing.clinic_TBClinicAppointments" DefaultMode="Insert" 
                                    InsertMethod="fvAddAppointment_InsertItem" RenderOuterTable="false">
                                    <InsertItemTemplate>
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <div class="form-group">
                                                <label for="tbDatePlaced">Time</label>
                                                <div class="input-group">
                                                    <asp:TextBox ID="txtAddTime" CssClass="form-control timepicker" runat="server" Text='<%# Bind("Time", "{0:hh\:mm}")%>'></asp:TextBox>
                                                    <div class="input-group-addon datepickericon"><i class="fa fa-clock-o"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="form-group">
                                                <label for="tbDatePlaced">Client</label>
                                                <asp:DropDownList ID="ddClient" runat="server" SelectedValue='<%# Bind("ClientID")%>'
                                                    DataSourceID="dsClientNames" DataTextField="FullName" DataValueField="ClientID" 
                                                    AppendDataBoundItems="true" CssClass="form-control">
                                                    <asp:ListItem Text="Please select..." Value="" />
                                                </asp:DropDownList>
<%--                                                <asp:DropDownList ID="ddClient" runat="server" SelectedValue="<%# BindItem.ClientID%>"
                                                    DataSourceID="dsClients" DataTextField="Firstname" DataValueField="ClientID" 
                                                    AppendDataBoundItems="true" CssClass="form-control">
                                                    <asp:ListItem Text="Please select..." Value="" />
                                                </asp:DropDownList>--%>

                                            </div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="form-group">        
                                                <label for="">Physician</label>                                               
                                                <asp:DropDownList ID="ddPhysician" runat="server" selectedValue="<%# BindItem.PhysicianID%>"
                                                    DataSourceID="dsApplicationUsers" DataTextField="NameLabel" DataValueField="UserID" 
                                                    AppendDataBoundItems="true" CssClass="form-control">
                                                    <asp:ListItem Text="Please Select" Value="" />
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="form-group">        
                                                <label for="">Reason</label>                                               
                                                <asp:DropDownList ID="ddReason" runat="server" selectedValue="<%# BindItem.Reason%>"
                                                    DataSourceID="dsReasons" DataTextField="ClinicReason" DataValueField="ID" 
                                                    AppendDataBoundItems="true" CssClass="form-control">
                                                    <asp:ListItem Text="Please Select" Value="" />
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <div class="form-group">        
                                                <label for="">Language</label>                                               
                                                <asp:DropDownList ID="ddLanguage" runat="server" selectedValue="<%# BindItem.Language%>"
                                                    DataSourceID="dsLanguages" DataTextField="Language" DataValueField="ID" 
                                                    AppendDataBoundItems="true" CssClass="form-control">
                                                    <asp:ListItem Text="Please Select" Value="" />
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-lg-9">
                                            <div class="form-group">
                                                <label for="tbDatePlaced">Comments</label>                                        
                                                <asp:TextBox ID="tbNotes" Text="<%# BindItem.Comments %>" runat="server" CssClass="form-control" placeholder="Notes here"></asp:TextBox>                                        
                                            </div>
                                        </div>
                                    </div>
                            
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="pull-right">
                                                <asp:LinkButton CommandName="Insert" ID="addNew" runat="server" CssClass="btn btn-success"><i class="fa fa-plus"></i> Add New Appointment</asp:LinkButton>
                                            </div>
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

        <div class="row">
            <div class="col-lg-12">
                <div class="pull-right">
                    <asp:LinkButton ID="lnkClinicHome" runat="server" CssClass="btn btn-default" PostBackUrl="~/AppPages/ClinicList.aspx"><i class="fa fa-hospital-o"></i> Back to Clinics</asp:LinkButton>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Dictionary DS -->
    <asp:EntityDataSource ID="dsClients" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="vwClients"  ></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsApplicationUsers" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_TBUser" ></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsReasons" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_ClinicReason"></asp:EntityDataSource>
    <asp:EntityDataSource ID="dsLanguages" runat="server" ConnectionString="name=TBTracingEntities" DefaultContainerName="TBTracingEntities" EnableFlattening="False" EntitySetName="common_Language"></asp:EntityDataSource>
    <asp:SqlDataSource ID="dsClientNames" runat="server" ConnectionString="<%$ ConnectionStrings:TBConnection %>" 
        SelectCommand="SELECT [ID], [ClientID], [FirstName], [LastName], ISNULL([FirstName],'') + ' ' + ISNULL([LastName],'') AS [FullName] FROM [vwClients] ORDER BY [FirstName], [LastName]">
    </asp:SqlDataSource>
</asp:Content>
