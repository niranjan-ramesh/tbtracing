Public Class OutcomeTreatmentGridLineItem
    Inherits client_OutcomeTreatmentRegimen

    Public Sub New()

    End Sub

    Public Sub New(ByRef baseClass As client_OutcomeTreatmentRegimen)
        MyBase.ID = baseClass.ID
        MyBase.StartDate = baseClass.StartDate
        MyBase.EndDate = baseClass.EndDate
        MyBase.Doseage = baseClass.Doseage
        MyBase.NumberDoses = baseClass.NumberDoses
        MyBase.Active = baseClass.Active
        MyBase.OutcomeID = baseClass.OutcomeID
        MyBase.StatusID = baseClass.StatusID
        MyBase.Notes = baseClass.Notes
        MyBase.FrequencyID = baseClass.FrequencyID
        MyBase.MedicationID = baseClass.MedicationID
    End Sub

    Public Property strMedicationName As String
    Public Property strStatus As String
    Public Property strFrequency As String

End Class
