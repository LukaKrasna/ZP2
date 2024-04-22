--1. Napi�i poizvedbo, ki vra�a ime, prvo vrstico naslova, mesto in nov stolpec z imenom
--�TipNaslova� in vrednostjo �Za ra�une� podjetja za vse stranke, ki imajo tip naslova v
--CustomerAddress tabeli enak 'Main Office'.
--Main Office
select c.CompanyName, a.AddressLine1, a.City,'Za ra�une' as TipNaslov from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where AddressType='Main Office'
--2. Napi�i podobno poizvedbo (ime, prva vrstica naslova, mesto in stolpec �Tip naslova� z
--vrednostjo �Za dobavo�) za vse stranke, ki imajo tip naslova v CustomerAddress enak
--'Shipping'
--za divavi=Shipping
union --z tem ukazom  dru�i� zgornjo kodo s spodnjo, obe tabeli skupaj
select c.CompanyName, a.AddressLine1, a.City,'Za dobavo' as TipNaslov from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where AddressType='Shipping'
--3. Kombiniraj oba rezultata v seznam, ki vrne vse naslove stranke urejene po strankah, nato po
--TipNalsova.
select c.CompanyName, a.AddressLine1, a.City,'Za ra�une' as TipNaslov from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where AddressType='Main Office'
union --z tem ukazom  dru�i� zgornjo kodo s spodnjo, obe tabeli skupaj
select c.CompanyName, a.AddressLine1, a.City,'Za dobavo' as TipNaslov from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where AddressType='Shipping'
order by TipNaslov
--4. Napi�i poizvedbo, ki vrne imena podjetji, ki so med podjetji z 'Main office' naslovom, a
--nimajo 'Shipping' naslova.
select c.CompanyName, AddressLine1, City from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where AddressType!='Main Office'
intersect
select c.CompanyName, AddressLine1, City from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where AddressType='Shipping'
--5. Napi�i poizvedbo, ki vrne imena podjetji, ki so med podjetji z 'Main office' naslovomin hkrati
--med podjetji s 'Shipping' naslovom.
select c.CompanyName, AddressLine1, City from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where AddressType='Main Office'
intersect
select c.CompanyName, AddressLine1, City from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where AddressType!='Shipping'