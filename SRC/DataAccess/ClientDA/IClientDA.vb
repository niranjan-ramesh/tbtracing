Public Interface IClientDA

    'Demographics
    Function AddClientDemographic(ByRef objDemographic As client_DemographicModel) As Integer
    Sub UpdateClientDemographic(ByRef objDemographic As client_DemographicModel)
    Function getDemographic(ByVal clientID As Integer) As client_Demographic
    Function checkForDuplicateHCN(ByVal clientID As Nullable(Of Integer), ByVal hcn As String) As Boolean

    'Skin Test
    Sub AddSkinTest(ByRef objSkinTest As client_SkinTest)
    Sub UpdateSkinTest(ByRef objSkinTest As client_SkinTest, ByVal testid As Integer)
    Function GetSkinTestHistory(ByVal clientID As Integer) As List(Of SkinTestGridLineItem)
    Sub AddUpdateBCG(ByRef objBCG As client_BCG)

    'Sputum Test
    Sub AddSputum(ByRef objSputum As client_SputumModel)
    Sub UpdateSputum(ByRef objSputum As client_SputumModel, ByVal testid As Integer)
    Function GetSputumHistory(ByVal clientID As Integer) As List(Of SputumGridLineItem)

    'Xray Test
    Sub AddXray(ByRef objSputum As client_Xray)
    Sub UpdateXray(ByRef objSputum As client_Xray, ByVal testid As Integer)
    Function GetXrayHistory(ByVal clientID As Integer) As List(Of XRayGridLineItem)
    Function GetChestXrayHistory(ByVal clientID As Integer) As List(Of XRayGridLineItem)
    Function GetDiagnosticHistory(ByVal clientID As Integer) As List(Of XRayGridLineItem)
    Sub AddDiagnosticImage(ByRef objDiagnosticImage As client_DiagnosticImage)
    Function UpdateDiagnosticImage(ByRef objDiagnosticImage As client_DiagnosticImage)

    'Communication 
    Sub AddCommunication(ByRef objCommunication As client_Communication)
    Function GetCommunicationHistory(ByVal clientID As Integer) As List(Of CommunicationGridLineItem)
    Sub UpdateCommunication(ByRef objCommunication As client_Communication)

    'Symptoms
    Sub AddSymptoms(ByRef objSymptoms As client_Symptoms)
    Sub UpdateSymptoms(ByRef objSymptoms As client_Symptoms)
    Function GetSymptomsHistory(ByVal clientID As Integer) As List(Of SymptomsItem)

    'Risks
    Sub AddRisk(ByRef objRisks As client_RiskFactors)
    Sub UpdateRisk(ByRef objRisk As client_RiskFactors)
    Function GetRisksHistory(ByVal clientID As Integer) As List(Of RisksItem)

    'IGRA
    Sub AddIGRA(ByRef objIGRA As client_IGRA)
    Sub UpdateIGRA(ByRef objIGRA As client_IGRA, ByVal testid As Integer)
    Function GetIGRAHistory(ByVal clientID As Integer) As List(Of IGRAGridLineItem)

    'Bloodwork
    Sub AddBloodwork(ByRef objBloodwork As client_Bloodwork)
    Sub UpdateBloodwork(ByRef objBloodwork As client_Bloodwork, ByVal testid As Integer)
    Function GetBloodworkHistory(ByVal clientID As Integer) As List(Of BloodworkGridLineItem)

    'Notes
    Sub AddNote(ByRef objNote As client_Notes)
    Sub UpdateNote(ByRef objNote As client_Notes, ByVal noteid As Integer)
    Sub DeleteNote(ByRef objNote As client_Notes, ByVal noteid As Integer)
    Function GetNotesHistory(ByVal clientID As Integer) As List(Of NotesGridLineItem)

    'Documents
    Sub AddDocument(ByRef objDocument As client_Document)
    Sub DeleteDocument(ByRef objDocument As client_Document, ByVal docid As Integer)
    Function GetDocument(ByVal docID As Integer) As DocumentsGridLineItem
    Function GetDocumentList(ByVal clientID As Integer) As List(Of DocumentsGridLineItem)

    'Followups
    Function GetFollowups(ByVal clientID As Integer) As List(Of FollowUpGridLineItem)
    Function GetAllFollowups(ByVal startDate As Nullable(Of DateTime), ByVal endDate As Nullable(Of DateTime), ByVal responsibility As String, ByVal fType As String) As List(Of FollowUpGridLineItem)
    'Function GetFollowups() As List(Of FollowUpGridLineItem)
    Sub AddFollowup(ByRef objFollowup As client_Followup)
    Sub UpdateFollowup(ByRef objFollowup As client_Followup)

    'Client Information Control
    Function GetClientInformation(ByVal clientID As Integer) As client_InformationModel

    'Contact Tracing
    Sub AddContactTracing(ByRef clientContactTrace As client_ContactTracing)
    Function GetContactTracingHistory(ByVal clientID As Integer) As List(Of ContactTracingHistoryGrid)
    Sub AddContactNote(ByRef clientContactNote As client_ContactNote)
    Sub UpdateContactNote(ByRef clientContactNote As client_ContactNote)
    Sub UpdateContactTracing(ByRef clientContactTrace As client_ContactTracing)

    'Outcome
    Function GetOutcomeForClient(ByVal clientID As Integer, ByVal statusList As List(Of Integer)) As List(Of OutcomeGridLineItem)
    Function AddOutcome(ByRef clientOutcome As client_Outcome) As String
    Function UpdateOutcome(ByRef clientOutcome As client_Outcome) As String
    Sub AddTreatmentRegimen(ByRef treatment As client_OutcomeTreatmentRegimen)
    Sub UpdateTreatmentRegimen(ByRef treatment As client_OutcomeTreatmentRegimen)
    Sub UpdateTreatment(ByRef treatment As client_OutcomeTreatment)
    Sub AddDOT(ByRef dot As client_DotModel)
    Function GetDotById(ByRef dotID As Integer) As client_DotModel
    Sub UpdateDOT(ByRef modelData As client_DotModel, ByVal clientID As Integer)

End Interface
