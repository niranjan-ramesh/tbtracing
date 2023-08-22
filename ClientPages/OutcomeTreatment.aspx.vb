Public Class OutcomeTreatment
    Inherits System.Web.UI.Page

    Private intOutcomeID As Nullable(Of Integer)
    Private intClientID As Integer
    Private intTreatmentID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsNothing(Request.Params("outcomeid")) AndAlso IsNumeric(Request.Params("outcomeid")) Then
            intOutcomeID = Integer.Parse(Request.Params("outcomeid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Request.Params("treatid")) AndAlso IsNumeric(Request.Params("treatid")) Then
            intTreatmentID = Integer.Parse(Request.Params("treatid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If


        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))

        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

    End Sub
#End Region

#Region "Add Treatment Regimen"
    Public Sub fvAddMedicatin_InsertItem()
        Dim item = New TBTracing.client_OutcomeTreatmentRegimen()
        item.OutcomeID = intOutcomeID
        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.AddTreatmentRegimen(item)
                gvTreatments.DataBind()
            Catch ex As Exception
                LogHelper.LogError("Error adding treatment regimen.", "OutcomeTreatment.aspx", ex)
                Session.Add("ErrorMessage", "Error adding treatment regimen.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
            'Else
            '    'addNewDrug.Attributes.Remove("class")
            '    ' addNewDrug.Attributes.Add("class", "in")
        End If
    End Sub
#End Region

#Region "Existing Regimen Details"
    Public Function gvFollowUps_GetData() As IQueryable(Of TBTracing.OutcomeTreatmentGridLineItem)
        Dim db As TBTracingEntities = New TBTracingEntities()
        Dim results As List(Of OutcomeTreatmentGridLineItem) = Nothing
        Dim queryResults = db.client_OutcomeTreatmentRegimen.Include("common_Medication").Include("common_MedicationStatus").Include("common_MedicationFrequency").Where(Function(p) p.OutcomeID = intOutcomeID).ToList()

        If Not IsNothing(queryResults) Then
            results = New List(Of OutcomeTreatmentGridLineItem)
            For Each queryResult In queryResults
                Dim result As OutcomeTreatmentGridLineItem = New OutcomeTreatmentGridLineItem(queryResult)
                result.strStatus = queryResult.common_MedicationStatus.MedicationStatus
                result.strMedicationName = queryResult.common_Medication.MedicationName
                If Not IsNothing(queryResult.common_MedicationFrequency) Then
                    result.strFrequency = queryResult.common_MedicationFrequency.Frequency
                Else
                    result.strFrequency = ""
                End If



                results.Add(result)
            Next
        End If

        Return results.AsQueryable()
    End Function
#End Region

#Region "Medication Updates - GRID"
    Public Sub gvTreatments_UpdateItem(ByVal id As Integer)
        Dim item As OutcomeTreatmentGridLineItem = New OutcomeTreatmentGridLineItem()
        item.OutcomeID = intOutcomeID

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                Dim treatmentRegiment As client_OutcomeTreatmentRegimen = item
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateTreatmentRegimen(treatmentRegiment)
            Catch ex As Exception
                LogHelper.LogError("Error updating treatment regimen.", "OutcomeTreatment.aspx", ex)
                Session.Add("ErrorMessage", "Error updating treatment regimen.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Protected Sub gvTreatments_PreRender(sender As Object, e As EventArgs) Handles gvTreatments.PreRender
        If Not IsNothing(gvTreatments) AndAlso Not IsNothing(gvTreatments.HeaderRow) Then gvTreatments.HeaderRow.TableSection = TableRowSection.TableHeader
    End Sub
#End Region

#Region "General Treatment Formview CRUD"
    Public Function fvTreatmentOutcomeDetails_GetItem() As TBTracing.client_OutcomeTreatment
        Dim db As TBTracingEntities = New TBTracingEntities()
        Return db.client_OutcomeTreatment.Find(intTreatmentID)
    End Function

    Public Sub fvTreatmentOutcomeDetails_UpdateItem(ByVal id As Integer)
        Dim item As client_OutcomeTreatment = New client_OutcomeTreatment()
        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateTreatment(item)
                Session.Add("OutcomeSuccess", "True")
                Response.Redirect("~/ClientPages/TreatmentHistory.aspx?clientid=" & intClientID.ToString(), False)
            Catch dataEX As TBDataAccessException
                LogHelper.LogError("DB Error updating skin test.", "SkinTest.aspx", dataEX)
                Session.Add("ErrorMessage", "Error updating skin test data.")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("General Error udpating skin test.", "SkinTest.aspx", ex)
                Session.Add("ErrorMessage", "Error updating skin test data.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try

        End If
    End Sub
#End Region

    Protected Sub fvTreatmentOutcomeDetails_DataBound(sender As Object, e As EventArgs)
        Dim btnCancel As HyperLink = CType(fvTreatmentOutcomeDetails.FindControl("lnkCancelButton"), HyperLink)
        btnCancel.NavigateUrl = String.Format(btnCancel.NavigateUrl, intClientID.ToString())
        'Dim lnkDOT As HyperLink = CType(fvAddMedicatin.FindControl("lnkDOT"), HyperLink)
        'lnkDOT.NavigateUrl = String.Format(lnkDOT.NavigateUrl, intClientID.ToString(), intTreatmentID.ToString(), intOutcomeID.ToString())
    End Sub
End Class