Public Class XRay
    Inherits System.Web.UI.Page

    Private intXRayID As Nullable(Of Integer)
    Private intClientID As Integer
    Private strXRayType As String

#Region "Page Load"
    Private Sub XRay_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        'Check for Test ID
        If Not IsNothing(Request.Params("testid")) AndAlso IsNumeric(Request.Params("testid")) Then
            intXRayID = Integer.Parse(Request.Params("testid"))
        End If

        'Check for Client ID
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error Retrieving Client X-Ray Test")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Check for X-Ray Type (i.e. Chest)
        If Not IsNothing(Request.Params("type")) Then
            strXRayType = Request.Params("type")
        Else
            strXRayType = ""
        End If

        If strXRayType.Equals("c") Then
            lblHeaderType.Text = "Chest"

        ElseIf strXRayType.Equals("nc") Then
            lblHeaderType.Text = "Non-Chest"
        Else

        End If

        'Determine which FormView Mode to use
        If IsNothing(intXRayID) Then
            XRayFormView.InsertItemTemplate = XRayFormView.EditItemTemplate
            XRayFormView.DefaultMode = FormViewMode.Insert
        Else
            XRayFormView.EditItemTemplate = XRayFormView.EditItemTemplate
            XRayFormView.DefaultMode = FormViewMode.Edit
        End If

    End Sub
#End Region

#Region "XRay CRUD"

    Public Sub XRayFormView_InsertItem()
        Dim item As New client_Xray
        TryUpdateModel(item)

        If ModelState.IsValid Then
            Try
                item.ClientID = intClientID
                Dim db As IClientDA = New ClientDAImpl()
                db.AddXray(item)
                Session.Add("SputumXraySuccess", "True")
                Response.Redirect("~/ClientPages/SputumXRayHistory?clientid=" & intClientID, False)
            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error adding XRay test", "XRay.aspx", dataEx)
                Session.Add("ErrorMessage", "Error Saving X-Ray Test")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error Adding XRay Test", "XRay.aspx", ex)
                Session.Add("ErrorMessage", "Error Saving X-Ray Test")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function XRayFormView_GetItem() As TBTracing.client_Xray
        Try
            Using db As New TBTracingEntities
                Dim xrayToUpdate As client_Xray = db.client_Xray.Find(intXRayID)
                Return xrayToUpdate
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting XRay for update.", "XRay Error", ex)
            Session.Add("ErrorMessage", "Error Retrieving X-Ray Data")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub XRayFormView_UpdateItem()
        Dim item As client_Xray = New client_Xray()
        TryUpdateModel(item)

        item.ClientID = intClientID
        item.ID = intXRayID

        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateXray(item, intXRayID)
                Session.Add("SputumXraySuccess", "True")
                Response.Redirect("~/ClientPages/SputumXRayHistory?clientid=" & intClientID, False)
            Catch dataEX As TBDataAccessException
                LogHelper.LogError("DB Error updating XRay.", "XRay.aspx", dataEX)
                Session.Add("ErrorMessage", "Error Updating X-Ray Test")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("General Error udpating XRay.", "XRay.aspx", ex)
                Session.Add("ErrorMessage", "Error Updating X-Ray Test")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "List View Binding"
    Protected Sub XRayFormView_DataBound(sender As Object, e As EventArgs) Handles XRayFormView.DataBound
        Dim addButton As LinkButton = XRayFormView.FindControl("addButton")
        Dim updateButton As LinkButton = XRayFormView.FindControl("updateButton")
        Dim cancelButton As HyperLink = XRayFormView.FindControl("lnkCancelButton")
        Dim areaDropdown As DropDownList = XRayFormView.FindControl("ddXrayArea")

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        'Change label from comments to findings for non-chest xray.  Hide results grid for non-chest xray
        Dim commentLabel As Label = CType(XRayFormView.FindControl("lblCommentsFindings"), Label)
        Dim gridPanel As Panel = CType(XRayFormView.FindControl("pnlFindingGrid"), Panel)
        If strXRayType.Equals("c") Then
            commentLabel.Text = "Comments"
            gridPanel.Visible = True
        ElseIf strXRayType.Equals("nc") Then
            commentLabel.Text = "Findings"
            gridPanel.Visible = False
        End If

        'If Chest X-Ray, set Area and disable
        If strXRayType.Equals("c") Then
            areaDropdown.Items.FindByText("Chest").Selected = True
            areaDropdown.Enabled = False
        Else
            areaDropdown.Enabled = True
        End If


        'Display the applicable button (i.e. add/update)
        If Not Page.IsPostBack Then
            If IsNothing(intXRayID) Then
                addButton.Visible = True
                updateButton.Visible = False
            Else
                addButton.Visible = False
                updateButton.Visible = True
            End If
        End If
    End Sub
#End Region

#Region "DropDown Binding"
    Protected Sub ddXrayView_DataBound(sender As Object, e As EventArgs)
        Dim viewDD As DropDownList = CType(XRayFormView.FindControl("ddXrayView"), DropDownList)
        If strXRayType.Equals("c") Or strXRayType.Equals("nc") Then
            viewDD.SelectedValue = DataConstants.XrayChestView
            viewDD.Enabled = False
        Else
            viewDD.Enabled = True
        End If
    End Sub

    Protected Sub ddXrayArea_DataBound(sender As Object, e As EventArgs)
        Dim areaDD As DropDownList = CType(XRayFormView.FindControl("ddXrayArea"), DropDownList)
        If strXRayType.Equals("nc") Then
            areaDD.Items.FindByValue(DataConstants.XrayAreaChest).Enabled = False
            areaDD.Items.FindByValue(DataConstants.XrayAreaChestPortable).Enabled = False
        End If
    End Sub


    Public Function fvXrayIndication_GetItem() As IEnumerable(Of common_XrayIndication)
        Try
            Dim db As TBTracingEntities = New TBTracingEntities()
            Dim indList As List(Of common_XrayIndication) = db.common_XrayIndication.Where(Function(p) p.Active = True).ToList()

            If Not IsNothing(intXRayID) AndAlso IsNumeric(intXRayID) Then
                If Not IsNothing(XRayFormView.DataItem) Then
                    Dim objClientXray As client_Xray = CType(XRayFormView.DataItem, client_Xray)
                    If Not IsNothing(objClientXray) Then
                        Dim legacyIndicationList As common_XrayIndication = indList.Where(Function(p) p.ID = objClientXray.IndicationID).FirstOrDefault()
                        If IsNothing(legacyIndicationList) Then
                            indList.Add(db.common_XrayIndication.Find(objClientXray.IndicationID))
                        End If
                    End If
                End If
            End If
            Return indList.AsQueryable()
        Catch ex As Exception
            LogHelper.LogError("Error getting xray indications", "XRay.aspx", ex)
            Session.Add("ErrorMessage", "Error With X-Ray Test")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function
#End Region

#Region "Reason Filtering Changing"
    Protected Sub dsReasons_Selecting(sender As Object, e As EntityDataSourceSelectingEventArgs)
        dsReasons.WhereParameters("xraytype") = New Parameter("xraytype", DbType.Int32, DataConstants.ReasonForTestXRay.ToString())
    End Sub

    Protected Sub ddReasonForTesting_TextChanged(sender As Object, e As EventArgs)
        Try
            Dim ddReason As DropDownList = CType(XRayFormView.FindControl("ddReasonForTesting"), DropDownList)
            Dim tbOther As TextBox = CType(XRayFormView.FindControl("tbOtherReason"), TextBox)

            If Not IsNothing(ddReason) AndAlso Not IsNothing(tbOther) Then
                Dim strOtherSXray As String = DataConstants.FollowupOtherXray.ToString
                If Not String.IsNullOrEmpty(ddReason.SelectedValue) AndAlso ddReason.SelectedValue = strOtherSXray Then
                    tbOther.Enabled = True
                Else
                    tbOther.Text = String.Empty
                    tbOther.Enabled = False
                End If
            End If
        Catch ex As Exception
            LogHelper.LogError("Error with reason for xray testing dropdown change", "Xray.aspx", ex)
            Session.Add("ErrorMessage", "Error With xray Test.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region


End Class