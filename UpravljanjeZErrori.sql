insert into [SalesLT].[SalesOrderDetail]
(SalesOrderID,OrderQty,ProductID,UnitPrice,UnitPriceDiscount)
values(100000,1,680,1431.50,0.00)

update [SalesLT].[Product]
set DiscontinuedDate=GETDATE()
where ProductID=0 --ni napaka, samo na 0 vrstic smo vplivali
if @@ROWCOUNT<1
	THROW 50001,'Produkt ni najden - niè ni posodobljeno',0

update [SalesLT].[Product]
set DiscontinuedDate=GETDATE()
where ProductID=0 --ni napaka, samo na 0 vrstic smo vplivali
if @@ROWCOUNT<1
	RAISERROR('Produkt ni najden - niè ni posodobljeno',16,0)
--ERROR_NUMBER()
--ERROR_MESSAGE()


declare @popust int=0
begin try 
	update [SalesLT].[Product]
	set ListPrice=ListPrice/@popust
end try
begin catch
	print Error_Message();
	throw 50001,'Prišlo je do napake',0
end catch