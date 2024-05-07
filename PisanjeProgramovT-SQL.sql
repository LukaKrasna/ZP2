-- brez transakcije
set xact_abort on;
begin try
begin transaction
	insert into SalesLT.SalesOrderHeader(DueDate, CustomerID,ShipMethod)
	values
	(DATEADD(dd,7,GETDATE()),1,'STD DELIVERY')
	declare @SalesOrderID int=SCOPE_IDENTITY();

	insert into
	SalesLT.SalesOrderDetail(SalesOrderID,OrderQty,ProductID,UnitPrice,UnitPriceDiscount)
	values
	(@SalesOrderID,1,99999,1431.50,0.00);
commit transaction
end try
begin catch
  --if @@TRANCOUNT>0
  --  rollback transaction
  if @@TRANCOUNT>0
	throw 50001,'Tranzakcija ni uspela.',0
 --print ERROR_MESSAGE();
end catch;
set xact_abort off;
--naroèila brez podrobnosti
select h.SalesOrderID,h.DueDate,h.CustomerID,h.ShipMethod,d.SalesOrderDetailID from
SalesLT.SalesOrderHeader as h
Left join SalesLT.SalesOrderDetail as d
on d.SalesOrderID=h.SalesOrderID
where d.SalesOrderDetailID is null;
--briši naroèilo
delete from SalesLT.SalesOrderHeader
where SalesOrderID=SCOPE_IDENTITY();
--transakicja
begin try
begin transaction
insert into SalesLT.SalesOrderHeader(DueDate, CustomerID,ShipMethod)
values
(DATEADD(dd,7,GETDATE()),1,'STD DELIVERY')
declare @SalesOrderID1 int=SCOPE_IDENTITY();
insert into
SalesLT.SalesOrderDetail(SalesOrderID,OrderQty,ProductID,UnitPrice,UnitPriceDiscount)
values
(@SalesOrderID1,1,99999,1431.50,0.00);
commit transaction
end try
begin catch
 if @@TRANCOUNT>0
 begin
 print XACt_STATE();
 ROLLBACK TRANSACTION
 end
 print ERROR_MESSAGE();
 throw 50001,'Vstavljanje ni uspelo',0;
end catch;
--naroèila brez podrobnosti
select h.SalesOrderID,h.DueDate,h.CustomerID,h.ShipMethod,d.SalesOrderDetailID from
SalesLT.SalesOrderHeader as h
Left join SalesLT.SalesOrderDetail as d
on d.SalesOrderID=h.SalesOrderID
where d.SalesOrderDetailID is null;
5
--avtomatski ROLLBACK
SET XACT_ABORT ON;
begin try
begin transaction
insert into SalesLT.SalesOrderHeader(DueDate, CustomerID,ShipMethod)
values
(DATEADD(dd,7,GETDATE()),1,'STD DELIVERY')
declare @SalesOrderID2 int=SCOPE_IDENTITY();
insert into
SalesLT.SalesOrderDetail(SalesOrderID,OrderQty,ProductID,UnitPrice,UnitPriceDiscount)
values
(@SalesOrderID2,1,99999,1431.50,0.00);
commit transaction
end try
begin catch
 print ERROR_MESSAGE();
 throw 50001,'Vstavljanje ni uspelo',0;
end catch;
SET XACT_ABORT OFF;
--naroèila brez podrobnosti
delete from SalesLT.SalesOrderDetail where SalesOrderDetailID is null

select h.SalesOrderID,h.DueDate,h.CustomerID,h.ShipMethod,d.SalesOrderDetailID from
SalesLT.SalesOrderHeader as h
Left join SalesLT.SalesOrderDetail as d
on d.SalesOrderID=h.SalesOrderID
where d.SalesOrderDetailID is null and DueDate>'2024/5/5';
--briši naroèilo
delete from SalesLT.SalesOrderHeader
where @SalesOrderID is null;