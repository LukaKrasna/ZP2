--1. Napiši skripto, ki bo vstavljala zapise v tabelo SalesLT.SalesOrderHeader. 
--Uporabnik bo vnesel
--datum naroèila, datum dobave (DueDate) in številko stranke (CustomerID). SalesOrderID naj
--se generira iz SalesLT.SalesOrderNumber in se shrani kot spremenljivka. 
--Koda, ki to naredi
--SET @OrderID = NEXT VALUE FOR SalesLT.SalesOrderNumber;
--Nato naj skripta vstavi zapis v tabelo, z uporabo teh vrednosti. Metoda dostave (ShipMethod)
--naj bo kar v stavku nastavljena na ‘CARGO TRANSPORT 5’. Ostale vrednosti naj bodo NULL. Po
--vstavljanju naj skripta izpiše SalesOrderID s pomoèjo ukaza PRINT. Testirajte kodo na primeru
--Order Date Due Date Customer ID
--Današnji datum 7 dni od danes 1

declare @OrderDate datetime =getdate(),
		@DueDate datetime=dateadd(DD,7,getdate()) --lahko tudi tako: @DueDate datetime=getdate()+7
declare @CustomerID int = 1
declare @OrderID int;
set @OrderID= next value for [SalesLT].[SalesOrderNumber]
insert into [SalesLT].[SalesOrderHeader] (SalesOrderId, OrderDate,DueDate,CustomerID,ShipMethod)
values
(@OrderID,@OrderDate,@DueDate,@CustomerID,'CARGO TRANSPORT 5')
print @orderid
--2. Napišite skripto, ki bo dodajala zapise v SalesOrderDetails tabelo. Uporabnik bo vnesel Id
--naroèila (SalesOrderID), ID produkta (ProductID), kolièino (Quantity) in ceno za enoto
--(UnitPrice). Skripta naj najprej preveri ali obstaja ta specifièen ID v glavah naroèil. Èe obstaja,
--naj naroèilo vstavi v tabelo podrobnosti, kjer naj bodo vrednosti NULL za nedoloèene
--vrednosti stolpcev. Èe ID ne obstaja v glavi naroèil, naj izpiše »Naroèilo ne obstaja«.
--Uporabite lahko EXSITS. Testirajte kodo na primeru
--Sales Order ID Product ID Quantity Unit Price
--Id, ki ste ga dobili v
--prejšnjem primeru
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

--3. Pri Adventure Works so ugotovili, da je povpreèna cena kolesa na trgu $2000 in da je najvišja
--cena, ki jo je stranka še pripravljena plaèati za kolo $5000. Napisati moraš skripto, ki
--postopoma veèa prodajno ceno koles po 10%, dokler ne bo povpreèna cena kolesa vsaj enaka
--povpreèni ceni na trgu ali dokler ne postane najdražje kolo dražje kot sprejemljiv maksimum
--cene. Napiši zanko:
--a. Izvaja naj se samo, èe je povpreèna cena v starševski kategoriji 'Bikes' nižja kot $2000.
--Vse kategorije produkt v starševski kategoriji 'Bikes' lahko dobiš v pogledu
--SalesLT.vGetAllCategories
--b. Posodobi vse produkte v tej kategoriji, tako da jim zvišaš ceno za 10%
--c. Preveri novo povpreèno ceno in najvišjo ceno v tej kategoriji
--d. Èe je nov maksimum veèji od $5000 konèaj z izvajanjem, sicer ponovi

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
print 'Nova povpreèna cena '+convert(nvarchar,@AWPovp)
print 'Nova max cena' + convert(nvarchar,@AWMAx)