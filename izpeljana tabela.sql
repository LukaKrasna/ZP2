--koliko razliènih strank je imelo naroèilo v enem letu npr.: 2020 7, 2021 8, 2022 34
select year([OrderDate]), COUNT(distinct CustomerID) from [SalesLT].[SalesOrderHeader]
group by OrderDate
-- zgornja poizvedba ni v redu. uporabimo izpeljano tabelo
select leto, COUNT(distinct customerID) from (select YEAR(OrderDate) as leto, customerID from [SalesLT].[SalesOrderHeader]) as izpeljana
group by leto

select leto, COUNT(distinct id) from (select YEAR(OrderDate) as leto, customerID from [SalesLT].[SalesOrderHeader]) as izpeljana(leto,id)
group by leto;
--CTE with, velja za enega naslednjih stavkov
with cte_leto(leto,id)
as
(select YEAR(OrderDate), customerID from [SalesLT].[SalesOrderHeader])
select leto, COUNT(distinct id) from cte_leto group by leto;

--izpiši neposredno nadrejene
with DirectReports(ManagerID, EmployeeID,Title,EmployeeLevel) as (select ManagerID, EmployeeID,Title,0 as EmployeeLevel from [dbo].[MyEmployees]
					where ManagerID is null
					union all
					select e.ManagerID, e.EmployeeID, e.Title, EmployeeLevel+1 from [dbo].[MyEmployees] e
					join DirectReports d on e.ManagerID=d.EmployeeId)
select * from DirectReports order by ManagerID


--isto le da izpisujem Ken Sanchez, |Brian..,||David - prikazuje kdo je komu podrejen/nadrejen
with DirectReports(Ime, Title,EmployeeId,EmployeeLevel) as 
					(select convert(nvarchar(255), FirstName+' '+LastName), Title,EmployeeID,1 as EmployeeLevel from [dbo].[MyEmployees]
					where ManagerID is null
					union all
					select convert(nvarchar(255), REPLICATE('|  ', EmployeeLevel)+e.FirstName+' '+e.LastName), e.Title, e.EmployeeID, EmployeeLevel+1 from [dbo].[MyEmployees] e
					join DirectReports d on e.ManagerID=d.EmployeeId)
select * from DirectReports order by Ime desc