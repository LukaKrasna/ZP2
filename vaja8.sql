--Pri reševanju nalog si pomagajte z dokumentacijo na strani https://docs.microsoft.com/en-us/sql/tsql/queries/select-group-by-transact-sql
--1. Imamo že obstojeèe poroèilo, ki vraèa vsote prodaj po country/region (USA; Združeno
--kraljestvo) in po State/Province (England, California, Colorado,…). Poizvedba je
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY a.CountryRegion, a.StateProvince
ORDER BY a.CountryRegion, a.StateProvince;
--Kar poizvedba vrne:
--CountryRegion StateProvince Revenue
--United Kingdom England 572496.5594
--United States California 346517.6072
--United States Colorado 14017.9083
--United States Nevada 7330.8972
--United States New Mexico 15275.1977
--United States Utah 665.4251

--Popravi poizvedbo tako, da bo vsebovala še delne vsote za country/region, poleg teh, ki jih
--imamo za state/province. Primer rešitve:
--CountryRegion StateProvince Revenue
--NULL NULL 956303.5949
--United Kingdom NULL 572496.5594
--United Kingdom England 572496.5594
--United States NULL 383807.0355
--United States California 346517.6072
--United States Colorado 14017.9083
--United States Nevada 7330.8972
--United States New Mexico 15275.1977
--United States Utah 665.4251

--rešitev dodaš le rollup pri group by
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY rollup(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

--2. Spremeni poizvedbo tako, da bo vsebovala nov atribut Level, ki bo opisoval tip delne vsote.
--Primer rešitve:
--CountryRegion StateProvince Level Revenue
--NULL NULL Total 956303.5949
--United Kingdom NULL United Kingdom Subtotal 572496.5594
--United Kingdom England England Subtotal 572496.5594
--United States NULL United States Subtotal 383807.0355
--United States California California Subtotal 346517.6072
--United States Colorado Colorado Subtotal 14017.9083
--United States Nevada Nevada Subtotal 7330.8972
--United States New Mexico New Mexico Subtotal 15275.1977
--United States Utah Utah Subtotal 665.4251

SELECT a.CountryRegion, a.StateProvince, 
iif(grouping_id(a.CountryRegion)=1 and grouping_id(a.StateProvince)=1,
	'Total',
	iif(grouping_id(a.StateProvince)=1,'Subtotal '+a.CountryRegion,
	a.StateProvince)
	),
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY rollup(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

--3. Razširi poizvedbo tako, da bo vsebovala tudi mesta.

SELECT --a.CountryRegion, a.StateProvince, a.City,
Choose(Grouping_id(a.City)+Grouping_id(a.StateProvince)+Grouping_id(a.CountryRegion)+1,
		a.City, 'Delna vstora '+a.StateProvince,
				'Delna vstoa '+a.CountryRegion,
				'Vse skupaj'),
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY rollup(a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince;