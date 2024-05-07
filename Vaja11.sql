--1. Denimo, da ima� spodnjo kodo za brisanje zapisov iz naro�il in podrobnosti naro�il.
DECLARE @SalesOrderID int = <the_order_ID_to_delete> 
DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
--Koda se vedno izvede, ne glede na to ali naro�ilo z izbrano �tevilko obstaja ali ne. Dodaj kodo, ki bo
--spro�ila napako v primeru, da �tevilka naro�ila ne obstaja in izpisala sporo�ilo, ko se napaka zgodi.

--2. Popravi kodo v prej�nji nalogi tako, da se bosta obe brisanji izvedli kot transakcija. V
--obravnavi napak spremeni kodo tako, da : �e je transakcija na pol izvedena, naj se povrne
--baza v prej�nje stanje in naj ponovno spro�i napako. �e transakcija ni v teku, naj preprosto
--izpi�e napako. Testiraj kodo tako, da da� med oba DELETE stavka en THROW stavek, ki bo
--spro�il izjemo in prekinil transakcijo.

select SalesOrderID from [SalesLT].[SalesOrderDetail]

DECLARE @SalesOrderID int = 71938;
begin try
	begin transaction 
	if not exists (select * from [SalesLT].[SalesOrderHeader] where SalesOrderID = @SalesOrderID)
	begin
		throw 50001,'ID ne obstaja!',0
	end
	DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
	DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
	throw 50001, 'Napaka med brisanjem tabel!', 0
	commit transaction
end try
begin catch
	if @@TRANCOUNT > 0
		begin
			rollback transaction;
			print 'Napaka med tranzakcijo, spremembe so povrnjene.';
		end
	print ERROR_MESSAGE();
	throw;
end catch

-----------------------------------------------------------------------Re�itev:
select [SalesOrderID] from [SalesLT].[SalesOrderHeader]

declare @SalesOrderID INT = 71782;
begin try
begin transaction
if not exists (select * from [SalesLT].[SalesOrderHeader] where [SalesOrderID] = @SalesOrderID)
begin
throw 50001, 'Naro�ilo z navedenim Id ne obstaja', 1;
end
delete from [SalesLT].[SalesOrderDetail] where [SalesOrderID] = @SalesOrderID;
throw 51000, 'Napaka med brisanjem podrobnosti naro�ila.', 1;
delete from [SalesLT].[SalesOrderHeader] where [SalesOrderID] = @SalesOrderID;
commit transaction
end try
begin catch
if @@TRANCOUNT > 0
begin
rollback transaction;
print 'Napaka med transakcijo, spremembe so povrnjene';
end
print ERROR_MESSAGE();
throw;
end catch