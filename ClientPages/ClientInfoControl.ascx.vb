Public Class ClientInfoControl
    Inherits System.Web.UI.UserControl

    Private intClientID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim objClientInfo As client_Profile = Nothing
        pnlClientInformation.Visible = False

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            PopulateClientInformation()
            pnlClientInformation.Visible = True
        End If
    End Sub

    Private Sub PopulateClientInformation()
        Try
            Dim db As IClientDA = New ClientDAImpl()
            Dim objClientInfo As client_InformationModel
            objClientInfo = db.GetClientInformation(intClientID)

            litClientName.Text = objClientInfo.demoData.FirstName & " " & objClientInfo.demoData.LastName
            If Not IsNothing(objClientInfo.demoData.DateofBirth) Then litClientDOB.Text = New DataHelper().convertDateToStringText(objClientInfo.demoData.DateofBirth)
            litClientHCN.Text = objClientInfo.demoData.HealthCareNumber
            If Not IsNothing(objClientInfo.profileData.LastUpdate) Then litLastUpdate.Text = New DataHelper().convertDateToStringText(objClientInfo.profileData.LastUpdate)
            litClientStatus.Text = objClientInfo.status
        Catch ex As Exception
            LogHelper.LogError("Error Retrieving Client Information", "ClientInfoControl.ascx", ex)
            Session.Add("ErrorMessage", "Error Retrieving Client Information")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub

    Public Property TBClientID() As Integer
        Get
            Return intClientID
        End Get
        Set(value As Integer)
            intClientID = value
        End Set
    End Property
End Class