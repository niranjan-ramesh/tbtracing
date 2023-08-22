Public Class OutcomeTreatmentAddDOT
    Inherits System.Web.UI.Page

    Private intDotID As Nullable(Of Integer)
    Private intClientID As Integer
    Private intOutcomeID As Integer
    Private intTreatID As Integer
    Private dotModel As client_DotModel = Nothing

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If editing a skin test, we will be passed a testid
        If Not IsNothing(Request.Params("dotid")) AndAlso IsNumeric(Request.Params("dotid")) Then
            intDotID = Integer.Parse(Request.Params("dotid"))
        End If

        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'DOT tied to treatment.  Must be passed.
        'Client ID is always passed.
        If Not IsNothing(Request.Params("outcomeid")) AndAlso IsNumeric(Request.Params("outcomeid")) Then
            intOutcomeID = Integer.Parse(Request.Params("outcomeid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Request.Params("treatid")) AndAlso IsNumeric(Request.Params("treatid")) Then
            intTreatID = Integer.Parse(Request.Params("treatid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Hack to use single template on form view
        If IsNothing(intDotID) Then
            fvDOT.InsertItemTemplate = fvDOT.EditItemTemplate
            fvDOT.DefaultMode = FormViewMode.Insert
        Else
            fvDOT.EditItemTemplate = fvDOT.EditItemTemplate
            fvDOT.DefaultMode = FormViewMode.Edit
        End If
    End Sub
#End Region

#Region "FV Databound - Populate Items"
    Protected Sub fvDOT_DataBound(sender As Object, e As EventArgs)
        Try
            Dim rblMedications As CheckBoxList = CType(fvDOT.FindControl("rblMedications"), CheckBoxList)

            Using db As TBTracingEntities = New TBTracingEntities()
                Dim activeMedStatus As Integer = My.Settings.ActiveTreatmentStatus
                'Dim listMedications As List(Of common_Medication) = db.common_Medication.ToList()

                Dim listMedications As List(Of common_Medication) = (From objDOT In db.client_OutcomeTreatmentRegimen _
                                                                   Where objDOT.OutcomeID = intOutcomeID _
                                                                   And objDOT.StatusID = activeMedStatus _
                                                                   Select objDOT.common_Medication).ToList()

                For Each medication In listMedications
                    Dim medItem As ListItem = New ListItem(medication.MedicationName, medication.ID)
                    rblMedications.Items.Add(medItem)
                Next

                If fvDOT.CurrentMode = FormViewMode.Edit AndAlso Not IsNothing(dotModel) AndAlso Not IsNothing(dotModel.selectedMedications) Then
                    Dim cblMedications As CheckBoxList = fvDOT.FindControl("rblMedications")

                    For Each item As ListItem In cblMedications.Items
                        Dim cbValue As Integer = Integer.Parse(item.Value)
                        Dim matchFound As Boolean = False
                        For Each selectedMedication In dotModel.selectedMedications
                            If cbValue = selectedMedication Then
                                matchFound = True
                                Exit For
                            End If
                        Next
                        If matchFound Then
                            item.Selected = True
                        End If
                    Next
                End If
            End Using

            'Show/Hide the appropri
            Dim cancelButton As HyperLink = fvDOT.FindControl("lnkCancelButton")
            Dim addButton As LinkButton = fvDOT.FindControl("addButton")
            Dim updateButton As LinkButton = fvDOT.FindControl("updateButton")

            If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
                cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString(), intTreatID.ToString(), intOutcomeID.ToString())
            End If
            If IsNothing(intDotID) Then
                addButton.Visible = True
                updateButton.Visible = False
            Else
                addButton.Visible = False
                updateButton.Visible = True
            End If


        Catch ex As Exception

        End Try
    End Sub
#End Region

#Region "CRUD DOT"

    Public Sub fvDOT_InsertItem()
        Dim item = New TBTracing.client_DotModel()
        TryUpdateModel(item)
        'Now manually bind the many-to-many relationships
        item.dotItem.TreatmentID = intTreatID
        item.dotItem.Active = True

        'Manually bind symptoms and medications
        Dim medications As CheckBoxList = CType(fvDOT.FindControl("rblMedications"), CheckBoxList)
        item.selectedMedications = New DataHelper().getSelectedCheckBoxesAsInteger(medications)

        Dim symptoms As CheckBoxList = CType(fvDOT.FindControl("rblSymptoms"), CheckBoxList)
        item.selectedSymptoms = New DataHelper().getSelectedCheckBoxesAsInteger(symptoms)

        'Run validations
        validateForm(item)
        If ModelState.IsValid Then
            Try            
                Dim db As IClientDA = New ClientDAImpl()
                db.AddDOT(item)

                Session.Add("AddDOTSuccess", "True")
                Response.Redirect(String.Format("~/ClientPages/OutcomeTreatmentSchedule?clientid={0}&treatid={1}&outcomeid={2}", intClientID.ToString(), intTreatID.ToString(), intOutcomeID.ToString()), False)
            Catch ex As Exception
                LogHelper.LogError("Error adding DOT treatment.", "OutcomeTreatmentAddDOT.aspx", ex)
                Session.Add("ErrorMessage", "Error adding DOT treatment.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function fvDOT_GetItem() As TBTracing.client_DotModel
        Try
            If Not IsNothing(intDotID) Then
                Dim db As IClientDA = New ClientDAImpl()
                dotModel = db.GetDotById(intDotID)
            End If
            Return dotModel
        Catch ex As Exception
            LogHelper.LogError("Error getting dot for update.", "OutcomeTreatmentAddDOT.aspx", ex)
            Session.Add("ErrorMessage", "Error getting DOT treatment data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function


    Public Sub fvDOT_UpdateItem()
        Dim item = New TBTracing.client_DotModel()
        TryUpdateModel(item)
        'Now manually bind the many-to-many relationships
        item.dotItem.TreatmentID = intTreatID
        item.dotItem.ID = intDotID
        item.dotItem.Active = True

        'Manually bind symptoms and medications
        Dim medications As CheckBoxList = CType(fvDOT.FindControl("rblMedications"), CheckBoxList)
        item.selectedMedications = New DataHelper().getSelectedCheckBoxesAsInteger(medications)

        Dim symptoms As CheckBoxList = CType(fvDOT.FindControl("rblSymptoms"), CheckBoxList)
        item.selectedSymptoms = New DataHelper().getSelectedCheckBoxesAsInteger(symptoms)

        'Run validations
        validateForm(item)
        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateDOT(item, intClientID)

                Session.Add("AddDOTSuccess", "True")
                Response.Redirect(String.Format("~/ClientPages/OutcomeTreatmentSchedule?clientid={0}&treatid={1}&outcomeid={2}", intClientID.ToString(), intTreatID.ToString(), intOutcomeID.ToString()), False)
            Catch ex As Exception
                LogHelper.LogError("Error adding DOT treatment.", "OutcomeTreatmentAddDOT.aspx", ex)
                Session.Add("ErrorMessage", "Error adding DOT treatment.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "Validation Routine"
    Private Sub validateForm(ByRef postedData As client_DotModel)
        Try
            If postedData.dotItem.ClientNoShow Then
                If ((Not IsNothing(postedData.selectedMedications) AndAlso postedData.selectedMedications.Count > 0) _
                    Or (Not IsNothing(postedData.selectedSymptoms) AndAlso postedData.selectedSymptoms.Count > 0)) Then
                    ModelState.AddModelError("Symptoms", "You can not select symptoms or medications if client did not show.")
                End If

                'If Not IsNothing(postedData.selectedSymptoms) AndAlso postedData.selectedSymptoms.Count > 0 Then
                '    ModelState.AddModelError("Medications", "You can not select medications if client did not show.")
                'End If
            End If
        Catch ex As Exception
            LogHelper.LogError("Error with validation routine.", "OutcomeTreatmentAddDOT.aspx", ex)
            Session.Add("ErrorMessage", "Error adding DOT treatment.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

#Region "Manual databind for many-to-may symptoms and medications"
    Protected Sub rblSymptoms_DataBound(sender As Object, e As EventArgs)
        Try
            If Not IsNothing(dotModel) AndAlso Not IsNothing(dotModel.selectedSymptoms) Then
                Dim cblSymptoms As CheckBoxList = fvDOT.FindControl("rblSymptoms")

                For Each item As ListItem In cblSymptoms.Items
                    Dim cbValue As Integer = Integer.Parse(item.Value)
                    Dim matchFound As Boolean = False
                    For Each selectedSymptom In dotModel.selectedSymptoms
                        If cbValue = selectedSymptom Then
                            matchFound = True
                            Exit For
                        End If
                    Next
                    If matchFound Then
                        item.Selected = True
                    End If
                Next
            End If
        Catch ex As Exception
            LogHelper.LogError("Error with symptoms binding.", "OutcomeTreatmentAddDOT.aspx", ex)
            Session.Add("ErrorMessage", "Error updating DOT treatment.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region
    
End Class