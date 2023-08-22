Imports System.Globalization

Public Class ClinicDAImpl
    Implements IClinicDA

    Public Sub AddClinic(ByRef objClinic As clinic_TBClinic) Implements IClinicDA.AddClinic
        Try
            Using db As New TBTracingEntities
                db.clinic_TBClinic.Add(objClinic)
                db.SaveChanges()
            End Using

            TBAudit.addAudit(TBAudit.AddEditClinic, "Adding new Clinic " & objClinic.ID, "Added Clinic", objClinic.ID)
        Catch ex As Exception
            LogHelper.LogError("Error adding new clinic.", "ClinicDAImpl", ex)
            Throw New TBDataAccessException("Error adding clinic", ex)
        End Try
    End Sub

    Public Sub UpdateClinic(ByRef objClinic As clinic_TBClinic) Implements IClinicDA.UpdateClinic
        Try
            Using db As New TBTracingEntities
                Dim originalClinic As clinic_TBClinic = db.clinic_TBClinic.Find(objClinic.ID)
                db.Entry(originalClinic).CurrentValues.SetValues(objClinic)

                'Get the changed values for audit purposes
                'Dim auditHelper As AuditHelper = New AuditHelper()
                'Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                'TBAudit.addAudit(TBAudit.AddEditClinic, "Editing Clinic ID: " & objClinic.ID, "Editing Audit Details: " & auditData, objClinic.ID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating clinic.", "ClinicDAImpl", ex)
            Throw New TBDataAccessException("Error updating clinic details.", ex)
        End Try
    End Sub

    Public Function GetClinicList() As List(Of ClinicListGridLineItem) Implements IClinicDA.GetClinicList
        Try
            Dim results As List(Of ClinicListGridLineItem) = Nothing
            Using db As New TBTracingEntities

                Dim objClinics = (From objList In db.clinic_TBClinic _ 
                                  Order By objList.ClinicDate Ascending).ToList()

                If Not IsNothing(objClinics) Then
                    Dim dataHelper As DataHelper = New DataHelper()

                    results = New List(Of ClinicListGridLineItem)
                    For Each objClinic In objClinics
                        Dim itemToAdd As ClinicListGridLineItem = New ClinicListGridLineItem()
                        itemToAdd.ClinicDate = objClinic.ClinicDate
                        itemToAdd.StartTime = objClinic.StartTime
                        itemToAdd.EndTime = objClinic.EndTime
                        itemToAdd.intNumberOfAppointments = objClinic.clinic_TBClinicAppointments.Count()
                        'itemToAdd.strClinicDate = New DataHelper().convertDateToStringText(objClinic.ClinicDate)
                        itemToAdd.PhysicianID = objClinic.PhysicianID
                        itemToAdd.strPhysicianName = objClinic.common_TBUser.NameLabel
                        itemToAdd.MaxAppointments = objClinic.MaxAppointments
                        itemToAdd.id = objClinic.ID
                        results.Add(itemToAdd)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting clinic list", "ClinicDAImpl", ex)
            Throw New TBDataAccessException("Error getting list of clinics.", ex)
        End Try
    End Function

    Public Function GetClinicDetails(clinicID As Integer) As ClinicListGridLineItem Implements IClinicDA.GetClinicDetails
        Try
            Dim result As clinic_TBClinic
            Dim objClinicDetails As ClinicListGridLineItem = New ClinicListGridLineItem()
            Using db As New TBTracingEntities
                result = (From objClinics In db.clinic_TBClinic
                                 Where objClinics.ID = clinicID).FirstOrDefault()
                If Not IsNothing(result) Then
                    objClinicDetails.ClinicDate = result.ClinicDate
                    objClinicDetails.StartTime = result.StartTime
                    objClinicDetails.EndTime = result.EndTime
                    objClinicDetails.intNumberOfAppointments = result.clinic_TBClinicAppointments.Count()
                    objClinicDetails.strClinicDate = New DataHelper().convertDateToStringText(result.ClinicDate)
                    objClinicDetails.PhysicianID = result.PhysicianID
                    objClinicDetails.strPhysicianName = result.common_TBUser.NameLabel
                    objClinicDetails.MaxAppointments = result.MaxAppointments
                    objClinicDetails.ID = result.ID
                End If
            End Using
            Return objClinicDetails
        Catch ex As Exception
            LogHelper.LogError("Error getting clinic details", "ClinicDAImpl", ex)
            Throw New TBDataAccessException("Error getting clinic details.", ex)
        End Try
    End Function

    Public Function GetClinicAppointments(clinicID As Integer) As List(Of ClinicAppointmentGridLineItem) Implements IClinicDA.GetClinicAppointments
        Try
            Dim results As List(Of ClinicAppointmentGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim qryResults = (From objAppointments In db.clinic_TBClinicAppointments _
                                  Where objAppointments.ClinicID = clinicID).ToList()

                If Not IsNothing(qryResults) AndAlso qryResults.Count > 0 Then
                    results = New List(Of ClinicAppointmentGridLineItem)

                    For Each objAppointment In qryResults
                        Dim gridItem As ClinicAppointmentGridLineItem = New ClinicAppointmentGridLineItem()

                        gridItem.ID = objAppointment.ID
                        gridItem.ClientID = objAppointment.ClientID
                        gridItem.strClientName = objAppointment.client_Profile.FirstName & " " & objAppointment.client_Profile.LastName
                        gridItem.PhysicianID = objAppointment.PhysicianID
                        If gridItem.PhysicianID.HasValue Then gridItem.strPhysicianName = objAppointment.common_TBUser.NameLabel Else gridItem.strPhysicianName = ""
                        gridItem.Reason = objAppointment.Reason
                        If gridItem.Reason.HasValue Then gridItem.strReason = objAppointment.common_ClinicReason.ClinicReason Else gridItem.strReason = ""
                        gridItem.Language = objAppointment.Language
                        If gridItem.Language.HasValue Then gridItem.strLanguage = objAppointment.common_Language.Language Else gridItem.strLanguage = ""
                        gridItem.Time = objAppointment.Time
                        gridItem.Complete = objAppointment.Complete
                        gridItem.CompletedDate = objAppointment.CompletedDate
                        gridItem.CompletedByID = objAppointment.CompletedByID
                        If gridItem.CompletedByID.HasValue Then gridItem.strCompletedByName = objAppointment.common_TBUser1.NameLabel Else gridItem.strCompletedByName = ""

                        gridItem.Comments = objAppointment.Comments
                        results.Add(gridItem)
                    Next
                End If
                Return results
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting clinic appointments.", "ClinicDAImpl", ex)
            Throw New TBDataAccessException("Error getting appointments for clinic.", ex)
        End Try
    End Function

    Public Sub UpdateClinicAppointment(ByRef objAppointment As clinic_TBClinicAppointments) Implements IClinicDA.UpdateClinicAppointment
        Try
            Using db As New TBTracingEntities
                Dim originalAppointment As clinic_TBClinicAppointments = db.clinic_TBClinicAppointments.Find(objAppointment.ID)
                db.Entry(originalAppointment).CurrentValues.SetValues(objAppointment)

                'Get the changed values for audit purposes.
                'Dim auditHelper As AuditHelper = New AuditHelper()
                'Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                'TBAudit.addAudit(TBAudit.AddEditClinic, "Editing Clinic Appointment ID:" & objAppointment.ID, "Editing Audit Details: " & auditData, objAppointment.ClinicID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating clinic appointment.", "ClinicDAImpl", ex)
            Throw New TBDataAccessException("Error updating appointment for clinic.", ex)
        End Try
    End Sub

    Public Sub AddClinicAppointment(ByRef objAppointment As clinic_TBClinicAppointments) Implements IClinicDA.AddClinicAppointment
        Try
            Using db As New TBTracingEntities
                db.clinic_TBClinicAppointments.Add(objAppointment)
                db.SaveChanges()
            End Using
            TBAudit.addAudit(TBAudit.AddEditFollowup, "Adding followup for Clinic ID:" & objAppointment.ClinicID, "Added followup for Appointment ID: " & objAppointment.ID, objAppointment.ClinicID)
        Catch ex As Exception
            LogHelper.LogError("Error adding clinic appointment.", "ClinicDAImpl", ex)
            Throw New TBDataAccessException("Error adding clinic appointment.", ex)
        End Try
    End Sub
End Class
