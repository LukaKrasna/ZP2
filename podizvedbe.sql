--poizvedbe
--kot stolpec
--podatki o id naroèila, datum naroèila, max cena na naroèilu -unti price
select SalesOrderID, OrderDate,
		(select max(unitprice) from [SalesLT].[SalesOrderDetail] sod
		where sod.SalesOrderID=sod.SalesOrderID) as MaxCena
from [SalesLT].[SalesOrderHeader] soh

--where
--izberi vsa imena produktov,kjer je listprice=list price od 'Touring Tire Tube'
--join
select prd1.Name, prd1.ListPrice from [SalesLT].[Product] prd1
join [SalesLT].[Product] prd2 on prd1.ListPrice=prd2.ListPrice
where prd2.Name='Touring Tire Tube'
-- s poizvedbo
select name from [SalesLT].[Product]
where ListPrice= (select ListPrice from [SalesLT].[Product] where name='Touring Tire Tube')

select name from [SalesLT].[Product] where listPrice=5.489
--where in/not in
--izberi vse produkte iz kategorije Wheels 
select name from [SalesLT].[Product] where ProductCategoryID in (select ProductCategoryID from
[SalesLT].[ProductCategory] where name like '%[b|B]ike%')
-- any/all
select max(ListPrice) from [SalesLT].[Product]
group by [ProductCategoryID]
-- kateri produkti imajo ceno višjo od vsaj ene max cene po kategorijah
select Name, ListPrice from [SalesLT].[Product]
where ListPrice>=all(select max(ListPrice) from [SalesLT].[Product]
group by ProductCategoryID)
-- exists
select salesorderid,max(unitprice) as maxunitePrice from [SalesLT].[SalesOrderDetail]
where salesorderid=71784
group by SalesOrderID

select * from [SalesLT].[udfMaxUnitPrice](71784)

select soh.SalesOrderID,maxunitprice from [SalesLT].[SalesOrderHeader] soh
cross apply [SalesLT].[udfMaxUnitPrice](soh.SalesOrderID)