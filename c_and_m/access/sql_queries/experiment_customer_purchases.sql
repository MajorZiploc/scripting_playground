SELECT Customer.[Customer Number], Customer.[First Name], Customer.[Last Name], Inventory.[Item Name], [Invoice Totals].[Invoice #], [Invoice Storage].Quantity, [Invoice Totals].Date
FROM Customer INNER JOIN ([Invoice Totals] INNER JOIN (Inventory INNER JOIN [Invoice Storage] ON Inventory.[Item Number] = [Invoice Storage].[Item Number]) ON [Invoice Totals].[Invoice #] = [Invoice Storage].[Invoice Number]) ON Customer.[Customer Number] = [Invoice Totals].[Customer #]
WHERE (((Customer.[First Name])='Cash'))
ORDER BY [Invoice Totals].[Invoice #];
