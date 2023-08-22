Public Class ErrorPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsNothing(Request.Params("notfound")) Then
            lblErrorMessage.Text = "Page not found."
        ElseIf Not IsNothing(Session.Item("ErrorMessage")) Then
            lblErrorMessage.Text = Session.Item("ErrorMessage")
            Session.Remove("ErrorMessage")
        Else
            lblErrorMessage.Text = "Application Error.  Please contact technical support."
        End If
    End Sub

End Class