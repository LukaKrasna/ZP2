--ansi 89 STAREJ�I NA�IN
--imena produktov in imena kategorij produkta iz tabele product
select p.Name, pc.Name from [SalesLT].[Product] p,[SalesLT].[ProductCategory] pc
where p.ProductCategoryID=pc.ProductCategoryID
--ANSI 92 novej�i
select p.Name as [Ime produkta], pc.Name from [SalesLT].[Product] p
join [SalesLT].[ProductCategory] pc
on p.ProductCategoryID=pc.ProductCategoryID
where p.Name like 'Bicycle%'

select p.Name, pc.Name from [SalesLT].[Product] p
left outer join [SalesLT].[ProductCategory] pc --left outer join - vzemi vse produkte iz tabele produkt in samo ujemajo�e iz ProductCategory
on p.ProductCategoryID=pc.ProductCategoryID

select p.Name, pc.Name from [SalesLT].[Product] p
right outer join [SalesLT].[ProductCategory] pc --right outer join - 
on p.ProductCategoryID=pc.ProductCategoryID

select p.Name, pc.Name from [SalesLT].[Product] p
full outer join [SalesLT].[ProductCategory] pc --full outer join - deluje kot left in right outer join skrati
on p.ProductCategoryID=pc.ProductCategoryID

select p.Name, pc.Name from [SalesLT].[Product] p
cross join [SalesLT].[ProductCategory] pc --cross join - 
