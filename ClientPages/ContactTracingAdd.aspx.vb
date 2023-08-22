Public Class ContactTracingAdd
    Inherits System.Web.UI.Page

    Private intClientID As Nullable(Of Integer)
    Private intContactID As Nullable(Of Integer)
    Private intTraceID As Nullable(Of Integer)

#Region "Page Load"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Client ID is always passed.
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            intClientID = Integer.Parse(Request.Params("clientid"))
        Else
            LogHelper.LogInfo("Missing client id.", "ContactTracingAdd.aspx")
            Session.Add("ErrorMessage", "Missing Client ID.")
            Response.Redirect("~/ErrorPage.aspx")
        End If

        If Not IsNothing(Request.Params("contactid")) AndAlso IsNumeric(Request.Params("contactid")) Then
            intContactID = Integer.Parse(Request.Params("contactid"))
        Else
            LogHelper.LogInfo("Missing contact id.", "ContactTracingAdd.aspx")
            Session.Add("ErrorMessage", "Missing Contact ID.")
            Response.Redirect("~/ErrorPage.aspx")
        End If

        If Not IsNothing(Request.Params("traceid")) AndAlso IsNumeric(Request.Params("traceid")) Then
            intTraceID = Integer.Parse(Request.Params("traceid"))
        End If


        'Hack to use single template on form view
        If IsNothing(intTraceID) Then
            fvContactTracing.InsertItemTemplate = fvContactTracing.EditItemTemplate
            fvContactTracing.DefaultMode = FormViewMode.Insert
        Else
            fvContactTracing.EditItemTemplate = fvContactTracing.EditItemTemplate
            fvContactTracing.DefaultMode = FormViewMode.Edit
        End If



        If Not Page.IsPostBack Then
            Try
                Using db As New TBTracingEntities
                    Dim demoDetails As client_Demographic = (From objDemo In db.client_Demographic _
                                                            Where objDemo.Active = True _
                                                            And objDemo.client_Profile.ID = intContactID).FirstOrDefault()

                    If Not IsNothing(demoDetails) Then
                        tbName.Text = demoDetails.FirstName & " " & demoDetails.LastName
                        If Not IsNothing(demoDetails.DateofBirth) Then tbDOB.Text = New DataHelper().convertDateToStringText(demoDetails.DateofBirth)
                        If Not IsNothing(demoDetails.common_Community) Then tbCity.Text = demoDetails.common_Community.Community
                        If Not IsNothing(demoDetails.common_Province) Then tbProv.Text = demoDetails.common_Province.Province
                        tbMCP.Text = demoDetails.HealthCareNumber
                        tbAliast.Text = demoDetails.Alias_MaidenName_Nickname
                        tbAddress.Text = demoDetails.StreetAddress
                    End If

                    'Get more recent outcome
                    'Dim outcomeDetails As client_Outcome = (From objOutcome In db.client_Outcome _
                    '                                       Where objOutcome.ClientID = intClientID _
                    '                                       And objOutcome.OutcomeDeterminationDate IsNot Nothing _
                    '                                       Order By objOutcome.OutcomeDeterminationDate _
                    '                                       Select objOutcome).FirstOrDefault()

                    'Dim outcomeMsg As New StringBuilder()

                    'If Not IsNothing(outcomeDetails) Then

                    '    outcomeMsg.Append("Determination Date: " & New DataHelper().convertDateToStringText(outcomeDetails.OutcomeDeterminationDate))
                    '    outcomeMsg.Append(", Outcome: " & outcomeDetails.common_TBOutcome.TBOutcome)

                    '    If outcomeDetails.Outcome = My.Settings.activeTBOutcome Then
                    '        outcomeMsg.Append(", TB Type: " & outcomeDetails.common_TBTypes.TBType)
                    '    End If
                    'Else
                    '    outcomeMsg.Append("No outcome for client.")
                    'End If

                    'tbOutCome.Text = outcomeMsg.ToString()
                End Using
            Catch ex As Exception
                LogHelper.LogError("Error getting contact information.  Contact ID: " & intContactID.ToString(), "ContactTracingAdd.aspx", ex)
                Session.Add("ErrorMessage", "Error retrieving contact information.")
                Response.Redirect("~/ErrorPage.aspx")
            End Try
        End If
    End Sub
#End Region

#Region "ListView Databinding"
    Protected Sub fvContactTracing_DataBound(sender As Object, e As EventArgs) Handles fvContactTracing.DataBound
        Dim addButton As LinkButton = fvContactTracing.FindControl("addButton")
        Dim updateButton As LinkButton = fvContactTracing.FindControl("updateButton")

        If IsNothing(intTraceID) Then
            addButton.Visible = True
            updateButton.Visible = False
        Else
            addButton.Visible = False
            updateButton.Visible = True
        End If

        Dim cancelButton As HyperLink = fvContactTracing.FindControl("lnkCancelButton")
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            cancelButton.NavigateUrl = String.Format(cancelButton.NavigateUrl, intClientID.ToString())
        End If
    End Sub
#End Region

#Region "Contact CRUD"
    Public Sub fvContactTracing_InsertItem()
        Dim item = New TBTracing.client_ContactTracing()
        TryUpdateModel(item)
        item.ClientID = intClientID
        item.ContactClientID = intContactID
        item.Active = True
        If ModelState.IsValid Then
            Try
                Dim db As IClientDA = New ClientDAImpl()
                db.AddContactTracing(item)
                Session.Add("ContactSuccess", "True")
                Response.Redirect("~/ClientPages/ContactHistory?clientid=" & intClientID, False)
            Catch dataEx As TBDataAccessException
                LogHelper.LogError("Data access error adding contact tracing.", "ContactTracingAdd.aspx", dataEx)
                Session.Add("ErrorMessage", "Error contact tracing record.")
                Response.Redirect("~/ErrorPage.aspx", False)
            Catch ex As Exception
                LogHelper.LogError("Generic Error Adding contact tracing.", "ContactTracingAdd.aspx", ex)
                Session.Add("ErrorMessage", "Error contact tracing record.")
                Response.Redirect("~/ErrorPage.aspx", False)
            End Try
        End If
    End Sub

    Public Function fvContactTracing_GetItem() As TBTracing.client_ContactTracing
        Try
            Using db As New TBTracingEntities
                Dim traceToUpdate As client_ContactTracing = db.client_ContactTracing.Find(intTraceID)
                Return traceToUpdate
            End Using
        Catch ex As Exception
            LogHelper.LogError("Error getting skin test for update.", "Skin Test Error", ex)
            Session.Add("ErrorMessage", "Error retrieving client skin test data.")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function

    ' The id parameter name should match the DataKeyNames value set on the control
    Public Sub fvContactTracing_UpdateItem()
        Dim item As TBTracing.client_ContactTracing = New TBTracing.client_ContactTracing


        TryUpdateModel(item)
        item.ID = intTraceID
        item.ClientID = intClientID
        item.ContactClientID = intContactID
        item.Active = True


        If ModelState.IsValid Then
            Dim db As IClientDA = New ClientDAImpl()
            db.UpdateContactTracing(item)
            Session.Add("ContactSuccess", "True")
            Response.Redirect("~/ClientPages/ContactHistory?clientid=" & intClientID, False)
        End If
    End Sub
#End Region


#Region "Dropdown data massaging"
    Public Function ddRelationship_GetItem() As IEnumerable(Of common_ContactRelationship)
        Try
            Dim db As TBTracingEntities = New TBTracingEntities()
            Dim results = Nothing

            Dim objClientContact As client_ContactTracing = Nothing
            If Not IsNothing(fvContactTracing.DataItem) Then
                objClientContact = CType(fvContactTracing.DataItem, client_ContactTracing)
            End If

            'If Not IsNothing(intContactID) AndAlso IsNumeric(intContactID) AndAlso Not IsNothing(objClientContact) AndAlso Not IsNothing(objClientContact.RelationshipID) Then
            If IsNumeric(intContactID) AndAlso Not IsNothing(objClientContact) AndAlso IsNumeric(objClientContact.RelationshipID) Then
                results = db.common_ContactRelationship.Where(Function(p) p.Active = True).Union(From objLegacy _
                                                                                                In db.common_ContactRelationship _
                                                                                                Where objLegacy.Active = False _
                                                                                                And objLegacy.ID = objClientContact.RelationshipID _
                                                                                                Select objLegacy).OrderBy(Function(p) p.RelationshipText)
            Else
                results = db.common_ContactRelationship.Where(Function(p) p.Active = True).OrderBy(Function(p) p.RelationshipText)
            End If

            Return results

            'Dim db As TBTracingEntities = New TBTracingEntities()
            'Dim relList As List(Of common_ContactRelationship) = db.common_ContactRelationship.Where(Function(p) p.Active = True).OrderBy(Function(p) p.RelationshipText).ToList()

            'If Not IsNothing(intContactID) AndAlso IsNumeric(intContactID) Then
            '    If Not IsNothing(fvContactTracing.DataItem) Then
            '        Dim objClientContact As client_ContactTracing = CType(fvContactTracing.DataItem, client_ContactTracing)
            '        If Not IsNothing(objClientContact) Then
            '            Dim legacyRelationship As common_ContactRelationship = relList.Where(Function(p) p.ID = objClientContact.RelationshipID).FirstOrDefault()
            '            If IsNothing(legacyRelationship) Then
            '                relList.Add(db.common_ContactRelationship.Find(objClientContact.RelationshipID))
            '            End If
            '        End If
            '    End If
            'End If
            'Return relList.AsQueryable()
        Catch ex As Exception
            LogHelper.LogError("Error getting tracing relationships", "ContactTracingAdd.aspx", ex)
            Session.Add("ErrorMessage", "Error With Contact Data")
            Response.Redirect("~/ErrorPage.aspx", False)
        End Try
    End Function
#End Region

    
End Class