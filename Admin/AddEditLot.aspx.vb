Public Class AddEditLot
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsNothing(Session.Item("LotAdminStatus")) Then
            ltStatusMessage.Text = Session.Item("LotAdminStatus")
            Session.Remove("LotAdminStatus")
        Else
            pnlSuccess.Visible = False
        End If
    End Sub

    Public Sub fvLot_InsertItem()
        Dim item = New TBTracing.common_MedicalLot()
        TryUpdateModel(item)
        If ModelState.IsValid Then
            ' Save changes here
            Try
                Using db As New TBTracingEntities
                    db.common_MedicalLot.Add(item)
                    db.SaveChanges()
                End Using
                Session.Add("LotAdminStatus", item.LotNumber & " Added Successfully.")
                Response.Redirect(Request.RawUrl, False)
            Catch ex As Exception
                LogHelper.LogError("General Error Adding Medical Lot.", "AddEditLot.aspx", ex)
                Session.Add("ErrorMessage", "Error adding Medical Lot.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Protected Sub ddLots_TextChanged(sender As Object, e As EventArgs)
        If IsNumeric(ddLots.SelectedValue) Then
            fvLot.ChangeMode(FormViewMode.Edit)
        ElseIf ddLots.SelectedValue.ToLower().Equals("add") Then
            fvLot.ChangeMode(FormViewMode.Insert)
        End If
        fvLot.DataBind()
    End Sub

    ' The id parameter should match the DataKeyNames value set on the control
    ' or be decorated with a value provider attribute, e.g. <QueryString>ByVal id as Integer
    Public Function fvLot_GetItem() As TBTracing.common_MedicalLot
        Try
            Dim returnModel = New common_MedicalLot()
            If String.IsNullOrEmpty(ddLots.SelectedValue) OrElse ddLots.SelectedValue.ToLower.Equals("add") Then
                Return returnModel
            ElseIf IsNumeric(ddLots.SelectedValue) Then
                Dim lotID As Integer = Integer.Parse(ddLots.SelectedValue)

                Using db As New TBTracingEntities
                    returnModel = db.common_MedicalLot.Find(lotID)
                End Using
            End If
            Return returnModel
        Catch ex As Exception
            LogHelper.LogError("General Retrieving Lot for Editing.", "AddEditLot.aspx", ex)
            Session.Add("ErrorMessage", "Error adding Medical Lot.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    ' The id parameter name should match the DataKeyNames value set on the control
    Public Sub fvLot_UpdateItem(ByVal id As Integer)
        Dim item As common_MedicalLot = New common_MedicalLot()
        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                Using db As New TBTracingEntities

                    Dim objLot As common_MedicalLot = db.common_MedicalLot.Find(id)

                    objLot.LotNumber = item.LotNumber
                    If Not String.IsNullOrEmpty(item.ExpDate) Then
                        objLot.ExpDate = item.ExpDate
                    Else
                        objLot.ExpDate = Nothing
                    End If
                    db.SaveChanges()
                    Session.Add("LotAdminStatus", item.LotNumber & " Updated Successfully.")
                    Response.Redirect(Request.RawUrl, False)
                End Using
            Catch ex As Exception
                LogHelper.LogError("General Updating Lot.", "AddEditLot.aspx", ex)
                Session.Add("ErrorMessage", "Error updating Medical Lot.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try

        End If
    End Sub
End Class