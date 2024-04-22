--1. Izdelaj poizvedbo, ki bo vsebovala Id produkta, ime produkta in povzetek produkta (Summary) iz
--SalesLT.Product tabele in SalesLT.vProductModelCatalogDescription pogleda.
select p.ProductID, p.Name, pmcd.Summary  
from [SalesLT].[Product] p, [SalesLT].[vProductModelCatalogDescription] pmcd
--2. Izdelaj tabelari�no spremenljivko in jo napolni s seznamom razli�nih barv iz tabele SalesLT.Product.
--Nato uporabi spremenljivko kot filter poizvedbe, ki vra�a ID produkta, ime, barvo iz tabele
--SalesLT.Product in samo tiste izdelke, ki imajo barvo v zgoraj definirani za�asni tabeli (rezultat vsebuje 245 vrstic)

--3. Podatkovna baza AdventureWorksLT vsebuje funkcijo dbo.ufnGetAllCategories, ki vra�a tabelo
--kategorij produktov (na primer 'Road Bikes') in roditeljske kategorije (na primer 'Bikes'). Napi�i
--poizvedbo, ki uporablja to funkcijo in vra�a seznam izdelkov, skupaj s kategorijo in roditeljsko kategorijo.
select * from dbo.ufnGetAllCategories(),[SalesLT].[Product] 
--4. Poi��i seznam strank v obliki Company (Contact Name), skupni prihodki za vsako stranko. Uporabi
--izpeljano tabelo, da poi��e� naro�ila, nato pa naredi poizvedbo po izpeljani tabeli, da agregira� in sumira� podatke.
--BikeStore(orlando Gee)
select CompanyName, CustomerID, ContactName, sum(SkupniPrihodek) as SumedTotalDue from (select CompanyName, c.[CustomerID], convert(nvarchar(255),FirstName+' '+LastName), TotalDue from [SalesLT].[Customer] c
				join [SalesLT].[SalesOrderHeader] s on c.CustomerID=s.CustomerID) as Company(CompanyName, CustomerID, ContactName, SkupniPrihodek)
group by ContactName, CompanyName, CustomerID
order by SumedTotalDue desc;
--5. Ista naloga kot prej, le da namesto izpeljane tabele uporabi� CTE
with cte_Company(CompanyName, CustomerID, ContactName, SkupniPrihodek)
as
(select CompanyName, c.[CustomerID], convert(nvarchar(255),FirstName+' '+LastName), TotalDue from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] s on c.CustomerID=s.CustomerID)
select CompanyName, CustomerID, ContactName, sum(SkupniPrihodek) as SumedTotalDue from cte_Company
group by ContactName, CompanyName, CustomerID
order by SumedTotalDue desc