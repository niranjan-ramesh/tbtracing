Public Class ClinicList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Function gvClinicList_GetData() As IQueryable(Of ClinicListGridLineItem)
        Dim db As IClinicDA = New ClinicDAImpl()
        Return db.GetClinicList().AsQueryable()
    End Function

    Private Sub gvClinicList_PreRender(sender As Object, e As EventArgs) Handles gvClinicList.PreRender
        If gvClinicList.Rows.Count > 0 Then
            gvClinicList.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

End Class