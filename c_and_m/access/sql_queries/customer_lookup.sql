SELECT Customer.[Customer Number], Customer.[First Name], Customer.[Last Name],
 Customer.[Telephone Number],
Customer.[Street Address], Customer.City,
Customer.State, Customer.[Zip Code],
Customer.[Company Name]
FROM Customer
WHERE (
((Customer.[Customer Number]) LIKE '*')
AND
((Customer.[First Name]) LIKE '*')
AND
((Customer.[Last Name]) LIKE '*')
)
AND
((Customer.[Company Name]) LIKE '*')
ORDER BY Customer.[First Name], Customer.[Last Name]
;
