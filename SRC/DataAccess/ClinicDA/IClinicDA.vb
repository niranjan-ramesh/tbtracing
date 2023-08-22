Public Interface IClinicDA

    'Clinic 
    Sub AddClinic(ByRef objClinic As clinic_TBClinic)
    Sub UpdateClinic(ByRef objClinic As clinic_TBClinic)
    Function GetClinicList() As List(Of ClinicListGridLineItem)
    Function GetClinicDetails(ByVal clinicID As Integer) As ClinicListGridLineItem
    Sub UpdateClinicAppointment(ByRef objAppointment As clinic_TBClinicAppointments)
    Function GetClinicAppointments(ByVal clinicID As Integer) As List(Of ClinicAppointmentGridLineItem)
    Sub AddClinicAppointment(ByRef objAppointment As clinic_TBClinicAppointments)

End Interface
