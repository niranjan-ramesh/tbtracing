Public Class ClientTabsControl
    Inherits System.Web.UI.UserControl

    Private m_ActiveTab As String
    Private strClientID As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsNothing(Request.Params("clientid")) AndAlso IsNumeric(Request.Params("clientid")) Then
            strClientID = Request.Params("clientid")
        Else
            strClientID = Nothing
        End If

        If m_ActiveTab.Equals("demographics") Then
            demoLi.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("symptoms") Then
            symptomsLi.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("tst") Then
            skinTestLI.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("sputumxray") Then
            sputmLI.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("investigation") Then
            investigationLI.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("diagnosis") Then
            diagnosisLI.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("treatment") Then
            treatmentLI.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("risks") Then
            riskLI.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("communication") Then
            communicationLI.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("contacts") Then
            contactLI.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("docsnotes") Then
            docsLI.Attributes.Add("class", "active")
        ElseIf m_ActiveTab.Equals("followups") Then
            followupLI.Attributes.Add("class", "active")
            'ElseIf m_ActiveTab.Equals("geno") Then
            '    genoLI.Attributes.Add("class", "active")

        End If

        If String.IsNullOrEmpty(strClientID) Then
            lnkDemo.NavigateUrl = String.Format(lnkDemo.NavigateUrl, "new")

            lnkSymp.Visible = False
            lnkSkinTest.Visible = False
            lnkSputum.Visible = False
            lnkInvestigations.Visible = False
            lnkDiagnosisTreatment.Visible = False
            lnkRiskFactors.Visible = False
            lnkCommunication.Visible = False
            lnkContactTrace.Visible = False
            lnkDocsNotes.Visible = False
            lnkFollowUps.Visible = False
            lnkTreatment.Visible = False
            'lnkGeno.Visible = False

            symptomsLi.Visible = False
            skinTestLI.Visible = False
            sputmLI.Visible = False
            investigationLI.Visible = False
            diagnosisLI.Visible = False
            riskLI.Visible = False
            communicationLI.Visible = False
            contactLI.Visible = False
            docsLI.Visible = False
            followupLI.Visible = False
            treatmentLI.Visible = False
            'genoLI.Visible = False

        Else
            lnkDemo.NavigateUrl = String.Format(lnkDemo.NavigateUrl, strClientID)
            lnkSymp.NavigateUrl = String.Format(lnkSymp.NavigateUrl, strClientID)
            lnkSkinTest.NavigateUrl = String.Format(lnkSkinTest.NavigateUrl, strClientID)
            lnkSputum.NavigateUrl = String.Format(lnkSputum.NavigateUrl, strClientID)
            lnkInvestigations.NavigateUrl = String.Format(lnkInvestigations.NavigateUrl, strClientID)
            lnkCommunication.NavigateUrl = String.Format(lnkCommunication.NavigateUrl, strClientID)
            lnkDocsNotes.NavigateUrl = String.Format(lnkDocsNotes.NavigateUrl, strClientID)
            lnkFollowUps.NavigateUrl = String.Format(lnkFollowUps.NavigateUrl, strClientID)
            lnkContactTrace.NavigateUrl = String.Format(lnkContactTrace.NavigateUrl, strClientID)
            lnkRiskFactors.NavigateUrl = String.Format(lnkRiskFactors.NavigateUrl, strClientID)
            lnkDiagnosisTreatment.NavigateUrl = String.Format(lnkDiagnosisTreatment.NavigateUrl, strClientID)
            lnkTreatment.NavigateUrl = String.Format(lnkTreatment.NavigateUrl, strClientID)
        End If


    End Sub

    Public Property ActiveTab() As String
        Get
            Return m_ActiveTab
        End Get
        Set(value As String)
            m_ActiveTab = value
        End Set
    End Property

    Public Property TBClientID() As String
        Get
            Return strClientID
        End Get
        Set(value As String)
            strClientID = value
        End Set
    End Property

End Class