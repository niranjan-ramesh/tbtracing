<%@ Page Title="DOT History" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="OutcomeTreatmentSchedule.aspx.vb" Inherits="TBTracing.OutcomeTreatmentSchedule" %>
<%@ Register TagPrefix="uc" TagName="ClientInfo" Src="~/ClientPages/ClientInfoControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ClientTabs" Src="~/ClientPages/ClientTabsControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<section class="content-header">
        <ol class="breadcrumb">
            <li><a href="~/Default" runat="server"><i class="fa fa-home"></i> Home</a></li>
            <li>Patient Record</li>
            <li class="active">DOT/DOP History</li>
        </ol>
    </section>

    <section class="content">
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-user"></i> DOT/DOP History</h1>
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
                <uc:ClientTabs ID="ClientTabsControl" runat="server" ActiveTab="treatment" />
                
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="treatment">

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

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><a data-toggle="collapse" data-parent="#accordion-identity" href="#collapseIdentity" aria-expanded="true" aria-controls="collapseIdentity">DOT History</a></h3>
                            </div>
                            <div id="collapseIdentity" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingIdentity">
                                <div class="panel-body">

                                    <div class="row">
                                        <div class="col-lg-12">
                                            <asp:GridView ID="gvDOTHistory" runat="server" DataSourceID="dsDOTHistory" EmptyDataText="No DOT/DOP Data" AllowSorting="true"
                                                DataKeyNames="treatmentID" AllowPaging="true" PageSize="25" ShowHeaderWhenEmpty="true" OnPreRender="gvDOTHistory_PreRender"
                                                CssClass="table table-striped table-bordered table-hover table-condensed" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:BoundField DataField="DOTDate" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="DOT/DOP Date" SortExpression="DOTDate" HeaderStyle-CssClass="text-center shrink" ItemStyle-CssClass="text-center shrink"></asp:BoundField>
                                                    <asp:BoundField DataField="symptomList" HeaderText="Symptoms (if any)" SortExpression="symptomList" HeaderStyle-CssClass="text-center" />
                                                    <asp:BoundField DataField="medicationList" HeaderText="Medications (if any)" SortExpression="medicationList" HeaderStyle-CssClass="text-center" />
                                                    <asp:BoundField DataField="clientNoShow" HeaderText="Show?" SortExpression="clientNoShow" HeaderStyle-CssClass="text-center" />
                                                    <asp:HyperLinkField datanavigateurlformatstring="~/ClientPages/OutcomeTreatmentAddDOT?clientid={0}&treatid={1}&outcomeid={2}&dotid={3}" Text="<i class='fa fa-eye'></i> View" DataNavigateUrlFields="ClientID,treatmentID,outcomeID,dotID" ControlStyle-CssClass="btn btn-info btn-table" />                                                                                                     
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="pull-right">
                                                <%--<asp:HyperLink CssClass="btn btn-default" ID="lnkBack" runat="server" NavigateUrl="~/ClientPages/OutcomeTreatment?clientid={0}&treatid={1}&outcomeid={2}"><i class='fa fa-arrow-left'></i>  Back to Treatment</asp:HyperLink>--%>
                                                <asp:HyperLink CssClass="btn btn-success" ID="lnkAddDOT" runat="server" NavigateUrl="~/ClientPages/OutcomeTreatmentAddDOT?clientid={0}&treatid={1}&outcomeid={2}"><i class='fa fa-plus'></i> Add DOT/DOP</asp:HyperLink>
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
    </section>
    <asp:SqlDataSource ID="dsDOTHistory" runat="server" ConnectionString='<%$ ConnectionStrings:TBConnection %>' 
        SelectCommand="select client_Outcome.ClientID, client_OutcomeTreatmentDOT.DOTDate, client_OutcomeTreatmentDOT.ID as dotID,
client_Outcome.ID as outcomeID, client_OutcomeTreatment.ID as treatmentID,
CASE WHEN client_OutcomeTreatmentDOT.ClientNoShow =1 Then 'No Show'  ELSE '' END As clientNoShow,
STUFF((SELECT ','+ commonSymptoms.Symptom
           FROM client_OutcomeTreatmentDOTSymptoms As clientSymptoms
           INNER JOIN common_Symptoms as commonSymptoms ON clientSymptoms.symptomID = commonSymptoms.ID
           WHERE client_OutcomeTreatmentDOT.ID = clientSymptoms.dotID
           FOR XML PATH(''), TYPE).value('.','VARCHAR(max)'), 1, 1, '') As symptomList,
 	STUFF((SELECT ','+ commonMeds.MedicationName
           FROM client_OutcomeMedications As clientMedications
           INNER JOIN common_Medication as commonMeds ON clientMedications.medID = commonMeds.ID
           WHERE client_OutcomeTreatmentDOT.ID = clientMedications.dotID
           FOR XML PATH(''), TYPE).value('.','VARCHAR(max)'), 1, 1, '') As medicationList           
FROM client_Outcome 
INNER JOIN client_OutcomeTreatment ON client_Outcome.TreatmentID = client_OutcomeTreatment.ID 
INNER JOIN client_OutcomeTreatmentDOT ON client_OutcomeTreatment.ID = client_OutcomeTreatmentDOT.TreatmentID
Where client_OutcomeTreatmentDOT.TreatmentID = @treatid and client_OutcomeTreatmentDOT.Active = 'true'
 Order By client_OutcomeTreatmentDOT.DOTDate desc">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="treatid" Name="treatid" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
