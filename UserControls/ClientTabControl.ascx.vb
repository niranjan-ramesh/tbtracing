Public Class ClientTabControl
    Inherits System.Web.UI.UserControl

    Property clientTabs As Dictionary(Of String, String)
    Property clientTabsActive As Dictionary(Of String, String)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim intSiteID As Integer = Integer.Parse(Request.Params("siteid"))

        clientTabs = New Dictionary(Of String, String)
        clientTabs.Add("SiteDepotInventory.aspx", "<li><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/SiteDepotInventory.aspx?siteid=" & intSiteID) & """>Inventory</a></li>")
        clientTabs.Add("SiteDepotShipReceive.aspx", "<li><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/SiteDepotShipReceive.aspx?siteid=" & intSiteID) & """>Shipping & Receiving</a></li>")
        clientTabs.Add("SiteDepotOrders.aspx", "<li><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/SiteDepotOrders.aspx?siteid=" & intSiteID) & """>My Orders</a></li>")
        clientTabs.Add("DocumentsInventory.aspx", "<li><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/DocumentsInventory.aspx?siteid=" & intSiteID) & """>Documents</a></li>")
        clientTabs.Add("SiteDepotVaccineHistory.aspx", "<li><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/SiteDepotVaccineHistory.aspx?siteid=" & intSiteID) & """>History</a></li>")


        clientTabsActive = New Dictionary(Of String, String)
        clientTabsActive.Add("SiteDepotInventory.aspx", "<li class=""active""><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/SiteDepotInventory.aspx?siteid=" & intSiteID) & """>Inventory</a></li>")
        clientTabsActive.Add("SiteDepotShipReceive.aspx", "<li class=""active""><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/SiteDepotShipReceive.aspx?siteid=" & intSiteID) & """>Shipping & Receiving</a></li>")
        clientTabsActive.Add("SiteDepotOrders.aspx", "<li class=""active""><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/SiteDepotOrders.aspx?siteid=" & intSiteID) & """>My Orders</a></li>")
        clientTabsActive.Add("DocumentsInventory.aspx", "<li class=""active""><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/DocumentsInventory.aspx?siteid=" & intSiteID) & """>Documents</a></li>")
        clientTabsActive.Add("SiteDepotVaccineHistory.aspx", "<li class=""active""><a href=""" & Page.ResolveClientUrl("~/Pages/Inventory/SiteDepotVaccineHistory.aspx?siteid=" & intSiteID) & """>History</a></li>")
    End Sub

End Class