--Za pomo� imate spletno stran Built-In Functions: https://learn.microsoft.com/en-us/sql/t-sql/functions/functions?view=sql-server-ver16
--1. Napi�ite poizvedbo, ki vra�a ID produkta, ime produkta z velikimi tiskanimi �rkami in stolpec
--Te�a, ki zaokro�i te�no na prvo celo �tevilo.
select ProductID,
		UPPER(name) as [Ime produkta], 
		round(weight,0) as Te�a
from [SalesLT].[Product]
--2. Raz�irite prvo poizvedbo tako, da dodate LetoZa�etkaProdaja, ki vsebuje leto atributa
--SellStartDate in MesecZa�Prodaje, ki vsebuje mesec istega atributa. V stolpcu naj bo ime
--meseca (na primer 'January')
select ProductID,
		UPPER(name) as Ime, 
		round(weight,0) as Te�a,
		year([SellStartDate]) as LetoZa�etkaProdaja,
		DATENAME(m, SellStartDate) as MesecZa�etkaProdaja
from [SalesLT].[Product]
--3. Dodajte poizvedbi �e stolpec z imenom Tip, ki vsebuje prvi dve �rki atributa ProductNumber.
select ProductID,
		UPPER(name) as Ime, 
		round(weight,0) as Te�a,
		year([SellStartDate]) as LetoZa�etkaProdaja,
		DATENAME(m, SellStartDate) as MesecZa�etkaProdaja,
		left([ProductNumber],2) as Tip 
from [SalesLT].[Product]
--4. Dodajte poizvedbi �e filter, tako da bodo rezultat samo tisti produkti, ki imajo pod atributom
--Size napisano �tevilo (ne pa 'S', 'M' ali 'L').
--Pri re�evanju si pomagajte z dokumentom https://docs.microsoft.com/en-us/sql/tsql/functions/ranking-functions-transact-sql
select ProductID,
		UPPER(name) as Ime, 
		round(weight,0) as Te�a,
		year([SellStartDate]) as LetoZa�etkaProdaja,
		DATENAME(m, SellStartDate) as MesecZa�etkaProdaja,
		left([ProductNumber],2) as Tip,
		Size as Velikost
from [SalesLT].[Product]
where try_cast(Size as int)is not null
--5. Napi�ite poizvedbo, ki vrne seznam imen podjetji in njihovo mesto v rangu, �e jih rangirate
--glede na najvi�jo vrednost atributa TotalDue iz tabele SalesOrderHeader.
--Pri re�evanju si pomagajte s https://docs.microsoft.com/en-us/sql/t-sql/queries/select-groupby-transact-sql
--[SalesLT].[Customer], [SalesLT].[SalesOrderHeader]
select c.CompanyName,
		max(soh.TotalDue) as Najvi�ji, 
		rank() over (order by max(TotalDue)desc) as Rank
from [SalesLT].[Customer] c
join [SalesLT].[SalesOrderHeader] soh on c.CustomerID = soh.CustomerID
group by CompanyName
order by Rank
--6. Napi�ite poizvedbo, ki izpi�e imena produktov in skupno vsoto izra�unano kot vsoto atributa
--LineTotal iz SalesOrderDetail tabele. Rezultat naj bo urejen po padajo�i vrednosti skupne
--vsote.
select p.[Name],sum([LineTotal]) as vsota from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] ON p.ProductID = SalesLT.SalesOrderDetail.ProductID
group by p.[Name]
order by vsota desc
--7. Spremenite prej�njo poizvedbo tako, da vklju�uje samo tiste produkte, ki imajo atribut
--ListPrice ve� kot 1000$.
select p.[Name],sum([LineTotal]) as vsota from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] ON p.ProductID = SalesLT.SalesOrderDetail.ProductID
where ListPrice>=1000
group by p.[Name]
order by vsota desc
--8. Spremenite prej�njo poizvedbo, da bo vsebovala samo skupine, ki imajo skupno vrednost
--prodaje ve�jo kot 20.000$.
select p.[Name],sum([LineTotal]) as vsota from [SalesLT].[Product] p
join [SalesLT].[SalesOrderDetail] ON p.ProductID = SalesLT.SalesOrderDetail.ProductID
where ListPrice>=1000
group by p.[Name]
having sum(LineTotal)>20000
order by vsota desc