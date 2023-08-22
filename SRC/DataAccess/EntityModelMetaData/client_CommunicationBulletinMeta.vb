Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_CommunicationBulletinMeta))> _
Partial Public Class client_CommunicationBulletin

End Class

Public Class client_CommunicationBulletinMeta

    <RestrictXSS(ErrorMessage:="Communication Bulletin comments contains bad characters.")> _
    <StringLength(5000, ErrorMessage:="Communication Bulletin must be 5000 characters or less.")> _
    Public Property CommunicationBulletin As String

End Class
