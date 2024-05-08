--baza je AdventureWorksLT2019
--1. Iz tabele SalesLT.Customer izpi�i vse stranke, ki nimajo e-po�tnega naslova. Izpis naj bo v
--obliki (rezultat ima 124 vrstic).

--Stranka
--Mr. OrlandoN. Gee
--Ms. LindaE. Burnett
--Mr. Bryan Hamilton
select * from [SalesLT].[Customer]
select CONCAT(Title,' ',FirstName,' ',ISNULL(MiddleName,''),' ',LastName) as Stranka
from [SalesLT].[Customer] where [EmailAddress] is null

--update [SalesLT].[Customer]
--set EmailAddress = null
--where CustomerID%10=0

--2. Iz tabele SalesLT.Product bi �eleli izpisati imena (Name) produktov, pri katerih se v imenu
--kategorije pojavlja 'Bike' (imamo Mountain Bike, Bike, Bike racks,�.). V rezultatu naj bo ime
--stolpca �Artikli� (re�itev ima 99 vrstic)
select * from [SalesLT].[Product]
select p.Name as Artikli
from [SalesLT].[Product] p
join [SalesLT].[ProductCategory] pc
ON pc.ProductCategoryID = p.ProductCategoryID
where pc.Name like '%Bike%'
--druga mo�nost
select p.Name as Artikli
from [SalesLT].[Product] as p
where p.ProductCategoryID in (select ProductCategoryID from [SalesLT].[ProductCategory] where Name like '%Bike%')

--3. Izpi�i imena (Name) in cene (ListPrice) 10% najdra�jih artiklov iz SalesLT.Product (31 vrstic)
select * from [SalesLT].[Product]
select top 10 percent Name, ListPrice from [SalesLT].[Product]
order by ListPrice

--4. Izpi�i ime star�evske kategorija (ParentProductCategoryName), ime kategorije
--(ProductCategoryName) in ime (Name) produkta iz tabele SalesLT.Product in iz pogleda
--SalesLT.vGetAllCategories. (re�itev ima 299 vrstic)
select * from [SalesLT].[vGetAllCategories]
select * from [SalesLT].[Product]
select ParentProductCategoryName , ProductCategoryName, Name from [SalesLT].[Product] p
join [SalesLT].[vGetAllCategories] v ON v.ProductCategoryID=p.ProductCategoryID
order by ParentProductCategoryName
--5. V tabeli SalesLT.ProductCategory imamo podatke o kategorijah. Tabela je povezana sama s
--seboj, saj so v njej zapisani podatki o glavnih kategorijah (ParentProductCategoryID) in o
--podkategorijah (ProductCategoryName). Zna�ilno je, da imajo glavne kategorije vrednost
--ParentProductCategoryID enako NULL. Napi�i poizvedbo, ki vra�a ParentProductCategoryID,
--ProductCategoryID in Name iz tabele SalesLT.ProductCategory. Rezultat je oblike (ni v celoti)

--Kategorija ProductCatogoryID Name
--NULL 1 Bikes
--NULL 2 Components
--NULL 3 Clothing
--NULL 4 Accessories
--Bikes 5 Mountain Bikes
--Bikes 6 Road Bikes
select * from [SalesLT].[ProductCategory]
select ParentProductCategoryID, ProductCategoryID, Name from [SalesLT].[ProductCategory]

--6. Izpi�ite imena (Name) in povpre�ne cene (UnitPrice) produkta iz tabele
--SalesLT.SalesOrderDetail, v izpisu naj bo tudi rang artikla od tistega z najvi�jo povpre�no
--ceno, do tistega z najni�jo povpre�no ceno.
select p.Name,AVG(sod.UnitPrice) as AverageUnitPrice,
RANK()over(order by avg(sod.unitPrice)desc) as rang
from [SalesLT].[SalesOrderDetail] sod
join [SalesLT].[Product] p on p.ProductID=sod.ProductID
group by p.Name
order by rang

--7. Poi��i seznam strank v obliki Company (Contact Name), skupni prihodki za vsako stranko.
--Uporabi CTE, da poi��e� podatek TotalDue iz tabele SalesLT.SalesOrderHeader in podatke o
--stranki iz SalesLT.Customer, nato pa naredi poizvedbo po novi tabeli, tako da agregira� in
--sumira� podatke.
with Prihodki as (
						select c.Title, c.Suffix, c.FirstName, c.MiddleName, c.LastName, SUM(soh.TotalDue) as SkupniPrihodek from [SalesLT].[Customer] c
						join [SalesLT].[SalesOrderHeader] soh on soh.CustomerID = c.CustomerID group by c.CustomerID, c.CompanyName, c.FirstName, c.LastName
					   )
select CompanyName + ' ('+ ContactName + ')' as CompanyContact
SkupniPrihodek from Prihodki
order by SkupniPrihodki desc;

with Prodaja(kontakt,vrednost)
as
(
	select c.CompanyName+' ('+c.FirstName+' '+c.LastName+')', soh.TotalDue from [SalesLT].[SalesOrderHeader] soh
	join [SalesLT].[Customer] c on soh.CustomerID = c.CustomerID
)
select kontakt,SUM(vrednost) as vrednost from Prodaja
group by kontakt
--8. Izpi�i koliko je produktov v posamezni kategoriji, v okviru kategorije pa �e v star�evski
--kategoriji in vseh artiklov skupaj. ( pomagaj si z nalogo 4., v kategoriji Bikes je tako 97
--artiklov, v Accessories 33,�, vseh skupaj je 299)
select ParentProductCategoryName , ProductCategoryName, COUNT(p.ProductID) 
from [SalesLT].[Product] p
join [SalesLT].[vGetAllCategories] v ON v.ProductCategoryID=p.ProductCategoryID
group by rollup(ParentProductCategoryName, ProductCategoryName)
order by ProductCategoryName