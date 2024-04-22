--1. Izdelati moraš poroèilo o raèunih. V prvem koraku izdelaj poizvedbo, ki vrne ime podjetja
--(CompanyName) iz tabele Customer , poleg tega pa še ID naroèila (salesOrderID) in skupni
--dolg (total due) iz atbele SalesOrderHeader.
select CompanyName, SalesOrderID, TotalDue from [SalesLT].[Customer]
 join SalesLT.SalesOrderHeader
 ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
--2. Razširi poizvedbo tako, da dodaš še naslov »Main Office« za vsakega kupca (naslov ulice,
--mesto, državo/provinco, poštno številko in regijo). Pri tem upoštevaj, da ima vsaka stranka
--veè naslovov v tabeli Address. Zato je naèrtovalec PB ustvaril še tabelo CustomerAddress, da
--je rešil povezavo M:N. Poizvedba mora vsebovati obe tabeli in mora filtrirati prikljuèeno
--tabelo CustomerAddress, tako da vzame samo naslov »Main Office«.
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
--3. Izdelaj seznam vseh podjetji in kontaktov (ime in priimek), ki vsebuje tudi ID naroèila
--in skupni dolg. Seznam mora vsebovati tudi kupce, ki niso še nièesar naroèili na koncu
--seznama.
select CompanyName, FirstName, LastName, [SalesOrderID], [TotalDue] from [SalesLT].[Customer]
left join [SalesLT].[SalesOrderHeader]
ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID AND SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID
order by SalesOrderID desc
--4. Izdelaj seznam vseh kupcev, ki nimajo podatkov o naslovu. V seznamu naj bo
--CustomerID, ime podjetja, ime kontakta in telefonska številka vseh, ki nimajo
--podatkov o naslovu.
select Title, AddressID, CompanyName, EmailAddress, Phone from [SalesLT].[Customer]
left join [SalesLT].[CustomerAddress]
ON SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID
where [SalesLT].[CustomerAddress].AddressID is NULL
--5. Radi bi ugotovili katere stranke še nikoli niso naroèile in kateri produkti še nikoli niso
--bili naroèeni. V ta namen izdelaj poizvedbo, ki vraèa CustomerID za vse stranke, ki
--niso še nièesar naroèile in stolpec productID za vse izdelke, ki še niso bili naroèeni.
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
