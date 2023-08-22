Imports Microsoft.VisualBasic
Imports System.Web.DynamicData
Imports System.ComponentModel.DataAnnotations

<MetadataType(GetType(client_SymptomsMeta))> _
Partial Public Class client_Symptoms

End Class

Public Class client_SymptomsMeta

    <Required(ErrorMessage:="Interview Date is required.")> _
    Public Property InterviewDate As Date

    <StringLength(5000, ErrorMessage:="Comments must be less than 5000 characters.")> _
    Public Property Comments As String

    <StringLength(500, ErrorMessage:="Fever Notes must be less than 500 characters.")> _
    <RestrictXSS(ErrorMessage:="Fever notes contains bad characters. ")> _
    Public Property FeverNotes As String
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property FeverStart As Nullable(Of Date)
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property FeverEnd As Nullable(Of Date)

    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property CoughGreat3WeeksStart As Nullable(Of Date)
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property CoughGreat3WeeksEnd As Nullable(Of Date)
    <StringLength(500, ErrorMessage:="Cough Notes must be less than 500 characters.")> _
    <RestrictXSS(ErrorMessage:="Cough notes contains bad characters. ")> _
    Public Property CoughGreat3WeeksNotes As String

    <StringLength(500, ErrorMessage:="Shortness of Breath notes must be less than 500 characters.")> _
    <RestrictXSS(ErrorMessage:="Shortness of breath notes contains bad characters. ")> _
    Public Property ShortnessBreathNotes As String
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property ShortnessBreathStart As Nullable(Of Date)
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property ShortnessBreathEnd As Nullable(Of Date)
    
    <StringLength(500, ErrorMessage:="Night Sweats notes must be less than 500 characters.")> _
    <RestrictXSS(ErrorMessage:="Night sweats notes contains bad characters. ")> _
    Public Property NightSweatsNotes As String
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property NightSweatsStart As Nullable(Of Date)
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property NightSweatsEnd As Nullable(Of Date)

    <StringLength(500, ErrorMessage:="Hemoptysis Notes must be less than 500 characters.")> _
    <RestrictXSS(ErrorMessage:="Hemoptysis notes contains bad characters. ")> _
    Public Property HemoptysisNotes As String
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property HemoptysisStart As Nullable(Of Date)
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property HemoptysisEnd As Nullable(Of Date)

    <StringLength(500, ErrorMessage:="Weight Loss Notes must be less than 500 characters.")> _
    <RestrictXSS(ErrorMessage:="Weight loss notes contains bad characters. ")> _
    Public Property WeightLossNotes As String
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property WeightLossStart As Nullable(Of Date)
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property WeightLossEnd As Nullable(Of Date)

    <StringLength(500, ErrorMessage:="Loss of Appetite Notes must be less than 500 characters.")> _
    <RestrictXSS(ErrorMessage:="Loss of Appetite notes contains bad characters. ")> _
    Public Property LossAppetiteNotes As String
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property LossAppetiteStart As Nullable(Of Date)
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property LossAppetiteEnd As Nullable(Of Date)

    <StringLength(500, ErrorMessage:="Fatigue Notes must be less than 500 characters.")> _
    <RestrictXSS(ErrorMessage:="Fatigue notes contains bad characters. ")> _
    Public Property FatigueNotes As String
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property FatigueStart As Nullable(Of Date)
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property FatigueEnd As Nullable(Of Date)

    <StringLength(500, ErrorMessage:="Chest Pain Notes must be less than 500 characters.")> _
    <RestrictXSS(ErrorMessage:="Chest Pain notes contains bad characters. ")> _
    Public Property ChestpainNotes As String
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property ChestpainStart As Nullable(Of Date)
    <DataType(DataType.Date, ErrorMessage:="Invalid Date.")> _
    Public Property ChestpainEnd As Nullable(Of Date)



End Class
