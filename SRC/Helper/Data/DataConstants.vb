Public Class DataConstants

    Shared Sub New()
        ReasonForTestBloodwork = My.Settings.reason_for_testing_bloodwork
        ReasonForTestIGRA = My.Settings.reason_for_testing_igra
        ReasonForTestSkinTest = My.Settings.reason_for_testing_skintest
        ReasonForTestSputum = My.Settings.reason_for_testing_sputum
        ReasonForTestXRay = My.Settings.reason_for_testing_xray
        ReasonForDI = My.Settings.reason_for_testing_diagnosticImage
        XrayChestView = My.Settings.xray_Chest
        XrayAreaChest = My.Settings.xray_AreaChest
        XrayAreaChestPortable = My.Settings.xray_AreaChestPortable
        FollowupSkinTest = My.Settings.RepeatTSTFollowup
        FollowupOtherSputum = My.Settings.OtherTestReasonSputum
        FollowupOtherXray = My.Settings.OtherTestReadonXray
        FollowupOtherIGRA = My.Settings.OtherTestReasonIGRA
        FollowupOtherBloodword = My.Settings.OtherTestReasonBloodwork
        FollowupOtherDI = My.Settings.OtherTestReasonDI
        DefaultProvinceID = My.Settings.DefaultProvince
    End Sub

    Public Shared ReadOnly ReasonForTestBloodwork As Integer
    Public Shared ReadOnly ReasonForTestIGRA As Integer
    Public Shared ReadOnly ReasonForTestSkinTest As Integer
    Public Shared ReadOnly ReasonForTestSputum As Integer
    Public Shared ReadOnly ReasonForTestXRay As Integer
    Public Shared ReadOnly ReasonForDI As Integer
    Public Shared ReadOnly XrayChestView As Integer
    Public Shared ReadOnly XrayAreaChest As Integer
    Public Shared ReadOnly XrayAreaChestPortable As Integer
    Public Shared ReadOnly FollowupSkinTest As Integer
    Public Shared ReadOnly FollowupOtherSputum As Integer
    Public Shared ReadOnly FollowupOtherXray As Integer
    Public Shared ReadOnly FollowupOtherIGRA As Integer
    Public Shared ReadOnly FollowupOtherBloodword As Integer
    Public Shared ReadOnly FollowupOtherDI As Integer
    Public Shared ReadOnly DefaultProvinceID As Integer

End Class
