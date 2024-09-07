SELECT Inventory.[Item Name], Inventory.[Item Number]
FROM Inventory
WHERE (
((Inventory.[Item Name]) Like '*Steel*')
AND
((Inventory.[Item Number]) Like '*')
)
ORDER BY Inventory.[Item Name]
;
