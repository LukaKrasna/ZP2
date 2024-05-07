--1. Denimo, da imaš spodnjo kodo za brisanje zapisov iz naroèil in podrobnosti naroèil.
DECLARE @SalesOrderID int = <the_order_ID_to_delete> 
DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
--Koda se vedno izvede, ne glede na to ali naroèilo z izbrano številko obstaja ali ne. Dodaj kodo, ki bo
--sprožila napako v primeru, da številka naroèila ne obstaja in izpisala sporoèilo, ko se napaka zgodi.

--2. Popravi kodo v prejšnji nalogi tako, da se bosta obe brisanji izvedli kot transakcija. V
--obravnavi napak spremeni kodo tako, da : Èe je transakcija na pol izvedena, naj se povrne
--baza v prejšnje stanje in naj ponovno sproži napako. Èe transakcija ni v teku, naj preprosto
--izpiše napako. Testiraj kodo tako, da daš med oba DELETE stavka en THROW stavek, ki bo
--sprožil izjemo in prekinil transakcijo.

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

-----------------------------------------------------------------------Rešitev:
select [SalesOrderID] from [SalesLT].[SalesOrderHeader]

declare @SalesOrderID INT = 71782;
begin try
begin transaction
if not exists (select * from [SalesLT].[SalesOrderHeader] where [SalesOrderID] = @SalesOrderID)
begin
throw 50001, 'Naroèilo z navedenim Id ne obstaja', 1;
end
delete from [SalesLT].[SalesOrderDetail] where [SalesOrderID] = @SalesOrderID;
throw 51000, 'Napaka med brisanjem podrobnosti naroèila.', 1;
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