<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ClientTabsControl.ascx.vb" Inherits="TBTracing.ClientTabsControl" %>

<ul class="nav nav-tabs" role="tablist">
    <li runat="server" id="demoLi" role="presentation"><asp:HyperLink NavigateUrl="~/ClientPages/ClientDemographic.aspx?clientid={0}" ID="lnkDemo" runat="server">Demographics</asp:HyperLink></li>
    <li runat="server" id="symptomsLi" role="presentation"><asp:HyperLink ID="lnkSymp" NavigateUrl="~/ClientPages/SymptomHistory.aspx?clientid={0}" runat="server">Symptoms</asp:HyperLink></li>
    <li runat="server" id="skinTestLI" role="presentation"> <asp:HyperLink ID="lnkSkinTest" NavigateUrl="~/ClientPages/SkinTestHistory.aspx?clientid={0}" runat="server">TST</asp:HyperLink></li>
    <li runat="server" id="sputmLI" role="presentation"><asp:HyperLink ID="lnkSputum" NavigateUrl="~/ClientPages/SputumXRayHistory.aspx?clientid={0}" runat="server">Sputum/Xray</asp:HyperLink></li>
    <li runat="server" id="investigationLI" role="presentation"><asp:HyperLink ID="lnkInvestigations" NavigateUrl="~/ClientPages/InvestigationHistory?clientid={0}" runat="server">Investigations</asp:HyperLink></li>
    <li runat="server" id="diagnosisLI" role="presentation"><asp:HyperLink ID="lnkDiagnosisTreatment" NavigateUrl="~/ClientPages/OutcomeHistory?clientid={0}" runat="server">Outcome/Diagnosis</asp:HyperLink></li>
    <li runat="server" id="treatmentLI" role="presentation"><asp:HyperLink ID="lnkTreatment" NavigateUrl="~/ClientPages/TreatmentHistory?clientid={0}" runat="server">Treatment</asp:HyperLink></li>
    <li runat="server" id="riskLI" role="presentation"><asp:HyperLink ID="lnkRiskFactors" NavigateUrl="~/ClientPages/RiskHistory?clientid={0}" runat="server">Risk Factors</asp:HyperLink></li>
    <li runat="server" id="communicationLI" role="presentation"><asp:HyperLink ID="lnkCommunication" NavigateUrl="~/ClientPages/CommunicationHistory.aspx?clientid={0}" runat="server">Communication</asp:HyperLink></li>
    <li runat="server" id="contactLI" role="presentation"><asp:HyperLink ID="lnkContactTrace" runat="server" NavigateUrl="~/ClientPages/ContactHistory.aspx?clientid={0}">Contact Tracing</asp:HyperLink></li>
    <li runat="server" id="docsLI" role="presentation"><asp:HyperLink ID="lnkDocsNotes" NavigateUrl="~/ClientPages/DocsNotes?clientid={0}" runat="server">Attachments</asp:HyperLink></li>
    <li runat="server" id="followupLI" role="presentation"><asp:HyperLink ID="lnkFollowUps" NavigateUrl="~/ClientPages/Followups.aspx?clientid={0}" runat="server">Follow-ups</asp:HyperLink></li>
    <%--<li runat="server" id="genoLI" role="presentation"><asp:HyperLink ID="lnkGeno" runat="server">Geno</asp:HyperLink></li>--%>
</ul>
