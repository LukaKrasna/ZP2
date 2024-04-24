--1. Napi�i skripto, ki bo vstavljala zapise v tabelo SalesLT.SalesOrderHeader. 
--Uporabnik bo vnesel
--datum naro�ila, datum dobave (DueDate) in �tevilko stranke (CustomerID). SalesOrderID naj
--se generira iz SalesLT.SalesOrderNumber in se shrani kot spremenljivka. 
--Koda, ki to naredi
--SET @OrderID = NEXT VALUE FOR SalesLT.SalesOrderNumber;
--Nato naj skripta vstavi zapis v tabelo, z uporabo teh vrednosti. Metoda dostave (ShipMethod)
--naj bo kar v stavku nastavljena na �CARGO TRANSPORT 5�. Ostale vrednosti naj bodo NULL. Po
--vstavljanju naj skripta izpi�e SalesOrderID s pomo�jo ukaza PRINT. Testirajte kodo na primeru
--Order Date Due Date Customer ID
--Dana�nji datum 7 dni od danes 1

declare @OrderDate datetime =getdate(),
		@DueDate datetime=dateadd(DD,7,getdate()) --lahko tudi tako: @DueDate datetime=getdate()+7
declare @CustomerID int = 1
declare @OrderID int;
set @OrderID= next value for [SalesLT].[SalesOrderNumber]
insert into [SalesLT].[SalesOrderHeader] (SalesOrderId, OrderDate,DueDate,CustomerID,ShipMethod)
values
(@OrderID,@OrderDate,@DueDate,@CustomerID,'CARGO TRANSPORT 5')
print @orderid
--2. Napi�ite skripto, ki bo dodajala zapise v SalesOrderDetails tabelo. Uporabnik bo vnesel Id
--naro�ila (SalesOrderID), ID produkta (ProductID), koli�ino (Quantity) in ceno za enoto
--(UnitPrice). Skripta naj najprej preveri ali obstaja ta specifi�en ID v glavah naro�il. �e obstaja,
--naj naro�ilo vstavi v tabelo podrobnosti, kjer naj bodo vrednosti NULL za nedolo�ene
--vrednosti stolpcev. �e ID ne obstaja v glavi naro�il, naj izpi�e �Naro�ilo ne obstaja�.
--Uporabite lahko EXSITS. Testirajte kodo na primeru
--Sales Order ID Product ID Quantity Unit Price
--Id, ki ste ga dobili v
--prej�njem primeru
--760 1 782.99
declare @SalesOrderID int,
		@ProductID int,
		@Quantity int,
		@UnitPrice decimal(10,2);
set @SalesOrderID=160;
set @ProductID=1;
set @Quantity=1;
set @UnitPrice=782.99;
if exists (select * from [SalesLT].[SalesOrderHeader] where [SalesOrderID]=@SalesOrderID)
begin
insert into [SalesLT].[SalesOrderDetail] (SalesOrderID, ProductID, OrderQty, UnitPrice)
values (@SalesOrderID, @ProductID, @Quantity, @UnitPrice);
	print 'Podrobnisti '; end
else begin
	print ''; end

--3. Pri Adventure Works so ugotovili, da je povpre�na cena kolesa na trgu $2000 in da je najvi�ja
--cena, ki jo je stranka �e pripravljena pla�ati za kolo $5000. Napisati mora� skripto, ki
--postopoma ve�a prodajno ceno koles po 10%, dokler ne bo povpre�na cena kolesa vsaj enaka
--povpre�ni ceni na trgu ali dokler ne postane najdra�je kolo dra�je kot sprejemljiv maksimum
--cene. Napi�i zanko:
--a. Izvaja naj se samo, �e je povpre�na cena v star�evski kategoriji 'Bikes' ni�ja kot $2000.
--Vse kategorije produkt v star�evski kategoriji 'Bikes' lahko dobi� v pogledu
--SalesLT.vGetAllCategories
--b. Posodobi vse produkte v tej kategoriji, tako da jim zvi�a� ceno za 10%
--c. Preveri novo povpre�no ceno in najvi�jo ceno v tej kategoriji
--d. �e je nov maksimum ve�ji od $5000 kon�aj z izvajanjem, sicer ponovi

select * from SalesLT.vGetAllCategories
declare @MarketPovp money=2000
declare @marketMax money=5000
declare @AWMax money;
declare @AWPovp money;
select @AWPovp=AVG(Listprice), @AWMAx=MAX(ListPrice) from [SalesLT].[Product]
where ProductCategoryID in 
							(select ProductCategoryID from SalesLT.vGetAllCategories
							where ParentProductCategoryName='Bikes')
while @AWPovp <@MarketPovp
begin
	update [SalesLT].[Product]
	set ListPrice=ListPrice*1.1
	where ProductCategoryID in
							(select ProductCategoryID from SalesLT.vGetAllCategories
							where ParentProductCategoryName='Bikes')

select @AWPovp=AVG(Listprice), @AWMAx=MAX(ListPrice) from [SalesLT].[Product]
where ProductCategoryID in 
							(select ProductCategoryID from SalesLT.vGetAllCategories
							where ParentProductCategoryName='Bikes')

if @AWMax>=@marketMax
	break
	else
	continue
end
print 'Nova povpre�na cena '+convert(nvarchar,@AWPovp)
print 'Nova max cena' + convert(nvarchar,@AWMAx)