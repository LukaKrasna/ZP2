use AdventureWorks2019
update Person.Address
set ModifiedDate=GETDATE()

update [Sales].[SalesPerson]
set Bonus=6000,CommissionPct=0.10,SalesQuota=null

--spremeni barvo kolesa v metllic red za vsa kolesa, ki so rdeèa in so Road-250...
select * from [Production].[Product]
where Name like 'Road-250%' and Color='Metallic Red'
update [Production].[Product]
set Color='Red'
where Name like 'Road-250%' and Color='Metallic Red'

select * from [Production].[BillOfMaterials]
where [ProductAssemblyID]=800 and EndDate is null
select * from [Production].[BillOfMaterials]
where [ProductAssemblyID]=518 and EndDate is null
select * from [Production].[BillOfMaterials]
where [ProductAssemblyID]=497 and EndDate is null

--posodobi perassemlyQTY *2 za vse komponente assemblyja 800
with Parts (AssemblyID,ComponentID,PerAssemblyQty,EndDate, ComponentLevel)
as(
	select b.ProductAssemblyID,b.ComponentID,b.PerAssemblyQty,b.EndDate,0 from [Production].[BillOfMaterials] b
	where b.EndDate is null and b.ProductAssemblyID=800
	union all
	select bom.ProductAssemblyID,bom.ComponentID,bom.PerAssemblyQty,bom.EndDate,ComponentLevel+1 from [Production].[BillOfMaterials] bom
	join Parts p on bom.ProductAssemblyID=bom.ComponentID
	where bom.EndDate is null
  )
  --select * from Parts where ComponentLevel=2
  update [Production].[BillOfMaterials]
  set PerAssemblyQty=c.PerAssemblyQty*2
    from [Production].[BillOfMaterials] c
	join Parts p on c.ProductAssemblyID=p.AssemblyID
	where ComponentLevel=2

	select * from Sales.SalesPerson
	--dodaj atributu SalesYTD znesek subtotal zadnjega naroèila za tega potnika 
	select SUM(subtotal),MAX(orderdate) from [Sales].[SalesOrderHeader]
	group by SalesPersonID

	update Sales.SalesPerson
	set SalesYTD=SalesYTD+
		(select SUM(soh.subtotal) from [Sales].[SalesOrderHeader] soh
		where soh.OrderDate=(select MAX(orderDate) from Sales.SalesOrderHeader soh2
							where soh.SalesPersonID=soh2.SalesPersonID)
							and Sales.SalesPerson.BusinessEntityID=soh.SalesPersonID
		group by soh.SalesPersonID)
--ista naloga le drugaèe rešena
update [Sales].[SalesPerson]
set SalesYTD=SalesYTD+subtotal
from [Sales].[SalesPerson] sp
		join [Sales].[SalesOrderHeader] soh on sp.BusinessEntityID=soh.SalesPersonID
		where soh.OrderDate=(select MAX(orderDate) from Sales.SalesOrderHeader soh2
							where SalesPersonID=BusinessEntityID)

--brisanje
delete from [Sales].[SalesPersonQuotaHistory]