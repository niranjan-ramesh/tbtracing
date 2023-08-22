Public Class SkinTest
    Inherits System.Web.UI.Page

    Private intSkinTestID As Nullable(Of Integer)
    Private intClientID As Integer

#Region "Page Load"
    Private Sub SkinTest_Init(sender As Object, e As EventArgs) Handles MyBase.Init
        'If editing a skin test, we will be passed a testid
        If Not IsNothing(Request.Params("testid")) AndAlso IsNumeric(Request.Params("testid")) Then
            intSkinTestID = Integer.Parse(Request.Params("testid"))
        End If

        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            Session.Add("ErrorMessage", "Error retrieving client data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End If

        'Hack to use single template on form view
        If IsNothing(intSkinTestID) Then
            SkinTestFormView.InsertItemTemplate = SkinTestFormView.EditItemTemplate
            SkinTestFormView.DefaultMode = FormViewMode.Insert
        Else
            SkinTestFormView.EditItemTemplate = SkinTestFormView.EditItemTemplate
            SkinTestFormView.DefaultMode = FormViewMode.Edit
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim cancelButton As HyperLink = SkinTestFormView.FindControl("lnkCancelButton")
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If
    End Sub
#End Region

#Region "Skin Test CRUD"
    Public Sub SkinTestFormView_InsertItem()
        Dim item = New TBTracing.client_SkinTest()
        TryUpdateModel(item)
        If ModelState.IsValid Then
            Try
                'Set the client id and insert into database.
                item.ClientID = intClientID
                Dim db As IClientDA = New ClientDAImpl()
                db.AddSkinTest(item)

                'Route back to history screen, with a success message.
                Session.Add("SkinSuccess", "True")
                Response.Redirect("~/ClientPages/SkinTestHistory.aspx?clientid=" & intClientID.ToString(), False)

            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error adding skin test", "SkinTest.aspx", dataEx)
                Session.Add("ErrorMessage", "Error adding skin test data.")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error Adding Skin Test", "SkinTest.aspx", ex)
                Session.Add("ErrorMessage", "Error adding skin test data.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function SkinTestFormView_GetItem() As TBTracing.client_SkinTest
        Try
            Using db As New TBTracingEntities
                Dim skinTestToUpdate As client_SkinTest = db.client_SkinTest.Find(intSkinTestID)
                Return skinTestToUpdate
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting skin test for update.", "Skin Test Error", ex)
            Session.Add("ErrorMessage", "Error retrieving client skin test data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    Public Sub SkinTestFormView_UpdateItem()
        Dim item As client_SkinTest = New client_SkinTest()
        TryUpdateModel(item)
        'Set the client id.
        item.ClientID = intClientID
        item.ID = intSkinTestID

        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.UpdateSkinTest(item, intSkinTestID)
                Session.Add("OutcomeSuccess", "True")
                Response.Redirect("~/ClientPages/SkinTestHistory.aspx?clientid=" & intClientID.ToString(), False)

            Catch dataEX As TBDataAccessException
                LogHelper.LogError("DB Error updating skin test.", "SkinTest.aspx", dataEX)
                Session.Add("ErrorMessage", "Error updating skin test data.")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("General Error udpating skin test.", "SkinTest.aspx", ex)
                Session.Add("ErrorMessage", "Error updating skin test data.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub
#End Region

#Region "Form View DataBind"
    Protected Sub SkinTestFormView_DataBound(sender As Object, e As EventArgs) Handles SkinTestFormView.DataBound
        Dim addButton As LinkButton = SkinTestFormView.FindControl("addButton")
        Dim updateButton As LinkButton = SkinTestFormView.FindControl("updateButton")

        If IsNothing(intSkinTestID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If
    End Sub
#End Region

#Region "Reason Filtering"
    Protected Sub dsReasons_Selecting(sender As Object, e As EntityDataSourceSelectingEventArgs) Handles dsReasons.Selecting
        dsReasons.WhereParameters("tsttype") = New Parameter("tsttype", TypeCode.Int32, DataConstants.ReasonForTestSkinTest.ToString())
    End Sub
#End Region

End Class