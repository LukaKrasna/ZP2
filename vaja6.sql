--Pri re�evanju si pomagajte s spletno stranjo https://technet.microsoft.com/library/ms189575.aspx
--1. Poi��i ID produkta, ime in ceno produkta (list price) za vsak produkt, kje je cena produkta
--ve�ja od povpre�ne cene na enoto (unit price) za vse produkte, ki smo jih prodali
select ProductID,name,ListPrice from [SalesLT].[Product]
where ListPrice> (select avg(unitPrice) from [SalesLT].[SalesOrderDetail])
order by ListPrice
--2. Poi��i ID produkta, ime in ceno produkta (list price) za vsak produkt, kjer je cena (list) 100$ ali
--ve� in je bil produkt prodan (unit price) za manj kot 100$.
select p.[ProductID], Name, ListPrice, sod.UnitPrice 
from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] sod on sod.ProductID=p.ProductID
where ListPrice>=100 and sod.UnitPrice<100
--3. Poi��i ID produkta, ime in ceno produkta (list price) in proizvodno ceno (standardcost) za vsak
--produkt skupaj s povpre�no ceno, po kateri je bil produkt prodan.
select ProductID, Name, ListPrice, StandardCost,
		(select avg(unitPrice) from [SalesLT].[SalesOrderDetail] sod
		where sod.ProductID=p.ProductID) as PovpProdaja
from [SalesLT].[Product] p
--4. Filtriraj prej�njo poizvedbo, da bo vsebovala samo produkte, kjer je cena proizvodnje (cost
--price) ve�ja od povpre�ne prodajne cene.
--Pri re�evanju si pomagaj z naslovom https://technet.microsoft.com/library/ms175156.aspx
select ProductID, Name, ListPrice, StandardCost,
		(select avg(unitPrice) from [SalesLT].[SalesOrderDetail] sod
		where sod.ProductID=p.ProductID) as PovpProdaja
from [SalesLT].[Product] p
where StandardCost>(select avg(unitPrice) from [SalesLT].[SalesOrderDetail] sod
		where sod.ProductID=p.ProductID)
--5. Poi��i ID naro�ila, ID stranke, Ime in priimek stranke in znesek dolga za vsa naro�ila v
--SalesLT.SalesOrderHeader s pomo�jo funkcije dbo.ufnGetCustomerInformation
select * from [dbo].[ufnGetCustomerInformation](10)
select soh.[SalesOrderID], soh.[CustomerID], ci.FirstName, ci.LastName, soh.TotalDue
from [SalesLT].[SalesOrderHeader] soh
cross apply [dbo].[ufnGetCustomerInformation](soh.CustomerID) ci
--6. Poi��i ID stranke, Ime in priimek stranke, naslov in mesto iz tabele SalesLT.Address in iz
--tabele SalesLT.CustomerAddress s pomo�jo funkcije dbo.ufnGetCustomerInformation
select ca.CustomerID, ci.FirstName, ci.LastName, a.AddressLine1, a.City from [SalesLT].[Address] a
join [SalesLT].[CustomerAddress] ca on ca.AddressID=a.AddressID
cross apply [dbo].[ufnGetCustomerInformation](ca.CustomerID) ci