<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ClientTabControl.ascx.vb" Inherits="TBTracing.ClientTabControl" %>
<%@ Import Namespace="System.IO" %>
<ul class="nav nav-tabs">
    <%
    Dim strFilename As String = Path.GetFileName(Request.Path)
    
        For Each tabLink As KeyValuePair(Of String, String) In clientTabs
            If tabLink.Key.Equals(strFilename) Then
                Response.Write(clientTabsActive.Item(strFilename))
            Else
                Response.Write(tabLink.Value)
            End If
        Next
    %>
</ul>