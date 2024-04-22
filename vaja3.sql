--1. Izdelati mora� poro�ilo o ra�unih. V prvem koraku izdelaj poizvedbo, ki vrne ime podjetja
--(CompanyName) iz tabele Customer , poleg tega pa �e ID naro�ila (salesOrderID) in skupni
--dolg (total due) iz atbele SalesOrderHeader.
select CompanyName, SalesOrderID, TotalDue from [SalesLT].[Customer]
 join SalesLT.SalesOrderHeader
 ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
--2. Raz�iri poizvedbo tako, da doda� �e naslov �Main Office� za vsakega kupca (naslov ulice,
--mesto, dr�avo/provinco, po�tno �tevilko in regijo). Pri tem upo�tevaj, da ima vsaka stranka
--ve� naslovov v tabeli Address. Zato je na�rtovalec PB ustvaril �e tabelo CustomerAddress, da
--je re�il povezavo M:N. Poizvedba mora vsebovati obe tabeli in mora filtrirati priklju�eno
--tabelo CustomerAddress, tako da vzame samo naslov �Main Office�.
select SalesOrderID, TotalDue, AddressLine1, City, StateProvince, PostalCode, CountryRegion from [SalesLT].[SalesOrderHeader]
join [SalesLT].[CustomerAddress]
on [SalesLT].[SalesOrderHeader].CustomerID=[SalesLT].[CustomerAddress].CustomerID
join [SalesLT].[Address]
on [SalesLT].[CustomerAddress].AddressID=[SalesLT].[Address].AddressID
where [SalesLT].[CustomerAddress].AddressType='Main Office'

select AddressLine1, City, StateProvince, PostalCode, CountryRegion from [SalesLT].[Customer] c
join [SalesLT].[CustomerAddress] ca on c.CustomerID=ca.CustomerID
join [SalesLT].[Address] a on a.AddressID=ca.AddressID
where AddressType='Main Office'
--3. Izdelaj seznam vseh podjetji in kontaktov (ime in priimek), ki vsebuje tudi ID naro�ila
--in skupni dolg. Seznam mora vsebovati tudi kupce, ki niso �e ni�esar naro�ili na koncu
--seznama.
select CompanyName, FirstName, LastName, [SalesOrderID], [TotalDue] from [SalesLT].[Customer]
left join [SalesLT].[SalesOrderHeader]
ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID AND SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID
order by SalesOrderID desc
--4. Izdelaj seznam vseh kupcev, ki nimajo podatkov o naslovu. V seznamu naj bo
--CustomerID, ime podjetja, ime kontakta in telefonska �tevilka vseh, ki nimajo
--podatkov o naslovu.
select Title, AddressID, CompanyName, EmailAddress, Phone from [SalesLT].[Customer]
left join [SalesLT].[CustomerAddress]
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID
where [SalesLT].[CustomerAddress].AddressID is NULL
--5. Radi bi ugotovili katere stranke �e nikoli niso naro�ile in kateri produkti �e nikoli niso
--bili naro�eni. V ta namen izdelaj poizvedbo, ki vra�a CustomerID za vse stranke, ki
--niso �e ni�esar naro�ile in stolpec productID za vse izdelke, ki �e niso bili naro�eni.
--Vsaka vrstica z ID-jem stranke ima pri ProductID NULL, vsak ProductID vrstica ima
--CustomerID NULL.
--[SalesLT].[SalesOrderDetail] [SalesLT].[SalesOrderHeader] [SalesLT].[Product]
select c.CustomerID, NULL as ProductID
FROM [SalesLT].[Customer] c
FULL outer join [SalesLT].[SalesOrderHeader] soh on c.CustomerID = soh.CustomerID
WHERE soh.SalesOrderID IS NULL
UNION ALL
SELECT NULL AS CustomerID, p.ProductID
FROM [SalesLT].[Product] p
FULL OUTER JOIN [SalesLT].[SalesOrderDetail] sod on p.ProductID = sod.ProductID
where sod.SalesOrderDetailID IS NULL
