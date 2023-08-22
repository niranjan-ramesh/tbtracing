Imports System.IO
Imports System.Security.Cryptography
Imports System.Data.SqlClient
Imports ClosedXML.Excel
Imports System.Threading

Public Class ClientDemographic
    Inherits System.Web.UI.Page

    Private intClientID As Nullable(Of Integer)
    Private selectedEthnicities As List(Of Integer)

#Region "Page Load/Init"
    Private Sub ClientDemographic_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        End If

        If IsNothing(intClientID) Then
            DemographicFormView.InsertItemTemplate = DemographicFormView.EditItemTemplate
        Else
            DemographicFormView.EditItemTemplate = DemographicFormView.EditItemTemplate
            DemographicFormView.DefaultMode = FormViewMode.Edit
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsNothing(Session.Item("DemoSuccess")) Then
            'Display success panel.
            pnlSuccess.Visible = True
            Session.Remove("DemoSuccess")
        Else
            pnlSuccess.Visible = False
        End If
    End Sub
#End Region

#Region "Add Demographic"
    Public Sub DemographicFormView_InsertItem()
        Try
            Dim item = New client_DemographicModel()
            TryUpdateModel(item)
            validateInput(item)
            If ModelState.IsValid Then
                ApplyRules(item)
                'Manually bind list items
                Dim ethnicities As CheckBoxList = DemographicFormView.FindControl("cblEthnicity")
                item.selectedCBEthnicity = New DataHelper().getSelectedCheckBoxesAsInteger(ethnicities)
                Dim clientDA As IClientDA = New ClientDAImpl()
                Dim id As Integer = clientDA.AddClientDemographic(item)

                If Not String.IsNullOrEmpty(Request.Item("sourceclientid")) AndAlso IsNumeric(Request.Item("sourceclientid")) Then
                    Session.Add("ContactSuccess", "Client " & item.demoData.FirstName & " " & item.demoData.LastName & " successfully added.  Find this client using search filters.")
                    Response.Redirect(String.Format("~/ClientPages/ContactTracingSearch.aspx?clientid={0}", Request.Params("sourceclientid")), False)
                    HttpContext.Current.ApplicationInstance.CompleteRequest()
                Else
                    Response.Redirect(String.Format("~/ClientPages/ClientDemographic.aspx?clientid={0}", id.ToString()), False)
                    HttpContext.Current.ApplicationInstance.CompleteRequest()
                End If
            End If
        Catch ex As Exception
            LogHelper.LogError("Error inserting client demographic", "ClientDemographic.aspx", ex)
            Session.Add("ErrorMessage", "Error With Client Demographic.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

#Region "Update Item"
    Public Sub DemographicFormView_UpdateItem()
        Try
            Dim item As client_DemographicModel = New client_DemographicModel()
            TryUpdateModel(item)
            validateInput(item)
            If ModelState.IsValid Then
                ApplyRules(item)
                item.demoData.ClientID = intClientID
                Dim ethnicities As CheckBoxList = DemographicFormView.FindControl("cblEthnicity")
                item.selectedCBEthnicity = New DataHelper().getSelectedCheckBoxesAsInteger(ethnicities)

                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateClientDemographic(item)
                Session.Add("DemoSuccess", "True")
                Dim strEndPoint As String = String.Format("~/ClientPages/ClientDemographic.aspx?clientid={0}", intClientID.ToString())
                Response.Redirect(strEndPoint, False)
                Context.ApplicationInstance.CompleteRequest()        
            End If
        Catch ex As Exception
            LogHelper.LogError("Error updating client demographic.", "ClientDemographic.aspx", ex)
            Session.Add("ErrorMessage", "Error With Client Demographic.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

#Region "Get Demographic"
    Public Function DemographicFormView_GetItem() As TBTracing.client_DemographicModel
        Dim clientID As Nullable(Of Integer) = Request.Item("clientid")
        Dim pageModel As client_DemographicModel = New client_DemographicModel()

        Using db As New TBTracingEntities
            'pageModel.statusID = db.client_Profile.Find()

            'Dim profileData As client_Profile = db.client_Profile.Where(Function(p) p.ID = intClientID).FirstOrDefault()

            Dim demoData As client_Demographic = (From demoQuery In db.client_Demographic _
                                                 Where demoQuery.ClientID = intClientID _
                                                 And demoQuery.Active = True).FirstOrDefault()

            Dim age As Nullable(Of Integer) = Nothing
            If Not IsNothing(demoData.DateofBirth) Then
                pageModel.strAge = New DataHelper().calculateAgeFromBirthday(demoData.DateofBirth)
            End If

            pageModel.demoData = demoData
            pageModel.statusID = demoData.client_Profile.StatusID
            pageModel.employee = demoData.client_Profile.Employee
            pageModel.idConfirmed = demoData.client_Profile.Confirmed

            If Not IsNothing(pageModel.demoData) Then
                selectedEthnicities = pageModel.demoData.common_Ethnicity.Select(Function(p) p.ID).ToList()
            End If
        End Using
        Return pageModel
    End Function
#End Region

#Region "Checkbox List Populate"
    Protected Sub cblEthnicity_DataBound(sender As Object, e As EventArgs)
        If Not IsNothing(selectedEthnicities) Then
            Dim cblEthnicities As CheckBoxList = DemographicFormView.FindControl("cblEthnicity")

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
        End If
    End Sub
#End Region

#Region "Form View Binding"
    Protected Sub DemographicFormView_DataBound(sender As Object, e As EventArgs) Handles DemographicFormView.DataBound
        Try
            Dim statusRadioButtons As RadioButtonList = CType(DemographicFormView.FindControl("rblStatus"), RadioButtonList)
            If Not IsNothing(statusRadioButtons) Then
                If String.IsNullOrEmpty(statusRadioButtons.SelectedValue) Then
                    statusRadioButtons.SelectedValue = My.Settings.defaultStatus
                End If
            End If
        Catch ex As Exception
            LogHelper.LogError("Error setting client status", "ClientDemographic.aspx", ex)
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub

    Protected Sub DemographicFormView_DataBound1(sender As Object, e As EventArgs)
        Dim objAddButton As LinkButton = DemographicFormView.FindControl("addButton")
        Dim objUpdateButton As LinkButton = DemographicFormView.FindControl("updateButton")
        Dim objDLButton As LinkButton = DemographicFormView.FindControl("dlButton")
        Dim historyLink As HyperLink = CType(DemographicFormView.FindControl("lnkHistory"), HyperLink)

        If IsNothing(intClientID) Then
            objAddButton.Visible = True
            objUpdateButton.Visible = False
            objDLButton.Visible = False
        Else
            objAddButton.Visible = False
            objUpdateButton.Visible = True
            objDLButton.Visible = True
        End If

        historyLink.NavigateUrl = String.Format(historyLink.NavigateUrl, intClientID.ToString())
    End Sub
#End Region

#Region "Excel Download"
    Protected Sub dlButton_Click(sender As Object, e As EventArgs)
        Try
            If Not IsNothing(intClientID) Then
                Dim fileName As String = "ClientData-"

                Using db As New TBTracingEntities
                    Dim result = (From query In db.client_Demographic _
                                 Where query.ClientID = intClientID _
                                 And query.Active = True).FirstOrDefault().CaseNumber

                    If Not String.IsNullOrEmpty(result) Then
                        fileName = fileName & result & ".xlsx"
                    Else
                        fileName = fileName & "clientid" & ClientID.ToString() & ".xlsx"
                    End If

                End Using

                Try
                    Using wb As New XLWorkbook()
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

                        Dim dtDemographic As DataTable = New DataTable()
                        PopulateDataTable(demoSql, intClientID, dtDemographic)
                        AddDatatableToWorkSheet(dtDemographic, "Demographics", wb)

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

                        Dim dtSymptoms As DataTable = New DataTable()
                        PopulateDataTable(strSymptoms, intClientID, dtSymptoms)
                        AddDatatableToWorkSheet(dtSymptoms, "Symptoms", wb)

                        Dim strSkinTest As String = "select common_InjectionRoute.Route, client_SkinTest.DatePlaced, client_SkinTest.DateRead, " & _
                                                    "client_SkinTest.Iduration,client_SkinTest.XrayRecommended, client_Skintest.IGRARecommended, " & _
                                                    "client_SkinTest.FollowUpTestRequired, client_Skintest.ReadByText, " & _
                                                    "common_SkinTestResult.SkinTestResult " & _
                                                    "from client_SkinTest  " & _
                                                    "LEFT JOIN common_InjectionRoute ON client_SkinTest.RouteID = common_InjectionRoute.ID " & _
                                                    "LEFT JOIN common_TestReason ON client_SkinTest.TestReasonID = common_TestReason.ID  " & _
                                                    "LEFT JOIN common_SkinTestResult ON client_SkinTest.ResultID = common_SkinTestResult.ID  " & _
                                                    "WHERE client_SkinTest.ClientID = @parmID " & _
                                                    "ORDER BY client_SkinTest.DatePlaced Desc "

                        Dim dtSkinTest As DataTable = New DataTable()
                        PopulateDataTable(strSkinTest, intClientID, dtSkinTest)
                        AddDatatableToWorkSheet(dtSkinTest, "Skin Test History", wb)

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

                        Dim dtSputum As DataTable = New DataTable()
                        PopulateDataTable(strSputim, intClientID, dtSputum)
                        AddDatatableToWorkSheet(dtSputum, "Sputum History", wb)


                        Dim strIgra As String = "SELECT CollectionDate,ResultDate," & _
                                    "common_IGRAResult.IGRATestResult, " & _
                                    "common_TestReason.TestReason, Comments " & _
                                    "FROM client_IGRA " & _
                                    "LEFT JOIN common_IGRAResult on client_IGra.ResultID = common_IGRAResult.ID " & _
                                    "LEFT JOIN common_TestReason on client_IGRA.ReasonForTestingID = common_TestReason.ID " & _
                                    "WHERE client_IGRA.ClientID = @parmID "

                        Dim dtIGRA As DataTable = New DataTable()
                        PopulateDataTable(strIgra, intClientID, dtIGRA)
                        AddDatatableToWorkSheet(dtIGRA, "IGRA History", wb)

                        Dim strBlood As String = "SELECT CollectedDate,ResultDate,common_BloodworkCollectionMethod.CollectionMethod " & _
                                                ",CollectedBy,Alt,Ast,SerumBilirubin " & _
                                                ",Comments,common_TestReason.TestReason,ReasonForTestingOther " & _
                                                "FROM client_Bloodwork " & _
                                                "LEFT JOIN common_BloodworkCollectionMethod ON client_Bloodwork.CollectionMethodID = common_BloodworkCollectionMethod.ID " & _
                                                "LEFT JOIN common_TestReason ON client_Bloodwork.ReasonForTestingID = common_TestReason.ID " & _
                                                "WHere client_Bloodwork.ClientID = @parmID "

                        Dim dtBloodwork As DataTable = New DataTable()
                        PopulateDataTable(strBlood, intClientID, dtBloodwork)
                        AddDatatableToWorkSheet(dtBloodwork, "Bloodwork History", wb)

                        Dim strDiagnotic As String = "SELECT ExamDate,common_XrayView.XrayView,common_XrayArea.XrayArea,common_XrayIndication.XrayIndication, " & _
                                            "common_XrayResult.XrayResult,common_TestReason.TestReason,Findings " & _
                                            "FROM client_DiagnosticImage " & _
                                            "LEFT JOIN common_TestReason ON client_DiagnosticImage.ReasonForTesting = common_TestReason.ID  " & _
                                            "LEFT JOIN common_XrayArea On client_DiagnosticImage.AreaID = common_XrayArea.ID " & _
                                            "LEFT JOIN common_XrayIndication ON client_DiagnosticImage.IndicationID = common_XrayIndication.ID   " & _
                                            "LEFT JOIN common_XrayResult ON client_DiagnosticImage.ResultID = common_XrayResult.ID  " & _
                                            "LEFT JOIN common_XrayView ON client_DiagnosticImage.ViewID = common_XrayView.ID  " & _
                                            "WHERE client_DiagnosticImage.ClientID = @parmID "

                        Dim dtDiagnostic As DataTable = New DataTable()
                        PopulateDataTable(strDiagnotic, intClientID, dtDiagnostic)
                        AddDatatableToWorkSheet(dtDiagnostic, "Diagnostic Imagine History", wb)


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

                        Dim dtRisks As DataTable = New DataTable()
                        PopulateDataTable(strRisk, intClientID, dtRisks)
                        AddDatatableToWorkSheet(dtRisks, "Risk History", wb)

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
                                                "  WHERE con.ClientID = @parmID and con.Active = 'true'"

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
                                                    "  WHERE con.ContactClientID = @parmID and con.Active = 'true'"

                        Dim dtContactsSrc As DataTable = New DataTable()
                        Dim dtContactsEnd As DataTable = New DataTable()

                        PopulateDataTable(contacts, intClientID, dtContactsSrc)
                        PopulateDataTable(identified, intClientID, dtContactsEnd)

                        Dim wsContacts = wb.Worksheets.Add("Contact History")
                        'Dim wsContacts = AddDatatableToWorkSheet(dtContactsSrc, "Contact History", wb)

                        AppendDataTableToWorkSheet(wsContacts, dtContactsSrc, 1, 1, "Identified as Contact By")

                        Dim offset As Integer = dtContactsSrc.Rows.Count + 5
                        AppendDataTableToWorkSheet(wsContacts, dtContactsEnd, offset, 1, "Identified as Contact By")

                        Dim clientOutcomes = Nothing
                        Using db As New TBTracingEntities
                            clientOutcomes = (From outcomeQuery In db.client_Outcome _
                                          Where outcomeQuery.ClientID = intClientID _
                                          Order By outcomeQuery.OutcomeDeterminationDate Ascending _
                                          Select New With {.ID = outcomeQuery.ID, .OutcomeDeterminationDate = outcomeQuery.OutcomeDeterminationDate, _
                                                           .Outcome = outcomeQuery.Outcome, .TBOutcome = outcomeQuery.common_TBOutcome.TBOutcome}).ToList()
                        End Using

                        If Not IsNothing(clientOutcomes) AndAlso clientOutcomes.Count > 0 Then
                            Dim wsOutCome = wb.AddWorksheet("Outcomes & Treatment")
                            Dim outcomeIteration As Integer = 1
                            Dim objDataHelper As DataHelper = New DataHelper()
                            offset = 1

                            For Each outcome In clientOutcomes
                                Dim outcomeMsg As String = Nothing
                                If Not IsNothing(outcome.OutcomeDeterminationDate) Then
                                    outcomeMsg = "OUTCOME #" & outcomeIteration.ToString() & " - " & objDataHelper.convertDateToStringText(outcome.OutcomeDeterminationDate)
                                Else
                                    outcomeMsg = "OUTCOME #" & outcomeIteration.ToString()
                                End If

                                Dim strOutcome As String = "SELECT common_TBOutcome.TBOutcome As 'Outcome Desc', " & _
                                                    "OutcomeDeterminationDate As 'Determination Date', common_TBTypes.TBType As 'TB Type', " & _
                                                    "common_Clinicians.Username as 'Determined By'," & _
                                                    "ClientDeathDate as 'Client Death Date', " & _
                                                    "ClientDeathTBCause as 'TB Cause of Death',ClientDeathTBContribute as 'TB Contributed to Death', " & _
                                                     "ClientDeathTBNoContribute as 'TB Did not contribute to Death', Comments  " & _
                                                    "  FROM client_Outcome " & _
                                                    "  LEFT JOIN common_TBTypes on client_Outcome.TBType = common_TBTypes.ID  " & _
                                                    "  LEFT JOIN common_TBOutcome ON client_Outcome.Outcome = common_TBOutcome.ID  " & _
                                                    "  LEFT JOIN common_Clinicians ON client_Outcome.DeterminedByID = common_Clinicians.ID  " & _
                                                    "Where client_Outcome.ID = @parmID"

                                Dim dtOutcome As DataTable = New DataTable()
                                PopulateDataTable(strOutcome, outcome.ID, dtOutcome)

                                AppendDataTableToWorkSheet(wsOutCome, dtOutcome, offset, 1, outcomeMsg)
                                offset = offset + dtOutcome.Rows.Count + 2

                                If Not IsNothing(outcome.Outcome) AndAlso (outcome.Outcome = My.Settings.activeTBOutcome Or outcome.Outcome = My.Settings.latentTBOutcome) Then

                                    Dim strOutcomeTreatments As String = "SELECT common_TreatmentMode.ModeTreatment As 'Mode of Treatment', common_TreatmentAdherence.Adherence,client_OutcomeTreatment.Comments, " & _
                                                                            "common_TBOutcome.TBOutcome " & _
                                                                            "FROM client_OutcomeTreatment " & _
                                                                            "INNER JOIN client_Outcome On client_OutcomeTreatment.ID = client_Outcome.TreatmentID " & _
                                                                            "LEFT JOIN common_TreatmentMode on client_OutcomeTreatment.TreatmentModeID = common_TreatmentMode.ID " & _
                                                                            "LEFT JOIN common_TreatmentAdherence ON client_OutcomeTreatment.AdherenceID = common_TreatmentAdherence.ID " & _
                                                                            "LEFT JOIN common_TBOutcome ON client_OutcomeTreatment.OutcomeID = common_TBOutcome.ID  " & _
                                                                            "WHERE client_Outcome.ID = @parmID " & _
                                                                            "ORDER by client_Outcome.OutcomeDeterminationDate "

                                    Dim dtTreatment As DataTable = New DataTable()
                                    PopulateDataTable(strOutcomeTreatments, outcome.ID, dtTreatment)
                                    If Not IsNothing(dtTreatment) AndAlso dtTreatment.Rows.Count > 0 Then
                                        AppendDataTableToWorkSheet(wsOutCome, dtTreatment, offset, 2, "Treatment")
                                        offset = offset + dtTreatment.Rows.Count + 2
                                    End If

                                    Dim strMedication As String = "SELECT common_Medication.MedicationName as 'Medication',StartDate as 'Start Date',EndDate as 'End Date',Doseage, " & _
                                                                    "NumberDoses, common_MedicationStatus.MedicationStatus as 'Status', " & _
                                                                    "common_MedicationFrequency.Frequency,  Notes " & _
                                                                    "FROM client_OutcomeTreatmentRegimen " & _
                                                                    "LEFT JOIN common_MedicationStatus on client_OutcomeTreatmentRegimen.StatusID = common_MedicationStatus.ID  " & _
                                                                    "LEFT JOIN common_MedicationFrequency on client_OutcomeTreatmentRegimen.FrequencyID = common_MedicationFrequency.ID  " & _
                                                                    "LEFT JOIN common_Medication on client_OutcomeTreatmentRegimen.MedicationID = common_Medication.ID  " & _
                                                                    "WHERE   client_OutcomeTreatmentRegimen.OutcomeID = @parmID "

                                    Dim dtMed As DataTable = New DataTable()
                                    PopulateDataTable(strMedication, outcome.ID, dtMed)
                                    If Not IsNothing(dtMed) AndAlso dtMed.Rows.Count > 0 Then
                                        AppendDataTableToWorkSheet(wsOutCome, dtMed, offset, 2, "Med History")
                                        offset = offset + dtMed.Rows.Count + 2
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

                                    Dim dtDOT As DataTable = New DataTable()
                                    PopulateDataTable(strDOT, outcome.ID, dtDOT)
                                    If Not IsNothing(dtDOT) AndAlso dtDOT.Rows.Count > 0 Then
                                        AppendDataTableToWorkSheet(wsOutCome, dtDOT, offset, 2, "DOT History")
                                        offset = offset + dtDOT.Rows.Count + 2
                                    End If


                                    offset = offset + 2
                                Else
                                    offset = offset + 2
                                End If
                            Next
                        End If

                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                        Dim headerDisposition As String = "attachment;filename=" & fileName
                        Response.AddHeader("content-disposition", headerDisposition)

                        Using MyMemoryStream As New MemoryStream()
                            wb.SaveAs(MyMemoryStream)
                            MyMemoryStream.WriteTo(Context.Response.OutputStream)
                            'Response.Flush()
                            'Response.End()
                            HttpContext.Current.Response.Flush()
                            HttpContext.Current.Response.SuppressContent = True
                            HttpContext.Current.ApplicationInstance.CompleteRequest()

                        End Using
                    End Using
                    'Catch endEx As ThreadAbortException
                    '    'DO Nothing
                Catch ex As Exception
                    LogHelper.LogError("Error creating XLS file.", "ClientExcelExtract", ex)
                    Session.Add("ErrorMessage", "Error Retrieving Client X-Ray Test")
                    Response.Redirect("~/ErrorPage.aspx", False)
                End Try
            Else
                'Response.ContentType = "text/plain"
                'Response.Write("Invalid client id")
            End If

        Catch ex As Exception
            LogHelper.LogError("Error setting client status", "ClientDemographic.aspx", ex)
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

#Region "Excel Helpers"
    Private Function AddDatatableToWorkSheet(ByRef dt As DataTable, ByVal wsName As String, ByRef wb As XLWorkbook) As IXLWorksheet
        Try
            Dim ws = wb.Worksheets.Add(dt, wsName)
            Dim rngTable = ws.Range("A1:Z1")
            rngTable.Style.Font.Bold = True
            'rngTable.Style.Fill.BackgroundColor = XLColor.LightGray
            ws.Tables.FirstOrDefault().ShowAutoFilter = False
            Return ws
        Catch ex As Exception
            LogHelper.LogError("Error adding datatable to Excel", "ClientExcelExtract", ex)
            Throw ex
        End Try
    End Function

    Private Sub AppendDataTableToWorkSheet(ByRef ws As IXLWorksheet, ByRef dt As DataTable, ByVal rowOffSet As Integer, ByVal colOffSet As Integer, ByVal headerText As String)
        Try
            ws.Cell(rowOffSet, colOffSet).Value = headerText
            ws.Cell(rowOffSet, colOffSet).Style.Font.Bold = True
            Dim rangeWithData = ws.Cell(rowOffSet + 1, colOffSet).InsertTable(dt)
            rangeWithData.ShowAutoFilter = False
            If colOffSet > 1 Then
                rangeWithData.Row(1).Style.Fill.BackgroundColor = XLColor.LightGray
            End If
            'ws.Cell(1, 1).InsertTable()
        Catch ex As Exception
            LogHelper.LogError("Error appending rows", "ClientExcelExtract", ex)
            Throw ex
        End Try
    End Sub

    Private Sub PopulateDataTable(ByRef strSql As String, ByRef parmID As Integer, ByRef results As DataTable)
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
                        sda.Fill(results)

                    End Using
                End Using
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting data for client report.", "DataExtractHandler", ex)
            Throw ex
        End Try
    End Sub
#End Region

#Region "Validation Logic"
    Private Sub validateInput(ByVal objClient As client_DemographicModel)

        Try
            Dim db As IClientDA = New ClientDAImpl()
            Dim exists As Boolean = db.checkForDuplicateHCN(intClientID, objClient.demoData.HealthCareNumber)

            If exists Then
                ModelState.AddModelError("Dup Error", "Client already exists with this Healthcare Number. ")
            End If
        Catch ex As Exception
            LogHelper.LogError("Error valdating demographic", "ClientDemographic.aspx", ex)
            Session.Add("ErrorMessage", "Error saving client demographic.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

#Region "Region Default Logic"
    Protected Sub ddProvince_DataBound(sender As Object, e As EventArgs)
        'If IsNothing(intClientID) Then
        '    Dim ddProvince As DropDownList = CType(DemographicFormView.FindControl("ddProvince"), DropDownList)
        '    If Not IsNothing(ddProvince) Then
        '        ddProvince.SelectedValue = DataConstants.DefaultProvinceID.ToString()
        '    End If
        'End If
    End Sub
#End Region

#Region "Business Logic.  "
    Private Sub ApplyRules(ByRef item As client_DemographicModel)
        Try
            If Not IsNothing(item.demoData.FirstName) AndAlso Not IsNothing(item.demoData.LastName) AndAlso Not IsNothing(item.demoData.HealthCareNumber) AndAlso Not IsNothing(item.demoData.DateofBirth) Then
                item.idConfirmed = True
            Else
                item.idConfirmed = False
            End If
        Catch ex As Exception
            LogHelper.LogError("Error with patient demographic business rules", "ClientDemographic.aspx", ex)
            Session.Add("ErrorMessage", "Error With Client Demographic.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Sub
#End Region

End Class