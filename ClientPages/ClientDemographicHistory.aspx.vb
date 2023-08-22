Public Class ClientDemographicHistory
    Inherits System.Web.UI.Page

    Private intClientID As Nullable(Of Integer)
    Private selectedEthnicities As List(Of Integer)

#Region "Page Load/Init"
    Private Sub ClientDemographic_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
            lnkHistory.NavigateUrl = String.Format(lnkHistory.NavigateUrl, intClientID.ToString())
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If
    End Sub
#End Region

#Region "Repeater Population"
    Public Function rptDemoDetails_GetData() As IEnumerable(Of TBTracing.client_Demographic)
        Dim db As New TBTracingEntities()

        Dim results = From demoQuery In db.client_Demographic.Include("common_Ethnicity").Include("common_Province").Include("client_Profile") _
                      Where demoQuery.ClientID = intClientID _
                      And demoQuery.Active = False _
                      Select demoQuery _
                      Order By demoQuery.ActiveTo Descending

        Return results

    End Function
#End Region

    Protected Sub rptDemoDetails_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        'Populate the ethnicities item
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim demoData As client_Demographic = CType(e.Item.DataItem, client_Demographic)

            Dim cblEthnicities As CheckBoxList = CType(e.Item.FindControl("cblEthnicity"), CheckBoxList)
            selectedEthnicities = demoData.common_Ethnicity.Select(Function(p) p.ID).ToList()

            For Each item As ListItem In cblEthnicities.Items
                Dim cbValue As Integer = Integer.Parse(item.Value)
                Dim matchFound As Boolean = False
                For Each selectedEthnicity In selectedEthnicities
                    If cbValue = selectedEthnicity Then
                        matchFound = True
                    End If
                Next
                If matchFound Then
                    item.Selected = True
                End If
            Next

            If Not IsNothing(demoData.DateofBirth) Then
                Dim tbAge As TextBox = CType(e.Item.FindControl("tbAge"), TextBox)
                tbAge.Text = New DataHelper().calculateAgeFromBirthday(demoData.DateofBirth)
            End If
        End If

    End Sub
End Class