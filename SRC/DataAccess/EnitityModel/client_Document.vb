'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated from a template.
'
'     Manual changes to this file may cause unexpected behavior in your application.
'     Manual changes to this file will be overwritten if the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Imports System
Imports System.Collections.Generic

Partial Public Class client_Document
    Public Property ID As Integer
    Public Property DocumentType As Integer
    Public Property DocumentName As String
    Public Property DocumentContents As Byte()
    Public Property Active As Boolean
    Public Property DateAdded As Date
    Public Property ClientID As Integer

    Public Overridable Property client_Profile As client_Profile
    Public Overridable Property common_DocumentType As common_DocumentType

End Class