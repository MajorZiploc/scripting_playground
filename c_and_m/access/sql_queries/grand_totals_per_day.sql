SELECT DISTINCTROW [Invoice Totals].Date, Sum(IIf([Invoice Totals]![Invoice_Discount]=0,[Invoice Totals]![Grand Total],[Invoice Totals]![Invoice_Discounted_GTotal])) AS Total
FROM [Invoice Totals]
GROUP BY [Invoice Totals].Date, [Invoice Totals].[Invoice Status]
HAVING ((([Invoice Totals].[Invoice Status])="C"))
ORDER BY CDate([Invoice Totals].Date)
;
