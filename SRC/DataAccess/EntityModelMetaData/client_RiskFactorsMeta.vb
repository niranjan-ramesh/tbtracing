Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_RiskFactorsMeta))> _
Partial Public Class client_RiskFactors

End Class

Public Class client_RiskFactorsMeta


    <DataType(DataType.Date, ErrorMessage:="Invalid Interview Date.")> _
    Public Property InterviewDate As Date

    <RestrictXSS(ErrorMessage:="Family History contains bad characters.")> _
    <StringLength(5000, ErrorMessage:="Family History needs to be 5000 characters of less.")> _
    Public Property FamilyHistory As String

    <RestrictXSS(ErrorMessage:="Notes for Contact with person with active TB contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Contact with person with active TB in past 2 yrs must be 500 characters of less.")> _
    Public Property ContactActiveTB2YrsNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Diabetes mellitus type 1 or 2  contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Diabetes mellitus type 1 or 2 must be 500 characters of less.")> _
    Public Property DiabetesMellitusType1or2Notes As String

    <RestrictXSS(ErrorMessage:="Notes for End-stage renal disease contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for End-stage renal disease must be 500 characters of less.")> _
    Public Property EndStageRenalDiseaseNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Underlying medical condition contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Underlying medical conditions must be 500 characters of less.")> _
    Public Property UnderlyingMedicalonditionsNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Homeless (at diagnosis or within past 12 mnths contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Homeless (at diagnosis or within past 12 mnths) must be 500 characters of less.")> _
    Public Property HomelessNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Previous abnormal chest xray contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Previous abnormal chest xray must be 500 characters of less.")> _
    Public Property OverCrowdedHousingNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Lives in correctional facility at time of diagnosis contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Lives in correctional facility at time of diagnosis must be 500 characters of less.")> _
    Public Property CorrectionalFacilityAtTimeDiagNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Previous abnormal chest xray contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Previous abnormal chest xray must be 500 characters of less.")> _
    Public Property PreviousAbnormalChestXrayNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Substance abuse (known or suspected) contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Substance abuse (known or suspected) must be 500 characters of less.")> _
    Public Property SubstanceAbuseNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Tobacco smoker contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Tobacco smoker be 500 characters of less.")> _
    Public Property TobaccoSmokerNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Transplant related immunosuppression contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Transplant related immunosuppression must be 500 characters of less.")> _
    Public Property TransplantRelatedImmunosuppressionNotes As String

    <RestrictXSS(ErrorMessage:="Notes for HIV contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for HIV must be 500 characters of less.")> _
    Public Property HIVNotes As String

    <RestrictXSS(ErrorMessage:="Notes for AIDS contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for AIDS must be 500 characters of less.")> _
    Public Property AIDSNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Cancer contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Cancer must be 500 characters of less.")> _
    Public Property CancerNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Taking immunosuppressive drug contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Taking immunosuppressive drug must be 500 characters of less.")> _
    Public Property ImmunosuppressiveDrugsNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Travel to high incidence country in last 2 years contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Travel to high incidence country in last 2 years. must be 500 characters of less.")> _
    Public Property TravelHighIncidenceCountry2yrsNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Age when infected <= 5 years contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Age when infected <= 5 years must be 500 characters of less.")> _
    Public Property AgeWhenInfectedLessThanEqual5yrsNotes As String

    <RestrictXSS(ErrorMessage:="Notes for Inactive disease not adequately treated contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Inactive disease not adequately treated must be 500 characters of less.")> _
    Public Property InactiveDiseaseNotAdequatelyTreatedNotes As String

    <RestrictXSS(ErrorMessage:="Notes for LTBI, refused DOP contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for LTBI, refused DOP must be 500 characters of less.")> _
    Public Property LTBIRrefusedDOPNotes As String

    <RestrictXSS(ErrorMessage:="Smoking Device Notes, refused DOP contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Notes for Smoking Device Notes must be 500 characters of less.")> _
    Public Property SmokingDeviceNotes As String

    <RestrictXSS(ErrorMessage:="Cannabis User Notes contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Cannabis User Notes must be 500 characters of less.")> _
    Public Property CannabisNotes As String

    <RestrictXSS(ErrorMessage:="Travel to another region of Inuit Nunagat in previous 2 years contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Travel to another region of Inuit Nunagat in previous 2 years Notes must be 500 characters of less.")> _
    Public Property TravelInuitNunaGutPrev2YearsNotes As String

    <RestrictXSS(ErrorMessage:="Out of town visitors (staying in household) from high incidence country Notes contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Out of town visitors (staying in household) from high incidence country Notes must be 500 characters of less.")> _
    Public Property VisitorsFrHighIncidenceRegionNotes As String

    <RestrictXSS(ErrorMessage:="Not Eligible for Treatment Notes contains bad characters.")> _
    <StringLength(500, ErrorMessage:="Not Eligible for Treatment Notes must be 500 characters of less.")> _
    Public Property NotEligibleForTreatmentNotes As String



End Class
