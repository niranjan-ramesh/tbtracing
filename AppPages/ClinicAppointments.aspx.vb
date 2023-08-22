Public Class ClinicAppointments
    Inherits System.Web.UI.Page

    Private intClinicID As Integer

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Clinic ID is always passed.
        If Not IsNothing(Request.Params("clinicid")) AndAlso IsNumeric(Request.Params("clinicid")) Then
            intClinicID = Integer.Parse(Request.Params("clinicid"))
            Dim clinicDetails As ClinicListGridLineItem = New ClinicListGridLineItem()
            clinicDetails = GetClinicDetails(intClinicID)
            litClinicDate.Text = clinicDetails.strClinicDate
            litPhysician.Text = clinicDetails.strPhysicianName
        Else
            Session.Add("ErrorMessage", "Error retrieving clinic data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        If Not IsNothing(Session.Item("AppointmentSuccess")) Then
            pnlSuccess.Visible = True
            Session.Remove("AppointmentSuccess")
        Else
            pnlSuccess.Visible = False
        End If
    End Sub
#End Region

#Region "Clinic Appointment CRUD"

    Public Function GetClinicDetails(intClinicID As Integer) As ClinicListGridLineItem
        Try
            Dim db As IClinicDA = New ClinicDAImpl()
            Return db.GetClinicDetails(intClinicID)
        Catch ex As Exception
            LogHelper.LogError("Error retrieving clinic details.", "ClinicAppointments.aspx", ex)
            Session.Add("ErrorMessage", "Error retrieving clinic details.")
            Response.Redirect("~/ErrorPage.aspx")
        End Try
    End Function

    Public Sub gvClinicAppointments_UpdateItem()
        Dim item As ClinicAppointmentGridLineItem = New ClinicAppointmentGridLineItem()

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                item.ClinicID = intClinicID
                Dim objAppointment As clinic_TBClinicAppointments = item
                'Dim objAppointment As ClinicAppointmentGridLineItem = item
                Dim db As IClinicDA = New ClinicDAImpl()
                db.UpdateClinicAppointment(objAppointment)
                Session.Add("AppointmentSuccess", "True")
                Response.Redirect("~/AppPages/ClinicAppointments?clinicid=" & intClinicID, False)
            Catch ex As Exception
                LogHelper.LogError("Error updating clinic appointments.", "ClinicAppointments.aspx", ex)
                Session.Add("ErrorMessage", "Error updating clinic appointments.")
                Response.Redirect("~/ErrorPage.aspx")
            End Try
        End If
    End Sub

    Public Function gvClinicAppointments_GetData() As List(Of ClinicAppointmentGridLineItem)
        Try
            Dim db As IClinicDA = New ClinicDAImpl()
            Return db.GetClinicAppointments(intClinicID)
        Catch ex As Exception
            LogHelper.LogError("Error getting clinic appointments", "ClinicAppointments.aspx", ex)
            Session.Add("ErrorMessage", "Error retrieving clinic appointments.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub fvAddAppointment_InsertItem()
        Dim item = New TBTracing.clinic_TBClinicAppointments()
        item.ClinicID = intClinicID

        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                Dim db As IClinicDA = New ClinicDAImpl()
                db.AddClinicAppointment(item)
                gvClinicAppointments.DataBind()
                Session.Add("AppointmentSuccess", "True")
                Response.Redirect("~/AppPages/ClinicAppointments?clinicid=" & intClinicID, False)
            Catch ex As Exception
                LogHelper.LogError("Error adding clinic appointment", "ClinicAppointments.aspx", ex)
                Session.Add("ErrorMessage", "Error adding clinic appointment.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "Gridview Table Render"
    Private Sub gvClinicAppointments_PreRender(sender As Object, e As EventArgs) Handles gvClinicAppointments.PreRender
        If gvClinicAppointments.Rows.Count > 0 Then
            gvClinicAppointments.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub
#End Region

End Class