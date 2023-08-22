Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_DemographicMeta))> _
Partial Public Class client_Demographic

End Class

Public Class client_DemographicMeta

    <RestrictXSS(ErrorMessage:="First name contains bad characters. ")> _
    <StringLength(100, ErrorMessage:="First name must be 100 characters or less.")> _
    <Required(ErrorMessage:="First Name is required.")> _
    Public Property FirstName As String

    <RestrictXSS(ErrorMessage:="Last name contains bad characters. ")> _
    <StringLength(100, ErrorMessage:="Last name must be 100 characters or less.")> _
    <Required(ErrorMessage:="Last Name is required.")> _
    Public Property LastName As String

    <RestrictXSS(ErrorMessage:="Postal Code name contains bad characters. ")> _
    <StringLength(7, ErrorMessage:="Postal Code must be 7 characters or less.")> _
    Public Property PostalCode As String

    <RestrictXSS(ErrorMessage:="Middle Initial contains bad characters. ")> _
    <StringLength(5, ErrorMessage:="Middle Initial Must be 5 characters or less.")> _
    Public Property MiddleInitial As String

    <RestrictXSS(ErrorMessage:="Maiden Name contains bad characters. ")> _
    <StringLength(200, ErrorMessage:="Maiden Name must be 200 characters or less.")> _
    Public Property Alias_MaidenName_Nickname As String

    <RestrictXSS(ErrorMessage:="Healthcare Number contains bad characters. ")> _
    <StringLength(50, ErrorMessage:="Healthcare Number must be 50 characters or less.")> _
    <Required(ErrorMessage:="Healthcare Number is mandatory.")> _
    Public Property HealthCareNumber As String

    <RestrictXSS(ErrorMessage:="Street Address contains bad characters. ")> _
    <StringLength(50, ErrorMessage:="Street Address must be 50 characters or less.")> _
    Public Property StreetAddress As String

    <RestrictXSS(ErrorMessage:="Community contains bad characters. ")> _
    <StringLength(50, ErrorMessage:="Community must be 50 characters or less.")> _
    Public Property Community As String

    <RestrictXSS(ErrorMessage:="RHA contains bad characters. ")> _
    <StringLength(50, ErrorMessage:="RHA must be 50 characters or less.")> _
    Public Property RhaOtherText As String

    <RestrictXSS(ErrorMessage:="Mobile Phone contains bad characters. ")> _
    <StringLength(25, ErrorMessage:="Mobile Phone must be 25 characters or less.")> _
    Public Property MobilePhone As String

    <RestrictXSS(ErrorMessage:="Home Phone bad characters. ")> _
    <StringLength(25, ErrorMessage:="Home Phone must be 25 characters or less.")> _
    Public Property HomePhone As String

    <RestrictXSS(ErrorMessage:="Other Phone contains bad characters. ")> _
    <StringLength(25, ErrorMessage:="Other Phone must be 25 characters or less.")> _
    Public Property OtherPhone As String

    <RestrictXSS(ErrorMessage:="Email contains bad characters. ")> _
    <StringLength(50, ErrorMessage:="Email must be 50 characters or less.")> _
    <RegularExpression("^[_a-z0-9-]+(.[a-z0-9-]+)@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$", ErrorMessage:="Invalid email address.")> _
    Public Property Email As String

    <RestrictXSS(ErrorMessage:="Occupation contains bad characters. ")> _
    <StringLength(25, ErrorMessage:="Occupation must be 75 characters or less.")> _
    Public Property Occupation As String

    <RestrictXSS(ErrorMessage:="Comments contains bad characters. ")> _
    <StringLength(5000, ErrorMessage:="Comments must be 5000 characters or less.")> _
    Public Property Comments As String

    <StringLength(200, ErrorMessage:="Other identifier must be 200 characters or less.")> _
    Public Property OtherIdentifier As String

    <DataType(DataType.Date, ErrorMessage:="Invalid Date of Birth.")> _
    <Required(ErrorMessage:="Date of Birth is required.")> _
    Public Property DateofBirth As Nullable(Of Date)

    <RestrictXSS(ErrorMessage:="Case Number contains bad characters. ")> _
    <StringLength(25, ErrorMessage:="Case Number must be 25 characters or less.")> _
    Public Property CaseNumber As String

    <RestrictXSS(ErrorMessage:="Other community contains bad characters. ")> _
    <StringLength(50, ErrorMessage:="Other community must be 50 characters or less.")> _
    Public Property CommunityOther As String


End Class

