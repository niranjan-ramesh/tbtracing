Public Class _003_ClientList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub lbSearch_Click(sender As Object, e As EventArgs) Handles lbSearch.Click

        Try

            Dim searchMCP As String = tbMCP.Text.ToLower().Trim()
            Dim searchFirstName As String = tbFirstName.Text.ToLower().Trim()
            Dim searchLastName As String = tbLastName.Text.ToLower().Trim()
            Dim searchDOB As String = tbDOB.Text.ToLower().Trim()
            'Dim searchResults As List(Of ClientSearchDTO) = New List(Of ClientSearchDTO)

            'Using db As New TBTracingCtx
            '    Dim results = (From searchQuery In db.)


            '    For Each result In results
            '        Dim searchResult As ClientSearchDTO = New ClientSearchDTO
            '        searchResult.firstName = result.firstName
            '        searchResult.lastName = result.lastName
            '        searchResult.MCP = result.MCP
            '        searchResult.DOB = result.DOB
            '    Next

            'End Using



        Catch ex As Exception

        End Try

    End Sub
End Class