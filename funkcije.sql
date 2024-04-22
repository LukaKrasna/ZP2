select ProductID,
		UPPER(name) as Ime, 
		round(weight,0) as Te�a,
		year([SellStartDate]), 
		Datename(m,[SellStartDate]) as Mesec,
		left([ProductNumber],2) as Koda
from [SalesLT].[Product]

select ProductID,
		UPPER(name) as Ime, 
		round(weight,0) as Te�a,
		year([SellStartDate]), 
		Datename(m,[SellStartDate]) as Mesec,
		left([ProductNumber],2) as Koda,
		DATEDIFF(yy,[SellStartDate],[SellEndDate]) as [Leta v prodaji]
from [SalesLT].[Product]
where [SellEndDate] is not null
--logi�ne funkcije
--isumeric('101.2')=1, �e je v nizu �tevilo
select isnumeric(size),SIZE from [SalesLT].[Product]
--iif(pogoj, kaj �e true, kaj �e false)
select name as Ime,
	   iif([ProductCategoryID] in (5,6,7),'Kolesa','Ostalo') as Kategorija
from [SalesLT].[Product]
--choose(ime, �e je vrednost 1, �e je vrednost 2,...)
select name, choose([ProductCategoryID],'Kolesa','Komponente','Drugo')
from [SalesLT].[Product]
where ProductCategoryID<=5
--okenske funkcije
--rank 
--razvrsti (rangiraj) produkte po ceni od najdra�jega do najcenej�ega
select ProductID, name, ListPrice,
		rank() over (order by ListPrice) as Rang
from [SalesLT].[Product]

select ProductID, name, ListPrice,
		dense_rank() over (order by ListPrice) as Rang
from [SalesLT].[Product]

--ragniraj glede na kategorijo
select ProductID, name, ListPrice,
		rank() over (partition by productCategoryID order by ListPrice) as Rang
from [SalesLT].[Product]
order by ProductCategoryID
--rangiraj v enakomerne skupine - 10 skupin po vrstnem redu
select ProductID, name, ListPrice,
		ntile(10) over (order by ListPrice) as Rang
from [SalesLT].[Product]
--rangiranje po vrsti od 1 do zdanje �tevilke
select ProductID, name, ListPrice,
		row_number() over (order by ListPrice) as Rang
from [SalesLT].[Product]

--agregati: count, min, max, sum , avg
select count(*) as [�tevilo izdelkov], count(distinct productcategoryID) as [�t. kategorij],
		avg(listPrice) as Povpre�je, ProductCategoryID from [SalesLT].[Product]
		group by ProductCategoryID