SELECT DISTINCTROW [Invoice Totals].[Customer #], Customer.[First Name], Customer.[Last Name], [Invoice Totals].Date, DDR_Left_Invoice_Number.Expr1 AS [Invoice Number], Inventory.[Item Name], Inventory.[Item Number], Sum(DDR_Left_Invoice_Number.Quantity) AS SumOfQuantity
FROM (DDR_Left_Invoice_Number INNER JOIN Inventory ON DDR_Left_Invoice_Number.[Item Number] = Inventory.[Item Number]) INNER JOIN (Customer INNER JOIN [Invoice Totals] ON Customer.[Customer Number] = [Invoice Totals].[Customer #]) ON DDR_Left_Invoice_Number.Expr1 = [Invoice Totals].[Invoice #]
WHERE ((([Invoice Totals].[Invoice Status])="C"))
GROUP BY [Invoice Totals].[Customer #], Customer.[First Name], Customer.[Last Name], [Invoice Totals].Date, DDR_Left_Invoice_Number.Expr1, Inventory.[Item Name], Inventory.[Item Number]
HAVING ((([Invoice Totals].[Customer #])="101"))
ORDER BY DDR_Left_Invoice_Number.Expr1;
