Imports System.Web
Imports System.Web.Services
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports DocumentFormat.OpenXml.Spreadsheet
Imports System.IO
Imports System.Data.SqlClient

Public Class DataExtractHandler
    Implements System.Web.IHttpHandler

    Private lineReturn As String = vbCr & vbLf
    Private objDataHelper As DataHelper = New DataHelper()


    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Try
            Dim objDataHelper As DataHelper = New DataHelper()

            Dim csvContents As StringBuilder = New StringBuilder()
            csvContents.Append("CLIENT DEMOGRAPHICS" & lineReturn)

            Dim demoSql As String = "SELECT client_Demographic.FirstName, client_Demographic.LastName,client_Profile.ID, " & _
                                            "client_Demographic.DateofBirth, client_Demographic.CaseNumber, common_Status.Status, " & _
                                            "client_Demographic.HealthCareNumber, common_Gender.Gender, common_Community.Community, " & _
                                            "(select DATEDIFF(yy, client_Demographic.DateofBirth, getdate())) As Age, " & _
                                            "STUFF((SELECT ','+ commonEth.Ethnicity " & _
                                                    "FROM client_DemographicEthnicity  As clientEth " & _
                                                    "INNER JOIN common_Ethnicity as commonEth ON clientEth.EthnicityID = commonEth.ID " & _
                                                    "WHERE client_Demographic.ID = clientEth.ClientID " & _
                                                    "FOR XML PATH(''), TYPE).value('.','VARCHAR(max)'), 1, 1, '') As ethniticiesList      " & _
                                            "FROM client_Profile " & _
                                            "LEFT JOIN common_Status on client_Profile.StatusID = common_Status.ID  " & _
                                            "INNER JOIN client_Demographic ON client_Profile.ID = client_Demographic.ClientID  " & _
                                            "LEFT JOIN common_Gender ON client_Demographic.GenderID = common_Gender.ID  " & _
                                            "LEFT JOIN common_Community ON client_Demographic.CommunityID = common_Community.ID  " & _
                                            "WHERE client_Demographic.Active = 'True' " & _
                                            "And client_Demographic.ClientID = @parmID "

            RunQueryAddResults(demoSql, 95, csvContents)

            csvContents.Append(lineReturn & lineReturn & lineReturn)
            csvContents.Append("CLIENT SYMPTOMS" & lineReturn)
            Dim strSymptoms As String = "select InterviewDate, " & _
                                        "SUBSTRING ( Cough3Weeks.Value, 1 , 1 ) As 'Cough > 3 Wks', " & _
                                        "SUBSTRING ( ShortnessBreath.Value, 1 , 1 ) As 'Shortness Breath', " & _
                                        "SUBSTRING ( Fever.Value, 1 , 1 ) As 'Fever', " & _
                                        "SUBSTRING ( NightSweats.Value, 1 , 1 ) As 'Night Sweats', " & _
                                        "SUBSTRING ( Hemoptysis.Value, 1 , 1 ) As 'Hemotypsis', " & _
                                        "SUBSTRING ( WeightLoss.Value, 1 , 1 ) As 'Weight Loss', " & _
                                        "SUBSTRING ( LossAppetite.Value, 1 , 1 ) As 'Loss of Appetite', " & _
                                        "SUBSTRING ( Fatigue.Value, 1 , 1 ) aS 'Fatigue', " & _
                                        "SUBSTRING ( ChestPain.Value, 1 , 1 ) as 'Chest Pain', " & _
                                        "SUBSTRING ( FailureToThrice.Value, 1 , 1 ) As 'Failure to Thrive', " & _
                                        "SUBSTRING ( Rash.Value, 1 , 1 ) As 'Rash', " & _
                                        "common_CompletionMethod.CompletionMethod As 'Completion Method' " & _
                                        "from client_Symptoms " & _
                                        "LEFT JOIN common_CompletionMethod ON client_Symptoms.CompletionMethod = common_CompletionMethod.ID " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As Cough3Weeks ON client_Symptoms.CoughGreat3Weeks = Cough3Weeks.ID " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As ShortnessBreath ON client_Symptoms.ShortnessBreath = ShortnessBreath.ID " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As Fever ON client_Symptoms.Fever = Fever.ID " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As NightSweats ON client_Symptoms.NightSweats = NightSweats.ID " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As Hemoptysis ON client_Symptoms.Hemoptysis = Hemoptysis.ID  " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As WeightLoss On client_Symptoms.WeightLoss = WeightLoss.ID " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As LossAppetite ON client_Symptoms.LossAppetite = LossAppetite.ID " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As Fatigue ON client_Symptoms.Fatigue = Fatigue.ID " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As ChestPain On client_Symptoms.Chestpain = ChestPain.ID  " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As FailureToThrice On client_Symptoms.FailureToThrive = FailureToThrice.ID  " & _
                                        "LEFT JOIN common_YesNoUnknownRefused As Rash on client_Symptoms.Rash = rash.ID " & _
                                        "WHERE client_Symptoms.ClientID = @parmID " & _
                                        "ORDER BY client_Symptoms.InterviewDate Desc "

            RunQueryAddResults(strSymptoms, 95, csvContents)
            csvContents.Append(", Key: Y = Yes , N = No , U = Unknown , R = Refused" & lineReturn)

            csvContents.Append(lineReturn & lineReturn & lineReturn)
            csvContents.Append("SKIN TEST HISTORY" & lineReturn)
            Dim strSkingTest As String = "select common_InjectionRoute.Route, client_SkinTest.DatePlaced, client_SkinTest.DateRead, " & _
                                        "client_SkinTest.Iduration,client_SkinTest.XrayRecommended, client_Skintest.IGRARecommended, " & _
                                        "client_SkinTest.FollowUpTestRequired, client_Skintest.ReadByText, " & _
                                        "common_SkinTestResult.SkinTestResult " & _
                                        "from client_SkinTest  " & _
                                        "LEFT JOIN common_InjectionRoute ON client_SkinTest.RouteID = common_InjectionRoute.ID " & _
                                        "LEFT JOIN common_TestReason ON client_SkinTest.TestReasonID = common_TestReason.ID  " & _
                                        "LEFT JOIN common_SkinTestResult ON client_SkinTest.ResultID = common_SkinTestResult.ID  " & _
                                        "WHERE client_SkinTest.ClientID = @parmID " & _
                                        "ORDER BY client_SkinTest.DatePlaced Desc "
            RunQueryAddResults(strSkingTest, 95, csvContents)
            csvContents.Append(lineReturn & lineReturn & lineReturn)


            csvContents.Append("CLIENT SPUTUM / CULTURE TEST" & lineReturn)
            Dim strSputim As String = "Select CollectedDate, ResultDate, common_SputumSmearResult.SmearResult, common_SputumCultureResult.CultureResult, " & _
                                        "StatusRefused, StatusUnableToProduce, StatusCollected, StatusSmearComplete, StatusPendingCulture, " & _
                                        "StatusInduced, StatusComplete, CultureResultData, common_SputumRequestBy.RequestedBy , " & _
                                        " common_Clinicians.Username As 'CompletedBy',  " & _
                                        " STUFF((SELECT ','+ clientAnti.AntibioticName " & _
                                        "           FROM common_Antibiotic  As clientAnti " & _
                                        "           INNER JOIN client_SputumResistence as commonSR ON clientAnti.id = commonSR.AntibioticID " & _
                                        "           WHERE commonSR.SputumID = client_Sputum.ID  " & _
                                        "           FOR XML PATH(''), TYPE).value('.','VARCHAR(max)'), 1, 1, '') As antiResistenceList      " & _
                                        "from client_Sputum  " & _
                                        "INNER JOIN client_Profile ON client_Sputum.ClientID = client_Profile.ID  " & _
                                        "Left Join common_SputumSmearResult on client_Sputum.SmearResultID = common_SputumSmearResult.ID  " & _
                                        "Left Join common_SputumCultureResult on client_Sputum.CultureResultID = common_SputumCultureResult.ID  " & _
                                        "Left Join common_TestReason on client_Sputum.ReasonForTestingID = common_TestReason.ID  " & _
                                        "Left Join common_SputumRequestBy on client_Sputum.RequestedByID = common_SputumRequestBy.ID  " & _
                                        "Left Join common_Clinicians on client_Sputum.CompletedByID = common_Clinicians.ID  " & _
                                        "where client_Profile.ID = @parmID "
            RunQueryAddResults(strSputim, 95, csvContents)


            csvContents.Append(lineReturn & lineReturn & lineReturn)
            csvContents.Append("IGRA HISTORY" & lineReturn)
            Dim strIgra As String = "SELECT CollectionDate,ResultDate," & _
                                    "common_IGRAResult.IGRATestResult, " & _
                                    "common_TestReason.TestReason, Comments " & _
                                    "FROM client_IGRA " & _
                                    "LEFT JOIN common_IGRAResult on client_IGra.ResultID = common_IGRAResult.ID " & _
                                    "LEFT JOIN common_TestReason on client_IGRA.ReasonForTestingID = common_TestReason.ID " & _
                                    "WHERE client_IGRA.ClientID = @parmID "
            RunQueryAddResults(strIgra, 95, csvContents)

            csvContents.Append(lineReturn & lineReturn & lineReturn)
            csvContents.Append("BLOODWORK HISTORY" & lineReturn)
            Dim strBlood As String = "SELECT CollectedDate,ResultDate,common_BloodworkCollectionMethod.CollectionMethod " & _
                                    ",CollectedBy,Alt,Ast,SerumBilirubin " & _
                                    ",Comments,common_TestReason.TestReason,ReasonForTestingOther " & _
                                    "FROM client_Bloodwork " & _
                                    "LEFT JOIN common_BloodworkCollectionMethod ON client_Bloodwork.CollectionMethodID = common_BloodworkCollectionMethod.ID " & _
                                    "LEFT JOIN common_TestReason ON client_Bloodwork.ReasonForTestingID = common_TestReason.ID " & _
                                    "WHere client_Bloodwork.ClientID = @parmID "
            RunQueryAddResults(strBlood, 95, csvContents)

            csvContents.Append(lineReturn & lineReturn & lineReturn)
            csvContents.Append("DIAGNOSTIC IMAGE HISTORY" & lineReturn)
            Dim strDiagnotic As String = "SELECT ExamDate,common_XrayView.XrayView,common_XrayArea.XrayArea,common_XrayIndication.XrayIndication, " & _
                                            "common_XrayResult.XrayResult,common_TestReason.TestReason,Findings " & _
                                            "FROM client_DiagnosticImage " & _
                                            "LEFT JOIN common_TestReason ON client_DiagnosticImage.ReasonForTesting = common_TestReason.ID  " & _
                                            "LEFT JOIN common_XrayArea On client_DiagnosticImage.AreaID = common_XrayArea.ID " & _
                                            "LEFT JOIN common_XrayIndication ON client_DiagnosticImage.IndicationID = common_XrayIndication.ID   " & _
                                            "LEFT JOIN common_XrayResult ON client_DiagnosticImage.ResultID = common_XrayResult.ID  " & _
                                            "LEFT JOIN common_XrayView ON client_DiagnosticImage.ViewID = common_XrayView.ID  " & _
                                            "WHERE client_DiagnosticImage.ClientID = @parmID "
            RunQueryAddResults(strDiagnotic, 95, csvContents)


            csvContents.Append(lineReturn & lineReturn & lineReturn)
            csvContents.Append("RISK HISTORY" & lineReturn)
            Dim strRisk As String = "SELECT common_Clinicians.Username,InterviewDate, " & _
                                    "conActive.Value as 'Con w/active TB 2 yrs',ContactActiveTB2YrsNotes As 'Con w/active TB 2 yrs Notes', " & _
                                    "diabetes.Value as 'Diabetes mellitus type 1/2',DiabetesMellitusType1or2Notes as 'Diabetes mellitus type 1/2 Notes', " & _
                                    "renal.Value As 'End-stage renal disease',EndStageRenalDiseaseNotes as 'End-stage renal disease Notes', " & _
                                    "underlying.Value As 'Underlying medical conditions',UnderlyingMedicalonditionsNotes As 'Underlying medical conditions Notes', " & _
                                    "homel.Value As 'Homeless',HomelessNotes As 'Homeless notes', " & _
                                    "crowding.value as 'Overcrowding' ,OverCrowdedHousingNotes as 'Overcrowding notes', " & _
                                    "correc.Value as 'Correctional Fac./time of diag', CorrectionalFacilityAtTimeDiagNotes as 'Correctional Fac./time of diag Notes', " & _
                                    "xray.value as 'Prev abnormal chest xray',PreviousAbnormalChestXrayNotes as 'Prev abnormal chest xray Notes', " & _
                                    "substance.Value as 'Substance Abuse',SubstanceAbuseNotes as 'Substance Abuse Notes', " & _
                                    "tobac.Value as 'Tobacco Smoker', TobaccoSmokerNotes As 'Tobacco Smoker Notes', " & _
                                    "transplan.Value as 'Transplant related immun', TransplantRelatedImmunosuppressionNotes as 'Transplant related immun Notes', " & _
                                    "hiv.Value as 'HIV',HIVNotes as 'HIV Notes', " & _
                                    "aids.Value as 'Aids',AIDSNotes as 'Aids Notes',  " & _
                                    "cancer.Value as 'Cancer', CancerNotes as 'Cancer Notes', " & _
                                    "immuno.Value as 'Immunosuppressive drugs', ImmunosuppressiveDrugsNotes As 'Immunosuppressive drugs notes', " & _
                                    "travel.Value as 'Travel high incidence country',TravelHighIncidenceCountry2yrsNotes as 'Travel high incidence country notes', " & _
                                    "five.Value as 'Age infected <= 5 yrs',AgeWhenInfectedLessThanEqual5yrsNotes as 'Age infected <= 5 yrs notes', " & _
                                    "inact.Value as 'Inactive tb not adequately treated',InactiveDiseaseNotAdequatelyTreatedNotes as 'Inactive tb not adequately treated notes', " & _
                                    "refused.Value as 'LTBI, refused DOP',LTBIRrefusedDOPNotes as 'LTBI, refused DOP Notes',  " & _
                                    "FamilyHistory As 'Family History notes' " & _
                                    "  FROM client_RiskFactors As rf " & _
                                    "  LEFT JOIn common_Clinicians  ON rf.InterviewByID = common_Clinicians.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as conActive On rf.ContactActiveTB2Yrs = conActive.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as diabetes on rf.DiabetesMellitusType1or2 = diabetes.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as renal on rf.EndStageRenalDisease = renal.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as underlying on rf.UnderlyingMedicalonditions = underlying.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as homel on rf.Homeless = homel.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused As crowding on rf.OverCrowdedHousing = crowding.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused As correc on rf.CorrectionalFacilityAtTimeDiag = correc.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused As xray on rf.PreviousAbnormalChestXray = xray.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused As substance on rf.SubstanceAbuse = substance.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused As tobac on rf.TobaccoSmoker = tobac.id " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused As transplan on rf.TransplantRelatedImmunosuppression = transplan.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused As hiv on rf.HIV = hiv.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused As aids on rf.AIDS = aids.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as cancer on rf.Cancer = cancer.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as immuno on rf.ImmunosuppressiveDrugs = immuno.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as travel on rf.TravelHighIncidenceCountry2yrs = travel.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as five on rf.AgeWhenInfectedLessThanEqual5yrs = five.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as inact on rf.InactiveDiseaseNotAdequatelyTreated = inact.ID  " & _
                                    "  LEFT JOIN common_YesNoUnknownRefused as refused on rf.LTBIRrefusedDOP = refused.ID  " & _
                                    " WHERE rf.ClientID = @parmID "
            RunQueryAddResults(strRisk, 95, csvContents)

            csvContents.Append(lineReturn & lineReturn & lineReturn)
            csvContents.Append("IN CONTACT WITH" & lineReturn)
            Dim contacts As String = "SELECT contactProfile.FirstName + ' ' +  contactProfile.LastName as 'Contact Name', FromDate,ToDate,common_ContactType.ContactType as 'Contact Type', " & _
                                    "common_ContactReason.ContactReason as 'Contact Reason',common_ContactRelationship.RelationshipText as 'Relationship', " & _
                                    "common_Community.Community as 'Contact Community',common_ContactPriority.Priority as 'Priority', " & _
                                    "con.Comments,con.ClientID " & _
                                    "  FROM client_ContactTracing as con " & _
                                    "  LEFT JOIN client_Outcome on con.DiagnosisID = client_Outcome.ID  " & _
                                    "  LEFT JOIN common_ContactType On con.ContactTypeID = common_ContactType.ID  " & _
                                    "  LEFT JOIN common_ContactReason on con.ReasonTypeID = common_ContactReason.ID  " & _
                                    "  LEFT JOIN common_ContactRelationship on con.RelationshipID = common_ContactRelationship.ID  " & _
                                    "  LEFT JOIN common_Community on con.CommunityID = common_Community.ID  " & _
                                    "  LEFT JOIN common_ContactPriority on con.PriorityID = common_ContactPriority.ID  " & _
                                    "  LEFT JOIN client_Profile as contactProfile on con.ContactClientID = contactProfile.ID " & _
                                    "  WHERE con.ClientID = @parmID and client_ContactTracing.Active = 'true'"
            RunQueryAddResults(contacts, 95, csvContents)

            csvContents.Append(lineReturn & lineReturn & lineReturn)
            csvContents.Append("LISTED AS CONTACT FROM" & lineReturn)
            Dim identified As String = "SELECT contactProfile.FirstName + ' ' +  contactProfile.LastName as 'Contact Name',FromDate,ToDate,common_ContactType.ContactType as 'Contact Type', " & _
                                        "common_ContactReason.ContactReason as 'Contact Reason',common_ContactRelationship.RelationshipText as 'Relationship', " & _
                                        "common_Community.Community as 'Contact Community',common_ContactPriority.Priority as 'Priority', " & _
                                        "con.Comments,con.ClientID " & _
                                        "  FROM client_ContactTracing as con " & _
                                        "  LEFT JOIN client_Outcome on con.DiagnosisID = client_Outcome.ID  " & _
                                        "  LEFT JOIN common_ContactType On con.ContactTypeID = common_ContactType.ID  " & _
                                        "  LEFT JOIN common_ContactReason on con.ReasonTypeID = common_ContactReason.ID  " & _
                                        "  LEFT JOIN common_ContactRelationship on con.RelationshipID = common_ContactRelationship.ID  " & _
                                        "  LEFT JOIN common_Community on con.CommunityID = common_Community.ID  " & _
                                        "  LEFT JOIN common_ContactPriority on con.PriorityID = common_ContactPriority.ID  " & _
                                        "  LEFT JOIN client_Profile as contactProfile on con.ContactClientID = contactProfile.ID " & _
                                        "  WHERE con.ContactClientID = @parmID and client_ContactTracing.Active = 'true'"
            RunQueryAddResults(identified, 95, csvContents)
            csvContents.Append(lineReturn & lineReturn & lineReturn)

            Dim clientOutcomes = Nothing
            Using db As New TBTracingEntities
                clientOutcomes = (From outcomeQuery In db.client_Outcome _
                              Where outcomeQuery.ClientID = 95 _
                              Order By outcomeQuery.OutcomeDeterminationDate Ascending _
                              Select New With {.ID = outcomeQuery.ID, .OutcomeDeterminationDate = outcomeQuery.OutcomeDeterminationDate, _
                                               .Outcome = outcomeQuery.Outcome, .TBOutcome = outcomeQuery.common_TBOutcome.TBOutcome}).ToList()
            End Using

            If Not IsNothing(clientOutcomes) AndAlso clientOutcomes.Count > 0 Then
                Dim outcomeIteration As Integer = 1

                For Each outcome In clientOutcomes
                    Dim outcomeMsg As String = Nothing
                    If Not IsNothing(outcome.OutcomeDeterminationDate) Then
                        outcomeMsg = "OUTCOME #" & outcomeIteration.ToString() & " - " & objDataHelper.convertDateToStringText(outcome.OutcomeDeterminationDate)
                    Else
                        outcomeMsg = "OUTCOME #" & outcomeIteration.ToString()

                    End If
                    csvContents.Append(outcomeMsg & lineReturn)


                    Dim strOutcome As String = "SELECT common_TBOutcome.TBOutcome As 'Outcome Desc', " & _
                                        "OutcomeDeterminationDate As 'Determination Date', common_TBTypes.TBType As 'TB Type', " & _
                                        "common_Clinicians.Username as 'Determined By', Comments " & _
                                        "  FROM client_Outcome " & _
                                        "  LEFT JOIN common_TBTypes on client_Outcome.TBType = common_TBTypes.ID  " & _
                                        "  LEFT JOIN common_TBOutcome ON client_Outcome.Outcome = common_TBOutcome.ID  " & _
                                        "  LEFT JOIN common_Clinicians ON client_Outcome.DeterminedByID = common_Clinicians.ID  " & _
                                        "Where client_Outcome.ID = @parmID"


                    RunQueryAddResults(strOutcome, outcome.ID, csvContents)

                    If Not IsNothing(outcome.Outcome) AndAlso (outcome.Outcome = My.Settings.activeTBOutcome Or outcome.Outcome = My.Settings.latentTBOutcome) Then

                        Dim strOutcomeTreatments As String = "SELECT common_TreatmentMode.ModeTreatment As 'Mode of Treatment', common_TreatmentAdherence.Adherence,client_OutcomeTreatment.Comments, " & _
                                                                "common_TBOutcome.TBOutcome,ClientDateDate as 'Client Death Date', " & _
                                                                "ClientDeathTBCause as 'TB Cause of Death',ClientDeathTBContribute as 'TB Contributed to Death', " & _
                                                                "ClientDeathTBNoContribute as 'TB Did not contribute to Death' " & _
                                                                "FROM client_OutcomeTreatment " & _
                                                                "INNER JOIN client_Outcome On client_OutcomeTreatment.ID = client_Outcome.TreatmentID " & _
                                                                "LEFT JOIN common_TreatmentMode on client_OutcomeTreatment.TreatmentModeID = common_TreatmentMode.ID " & _
                                                                "LEFT JOIN common_TreatmentAdherence ON client_OutcomeTreatment.AdherenceID = common_TreatmentAdherence.ID " & _
                                                                "LEFT JOIN common_TBOutcome ON client_OutcomeTreatment.OutcomeID = common_TBOutcome.ID  " & _
                                                                "WHERE client_Outcome.ID = @parmID " & _
                                                                "ORDER by client_Outcome.OutcomeDeterminationDate "

                        Dim treatmentsCsv As List(Of String) = RunQueryReturnCSV(strOutcomeTreatments, outcome.ID)
                        If Not IsNothing(treatmentsCsv) AndAlso treatmentsCsv.Count > 1 Then
                            csvContents.Append(", Treatment Details" & lineReturn)
                            For Each treatmentCsv In treatmentsCsv
                                csvContents.Append(" , , " & treatmentCsv & lineReturn)
                            Next

                            'Get any prescribed medications.
                            Dim strMedication As String = "SELECT common_Medication.MedicationName as 'Medication',StartDate as 'Start Date',EndDate as 'End Date',Doseage, " & _
                                                            "NumberDoses, common_MedicationStatus.MedicationStatus as 'Status', " & _
                                                            "common_MedicationFrequency.Frequency,  Notes " & _
                                                            "FROM client_OutcomeTreatmentRegimen " & _
                                                            "LEFT JOIN common_MedicationStatus on client_OutcomeTreatmentRegimen.StatusID = common_MedicationStatus.ID  " & _
                                                            "LEFT JOIN common_MedicationFrequency on client_OutcomeTreatmentRegimen.FrequencyID = common_MedicationFrequency.ID  " & _
                                                            "LEFT JOIN common_Medication on client_OutcomeTreatmentRegimen.MedicationID = common_Medication.ID  " & _
                                                            "WHERE   client_OutcomeTreatmentRegimen.OutcomeID = @parmID "

                            Dim medCSV As List(Of String) = RunQueryReturnCSV(strMedication, outcome.ID)

                            If Not IsNothing(medCSV) AndAlso medCSV.Count > 1 Then
                                csvContents.Append(",, Medications" & lineReturn)
                                For Each med In medCSV
                                    csvContents.Append(",,," & med & lineReturn)
                                Next
                            End If


                            Dim strDOT As String = "select client_OutcomeTreatmentDOT.DOTDate, " & _
                                                            "CASE WHEN client_OutcomeTreatmentDOT.ClientNoShow =1 Then 'No Show'  ELSE '' END As clientNoShow, " & _
                                                            "STUFF((SELECT ','+ commonSymptoms.Symptom " & _
                                                            "          FROM client_OutcomeTreatmentDOTSymptoms As clientSymptoms " & _
                                                            "           INNER JOIN common_Symptoms as commonSymptoms ON clientSymptoms.symptomID = commonSymptoms.ID " & _
                                                            "           WHERE client_OutcomeTreatmentDOT.ID = clientSymptoms.dotID " & _
                                                            "           FOR XML PATH(''), TYPE).value('.','VARCHAR(max)'), 1, 1, '') As symptomList, " & _
                                                            " 	STUFF((SELECT ','+ commonMeds.MedicationName " & _
                                                            "           FROM client_OutcomeMedications As clientMedications " & _
                                                            "           INNER JOIN common_Medication as commonMeds ON clientMedications.medID = commonMeds.ID " & _
                                                            "           WHERE client_OutcomeTreatmentDOT.ID = clientMedications.dotID " & _
                                                            "           FOR XML PATH(''), TYPE).value('.','VARCHAR(max)'), 1, 1, '') As medicationList " & _
                                                            "FROM client_Outcome " & _
                                                            "INNER JOIN client_OutcomeTreatment ON client_Outcome.TreatmentID = client_OutcomeTreatment.ID " & _
                                                            "INNER JOIN client_OutcomeTreatmentDOT ON client_OutcomeTreatment.ID = client_OutcomeTreatmentDOT.TreatmentID " & _
                                                            "Where client_Outcome.ID = @parmID and client_OutcomeTreatmentDOT.Active = 'true' " & _
                                                            " Order By client_OutcomeTreatmentDOT.DOTDate desc "

                            Dim dotCSV As List(Of String) = RunQueryReturnCSV(strDOT, outcome.ID)
                            If Not IsNothing(dotCSV) AndAlso dotCSV.Count > 1 Then
                                csvContents.Append(" ,, DOT History" & lineReturn)
                                For Each dotLine In medCSV
                                    csvContents.Append(" , , ," & dotLine & lineReturn)
                                Next
                            End If

                            'Else
                            '    csvContents.Append(lineReturn & "No treatments listed")
                        End If
                    End If
                    csvContents.Append(lineReturn & lineReturn & lineReturn)
                    outcomeIteration = outcomeIteration + 1
                Next
            Else
                'csvContents.Append(lineReturn & lineReturn & "No Client Outcomes")
            End If

            context.Response.ContentType = "application/text"
            context.Response.AppendHeader("content-disposition", "attachment;fileName = ClientSummary.csv")
            context.Response.Write(csvContents.ToString())

        Catch ex As Exception
            LogHelper.LogError("Error outputtings CSV file", "DataExtractHandler.ashx", ex)
        End Try
    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

    Private Function RunQueryReturnCSV(ByRef strSql As String, ByRef parmID As Integer) As List(Of String)
        Try
            Dim results As List(Of String) = New List(Of String)
            Dim constr As String = ConfigurationManager.ConnectionStrings("TBConnection").ConnectionString
            Dim strResult As String = Nothing
            Dim strLine As StringBuilder = New StringBuilder()
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand(strSql)
                    Dim prmClientID As New SqlParameter("@parmID", parmID)
                    cmd.Parameters.Add(prmClientID)

                    Using sda As New SqlDataAdapter()
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        Using dt As New DataTable()
                            sda.Fill(dt)

                            For Each column As DataColumn In dt.Columns
                                'Add the Header row for CSV file.
                                strLine.Append(column.ColumnName & ",")
                            Next
                            results.Add(strLine.ToString())

                            For Each row As DataRow In dt.Rows
                                strResult = Nothing
                                strLine.Clear()
                                For Each column As DataColumn In dt.Columns
                                    'Add the Data rows.
                                    If column.DataType = System.Type.GetType("System.DateTime") Then
                                        Dim objDateTime As Nullable(Of DateTime) = Nothing
                                        If Not IsDBNull(row(column.ColumnName)) Then
                                            objDateTime = row(column.ColumnName)
                                        End If

                                        If Not IsNothing(objDateTime) Then
                                            strLine.Append(objDataHelper.convertDateToStringText(objDateTime) & ",")
                                        Else
                                            strLine.Append(" -- ,")
                                        End If
                                    ElseIf column.DataType = System.Type.GetType("System.Date") Then
                                        Dim objDateTime As Nullable(Of Date) = Nothing
                                        If Not IsDBNull(row(column.ColumnName)) Then
                                            objDateTime = row(column.ColumnName)
                                        End If

                                        If Not IsNothing(objDateTime) Then
                                            strLine.Append(objDataHelper.convertDateToStringText(objDateTime) & ",")
                                        Else
                                            strLine.Append(" -- ,")
                                        End If
                                    Else
                                        strResult = row(column.ColumnName).ToString()
                                        If Not String.IsNullOrEmpty(strResult) Then
                                            strLine.Append(strResult.Replace(",", ";") & ",")
                                        Else
                                            strLine.Append(" -- ,")
                                        End If

                                        'results.Append & ",")
                                    End If
                                Next
                                results.Add(strLine.ToString())
                            Next
                        End Using
                    End Using
                End Using
            End Using
            Return results
        Catch ex As Exception
            LogHelper.LogError("Error getting data for client report.", "DataExtractHandler", ex)
        End Try
    End Function


    Private Sub RunQueryAddResults(ByRef strSql As String, ByRef parmID As Integer, ByRef results As StringBuilder)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("TBConnection").ConnectionString
            Dim strResult As String = Nothing
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand(strSql)
                    Dim prmClientID As New SqlParameter("@parmID", parmID)
                    cmd.Parameters.Add(prmClientID)

                    Using sda As New SqlDataAdapter()
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        Using dt As New DataTable()
                            sda.Fill(dt)
                            'Append blank column
                            results.Append(",")
                            For Each column As DataColumn In dt.Columns
                                'Add the Header row for CSV file.
                                results.Append(column.ColumnName & ",")
                            Next
                            results.Append(lineReturn)

                            For Each row As DataRow In dt.Rows
                                'Add blank column for formatting.
                                results.Append(",")
                                strResult = Nothing
                                For Each column As DataColumn In dt.Columns
                                    'Add the Data rows.
                                    If column.DataType = System.Type.GetType("System.DateTime") Then
                                        Dim objDateTime As Nullable(Of DateTime) = Nothing
                                        If Not IsDBNull(row(column.ColumnName)) Then
                                            objDateTime = row(column.ColumnName)
                                        End If

                                        If Not IsNothing(objDateTime) Then
                                            results.Append(objDataHelper.convertDateToStringText(objDateTime) & ",")
                                        Else
                                            results.Append(" -- ,")
                                        End If
                                    ElseIf column.DataType = System.Type.GetType("System.Date") Then
                                        Dim objDateTime As Nullable(Of Date) = Nothing
                                        If Not IsDBNull(row(column.ColumnName)) Then
                                            objDateTime = row(column.ColumnName)
                                        End If

                                        If Not IsNothing(objDateTime) Then
                                            results.Append(objDataHelper.convertDateToStringText(objDateTime) & ",")
                                        Else
                                            results.Append(" -- ,")
                                        End If
                                    Else
                                        strResult = row(column.ColumnName).ToString()
                                        If Not String.IsNullOrEmpty(strResult) Then
                                            results.Append(strResult.Replace(",", ";") & ",")
                                        Else
                                            results.Append(" -- ,")
                                        End If

                                        'results.Append & ",")
                                    End If
                                Next
                                results.Append(lineReturn)
                            Next
                        End Using
                    End Using
                End Using
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting data for client report.", "DataExtractHandler", ex)
        End Try
    End Sub


    'End Using

    'Dim oXL As Excel.Application
    'Dim clientWorkbook As Excel.Workbook
    'Dim clientDemoSheet As Excel.Worksheet
    ''Dim clientSkinTestSheet As Excel.Worksheet

    'Dim oRng As Excel.Range

    'oXL = CreateObject("Excel.Application")

    '' Get a new workbook.
    'clientWorkbook = oXL.Workbooks.Add

    'clientDemoSheet = CType(clientWorkbook.Worksheets.Add(), Excel.Worksheet)
    'clientDemoSheet.Name = "Client Demographic"

    'clientDemoSheet.Columns.HorizontalAlignment = HorizontalAlign.Left




    'clientDemoSheet.Cells(1, 1) = "First Name"
    'clientDemoSheet.Cells(1, 2) = "Last Name"
    'clientDemoSheet.Cells(1, 3) = "MCP"
    'clientDemoSheet.Cells(1, 4) = "Case Number"

    'clientDemoSheet.Cells(2, 1) = "Jason"
    'clientDemoSheet.Cells(2, 2) = "Hoskins"
    'clientDemoSheet.Cells(2, 3) = "123"
    'clientDemoSheet.Cells(2, 4) = "JH 1234"


    'context.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    'context.Response.Clear()
    'context.Response.ClearContent()
    'context.Response.ClearHeaders()
    'context.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    'context.Response.AppendHeader("content-disposition", "attachment;fileName = ClientSummary.xls")

    'csvContents.Append("First Name,Last Name,Case Number,MCP,Status")

    'Using db As New TBTracingEntities
    '    Dim demoGraphic = (From demo In db.client_Demographic _
    '                                            Where demo.Active = True _
    '                                            And demo.ClientID = 95 _
    '                                            Select New With {.firstName = demo.FirstName,
    '                                                              .lastName = demo.LastName,
    '                                                             .caseNumber = demo.CaseNumber,
    '                                                             .hcn = demo.HealthCareNumber,
    '                                                             .status = demo.client_Profile.common_Status.Status,
    '                                                             .dob = demo.DateofBirth,
    '                                                             .gender = demo.common_Gender.Gender}).FirstOrDefault()




    '    If Not IsNothing(demoGraphic) Then
    '        csvContents.Append(demoGraphic.firstName.Replace(",", ";") & ",")
    '        csvContents.Append(demoGraphic.lastName.Replace(",", ";") & ",")
    '        csvContents.Append(demoGraphic.caseNumber.Replace(",", ";") & ",")
    '        csvContents.Append(demoGraphic.hcn.Replace(",", ";") & ",")
    '        csvContents.Append(demoGraphic.status.Replace(",", ";") & ",")

    '    End If




    'End Using
End Class