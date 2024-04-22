--en batch
declare @Ime nvarchar(50);
set @Ime ='Amy'
select * from [SalesLT].[Customer]
where FirstName=@Ime
--konec batcha
declare @varProdukti as table
(ProductID int, ProductName varchar(50))
insert into @varProdukti select ProductID, Name from [SalesLT].[Product]
select * from @varProdukti
--zaèasna tabela v okviru ene seje
create table #temp1
(ProductID int, ProductName varchar(50))
insert into #temp1 select ProductID, Name from [SalesLT].[Product]
select * from #temp1
