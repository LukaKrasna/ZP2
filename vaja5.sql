--Za pomoè imate spletno stran Built-In Functions: https://learn.microsoft.com/en-us/sql/t-sql/functions/functions?view=sql-server-ver16
--1. Napišite poizvedbo, ki vraèa ID produkta, ime produkta z velikimi tiskanimi èrkami in stolpec
--Teža, ki zaokroži težno na prvo celo število.
select ProductID,
		UPPER(name) as [Ime produkta], 
		round(weight,0) as Teža
from [SalesLT].[Product]
--2. Razširite prvo poizvedbo tako, da dodate LetoZaèetkaProdaja, ki vsebuje leto atributa
--SellStartDate in MesecZaèProdaje, ki vsebuje mesec istega atributa. V stolpcu naj bo ime
--meseca (na primer 'January')
select ProductID,
		UPPER(name) as Ime, 
		round(weight,0) as Teža,
		year([SellStartDate]) as LetoZaèetkaProdaja,
		DATENAME(m, SellStartDate) as MesecZaèetkaProdaja
from [SalesLT].[Product]
--3. Dodajte poizvedbi še stolpec z imenom Tip, ki vsebuje prvi dve èrki atributa ProductNumber.
select ProductID,
		UPPER(name) as Ime, 
		round(weight,0) as Teža,
		year([SellStartDate]) as LetoZaèetkaProdaja,
		DATENAME(m, SellStartDate) as MesecZaèetkaProdaja,
		left([ProductNumber],2) as Tip 
from [SalesLT].[Product]
--4. Dodajte poizvedbi še filter, tako da bodo rezultat samo tisti produkti, ki imajo pod atributom
--Size napisano število (ne pa 'S', 'M' ali 'L').
--Pri reševanju si pomagajte z dokumentom https://docs.microsoft.com/en-us/sql/tsql/functions/ranking-functions-transact-sql
select ProductID,
		UPPER(name) as Ime, 
		round(weight,0) as Teža,
		year([SellStartDate]) as LetoZaèetkaProdaja,
		DATENAME(m, SellStartDate) as MesecZaèetkaProdaja,
		left([ProductNumber],2) as Tip,
		Size as Velikost
from [SalesLT].[Product]
where try_cast(Size as int)is not null
--5. Napišite poizvedbo, ki vrne seznam imen podjetji in njihovo mesto v rangu, èe jih rangirate
--glede na najvišjo vrednost atributa TotalDue iz tabele SalesOrderHeader.
--Pri reševanju si pomagajte s https://docs.microsoft.com/en-us/sql/t-sql/queries/select-groupby-transact-sql
--[SalesLT].[Customer], [SalesLT].[SalesOrderHeader]
select c.CompanyName,
		max(soh.TotalDue) as Najvišji, 
		rank() over (order by max(TotalDue)desc) as Rank
from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] soh on c.CustomerID = soh.CustomerID
group by CompanyName
order by Rank
--6. Napišite poizvedbo, ki izpiše imena produktov in skupno vsoto izraèunano kot vsoto atributa
--LineTotal iz SalesOrderDetail tabele. Rezultat naj bo urejen po padajoèi vrednosti skupne
--vsote.
select p.[Name],sum([LineTotal]) as vsota from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] ON p.ProductID = SalesLT.SalesOrderDetail.ProductID
group by p.[Name]
order by vsota desc
--7. Spremenite prejšnjo poizvedbo tako, da vkljuèuje samo tiste produkte, ki imajo atribut
--ListPrice veè kot 1000$.
select p.[Name],sum([LineTotal]) as vsota from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] ON p.ProductID = SalesLT.SalesOrderDetail.ProductID
where ListPrice>=1000
group by p.[Name]
order by vsota desc
--8. Spremenite prejšnjo poizvedbo, da bo vsebovala samo skupine, ki imajo skupno vrednost
--prodaje veèjo kot 20.000$.
select p.[Name],sum([LineTotal]) as vsota from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] ON p.ProductID = SalesLT.SalesOrderDetail.ProductID
where ListPrice>=1000
group by p.[Name]
having sum(LineTotal)>20000
order by vsota desc