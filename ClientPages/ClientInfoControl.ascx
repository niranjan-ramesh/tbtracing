<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ClientInfoControl.ascx.vb" Inherits="TBTracing.ClientInfoControl" %>

<asp:Panel ID="pnlClientInformation" runat="server">    
<div class="client-info-box bg-lggreen">
    <span class="client-info-box-icon"><i class="fa fa-user"></i></span>
    <div class="client-info-box-content">
        <span class="client-name"><asp:Literal ID="litClientName" runat="server" /></span>
        <div class="progress">
            <div class="progress-bar" style="width:0"></div>
        </div>
        <div class="client-description">
            <div class="row">
                <div class="col-lg-6 left-info">
                    <strong>Status:</strong> <asp:Literal ID="litClientStatus" runat="server" Text="" />&nbsp;<br />
                    <strong>HCN:</strong> <asp:Literal ID="litClientHCN" runat="server" Text="" />
                </div>
                <div class="col-lg-6 right-info">
                    <strong>DOB:</strong> <asp:Literal ID="litClientDOB" runat="server" Text="" /><br />
                    <strong>Last Update:</strong> <asp:Literal ID="litLastUpdate" runat="server" Text="" />
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Panel>
