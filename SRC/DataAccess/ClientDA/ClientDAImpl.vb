Imports System.Globalization
Imports System.Data.Entity.Validation

Public Class ClientDAImpl
    Implements IClientDA

#Region "Demographic Functions"
    Public Function AddClientDemographic(ByRef objDemographicModel As client_DemographicModel) As Integer Implements IClientDA.AddClientDemographic
        Try
            Using db As New TBTracingEntities
                Dim objDemographic As client_Demographic = objDemographicModel.demoData
                Dim objClient As client_Profile = New client_Profile()
                objDemographic.Active = True
                objDemographic.ActiveFrom = DateTime.Now
                objClient.FirstName = objDemographic.FirstName
                objClient.LastName = objDemographic.LastName
                objClient.LastUpdate = DateTime.Now
                objClient.StatusID = objDemographicModel.statusID
                objClient.Employee = objDemographicModel.employee
                objClient.Confirmed = objDemographicModel.idConfirmed

                'Get the selected ethnicities.  They are bound as listitem.  Convert to entities.
                'Dim selectedEthnicities As ListItemCollection = objDemographicModel.selectedEthnicities
                Dim allEthnicities As List(Of common_Ethnicity) = db.common_Ethnicity.ToList()

                If Not IsNothing(objDemographicModel.selectedCBEthnicity) Then
                    For Each selectedEthnicity As Integer In objDemographicModel.selectedCBEthnicity
                        Dim dbEthnicity As common_Ethnicity = allEthnicities.Find(Function(p) p.ID = selectedEthnicity)
                        If Not IsNothing(dbEthnicity) Then
                            objDemographic.common_Ethnicity.Add(dbEthnicity)
                        End If
                    Next
                End If

                objClient.client_Demographic.Add(objDemographic)
                db.client_Profile.Add(objClient)
                db.SaveChanges()

                Dim strBuilder As StringBuilder = New StringBuilder()
                If Not String.IsNullOrEmpty(objClient.FirstName) Then
                    strBuilder.Append(objClient.FirstName.Chars(0))
                Else
                    strBuilder.Append(" ")
                End If
                If Not String.IsNullOrEmpty(objClient.LastName) Then
                    strBuilder.Append(objClient.LastName.Chars(0))
                Else
                    strBuilder.Append(" ")
                End If
                'Needs to be min 4 digits, however identity stats at 1.  Add 1000.
                Dim intCaseNumeric As Integer = objClient.ID + 1000
                strBuilder.Append(" " & intCaseNumeric.ToString())

                objDemographic.CaseNumber = strBuilder.ToString()
                db.SaveChanges()

                TBAudit.addAudit(TBAudit.AddClient, "Adding Client ID" & objClient.ID, "Added Demographic and Profile", objClient.ID)
                Return objClient.ID
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error adding client demographic.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client demographic", ex)
        End Try
    End Function

    Public Sub UpdateClientDemographic(ByRef objDemographicModel As client_DemographicModel) Implements IClientDA.UpdateClientDemographic
        Try
            Dim demoData As client_Demographic = objDemographicModel.demoData
            demoData.Active = True

            Using db As New TBTracingEntities
                'Get the profile we are updating.
                Dim clientToUpdate As client_Profile = db.client_Profile.Find(demoData.ClientID)
                clientToUpdate.FirstName = demoData.FirstName
                clientToUpdate.LastName = demoData.LastName
                clientToUpdate.LastUpdate = DateTime.Now
                clientToUpdate.StatusID = objDemographicModel.statusID
                clientToUpdate.Employee = objDemographicModel.employee
                clientToUpdate.Confirmed = objDemographicModel.idConfirmed

                TBAudit.addAudit(TBAudit.AddClient, "Updating Profile for Client ID" & objDemographicModel.demoData.ClientID, "Updating Demographic and Profile", objDemographicModel.demoData.ClientID)


                'Get the current demographic and set it to active as of current date.
                Dim demoToUpdate As client_Demographic = (From objDemo In db.client_Demographic _
                                                         Where objDemo.ClientID = demoData.ClientID _
                                                         And objDemo.Active = True).FirstOrDefault

                If Not IsNothing(demoToUpdate) Then
                    demoToUpdate.Active = False
                    demoToUpdate.ActiveTo = DateTime.Now
                End If

                'Get the selected ethnicities.  They are bound as listitem.  Convert to entities.
                Dim allEthnicities As List(Of common_Ethnicity) = db.common_Ethnicity.ToList()

                If Not IsNothing(objDemographicModel.selectedCBEthnicity) Then
                    For Each selectedEthnicity As Integer In objDemographicModel.selectedCBEthnicity
                        Dim dbEthnicity As common_Ethnicity = allEthnicities.Find(Function(p) p.ID = selectedEthnicity)
                        If Not IsNothing(dbEthnicity) Then
                            demoData.common_Ethnicity.Add(dbEthnicity)
                        End If
                    Next
                End If
                demoData.ActiveFrom = DateTime.Now

                ''Regenerate the Case Number
                'Dim strBuilder As StringBuilder = New StringBuilder()
                'If Not String.IsNullOrEmpty(demoData.FirstName) Then
                '    strBuilder.Append(demoData.FirstName.Chars(0))
                'Else
                '    strBuilder.Append(" ")
                'End If
                'If Not String.IsNullOrEmpty(demoData.LastName) Then
                '    strBuilder.Append(demoData.LastName.Chars(0))
                'Else
                '    strBuilder.Append(" ")
                'End If
                ''Needs to be min 4 digits, however identity stats at 1.  Add 1000.
                'Dim intCaseNumeric As Integer = clientToUpdate.ID + 1000
                'strBuilder.Append(" " & intCaseNumeric.ToString())
                'demoData.CaseNumber = strBuilder.ToString()

                clientToUpdate.client_Demographic.Add(demoData)
                db.SaveChanges()
            End Using
            'Catch validationEx As DbEntityValidationException
            '    For Each valErr In validationEx.EntityValidationErrors
            '        For Each propErr In valErr.ValidationErrors
            '            Dim validationMsg As String = propErr.PropertyName & " " & propErr.ErrorMessage

            '        Next
            '    Next
        Catch ex As Exception
            LogHelper.LogError("Error updating client demographic.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating client demographic", ex)
        End Try
    End Sub

    Public Function getDemographic(clientID As Integer) As client_Demographic Implements IClientDA.getDemographic
        Try
            Dim result As client_Demographic = Nothing

            Using db As New TBTracingEntities
                result = (From objDemo In db.client_Demographic _
                         Where objDemo.ClientID = clientID _
                         And objDemo.Active = True).FirstOrDefault()
            End Using
            Return result
        Catch ex As Exception
            LogHelper.LogError("Error getting client demographic.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client demographic", ex)
        End Try
    End Function

    Public Function checkForDuplicateHCN(clientID As Nullable(Of Integer), hcn As String) As Boolean Implements IClientDA.checkForDuplicateHCN
        Try
            Dim result As Boolean = False

            Using db As New TBTracingEntities
                If IsNothing(clientID) Then
                    Dim objDemo As client_Demographic = (From objClient In db.client_Demographic _
                                   Where objClient.HealthCareNumber.Trim().Equals(hcn) _
                                   And objClient.Active = True).FirstOrDefault()

                    If Not IsNothing(objDemo) Then
                        result = True
                    End If
                Else
                    Dim objDemo As client_Demographic = (From objClient In db.client_Demographic _
                                                       Where objClient.HealthCareNumber.Trim().Equals(hcn) _
                                                       And objClient.Active = True _
                                                       And objClient.client_Profile.ID <> clientID).FirstOrDefault()

                    If Not IsNothing(objDemo) Then
                        result = True
                    End If
                End If


            End Using

            Return result
        Catch ex As Exception
            LogHelper.LogError("Error validation client for duplication.", "client_DemographicModel", ex)
            Throw ex
        End Try
    End Function
#End Region

#Region "Skin Test Functions"
    Public Sub AddSkinTest(ByRef objSkinTest As client_SkinTest) Implements IClientDA.AddSkinTest
        Try
            Using db As New TBTracingEntities
                db.client_SkinTest.Add(objSkinTest)
                db.SaveChanges()
            End Using

            TBAudit.addAudit(TBAudit.AddEditSkinTest, "Adding skin test for Client ID" & objSkinTest.ClientID, "Added Skin Test", objSkinTest.ClientID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client skin test.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client skin test", ex)
        End Try
    End Sub

    Public Sub UpdateSkinTest(ByRef objSkinTest As client_SkinTest, ByVal testid As Integer) Implements IClientDA.UpdateSkinTest
        Try
            Using db As New TBTracingEntities
                Dim originalSkinTest As client_SkinTest = db.client_SkinTest.Find(testid)

                db.Entry(originalSkinTest).CurrentValues.SetValues(objSkinTest)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditSkinTest, "Editing Skin Test ID:" & objSkinTest.ID, "Editing Audit Details: " & auditData, objSkinTest.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client skin test.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client skin test", ex)
        End Try
    End Sub

    Public Sub AddUpdateBCG(ByRef objBCG As client_BCG) Implements IClientDA.AddUpdateBCG
        Try
            Dim auditData As String = Nothing
            Using db As New TBTracingEntities
                Dim cID As Integer = objBCG.ClientID
                Dim origBCG As client_BCG = (From objQuery In db.client_BCG _
                                                          Where objQuery.ClientID = cID _
                                                          Select objQuery).FirstOrDefault()

                If IsNothing(origBCG) Then
                    db.client_BCG.Add(objBCG)
                    auditData = "Added BCG Status for Client: " & objBCG.ClientID
                Else
                    objBCG.ID = origBCG.ID
                    db.Entry(origBCG).CurrentValues.SetValues(objBCG)
                    'Get the changed values for audit purposes.
                    Dim auditHelper As AuditHelper = New AuditHelper()
                    auditData = auditHelper.getAuditStringForContext(db, False)
                End If

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditSkinTest, "BCG Status ", auditData, objBCG.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client skin test.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client skin test", ex)
        End Try
    End Sub


    Public Function GetSkinTestHistory(clientID As Integer) As List(Of SkinTestGridLineItem) Implements IClientDA.GetSkinTestHistory
        Try
            Dim results As List(Of SkinTestGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim skinTestHistories = (From objHistory In db.client_SkinTest _
                                      Where objHistory.ClientID = clientID _
                                      Select New With { _
                                            .id = objHistory.ID, .datePlaced = objHistory.DatePlaced, _
                                            .dateRead = objHistory.DateRead, .clientID = objHistory.ClientID, _
                                            .induration = objHistory.Iduration, .result = objHistory.common_SkinTestResult.SkinTestResult, _
                                            .lotNumber = objHistory.common_MedicalLot.LotNumber, .xray = objHistory.XrayRecommended, .igra = objHistory.IGRARecommended, _
                                            .sputum = objHistory.SputumRecommended, .symptom = objHistory.SymptomInquiryRecommended, _
                                            .dose = objHistory.Dose, .route = objHistory.common_InjectionRoute.Route,
                                            .site = objHistory.common_SkinTestSite.SkinTestSite, .location = objHistory.common_GeographicLocation.SiteName
                                        }).ToList()

                If Not IsNothing(skinTestHistories) AndAlso skinTestHistories.Count > 0 Then
                    results = New List(Of SkinTestGridLineItem)

                    For Each skinTestHistory In skinTestHistories
                        Dim result As SkinTestGridLineItem = New SkinTestGridLineItem()
                        result.id = skinTestHistory.id
                        result.clientID = skinTestHistory.clientID
                        result.datePlace = skinTestHistory.datePlaced
                        result.dateRead = skinTestHistory.dateRead
                        If result.datePlace.HasValue Then result.strDatePlace = result.datePlace.Value.ToString("d MMM yyyy") Else result.strDatePlace = ""
                        If result.dateRead.HasValue Then result.strDateRead = result.dateRead.Value.ToString("dd-MMM-yyyy") Else result.strDateRead = ""
                        result.dose = skinTestHistory.dose
                        result.route = skinTestHistory.route
                        result.site = skinTestHistory.site
                        result.location = skinTestHistory.location

                        result.induration = skinTestHistory.induration
                        result.result = skinTestHistory.result
                        If Not IsNothing(skinTestHistory.xray) AndAlso skinTestHistory.xray Then result.xray = "yes" Else result.xray = "no"
                        If Not IsNothing(skinTestHistory.igra) AndAlso skinTestHistory.igra Then result.igra = "yes" Else result.igra = "no"
                        If Not IsNothing(skinTestHistory.sputum) AndAlso skinTestHistory.sputum Then result.sputum = "yes" Else result.sputum = "no"
                        If Not IsNothing(skinTestHistory.symptom) AndAlso skinTestHistory.symptom Then result.symptom = "yes" Else result.symptom = "no"
                        result.lotNumber = skinTestHistory.lotNumber
                        results.Add(result)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client skin history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client skin test history.", ex)
        End Try
    End Function
#End Region

#Region "Sputum Functions"
    Public Sub AddSputum(ByRef objSputumModel As client_SputumModel) Implements IClientDA.AddSputum
        Try
            Using db As New TBTracingEntities
                Dim objSputum As client_Sputum = objSputumModel.sputumData

                ' Get selected Antibiotics
                Dim allAntibiotics As List(Of common_Antibiotic) = db.common_Antibiotic.ToList()

                If Not IsNothing(objSputumModel.selectedCBAntibiotic) Then
                    For Each selectedAntibiotic As Integer In objSputumModel.selectedCBAntibiotic
                        Dim dbAntibiotic As common_Antibiotic = allAntibiotics.Find(Function(p) p.ID = selectedAntibiotic)
                        If Not IsNothing(dbAntibiotic) Then
                            objSputum.common_Antibiotic.Add(dbAntibiotic)
                        End If
                    Next
                End If

                db.client_Sputum.Add(objSputum)
                db.SaveChanges()

                TBAudit.addAudit(TBAudit.AddEditSputum, "Adding Sputum for Client ID" & objSputum.ID, "Added Sputum", objSputum.ID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error adding client Sputum.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client Sputum", ex)
        End Try
    End Sub

    Public Sub UpdateSputum(ByRef objSputumModel As client_SputumModel, ByVal testid As Integer) Implements IClientDA.UpdateSputum
        Try
            Dim sputumData As client_Sputum = objSputumModel.sputumData

            Using db As New TBTracingEntities
                Dim originalSputum As client_Sputum = db.client_Sputum.Find(testid)

                db.Entry(originalSputum).CurrentValues.SetValues(sputumData)

                Dim allAntibiotics As List(Of common_Antibiotic) = db.common_Antibiotic.ToList()
                originalSputum.common_Antibiotic.Clear()

                If Not IsNothing(objSputumModel.selectedCBAntibiotic) Then
                    For Each selectedAntibiotic As Integer In objSputumModel.selectedCBAntibiotic
                        Dim dbAntibiotic As common_Antibiotic = allAntibiotics.Find(Function(p) p.ID = selectedAntibiotic)

                        If Not IsNothing(dbAntibiotic) Then
                            originalSputum.common_Antibiotic.Add(dbAntibiotic)
                        End If
                    Next
                End If

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditSputum, "Editing Sputum ID:" & objSputumModel.sputumData.ID, "Editing Audit Details: " & auditData, objSputumModel.sputumData.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client sputum.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client sputum", ex)
        End Try
    End Sub

    Public Function GetSputmHistory(clientID As Integer) As List(Of SputumGridLineItem) Implements IClientDA.GetSputumHistory
        Try
            Dim results As List(Of SputumGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim sputumHistories = (From objHistory In db.client_Sputum _
                                      Where objHistory.ClientID = clientID _
                                      Select New With { _
                                            .id = objHistory.ID, _
                                            .clientID = objHistory.ClientID, _
                                            .collectedDate = objHistory.CollectedDate, _
                                            .resultDate = objHistory.ResultDate, _
                                            .reason = objHistory.common_TestReason.TestReason, _
                                            .smearResult = objHistory.common_SputumSmearResult.SmearResult, _
                                            .cultureResult = objHistory.common_SputumCultureResult.CultureResult
                                        }).ToList()

                If Not IsNothing(sputumHistories) AndAlso sputumHistories.Count > 0 Then
                    results = New List(Of SputumGridLineItem)

                    For Each sputumHistory In sputumHistories
                        Dim result As SputumGridLineItem = New SputumGridLineItem()
                        result.id = sputumHistory.id
                        result.clientID = sputumHistory.clientID
                        If Not IsNothing(sputumHistory.collectedDate) Then result.strCollectedDate = Date.Parse(sputumHistory.collectedDate).ToString("MMM-dd-yyyy") Else result.strCollectedDate = ""
                        If Not IsNothing(sputumHistory.resultDate) Then result.strResultDate = Date.Parse(sputumHistory.resultDate).ToString("MMM-dd-yyyy") Else result.strResultDate = ""
                        result.reason = sputumHistory.reason
                        result.smearResult = sputumHistory.smearResult
                        result.cultureResult = sputumHistory.cultureResult
                        results.Add(result)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client skin history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client skin test history.", ex)
        End Try
    End Function
#End Region

#Region "X-Ray Functions"
    Public Sub AddXray(ByRef objXray As client_Xray) Implements IClientDA.AddXray
        Try
            Using db As New TBTracingEntities
                db.client_Xray.Add(objXray)
                db.SaveChanges()
            End Using

            'TBAudit.addAudit(TBAudit.addedit, "Adding X-Ray for Client ID" & objClient.ID, "Added X-Ray", objClient.ID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client X-Ray.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client X-Ray", ex)
        End Try
    End Sub

    Public Sub UpdateXray(ByRef objXray As client_Xray, ByVal testid As Integer) Implements IClientDA.UpdateXray
        Try
            Using db As New TBTracingEntities
                Dim originalXray As client_Xray = db.client_Xray.Find(testid)

                db.Entry(originalXray).CurrentValues.SetValues(objXray)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                'PERRY TBAudit.addAudit(TBAudit.AddEditXray, "Updating Xray for Client ID" & objClient.ID, "Update Xray", objClient.ID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client X-Ray.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client X-Ray", ex)
        End Try
    End Sub

    Public Function GetChestXRayHistory(clientID As Integer) As List(Of XRayGridLineItem) Implements IClientDA.GetChestXrayHistory
        Try
            Dim results As List(Of XRayGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim xrayHistories = (From objHistory In db.client_Xray _
                                      Where objHistory.ClientID = clientID _
                                      And objHistory.AreaID = 4
                                      Select New With { _
                                            .id = objHistory.ID, _
                                            .clientID = objHistory.ClientID, _
                                            .examDate = objHistory.ExamDate, _
                                            .result = objHistory.common_XrayResult.XrayResult, _
                                            .location = objHistory.common_XrayArea.XrayArea, _
                                            .reason = objHistory.common_TestReason.TestReason
                                        }).ToList()

                If Not IsNothing(xrayHistories) AndAlso xrayHistories.Count > 0 Then
                    results = New List(Of XRayGridLineItem)

                    For Each xrayHistory In xrayHistories
                        Dim result As XRayGridLineItem = New XRayGridLineItem()
                        result.id = xrayHistory.id
                        result.clientID = xrayHistory.clientID
                        If Not IsNothing(xrayHistory.examDate) Then result.strExamDate = Date.Parse(xrayHistory.examDate).ToString("MMM-dd-yyyy") Else result.strExamDate = ""
                        result.result = xrayHistory.result
                        result.location = xrayHistory.location
                        result.reason = xrayHistory.reason
                        results.Add(result)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client xray history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client xray history.", ex)
        End Try
    End Function

    Public Function GetXRayHistory(clientID As Integer) As List(Of XRayGridLineItem) Implements IClientDA.GetXrayHistory
        Try
            Dim results As List(Of XRayGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim xrayHistories = (From objHistory In db.client_Xray _
                                      Where objHistory.ClientID = clientID _
                                      And objHistory.AreaID <> 4
                                      Select New With { _
                                            .id = objHistory.ID, _
                                            .clientID = objHistory.ClientID, _
                                            .examDate = objHistory.ExamDate, _
                                            .result = objHistory.common_XrayResult.XrayResult, _
                                            .location = objHistory.common_XrayArea.XrayArea, _
                                            .reason = objHistory.common_TestReason.TestReason
                                        }).ToList()

                If Not IsNothing(xrayHistories) AndAlso xrayHistories.Count > 0 Then
                    results = New List(Of XRayGridLineItem)

                    For Each xrayHistory In xrayHistories
                        Dim result As XRayGridLineItem = New XRayGridLineItem()
                        result.id = xrayHistory.id
                        result.clientID = xrayHistory.clientID
                        If Not IsNothing(xrayHistory.examDate) Then result.strExamDate = Date.Parse(xrayHistory.examDate).ToString("MMM-dd-yyyy") Else result.strExamDate = ""
                        result.result = xrayHistory.result
                        result.location = xrayHistory.location
                        result.reason = xrayHistory.reason
                        results.Add(result)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client xray history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client xray history.", ex)
        End Try
    End Function

    Public Function GetDiagnosticHistory(clientID As Integer) As List(Of XRayGridLineItem) Implements IClientDA.GetDiagnosticHistory
        Try
            Dim results As List(Of XRayGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim xrayHistories = (From objHistory In db.client_DiagnosticImage _
                                      Where objHistory.ClientID = clientID _
                                      And objHistory.AreaID <> 4
                                      Select New With { _
                                            .id = objHistory.ID, _
                                            .clientID = objHistory.ClientID, _
                                            .examDate = objHistory.ExamDate, _
                                            .result = objHistory.common_XrayResult.XrayResult, _
                                            .location = objHistory.common_XrayArea.XrayArea, _
                                            .reason = objHistory.common_TestReason.TestReason, _
                                            .view = objHistory.common_XrayView.XrayView, _
                                            .area = objHistory.common_XrayArea.XrayArea _
                                        }).ToList()

                If Not IsNothing(xrayHistories) AndAlso xrayHistories.Count > 0 Then
                    results = New List(Of XRayGridLineItem)

                    For Each xrayHistory In xrayHistories
                        Dim result As XRayGridLineItem = New XRayGridLineItem()
                        result.id = xrayHistory.id
                        result.clientID = xrayHistory.clientID
                        If Not IsNothing(xrayHistory.examDate) Then result.strExamDate = Date.Parse(xrayHistory.examDate).ToString("MMM-dd-yyyy") Else result.strExamDate = ""
                        result.result = xrayHistory.result
                        result.location = xrayHistory.location
                        result.reason = xrayHistory.reason
                        result.view = xrayHistory.view
                        result.area = xrayHistory.area
                        results.Add(result)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client xray history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client xray history.", ex)
        End Try
    End Function

    Public Sub AddDiagnosticImage(ByRef objDiagnosticImage As client_DiagnosticImage) Implements IClientDA.AddDiagnosticImage
        Try
            Using db As New TBTracingEntities
                db.client_DiagnosticImage.Add(objDiagnosticImage)
                db.SaveChanges()
            End Using

            TBAudit.addAudit(TBAudit.AddEditXrayImagine, "Adding Diagnostic Image for Client ID" & objDiagnosticImage.ClientID, "Added X-Ray", objDiagnosticImage.ID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client Diagnostic Image.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client Diagnostic Image.", ex)
        End Try
    End Sub

    Public Function UpdateDiagnosticImage(ByRef objDiagnosticImage As client_DiagnosticImage) As Object Implements IClientDA.UpdateDiagnosticImage
        Try
            Using db As New TBTracingEntities
                Dim originalImage As client_DiagnosticImage = db.client_DiagnosticImage.Find(objDiagnosticImage.ID)

                db.Entry(originalImage).CurrentValues.SetValues(objDiagnosticImage)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditXrayImagine, "Updating image for Client ID" & objDiagnosticImage.ClientID, "Details" & auditData, objDiagnosticImage.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client image.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating client image", ex)
        End Try
    End Function

#End Region

#Region "Communication Functions"
    Public Sub AddCommunication(ByRef objCommunication As client_Communication) Implements IClientDA.AddCommunication
        Try
            Using db As New TBTracingEntities
                db.client_Communication.Add(objCommunication)
                db.SaveChanges()
            End Using
            TBAudit.addAudit(TBAudit.AddEditCommunication, "Adding skin test for Client ID" & objCommunication.ClientID, "Added Demographic and Profile", objCommunication.ClientID)
        Catch ex As Exception
            LogHelper.LogError("Error adding communication.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client communication", ex)
        End Try
    End Sub

    Public Function GetCommunicationHistory(ByVal clientID As Integer) As List(Of CommunicationGridLineItem) Implements IClientDA.GetCommunicationHistory
        Try
            Dim results As List(Of CommunicationGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim objCommunications = (From objQuery In db.client_Communication _
                                       Where objQuery.ClientID = clientID _
                                       Select New With { _
                                        .commID = objQuery.ID, _
                                        .communicationMethod = objQuery.common_CommunicationMethod.ContactMethod, _
                                        .communicationResult = objQuery.common_CommunicationResult.CommunicationResult, _
                                        .communicationReason = objQuery.common_CommunicationReason.CommunicationReason, _
                                        .communicationDate = objQuery.CommunicationDateTime, _
                                        .contactedBy = objQuery.common_TBUser.NameLabel}).ToList()

                If Not IsNothing(objCommunications) Then
                    results = New List(Of CommunicationGridLineItem)
                    For Each objCommunication In objCommunications
                        Dim historyItem As CommunicationGridLineItem = New CommunicationGridLineItem()
                        historyItem.commDateTiem = objCommunication.communicationDate
                        historyItem.commMethod = objCommunication.communicationMethod
                        historyItem.commReason = objCommunication.communicationReason
                        historyItem.commResult = objCommunication.communicationResult
                        historyItem.contactedBy = objCommunication.contactedBy
                        historyItem.clientID = clientID
                        historyItem.commId = objCommunication.commID
                        results.Add(historyItem)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting communication history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting communicatin history", ex)
        End Try
    End Function

    Public Sub UpdateCommunication(ByRef objCommunication As client_Communication) Implements IClientDA.UpdateCommunication
        Try
            Using db As New TBTracingEntities
                Dim originalCommunication As client_Communication = db.client_Communication.Find(objCommunication.ID)

                db.Entry(originalCommunication).CurrentValues.SetValues(objCommunication)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditCommunication, "Editing Communication ID:" & objCommunication.ID, "Editing Audit Details: " & auditData, objCommunication.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating communication.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating communicatin.", ex)
        End Try
    End Sub
#End Region

#Region "Symptoms Functions"


    Public Sub AddSymptoms(ByRef objSymptoms As client_Symptoms) Implements IClientDA.AddSymptoms
        Try
            Using db As New TBTracingEntities
                db.client_Symptoms.Add(objSymptoms)
                db.SaveChanges()
            End Using
            TBAudit.addAudit(TBAudit.AddEditSymptoms, "Adding symptoms for Client ID:" & objSymptoms.ClientID, "Added symptoms for Client ID: " & objSymptoms.ClientID, objSymptoms.ClientID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client symptoms.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding symptoms for client.", ex)
        End Try
    End Sub

    Public Sub UpdateSymptoms(ByRef objSymptoms As client_Symptoms) Implements IClientDA.UpdateSymptoms
        Try
            Using db As New TBTracingEntities
                Dim originalSymptoms As client_Symptoms = db.client_Symptoms.Find(objSymptoms.ID)

                db.Entry(originalSymptoms).CurrentValues.SetValues(objSymptoms)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditSymptoms, "Editing Symptoms Test ID:" & objSymptoms.ID, "Editing Audit Details: " & auditData, objSymptoms.ClientID)
            End Using

        Catch ex As Exception
            LogHelper.LogError("Error updating client symptoms.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating symptoms for client.", ex)
        End Try
    End Sub

    Public Function GetSymptomsHistory(clientID As Integer) As List(Of SymptomsItem) Implements IClientDA.GetSymptomsHistory
        Try
            Dim results As List(Of SymptomsItem) = Nothing
            Using db As New TBTracingEntities

                Dim objSymptomsList = (From objList In db.client_Symptoms _
                                      Where objList.ClientID = clientID).ToList()

                If Not IsNothing(objSymptomsList) Then
                    Dim dataHelper As DataHelper = New DataHelper()
                    Dim resultList As List(Of common_YesNoUnknownRefused) = db.common_YesNoUnknownRefused.ToList()

                    results = New List(Of SymptomsItem)
                    For Each objSymptom In objSymptomsList
                        Dim itemToAdd As SymptomsItem = New SymptomsItem()
                        itemToAdd.completedBy = objSymptom.common_Clinicians.Username
                        itemToAdd.strDateAdded = New DataHelper().convertDateToStringText(objSymptom.InterviewDate)
                        itemToAdd.objSymptom = objSymptom
                        itemToAdd.symptomID = objSymptom.ID.ToString()
                        results.Add(itemToAdd)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client symptoms.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting symptoms for client.", ex)
        End Try
    End Function

#End Region

#Region "IGRA Functions"
    Public Sub AddIGRA(ByRef objIGRA As client_IGRA) Implements IClientDA.AddIGRA
        Try
            Using db As New TBTracingEntities
                db.client_IGRA.Add(objIGRA)
                db.SaveChanges()
            End Using

            TBAudit.addAudit(TBAudit.AddEditIGRA, "Adding IGRA for Client ID" & objIGRA.ClientID, "Added IGRA", objIGRA.ClientID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client IGRA.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client IGRA", ex)
        End Try
    End Sub

    Public Sub UpdateIGRA(ByRef objIGRA As client_IGRA, ByVal testid As Integer) Implements IClientDA.UpdateIGRA
        Try
            Using db As New TBTracingEntities
                Dim originalIGRA As client_IGRA = db.client_IGRA.Find(testid)

                db.Entry(originalIGRA).CurrentValues.SetValues(objIGRA)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditIGRA, "Editing IGRA ID:" & objIGRA.ID, "Editing Audit Details: " & auditData, objIGRA.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client IGRA.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client IGRA", ex)
        End Try
    End Sub

    Public Function GetIGRAHistory(clientID As Integer) As List(Of IGRAGridLineItem) Implements IClientDA.GetIGRAHistory
        Try
            Dim results As List(Of IGRAGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim igraHistories = (From objHistory In db.client_IGRA _
                                      Where objHistory.ClientID = clientID _
                                      Select New With { _
                                            .id = objHistory.ID, _
                                            .clientID = objHistory.ClientID, _
                                            .dateCollection = objHistory.CollectionDate, _
                                            .dateResult = objHistory.ResultDate, _
                                            .result = objHistory.common_IGRAResult.IGRATestResult, _
                                            .comments = objHistory.Comments, _
                                            .reason = objHistory.common_TestReason.TestReason
                                        }).ToList()

                If Not IsNothing(igraHistories) AndAlso igraHistories.Count > 0 Then
                    results = New List(Of IGRAGridLineItem)

                    For Each igraHistory In igraHistories
                        Dim result As IGRAGridLineItem = New IGRAGridLineItem()
                        result.id = igraHistory.id
                        result.clientID = igraHistory.clientID
                        result.dateCollection = igraHistory.dateCollection
                        result.dateResult = igraHistory.dateResult
                        If result.dateCollection.HasValue Then result.strDateCollection = result.dateCollection.Value.ToString("d MMM yyyy") Else result.strDateCollection = ""
                        If result.dateResult.HasValue Then result.strDateResult = result.dateResult.Value.ToString("dd-MMM-yyyy") Else result.strDateResult = ""
                        result.result = igraHistory.result
                        result.comments = igraHistory.comments
                        result.reason = igraHistory.reason

                        results.Add(result)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client IGRA history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client IGRA history.", ex)
        End Try
    End Function
#End Region

#Region "Bloodwork Functions"
    Public Sub AddBloodwork(ByRef objBloodwork As client_Bloodwork) Implements IClientDA.AddBloodwork
        Try
            Using db As New TBTracingEntities
                db.client_Bloodwork.Add(objBloodwork)
                db.SaveChanges()
            End Using

            TBAudit.addAudit(TBAudit.AddEditBloodwork, "Adding Bloodwork for Client ID" & objBloodwork.ClientID, "Added Bloodwork", objBloodwork.ClientID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client Bloodwork.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client Bloodwork", ex)
        End Try
    End Sub

    Public Sub UpdateBloodwork(ByRef objBloodwork As client_Bloodwork, ByVal testid As Integer) Implements IClientDA.UpdateBloodwork
        Try
            Using db As New TBTracingEntities
                Dim originalBloodwork As client_Bloodwork = db.client_Bloodwork.Find(testid)

                db.Entry(originalBloodwork).CurrentValues.SetValues(objBloodwork)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditBloodwork, "Editing Bloodwork ID:" & objBloodwork.ID, "Editing Audit Details: " & auditData, objBloodwork.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client Bloodwork.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client Bloodwork", ex)
        End Try
    End Sub

    Public Function GetBloodworkHistory(clientID As Integer) As List(Of BloodworkGridLineItem) Implements IClientDA.GetBloodworkHistory
        Try
            Dim results As List(Of BloodworkGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim bloodworkHistories = (From objHistory In db.client_Bloodwork _
                                      Where objHistory.ClientID = clientID _
                                      Select New With { _
                                            .id = objHistory.ID, _
                                            .clientID = objHistory.ClientID, _
                                            .dateCollected = objHistory.CollectedDate, _
                                            .dateResult = objHistory.ResultDate,
                                            .alt = objHistory.Alt, _
                                            .ast = objHistory.Ast, _
                                            .serumBilirubin = objHistory.SerumBilirubin, _
                                            .comments = objHistory.Comments, _
                                            .reason = objHistory.common_TestReason.TestReason
                                        }).ToList()

                If Not IsNothing(bloodworkHistories) AndAlso bloodworkHistories.Count > 0 Then
                    results = New List(Of BloodworkGridLineItem)

                    For Each bloodworkHistory In bloodworkHistories
                        Dim result As BloodworkGridLineItem = New BloodworkGridLineItem()
                        result.id = bloodworkHistory.id
                        result.clientID = bloodworkHistory.clientID
                        result.dateCollected = bloodworkHistory.dateCollected
                        result.dateResult = bloodworkHistory.dateResult
                        If result.dateCollected.HasValue Then result.strDateCollected = result.dateCollected.Value.ToString("d MMM yyyy") Else result.strDateCollected = ""
                        If result.dateResult.HasValue Then result.strDateResult = result.dateResult.Value.ToString("dd-MMM-yyyy") Else result.strDateResult = ""
                        result.alt = bloodworkHistory.alt
                        result.ast = bloodworkHistory.ast
                        result.serumBilirubin = bloodworkHistory.serumBilirubin
                        result.comments = bloodworkHistory.comments
                        result.reason = bloodworkHistory.reason
                        results.Add(result)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client skin history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client skin test history.", ex)
        End Try
    End Function

#End Region

#Region "Notes Functions"

    Public Sub AddNote(ByRef objNote As client_Notes) Implements IClientDA.AddNote
        Try
            Using db As New TBTracingEntities
                db.client_Notes.Add(objNote)
                objNote.DateAdded = DateTime.Now
                objNote.Active = True
                db.SaveChanges()

                TBAudit.addAudit(TBAudit.AddEditSputum, "Adding Note for Client ID" & objNote.ID, "Added Note", objNote.ID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error adding client Note.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client Note", ex)
        End Try
    End Sub

    Public Sub UpdateNote(ByRef objNote As client_Notes, ByVal noteid As Integer) Implements IClientDA.UpdateNote
        Try
            Using db As New TBTracingEntities
                Dim originalNote As client_Notes = db.client_Notes.Find(noteid)

                db.Entry(originalNote).CurrentValues.SetValues(objNote)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditNote, "Updating Note for Client ID" & objNote.ID, "Update Note", objNote.ID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client Note.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client Note", ex)
        End Try
    End Sub

    Public Sub DeleteNote(ByRef objNote As client_Notes, ByVal noteid As Integer) Implements IClientDA.DeleteNote
        Try
            Using db As New TBTracingEntities
                Dim originalNote As client_Notes = db.client_Notes.Find(noteid)

                db.Entry(originalNote).CurrentValues.SetValues(objNote)

                'Get the changed values for audit purposes.
                'Dim auditHelper As AuditHelper = New AuditHelper()
                'Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                'TBAudit.addAudit(TBAudit.AddEditNote, "Editing Note ID:" & objNote.ID, "Editing Audit Details: " & auditData, objNote.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client Bloodwork.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client Bloodwork", ex)
        End Try
    End Sub

    Public Function GetNotesHistory(clientID As Integer) As List(Of NotesGridLineItem) Implements IClientDA.GetNotesHistory
        Try
            Dim results As List(Of NotesGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim notesHistories = (From objHistory In db.client_Notes _
                                      Where objHistory.ClientID = clientID _
                                      And objHistory.Active = True
                                      Select New With { _
                                            .id = objHistory.ID, _
                                            .clientID = objHistory.ClientID, _
                                            .addedDate = objHistory.DateAdded, _
                                            .noteLabel = objHistory.NoteLabel
                                        }).ToList()

                If Not IsNothing(notesHistories) AndAlso notesHistories.Count > 0 Then
                    results = New List(Of NotesGridLineItem)

                    For Each notesHistory In notesHistories
                        Dim result As NotesGridLineItem = New NotesGridLineItem()
                        result.id = notesHistory.id
                        result.clientID = notesHistory.clientID
                        result.addedDate = notesHistory.addedDate
                        result.noteLabel = notesHistory.noteLabel
                        If result.addedDate.HasValue Then result.strAddedDate = result.addedDate.Value.ToString("d MMM yyyy") Else result.strAddedDate = ""
                        results.Add(result)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client Notes history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client Notes history.", ex)
        End Try
    End Function

#End Region

#Region "Documents Functions"

    Public Sub AddDocument(ByRef objDocument As client_Document) Implements IClientDA.AddDocument
        Try
            Using db As New TBTracingEntities
                objDocument.DateAdded = DateTime.Now
                objDocument.Active = True
                db.client_Document.Add(objDocument)
                db.SaveChanges()

                'TBAudit.addAudit(TBAudit.AddEditDocument, "Adding Document for Client ID" & objDocument.ID, "Added Document", objDocument.ID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error adding client Document.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client Document", ex)
        End Try
    End Sub

    Public Sub DeleteDocument(ByRef objDocument As client_Document, ByVal docid As Integer) Implements IClientDA.DeleteDocument
        Try
            Using db As New TBTracingEntities
                Dim originalDocument As client_Document = db.client_Document.Find(docid)

                db.Entry(originalDocument).CurrentValues.SetValues(objDocument)

                'Get the changed values for audit purposes.
                'Dim auditHelper As AuditHelper = New AuditHelper()
                'Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                'TBAudit.addAudit(TBAudit.AddEditDocument, "Editing Docuemtn ID:" & objDocument.ID, "Editing Audit Details: " & auditData, objDocument.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client Bloodwork.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding client Bloodwork", ex)
        End Try
    End Sub

    Public Function GetDocumentList(clientID As Integer) As List(Of DocumentsGridLineItem) Implements IClientDA.GetDocumentList
        Try
            Dim results As List(Of DocumentsGridLineItem) = Nothing
            Using db As New TBTracingEntities

                Dim objDocuments = (From objList In db.client_Document _
                                      Where objList.ClientID = clientID _
                                      And objList.Active = True).ToList()

                If Not IsNothing(objDocuments) Then
                    Dim dataHelper As DataHelper = New DataHelper()

                    results = New List(Of DocumentsGridLineItem)
                    For Each objDoc In objDocuments
                        Dim itemToAdd As DocumentsGridLineItem = New DocumentsGridLineItem()
                        itemToAdd.documentName = objDoc.DocumentName
                        'itemToAdd.documentContent = objDoc.DocumentContents
                        itemToAdd.strDateAdded = New DataHelper().convertDateToStringText(objDoc.DateAdded)
                        itemToAdd.documentType = objDoc.common_DocumentType.DocumentType
                        itemToAdd.active = objDoc.Active
                        itemToAdd.id = objDoc.ID
                        results.Add(itemToAdd)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client documents.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting documents for client.", ex)
        End Try
    End Function

    Public Function GetDocument(docID As Integer) As DocumentsGridLineItem Implements IClientDA.GetDocument
        Try
            Dim selectedDoc As client_Document = Nothing
            Dim docToDownload As New DocumentsGridLineItem()

            Using db As New TBTracingEntities
                selectedDoc = db.client_Document.Find(docID)
                docToDownload.documentName = selectedDoc.DocumentName
                docToDownload.documentType = selectedDoc.common_DocumentType.DocumentType
                docToDownload.documentMime = selectedDoc.common_DocumentType.DocumentTypeMime
                docToDownload.documentContent = selectedDoc.DocumentContents

            End Using
            Return docToDownload
        Catch ex As Exception
            LogHelper.LogError("Error getting document.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting document.", ex)
        End Try

    End Function

#End Region

#Region "Risk Functions"

    Public Sub AddRisk(ByRef objRisks As client_RiskFactors) Implements IClientDA.AddRisk
        Try
            Using db As New TBTracingEntities
                db.client_RiskFactors.Add(objRisks)
                db.SaveChanges()
            End Using
            TBAudit.addAudit(TBAudit.AddEditRisks, "Adding risks for Client ID:" & objRisks.ClientID, "Added risks for Client ID: " & objRisks.ClientID, objRisks.ClientID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client risks.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding risks for client.", ex)
        End Try
    End Sub

    Public Sub UpdateRisk(ByRef objRisk As client_RiskFactors) Implements IClientDA.UpdateRisk
        Try
            Using db As New TBTracingEntities
                Dim originalRisks As client_RiskFactors = db.client_RiskFactors.Find(objRisk.ID)

                db.Entry(originalRisks).CurrentValues.SetValues(objRisk)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditRisks, "Editing Symptoms Test ID:" & objRisk.ID, "Editing Audit Details: " & auditData, objRisk.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client risks.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating risks for client.", ex)
        End Try
    End Sub

    Public Function GetRisksHistory(clientID As Integer) As List(Of RisksItem) Implements IClientDA.GetRisksHistory
        Try
            Dim results As List(Of RisksItem) = Nothing
            Using db As New TBTracingEntities

                Dim objRisksList = (From objList In db.client_RiskFactors _
                                      Where objList.ClientID = clientID).ToList()

                If Not IsNothing(objRisksList) Then
                    Dim dataHelper As DataHelper = New DataHelper()
                    'Dim resultList As List(Of common_YesNoUnknownRefused) = db.common_YesNoUnknownRefused.ToList()

                    results = New List(Of RisksItem)
                    For Each objRisk In objRisksList
                        Dim itemToAdd As RisksItem = New RisksItem()
                        itemToAdd.completedBy = objRisk.common_Clinicians.Username
                        itemToAdd.strDateAdded = New DataHelper().convertDateToStringText(objRisk.InterviewDate)
                        itemToAdd.objRisk = objRisk
                        itemToAdd.riskID = objRisk.ID.ToString()
                        results.Add(itemToAdd)
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client risks.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting risks for client.", ex)
        End Try
    End Function
#End Region

#Region "Followups"

    Public Function GetFollowups(clientID As Integer) As List(Of FollowUpGridLineItem) Implements IClientDA.GetFollowups
        Try
            Dim results As List(Of FollowUpGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim qryResults = (From objFollows In db.client_Followup _
                                Where objFollows.ClientID = clientID _
                                Select New With {.objFollowUp = objFollows, _
                                .strResponsibility = objFollows.common_TBUser.NameLabel, _
                                .strFollowupType = objFollows.common_Followup.FollowupType}).ToList()


                If Not IsNothing(qryResults) AndAlso qryResults.Count > 0 Then
                    results = New List(Of FollowUpGridLineItem)
                    Dim objHelper As DataHelper = New DataHelper()

                    For Each followup In qryResults
                        Dim gridItem As FollowUpGridLineItem = New FollowUpGridLineItem(followup.objFollowUp)

                        gridItem.strResponsibility = followup.strResponsibility
                        gridItem.strFollowupType = followup.strFollowupType
                        results.Add(gridItem)
                    Next
                End If
                Return results
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting client followups.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting followups for client.", ex)
        End Try
    End Function


    Public Sub AddFollowup(ByRef objFollowup As client_Followup) Implements IClientDA.AddFollowup
        Try
            Using db As New TBTracingEntities
                db.client_Followup.Add(objFollowup)
                db.SaveChanges()
            End Using
            TBAudit.addAudit(TBAudit.AddEditFollowup, "Adding followup for Client ID:" & objFollowup.ClientID, "Added followup for Followup ID: " & objFollowup.ID, objFollowup.ClientID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client followups.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding followups for client.", ex)
        End Try
    End Sub

    Public Sub UpdateFollowup(ByRef objFollowup As client_Followup) Implements IClientDA.UpdateFollowup
        Try
            Using db As New TBTracingEntities
                Dim originalFollowup As client_Followup = db.client_Followup.Find(objFollowup.ID)

                db.Entry(originalFollowup).CurrentValues.SetValues(objFollowup)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditFollowup, "Editing Followup Test ID:" & objFollowup.ID, "Editing Audit Details: " & auditData, objFollowup.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client followups.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating followups for client.", ex)
        End Try
    End Sub

    Public Function GetAllFollowups(startDate As Nullable(Of DateTime), endDate As Nullable(Of DateTime), responsibility As String, fType As String) As List(Of FollowUpGridLineItem) Implements IClientDA.GetAllFollowups
        Try
            If IsNothing(startDate) Then
                startDate = DateTime.Now + New TimeSpan(0, 0, 0)
            End If

            If IsNothing(endDate) Then
                endDate = DateTime.MaxValue
            End If

            Dim results As List(Of FollowUpGridLineItem) = Nothing
            Using db As New TBTracingEntities
                Dim fQuery = (From objFollows In db.client_Followup _
                                Where objFollows.FollowupDate >= startDate _
                                And objFollows.FollowupDate <= endDate _
                                Select New With {.objFollowUp = objFollows, _
                                .strClientLastName = objFollows.client_Profile.LastName, _
                                .strClientFirstname = objFollows.client_Profile.FirstName, _
                                .strResponsibility = objFollows.common_TBUser.NameLabel, _
                                .strFollowupType = objFollows.common_Followup.FollowupType})

                If Not String.IsNullOrEmpty(responsibility) AndAlso IsNumeric(responsibility) Then
                    Dim intResp As Integer = Integer.Parse(responsibility)
                    fQuery = fQuery.Where(Function(p) p.objFollowUp.PhysicianID = intResp)
                End If

                If Not String.IsNullOrEmpty(fType) AndAlso IsNumeric(fType) Then
                    Dim followupType As Integer = Integer.Parse(fType)
                    fQuery = fQuery.Where(Function(p) p.objFollowUp.FollowupType = followupType)
                End If


                Dim qryResults = fQuery.ToList()

                If Not IsNothing(qryResults) AndAlso qryResults.Count > 0 Then
                    results = New List(Of FollowUpGridLineItem)
                    Dim objHelper As DataHelper = New DataHelper()

                    For Each followup In qryResults
                        Dim gridItem As FollowUpGridLineItem = New FollowUpGridLineItem(followup.objFollowUp)
                        gridItem.strResponsibility = followup.strResponsibility
                        gridItem.strFollowupType = followup.strFollowupType
                        gridItem.strClientName = followup.strClientFirstname & " " & followup.strClientLastName
                        results.Add(gridItem)
                    Next
                End If
                Return results
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting client followups.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting followups for client.", ex)
        End Try
    End Function

#End Region

#Region "Client Information Control"
    Public Function GetClientInformation(ByVal clientID As Integer) As client_InformationModel Implements IClientDA.GetClientInformation
        Try
            Dim result As client_InformationModel = New client_InformationModel()

            Using db As New TBTracingEntities
                Dim clientInfo = (From clientDemo In db.client_Demographic.Include("client_Profile") _
                                    Where clientDemo.ClientID = clientID _
                                    And clientDemo.Active = True).FirstOrDefault()

                result.demoData = clientInfo
                result.profileData = clientInfo.client_Profile
                result.status = clientInfo.client_Profile.common_Status.Status
            End Using
            Return result
        Catch ex As Exception
            LogHelper.LogError("Error getting client information", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting client information", ex)
        End Try
    End Function

#End Region

#Region "Contact Tracing"
    Public Sub AddContactTracing(ByRef clientContactTrace As client_ContactTracing) Implements IClientDA.AddContactTracing
        Try
            Using db As New TBTracingEntities
                db.client_ContactTracing.Add(clientContactTrace)
                db.SaveChanges()
            End Using
            TBAudit.addAudit(TBAudit.AddEditContactTracing, "Adding contact tracing for Client ID:" & clientContactTrace.ClientID, "Added contact tracing for ID: " & clientContactTrace.ID, clientContactTrace.ClientID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client contact tracing.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding contact tracing for client.", ex)
        End Try
    End Sub

    Public Function GetContactTracingHistory(clientID As Integer) As List(Of ContactTracingHistoryGrid) Implements IClientDA.GetContactTracingHistory
        Try
            Dim results As List(Of ContactTracingHistoryGrid) = Nothing
            Using db As New TBTracingEntities
                Dim objDataHelper As DataHelper = New DataHelper()
                'First get the contacts where the client is the source.
                Dim clientSource As List(Of vwContactTracingConsolidated) = (From query In db.vwContactTracingConsolidated _
                                                                            Where query.SourceClientID = clientID).ToList()


                If Not IsNothing(clientSource) Then
                    results = New List(Of ContactTracingHistoryGrid)
                    For Each objClient In clientSource
                        Dim result As ContactTracingHistoryGrid = New ContactTracingHistoryGrid()
                        result.ClientID = clientID
                        result.ContactID = objClient.IdentifiedClientID
                        result.ContactName = objClient.IdentifiedFirstName & " " & objClient.IdentifiedLastName
                        If Not IsNothing(objClient.FromDate) Then result.strFromDate = objDataHelper.convertDateToStringText(objClient.FromDate) Else result.strFromDate = String.Empty
                        If Not IsNothing(objClient.FromDate) Then result.FromDate = objClient.FromDate Else result.FromDate = Nothing
                        If Not IsNothing(objClient.ToDate) Then result.ToDate = objClient.ToDate Else result.ToDate = Nothing
                        If Not IsNothing(objClient.ToDate) Then result.strToDate = objDataHelper.convertDateToStringText(objClient.ToDate) Else result.strToDate = String.Empty
                        result.TraceID = objClient.ID
                        result.TraceType = objClient.ContactType
                        result.TraceTypeID = objClient.ContactTypeID
                        result.Relationship = objClient.RelationshipText
                        result.RelationshipID = objClient.RelationshipID
                        result.Priority = objClient.Priority
                        result.PriorityID = objClient.PriorityID
                        result.Reason = objClient.ContactReason
                        results.Add(result)
                    Next
                End If

                'Now get conctacts where the client was listed as a contact
                Dim identifiedSource As List(Of vwContactTracingConsolidated) = (From query In db.vwContactTracingConsolidated _
                                                                            Where query.IdentifiedClientID = clientID).ToList()


                If Not IsNothing(identifiedSource) Then
                    If IsNothing(results) Then results = New List(Of ContactTracingHistoryGrid)
                    For Each objClient In identifiedSource
                        Dim result As ContactTracingHistoryGrid = New ContactTracingHistoryGrid()
                        result.ClientID = clientID
                        result.ContactID = objClient.SourceClientID
                        result.ContactName = objClient.SourceFirstName & " " & objClient.SourceLastName
                        If Not IsNothing(objClient.FromDate) Then result.strFromDate = objDataHelper.convertDateToStringText(objClient.FromDate) Else result.strToDate = String.Empty
                        result.FromDate = objClient.FromDate
                        result.ToDate = objClient.ToDate
                        If Not IsNothing(objClient.ToDate) Then result.strToDate = objDataHelper.convertDateToStringText(objClient.ToDate) Else result.strToDate = String.Empty
                        result.TraceID = objClient.ID
                        result.TraceType = objClient.ContactType
                        result.TraceTypeID = objClient.ContactTypeID
                        result.Relationship = objClient.RelationshipText
                        result.RelationshipID = objClient.RelationshipID
                        result.Priority = objClient.Priority
                        result.PriorityID = objClient.PriorityID
                        result.Reason = objClient.ContactReason
                        results.Add(result)
                    Next
                End If

                Return results
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error retrieving tracing history.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding contact tracing for client.", ex)
        End Try
    End Function

    Public Sub AddContactNote(ByRef clientContactNote As client_ContactNote) Implements IClientDA.AddContactNote
        Try
            Using db As New TBTracingEntities
                db.client_ContactNote.Add(clientContactNote)
                db.SaveChanges()
            End Using
            TBAudit.addAudit(TBAudit.AddEditContactTracing, "Adding contact note for Client ID:" & clientContactNote.ClientID, "Added contact note for ID: " & clientContactNote.ID, clientContactNote.ClientID)
        Catch ex As Exception
            LogHelper.LogError("Error add contact note.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding contact tracing notes.", ex)
        End Try
    End Sub

    Public Sub UpdateContactNote(ByRef clientContactNote As client_ContactNote) Implements IClientDA.UpdateContactNote
        Try
            Using db As New TBTracingEntities
                Dim origNote As client_ContactNote = db.client_ContactNote.Find(clientContactNote.ID)

                db.Entry(origNote).CurrentValues.SetValues(clientContactNote)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditContactTracing, "Editing Contact Note ID:" & clientContactNote.ID, "Editing Audit Details: " & auditData, clientContactNote.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error update contact note.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating contact tracing notes.", ex)
        End Try
    End Sub

    Public Sub UpdateContactTracing(ByRef clientContactTrace As client_ContactTracing) Implements IClientDA.UpdateContactTracing
        Try
            Using db As New TBTracingEntities
                Dim origTrace As client_ContactTracing = db.client_ContactTracing.Find(clientContactTrace.ID)

                db.Entry(origTrace).CurrentValues.SetValues(clientContactTrace)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditContactTracing, "Editing Contact Tracing ID:" & clientContactTrace.ID, "Editing Audit Details: " & auditData, clientContactTrace.ClientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error update contact tracing record.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating contact tracing record.", ex)
        End Try
    End Sub
#End Region

#Region "Outcomes"
    Public Function GetOutcomeForClient(clientID As Integer, ByVal statusList As List(Of Integer)) As List(Of OutcomeGridLineItem) Implements IClientDA.GetOutcomeForClient
        Try
            Dim results As List(Of OutcomeGridLineItem) = Nothing

            Using db As New TBTracingEntities

                Dim outcomes = From outQuery In db.client_Outcome _
                                               Where outQuery.ClientID = clientID _
                                               Select New With {.recordID = outQuery.ID, .clientID = outQuery.ClientID, _
                                                                .determinationDate = outQuery.OutcomeDeterminationDate, .deterBy = outQuery.common_Clinicians.Username, _
                                                                .outcomeName = outQuery.common_TBOutcome.TBOutcome, .outcomeID = outQuery.Outcome, _
                                                                .typeID = outQuery.TBType, .deterID = outQuery.DeterminedByID, _
                                                                .treatID = outQuery.TreatmentID, .regCount = outQuery.client_OutcomeTreatmentRegimen.Count, _
                                                                .typeStr = outQuery.common_TBTypes.TBType}

                If Not IsNothing(statusList) AndAlso statusList.Count > 0 Then
                    outcomes = outcomes.Where(Function(p) statusList.Contains(p.outcomeID))
                End If

                Dim qryResults = outcomes.ToList()


                If Not IsNothing(qryResults) Then
                    results = New List(Of OutcomeGridLineItem)
                    Dim objHelper As DataHelper = New DataHelper()

                    For Each outcome In qryResults
                        Dim result As OutcomeGridLineItem = New OutcomeGridLineItem()

                        result.DeterminationDate = outcome.determinationDate
                        If Not IsNothing(result.DeterminationDate) Then result.strDeterminationDate = objHelper.convertDateToStringText(outcome.determinationDate)
                        result.DeterminedBy = outcome.deterID
                        result.strDeterminedBy = outcome.deterBy
                        result.intPK = outcome.recordID
                        result.intClientID = outcome.clientID
                        result.OutcomeID = outcome.outcomeID
                        result.strOutcome = outcome.outcomeName
                        result.TypeID = outcome.typeID
                        result.strType = outcome.typeStr
                        result.intTreatID = outcome.treatID
                        results.Add(result)

                        If Not IsNothing(outcome.regCount) AndAlso outcome.regCount > 0 Then
                            result.hasRegimen = True
                        Else
                            result.hasRegimen = False
                        End If
                    Next
                End If
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting client outcomes.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting clientoutcome for client.", ex)
        End Try
    End Function

    Public Function AddOutcome(ByRef clientOutcome As client_Outcome) As String Implements IClientDA.AddOutcome
        Try
            Dim returnString As String = Nothing
            Using db As New TBTracingEntities
                Dim objTreatment As client_OutcomeTreatment = New client_OutcomeTreatment()
                clientOutcome.client_OutcomeTreatment = objTreatment
                db.client_Outcome.Add(clientOutcome)
                db.SaveChanges()

                'Update the client profile status
                Dim intClientID As Integer = clientOutcome.ClientID
                Dim addedID As Integer = clientOutcome.ID

                'Get most recent data of any other outcomes
                Dim mostRecentDate As Nullable(Of DateTime) = Nothing

                If db.client_Outcome.Where(Function(p) p.ClientID = intClientID And p.ID <> addedID).Count > 0 Then
                    mostRecentDate = db.client_Outcome.Where(Function(p) p.ClientID = intClientID And p.ID <> addedID).Max(Function(p) p.OutcomeDeterminationDate)
                End If

                'If the updated the most recent outcome (by date), reflect the change in the status
                If IsNothing(mostRecentDate) Or (Not IsNothing(mostRecentDate) AndAlso clientOutcome.OutcomeDeterminationDate > mostRecentDate) Then
                    Dim newStatus As common_Status = db.common_TBOutcome.Find(clientOutcome.Outcome).common_Status
                    Dim clientProfile As client_Profile = db.client_Profile.Find(intClientID)

                    If clientProfile.StatusID <> newStatus.ID Then
                        Dim oldStatus As common_Status = db.common_Status.Find(clientProfile.StatusID)
                        returnString = "Update status from " & oldStatus.Status & " to " & newStatus.Status
                        clientProfile.StatusID = newStatus.ID
                        db.SaveChanges()
                    End If
                End If
            End Using
            TBAudit.addAudit(TBAudit.AddEditOutcome, "Adding client outcome for Client ID" & clientOutcome.ClientID, "Added Client Outcome", clientOutcome.ClientID)
            Return returnString
        Catch ex As Exception
            LogHelper.LogError("Error adding client outcome.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding clientoutcome for client.", ex)
        End Try
    End Function

    Public Function UpdateOutcome(ByRef clientOutcome As client_Outcome) As String Implements IClientDA.UpdateOutcome
        Try
            Dim returnString As String = Nothing
            Using db As New TBTracingEntities
                Dim originalOutcome As client_Outcome = db.client_Outcome.Find(clientOutcome.ID)

                db.Entry(originalOutcome).CurrentValues.SetValues(clientOutcome)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditOutcome, "Editing Outcome ID:" & clientOutcome.ID, "Editing Audit Details: " & auditData, clientOutcome.ClientID)

                'Update the client profile status
                Dim intClientID As Integer = clientOutcome.ClientID
                Dim outcomeID As Integer = clientOutcome.ID

                'Get most recent data of any other outcomes
                Dim mostRecentDate As Nullable(Of DateTime) = db.client_Outcome.Where(Function(p) p.ClientID = intClientID And p.ID <> outcomeID).Max(Function(p) p.OutcomeDeterminationDate)

                'If the updated the most recent outcome (by date), reflect the change in the status
                If IsNothing(mostRecentDate) Or (Not IsNothing(mostRecentDate) AndAlso clientOutcome.OutcomeDeterminationDate > mostRecentDate) Then
                    Dim newStatus As common_Status = db.common_TBOutcome.Find(clientOutcome.Outcome).common_Status
                    Dim clientProfile As client_Profile = db.client_Profile.Find(intClientID)

                    If clientProfile.StatusID <> newStatus.ID Then
                        Dim oldStatus As common_Status = db.common_Status.Find(clientProfile.StatusID)
                        returnString = "Update status from " & oldStatus.Status & " to " & newStatus.Status
                        clientProfile.StatusID = newStatus.ID
                        db.SaveChanges()
                    End If
                End If

            End Using
            Return returnString
        Catch ex As Exception
            LogHelper.LogError("Error updating client outcome.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating clientoutcome for client.", ex)
        End Try
    End Function

    Public Sub AddTreatmentRegimen(ByRef treatment As client_OutcomeTreatmentRegimen) Implements IClientDA.AddTreatmentRegimen
        Try
            Using db As New TBTracingEntities
                db.client_OutcomeTreatmentRegimen.Add(treatment)
                db.SaveChanges()
            End Using

            TBAudit.addAudit(TBAudit.AddEditOutcome, "Adding treatment regiment for outcome" & treatment.OutcomeID, "Added Regiment for  Outcome", treatment.OutcomeID)
        Catch ex As Exception
            LogHelper.LogError("Error adding client treatment regimen.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding treatment regimen.", ex)
        End Try
    End Sub

    Public Sub UpdateTreatmentRegimen(ByRef treatment As client_OutcomeTreatmentRegimen) Implements IClientDA.UpdateTreatmentRegimen
        Try
            Using db As New TBTracingEntities
                Dim originalRegiment As client_OutcomeTreatmentRegimen = db.client_OutcomeTreatmentRegimen.Find(treatment.ID)

                db.Entry(originalRegiment).CurrentValues.SetValues(treatment)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditOutcome, "Editing Regimen ID:" & treatment.ID, "Editing Audit Details: " & auditData, treatment.ID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client treatment regimen.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating treatment regimen.", ex)
        End Try
    End Sub

    Public Sub UpdateTreatment(ByRef treatment As client_OutcomeTreatment) Implements IClientDA.UpdateTreatment
        Try
            Using db As New TBTracingEntities
                Dim originalTreatment As client_OutcomeTreatment = db.client_OutcomeTreatment.Find(treatment.ID)

                db.Entry(originalTreatment).CurrentValues.SetValues(treatment)

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)

                db.SaveChanges()
                TBAudit.addAudit(TBAudit.AddEditOutcome, "Editing Treatment ID:" & treatment.ID, "Editing Audit Details: " & auditData, treatment.ID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client treatment.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating treatment.", ex)
        End Try
    End Sub

    Public Sub AddDOT(ByRef dot As client_DotModel) Implements IClientDA.AddDOT
        Try
            Using db As New TBTracingEntities
                Dim dotToAdd As client_OutcomeTreatmentDOT = dot.dotItem

                'Add medications
                Dim allMedications As List(Of common_Medication) = db.common_Medication.ToList()
                If Not IsNothing(dot.selectedMedications) Then
                    For Each selectedMed As Integer In dot.selectedMedications
                        Dim dbMed As common_Medication = allMedications.Find(Function(p) p.ID = selectedMed)
                        If Not IsNothing(dbMed) Then
                            dotToAdd.common_Medication.Add(dbMed)
                        End If
                    Next
                End If

                'Add Symptoms
                Dim allSymptoms As List(Of common_Symptoms) = db.common_Symptoms.ToList()
                If Not IsNothing(dot.selectedSymptoms) Then
                    For Each selectedSymp In dot.selectedSymptoms
                        Dim dbSymp As common_Symptoms = allSymptoms.Find(Function(p) p.ID = selectedSymp)
                        If Not IsNothing(dbSymp) Then
                            dotToAdd.common_Symptoms.Add(dbSymp)
                        End If
                    Next
                End If

                db.client_OutcomeTreatmentDOT.Add(dotToAdd)
                db.SaveChanges()

                TBAudit.addAudit(TBAudit.AddClient, "Adding DOT ID: " & dotToAdd.ID, "Added DOT Data", dotToAdd.ID)

            End Using
        Catch ex As Exception
            LogHelper.LogError("Error adding client DOT.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error adding DOT.", ex)
        End Try
    End Sub

    Public Function GetDotById(ByRef dotID As Integer) As client_DotModel Implements IClientDA.GetDotById
        Try
            Dim result As client_DotModel = Nothing

            Using db As New TBTracingEntities
                Dim dotData As client_OutcomeTreatmentDOT = db.client_OutcomeTreatmentDOT.Find(dotID)

                If Not IsNothing(dotData) Then
                    result = New client_DotModel()
                    result.dotItem = dotData
                    result.selectedSymptoms = dotData.common_Symptoms.Select(Function(p) p.ID).ToList()
                    result.selectedMedications = dotData.common_Medication.Select(Function(p) p.ID).ToList()
                End If
            End Using
            Return result
        Catch ex As Exception
            LogHelper.LogError("Error getting client DOT.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error getting DOT.", ex)
        End Try
    End Function

    Public Sub UpdateDOT(ByRef modelData As client_DotModel, ByVal clientID As Integer) Implements IClientDA.UpdateDOT
        Try
            Using db As New TBTracingEntities
                Dim originalDOT As client_OutcomeTreatmentDOT = db.client_OutcomeTreatmentDOT.Find(modelData.dotItem.ID)


                db.Entry(originalDOT).CurrentValues.SetValues(modelData.dotItem)

                'Add/Remove Medications
                Dim allMeds As List(Of common_Medication) = db.common_Medication.ToList()
                Dim originalMedicationIDs = originalDOT.common_Medication.Select(Function(t) t.ID)
                Dim newMedicationIDs = modelData.selectedMedications
                Dim removedMedications = originalMedicationIDs.Except(newMedicationIDs)
                Dim addedMedications = newMedicationIDs.Except(originalMedicationIDs)

                If Not IsNothing(addedMedications) Then
                    For Each addedMedication In addedMedications.ToList()
                        Dim medToAdd As common_Medication = allMeds.Find(Function(p) p.ID = addedMedication)
                        If Not IsNothing(medToAdd) Then originalDOT.common_Medication.Add(medToAdd)
                    Next
                End If

                If Not IsNothing(removedMedications) Then
                    For Each removedMedication In removedMedications.ToList()
                        Dim medToRemove As common_Medication = allMeds.Find(Function(p) p.ID = removedMedication)
                        If Not IsNothing(medToRemove) Then originalDOT.common_Medication.Remove(medToRemove)
                    Next
                End If

                'Add/Remove Symptoms
                Dim allSymptoms As List(Of common_Symptoms) = db.common_Symptoms.ToList()
                Dim originalSymptomIDs = originalDOT.common_Symptoms.Select(Function(t) t.ID)
                Dim newSymptomIDs = modelData.selectedSymptoms
                Dim removedSymptoms = originalSymptomIDs.Except(newSymptomIDs)
                Dim addedSymptoms = newSymptomIDs.Except(originalSymptomIDs)

                If Not IsNothing(addedSymptoms) Then
                    For Each addedSymptom In addedSymptoms.ToList()
                        Dim sympToAdd As common_Symptoms = allSymptoms.Find(Function(p) p.ID = addedSymptom)
                        If Not IsNothing(sympToAdd) Then originalDOT.common_Symptoms.Add(sympToAdd)
                    Next
                End If

                If Not IsNothing(removedSymptoms) Then
                    For Each removedSymptom In removedSymptoms.ToList()
                        Dim symptomToRemove As common_Symptoms = allSymptoms.Find(Function(p) p.ID = removedSymptom)
                        If Not IsNothing(symptomToRemove) Then originalDOT.common_Symptoms.Remove(symptomToRemove)
                    Next
                End If

                'Get the changed values for audit purposes.
                Dim auditHelper As AuditHelper = New AuditHelper()
                Dim auditData As String = auditHelper.getAuditStringForContext(db, False)
                db.SaveChanges()

                TBAudit.addAudit(TBAudit.AddClient, "Updating DOT ID: " & modelData.dotItem.ID, "Update DOT Data: " & auditData, clientID)
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error updating client DOT.", "ClientDAImpl", ex)
            Throw New TBDataAccessException("Error updating DOT.", ex)
        End Try
    End Sub
#End Region


End Class
