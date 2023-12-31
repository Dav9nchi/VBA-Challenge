Sub StocksYearlySummarize()
    Dim ws As Worksheet
    Dim Ticker As String
    Dim Yearly_change As Double
    Dim Percentage_change As Double
    Dim Tot_Stock_Vol As Double
    Dim OpenRow As Double
    Dim CloseRow As Double
    Dim G_porc_increase As Double
    Dim G_porc_decrease As Double
    Dim G_Vol As Double
    Dim G_increase_ticker As String
    Dim G_decrease_ticker As String
    Dim G_Ticker_Vol As String
    Dim j As Long

    For Each ws In Worksheets
        Dim LastRow As Long
        Dim i As Long

        ws.Range("i1").Value = "Ticker"
        ws.Range("J1").Value = "Yearly Change"
        ws.Range("k1").Value = "Percent Change"
        ws.Range("l1").Value = "Total Stock Volume"
        ws.Range("P1").Value = "Ticker"
        ws.Range("Q1").Value = "Value"
        ws.Range("O4").Value = "Greatest Total Volume"
        ws.Range("O3").Value = "Greatest % Decrease"
        ws.Range("O2").Value = "Greatest % Increase"
  
        G_porc_increase = 0
        G_porc_decrease = 0
        G_Vol = 0
        G_increase_ticker = ""
        G_decrease_ticker = ""
        G_Ticker_Vol = ""

        Tot_Stock_Vol = 0
        j = 2

        LastRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row
        OpenRow = ws.Cells(2, 3).Value

        For i = 2 To LastRow
            Ticker = ws.Cells(i, 1).Value
            If Ticker <> ws.Cells(i + 1, 1).Value Or i = LastRow Then
                CloseRow = ws.Cells(i, 6).Value
                Yearly_change = CloseRow - OpenRow
                ws.Cells(j, 9).Value = Ticker
                ws.Cells(j, 10).Value = Yearly_change
                ws.Cells(j, 12).Value = Tot_Stock_Vol

                If Yearly_change >= 0 Then
                    ws.Cells(j, 10).Interior.Color = vbGreen
                Else
                    ws.Cells(j, 10).Interior.Color = vbRed
                End If

                If OpenRow <> 0 Then
                    Percentage_change = (Yearly_change / OpenRow)
                    ws.Cells(j, 11).Value = Format(Percentage_change, "Percent")
                Else
                    ws.Cells(j, 11).Value = Format(0, "Percent")
                End If

                If Percentage_change > G_porc_increase Then
                    G_porc_increase = Percentage_change
                    G_increase_ticker = Ticker
                ElseIf Percentage_change < G_porc_decrease Then
                    G_porc_decrease = Percentage_change
                    G_decrease_ticker = Ticker
                End If
                
                ws.Range("Q2").Value = Format(0, "Percent")
                ws.Range("Q3").Value = Format(0, "Percent")
                ws.Range("Q4").Value = Format(0, "Percent")

                If Tot_Stock_Vol > G_Vol Then
                    G_Vol = Tot_Stock_Vol
                    G_Ticker_Vol = Ticker
                End If

                Tot_Stock_Vol = 0
                Ticker = ws.Cells(i, 1).Value
                OpenRow = ws.Cells(i + 1, 3).Value
                j = j + 1
            Else
                Tot_Stock_Vol = Tot_Stock_Vol + ws.Cells(i, 7).Value
            End If
        Next i

        ws.Range("P2").Value = G_increase_ticker
        ws.Range("P3").Value = G_decrease_ticker
        ws.Range("P4").Value = G_Ticker_Vol
        ws.Cells(4, 17).Value = G_Vol
        ws.Cells(3, 17).Value = G_porc_decrease
        ws.Cells(2, 17).Value = G_porc_increase
        
    Next ws
End Sub
