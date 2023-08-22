Public Class Sputum
    Inherits System.Web.UI.Page

    Private intSputumID As Nullable(Of Integer)
    Private intClientID As Integer
    Private selectedAntibiotics As List(Of Integer)

#Region "Page Load"
    Private Sub Sputum_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        'Check for Test ID
        If Not IsNothing(Request.Params("testid")) AndAlso IsNumeric(Request.Params("testid")) Then
            intSputumID = Integer.Parse(Request.Params("testid"))
        End If

        'Check for Client ID
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Determine which FormView Mode to use
        If IsNothing(intSputumID) Then
            SputumFormView.InsertItemTemplate = SputumFormView.EditItemTemplate
            SputumFormView.DefaultMode = FormViewMode.Insert
        Else
            SputumFormView.EditItemTemplate = SputumFormView.EditItemTemplate
            SputumFormView.DefaultMode = FormViewMode.Edit
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim addButton As LinkButton = SputumFormView.FindControl("addButton")
        'Dim updateButton As LinkButton = SputumFormView.FindControl("updateButton")
        'Dim cancelButton As HyperLink = SputumFormView.FindControl("lnkCancelButton")

        'If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
        '    cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        'End If

        ''Display the applicable button (i.e. add/update)
        'If IsNothing(intSputumID) Then
        '    addButton.Visible = True
        '    updateButton.Visible = False
        'Else
        '    addButton.Visible = False
        '    updateButton.Visible = True
        'End If
    End Sub
#End Region

#Region "Sputum CRUD"
    Public Sub SputumFormView_InsertItem()
        Dim item As New client_Sputum()
        Dim itemModel As client_SputumModel = New client_SputumModel()
        TryUpdateModel(itemModel)

        If ModelState.IsValid Then
            Try
                itemModel.sputumData.ClientID = intClientID
                Dim antibiotics As CheckBoxList = SputumFormView.FindControl("cblAntibioticResistance")
                itemModel.selectedCBAntibiotic = New DataHelper().getSelectedCheckBoxesAsInteger(antibiotics)

                Dim db As IClientDA = New ClientDAImpl()
                db.AddSputum(itemModel)
                Session.Add("SputumXraySuccess", "True")
                Response.Redirect("~/ClientPages/SputumXRayHistory?clientid=" & intClientID, False)
            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error adding Sputum test", "Sputum.aspx", dataEx)
                Session.Add("ErrorMessage", "Error Adding Sputum Test.")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error Adding Sputum Test", "Sputum.aspx", ex)
                Session.Add("ErrorMessage", "Error Adding Sputum Test.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function SputumFormView_GetItem() As TBTracing.client_SputumModel
        Dim pageModel As client_SputumModel = New client_SputumModel()

        Try
            Using db As New TBTracingEntities
                pageModel.sputumData = db.client_Sputum.Find(intSputumID)

                If Not IsNothing(pageModel.sputumData) Then
                    selectedAntibiotics = pageModel.sputumData.common_Antibiotic.Select(Function(p) p.ID).ToList()
                    pageModel.selectedCBAntibiotic = selectedAntibiotics
                End If
            End Using

            Return pageModel
        Catch ex As Exception
            LogHelper.LogError("Error getting sputum data", "Sputum.aspx", ex)
            Session.Add("ErrorMessage", "Error Retrieving Sputum Data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub SputumFormView_UpdateItem()
        Dim item As New client_Sputum()
        Dim itemModel As client_SputumModel = New client_SputumModel()
        TryUpdateModel(itemModel)

        If ModelState.IsValid Then
            itemModel.sputumData.ClientID = intClientID
            itemModel.sputumData.ID = intSputumID
            Dim antibiotics As CheckBoxList = SputumFormView.FindControl("cblAntibioticResistance")
            itemModel.selectedCBAntibiotic = New DataHelper().getSelectedCheckBoxesAsInteger(antibiotics)

            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateSputum(itemModel, intSputumID)
                Session.Add("SputumXraySuccess", "True")
                Response.Redirect("~/ClientPages/SputumXRayHistory?clientid=" & intClientID, False)
            Catch dataEX As TBDataAccessException
                LogHelper.LogError("DB Error updating Sputum.", "Sputum.aspx", dataEX)
                Session.Add("ErrorMessage", "Error Updating Sputum Test.")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("General Error udpating Sputum.", "Sputum.aspx", ex)
                Session.Add("ErrorMessage", "Error Updating Sputum Test.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "CheckBox List Binding"
    Protected Sub cblAntibioticResistance_DataBound(sender As Object, e As EventArgs)
        If Not IsNothing(selectedAntibiotics) Then
            Dim cblAntibiotics As CheckBoxList = SputumFormView.FindControl("cblAntibioticResistance")

            For Each item As ListItem In cblAntibiotics.Items
                Dim cbValue As Integer = Integer.Parse(item.Value)
                Dim matchFound As Boolean = False
                For Each selectedAntibiotic In selectedAntibiotics
                    If cbValue = selectedAntibiotic Then
                        matchFound = True
                    End If
                Next
                If matchFound Then
                    item.Selected = True
                End If
            Next
        End If
    End Sub
#End Region

#Region "Form View DataBind"
    Protected Sub SputumFormView_DataBound(sender As Object, e As EventArgs) Handles SputumFormView.DataBound
        Dim addButton As LinkButton = SputumFormView.FindControl("addButton")
        Dim updateButton As LinkButton = SputumFormView.FindControl("updateButton")
        Dim cancelButton As HyperLink = SputumFormView.FindControl("lnkCancelButton")

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        'Display the applicable button (i.e. add/update)
        If IsNothing(intSputumID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If
    End Sub
#End Region

#Region "Reason Filtering / Changing"
    Protected Sub dsReasons_Selecting(sender As Object, e As EntityDataSourceSelectingEventArgs)
        dsReasons.WhereParameters("sputumtype") = New Parameter("sputumtype", DbType.Int32, DataConstants.ReasonForTestSputum.ToString())
    End Sub

    Protected Sub ddReasonForTesting_TextChanged(sender As Object, e As EventArgs)
        Try
            Dim ddReason As DropDownList = CType(SputumFormView.FindControl("ddReasonForTesting"), DropDownList)
            Dim tbOther As TextBox = CType(SputumFormView.FindControl("tbOtherTestReason"), TextBox)

            If Not IsNothing(ddReason) AndAlso Not IsNothing(tbOther) Then
                Dim strOtherSputum As String = DataConstants.FollowupOtherSputum.ToString
                If Not String.IsNullOrEmpty(ddReason.SelectedValue) AndAlso ddReason.SelectedValue = strOtherSputum Then
                    tbOther.Enabled = True
                Else
                    tbOther.Text = String.Empty
                    tbOther.Enabled = False
                End If
            End If
        Catch ex As Exception
            LogHelper.LogError("Error with reason for sputum testing dropdown change", "Sputum.aspx", ex)
            Session.Add("ErrorMessage", "Error With Sputum Test.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub

#End Region


End Class