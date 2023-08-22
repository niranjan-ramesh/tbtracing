Public Class Clinic
    Inherits System.Web.UI.Page

    Private intClinicID As Nullable(Of Integer)

    Private Sub Clinic_Init(sender As Object, e As EventArgs) Handles Me.Init
        'Check for Clinic ID
        If Not IsNothing(Request.Params("clinicid")) AndAlso IsNumeric(Request.Params("clinicid")) Then
            intClinicID = Integer.Parse(Request.Params("clinicid"))
        End If

        'Determine which FormView Mode to use
        If IsNothing(intClinicID) Then
            ClinicFormView.InsertItemTemplate = ClinicFormView.EditItemTemplate
            ClinicFormView.DefaultMode = FormViewMode.Insert
        Else
            ClinicFormView.EditItemTemplate = ClinicFormView.EditItemTemplate
            ClinicFormView.DefaultMode = FormViewMode.Edit
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim addButton As LinkButton = ClinicFormView.FindControl("addButton")
        Dim updateButton As LinkButton = ClinicFormView.FindControl("updateButton")
        Dim cancelButton As HyperLink = ClinicFormView.FindControl("lnkCancelButton")

        If Not IsNothing(Request.Params("clinicid")) AndAlso IsNumeric(Request.Params("clinicid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClinicID.ToString())
        End If

        'Display the applicable button (i.e. add/update)
        If IsNothing(intClinicID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If
    End Sub

#Region "Clinic CRUD"

    Public Sub ClinicFormView_InsertItem()
        Dim item = New TBTracing.clinic_TBClinic()
        TryUpdateModel(item)

        If ModelState.IsValid Then
            Try
                Dim db As IClinicDA = New ClinicDAImpl()
                db.AddClinic(item)
                Response.Redirect("~/AppPages/ClinicList", False)
            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error adding Clinic", "Clinic.aspx", dataEx)
                Session.Add("ErrorMessage", "Error Saving Clinic")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error Adding Clinic", "Clinic.aspx", ex)
                Session.Add("ErrorMessage", "Error Saving Clinic")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function ClinicFormView_GetItem() As TBTracing.clinic_TBClinic
        Try
            Dim result As clinic_TBClinic = Nothing
            Using db As New TBTracingEntities
                result = db.clinic_TBClinic.Find(intClinicID)
            End Using
            Return result
        Catch ex As Exception
            LogHelper.LogError("Error getting Clinic for update.", "Clinic Error", ex)
            Session.Add("ErrorMessage", "Error Retrieving Clinic")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub ClinicFormView_UpdateItem()
        Dim item As clinic_TBClinic = New clinic_TBClinic
        TryUpdateModel(item)

        If ModelState.IsValid Then
            item.ID = intClinicID
            Try
                Dim db As IClinicDA = New ClinicDAImpl
                db.UpdateClinic(item)
                Session.Add("ClinicSuccess", "True")
                Response.Redirect("~/AppPages/ClinicList", False)
            Catch ex As Exception
                LogHelper.LogError("Error updating Clinic", "Clinic.aspx", ex)
                Session.Add("ErrorMessage", "Error updating Clinic.")
                Response.Redirect("~/ErrorPage.aspx")
            End Try
        End If
    End Sub

#End Region

    Private Sub InitializeComponent()

    End Sub

End Class