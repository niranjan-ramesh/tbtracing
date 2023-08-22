Public Class AddOutcome
    Inherits System.Web.UI.Page

    Private intOutcomeID As Nullable(Of Integer)
    Private intClientID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub AddOutcome_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        'If editing a skin test, we will be passed a testid
        If Not IsNothing(Request.Params("outcomeid")) AndAlso IsNumeric(Request.Params("outcomeid")) Then
            intOutcomeID = Integer.Parse(Request.Params("outcomeid"))
        End If

        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Hack to use single template on form view
        If IsNothing(intOutcomeID) Then
            fvTBOutcome.InsertItemTemplate = fvTBOutcome.EditItemTemplate
            fvTBOutcome.DefaultMode = FormViewMode.Insert
        Else
            fvTBOutcome.EditItemTemplate = fvTBOutcome.EditItemTemplate
            fvTBOutcome.DefaultMode = FormViewMode.Edit
        End If
    End Sub
#End Region

#Region "Outcome Radio button event"
    Protected Sub rbOutcome_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim activeTB As String = My.Settings.activeTBOutcome.ToString()

        Dim listActiveTB As List(Of String) = Split(My.Settings.activeTBOutcomearray, ",").ToList()

        Dim tranOutcome As String = My.Settings.transTBOutcome.ToString()

        Dim rblOutcome As RadioButtonList = CType(fvTBOutcome.FindControl("rbOutcome"), RadioButtonList)
        Dim tbTypePanel As Panel = CType(fvTBOutcome.FindControl("pnlActivePick"), Panel)
        Dim tbDestination As TextBox = CType(fvTBOutcome.FindControl("tbTransferredTo"), TextBox)

        If Not String.IsNullOrEmpty(rblOutcome.SelectedValue) AndAlso listActiveTB.Contains(rblOutcome.SelectedValue) Then
            tbTypePanel.Visible = True
        Else
            tbTypePanel.Visible = False

            If Not String.IsNullOrEmpty(rblOutcome.SelectedValue) AndAlso rblOutcome.SelectedValue.Equals(tranOutcome) Then
                tbDestination.Enabled = True
            Else
                tbDestination.Text = String.Empty
                tbDestination.Enabled = False
            End If
        End If
    End Sub

    Protected Sub rbOutcome_DataBound(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim rblOutcome As RadioButtonList = CType(fvTBOutcome.FindControl("rbOutcome"), RadioButtonList)
            Dim tbDestination As TextBox = CType(fvTBOutcome.FindControl("tbTransferredTo"), TextBox)
            Dim tranOutcome As String = My.Settings.transTBOutcome.ToString()

            If Not String.IsNullOrEmpty(rblOutcome.SelectedValue) AndAlso rblOutcome.SelectedValue.Equals(tranOutcome) Then
                tbDestination.Enabled = True
            End If
        End If

    End Sub


#End Region

#Region "Form View Bound Event"
    Protected Sub fvTBOutcome_DataBound(sender As Object, e As EventArgs)
        Dim addButton As LinkButton = fvTBOutcome.FindControl("addButton")
        Dim updateButton As LinkButton = fvTBOutcome.FindControl("updateButton")
        Dim cancelButton As HyperLink = fvTBOutcome.FindControl("lnkCancelButton")

        If IsNothing(intOutcomeID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If

        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If

        'Show/Hide Panel for TB Type
        Dim activeTB As String = My.Settings.activeTBOutcome.ToString()

        Dim rblOutcome As RadioButtonList = CType(fvTBOutcome.FindControl("rbOutcome"), RadioButtonList)
        Dim tbTypePanel As Panel = CType(fvTBOutcome.FindControl("pnlActivePick"), Panel)

        Dim activeOutcomes As List(Of String) = Split(My.Settings.activeTBOutcomearray, ",").ToList()

        If Not String.IsNullOrEmpty(rblOutcome.SelectedValue) AndAlso activeOutcomes.Contains(rblOutcome.SelectedValue) Then
            tbTypePanel.Visible = True
        Else
            tbTypePanel.Visible = False
        End If
    End Sub
#End Region

#Region "FormView CRUD"
    Public Sub fvTBOutcome_InsertItem()
        Dim item = New TBTracing.client_Outcome()
        TryUpdateModel(item)
        item.ClientID = intClientID
        validateInput()
        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                Dim returnMessage = db.AddOutcome(item)
                'Route back to history screen, with a success message.
                If Not String.IsNullOrEmpty(returnMessage) Then
                    Session.Add("OutcomeSuccess", returnMessage)
                Else
                    Session.Add("OutcomeSuccess", "True")
                End If

                Response.Redirect("~/ClientPages/OutcomeHistory.aspx?clientid=" & intClientID.ToString(), False)

            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error client outcome", "AddOutcome.aspx", dataEx)
                Session.Add("ErrorMessage", "Error adding outcome data.")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error Adding client outcome", "AddOutcome.aspx", ex)
                Session.Add("ErrorMessage", "Error adding outcome data.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try

        End If
    End Sub

    Public Function fvTBOutcome_GetItem() As TBTracing.client_Outcome
        Try
            Using db As New TBTracingEntities
                Dim outcomeToUpdate As client_Outcome = db.client_Outcome.Find(intOutcomeID)
                Return outcomeToUpdate
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting skin test for update.", "Skin Test Error", ex)
            Session.Add("ErrorMessage", "Error retrieving client skin test data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function


    Public Sub fvTBOutcome_UpdateItem()
        Dim item As TBTracing.client_Outcome = Nothing

        Using db As New TBTracingEntities
            item = db.client_Outcome.Find(intOutcomeID)
        End Using
       
        TryUpdateModel(item)
        item.ID = intOutcomeID
        item.ClientID = intClientID
        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                Dim returnString As String = db.UpdateOutcome(item)
                If Not String.IsNullOrEmpty(returnString) Then
                    Session.Add("OutcomeSuccess", returnString)
                Else
                    Session.Add("OutcomeSuccess", "True")
                End If

                Response.Redirect("~/ClientPages/OutcomeHistory.aspx?clientid=" & intClientID.ToString(), False)
            Catch dataEX As TBDataAccessException
                LogHelper.LogError("DB Error updating outcome.", "AddOutcome.aspx", dataEX)
                Session.Add("ErrorMessage", "Error updating outcome.")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("General Error udpating outcome.", "AddOutcome.aspx", ex)
                Session.Add("ErrorMessage", "Error updating outcome.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try

        End If
    End Sub

#End Region

#Region "Validation Routine"
    Private Sub validateInput()
        Dim activeTB As String = My.Settings.activeTBOutcome.ToString()

        Dim rblOutcome As RadioButtonList = CType(fvTBOutcome.FindControl("rbOutcome"), RadioButtonList)


        If Not String.IsNullOrEmpty(rblOutcome.SelectedValue) AndAlso rblOutcome.SelectedValue.Equals(activeTB) Then
            Dim ddType As DropDownList = CType(fvTBOutcome.FindControl("ddTBTypes"), DropDownList)

            If String.IsNullOrEmpty(ddType.SelectedValue) Then
                ModelState.AddModelError("No Type", "Active TB must have an associated type.")
            End If


        End If


    End Sub


#End Region


End Class