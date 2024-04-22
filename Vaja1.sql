--Adventure Works Cycles prodaja neposredno prodajalcem, katerih stranke so kupci. Vsak prodajalec
--je stranka, ki je podjetju Adventure Works Cycles posredovala ime kontakta za komunikacijo. Vodja
--prodaje vam postavi naslednje naloge:
--1. Poišèi vse stranke iz tabele Customers
select * from [SalesLT].[Customer]
--2. Izdelaj seznam strank, ki vsebuje ime kontakta, naziv, ime, srednje ime (èe ga kontakt ima),
--priimek in dodatek (èe ga kontakt ima) za vse stranke.
select EmailAddress, Phone, Title, Suffix, FirstName, MiddleName, LastName from [SalesLT].[Customer]
--3. Iz tabele Customers izdelaj seznam, ki vsebuje:
--a. Prodajalca (SalesPerson)
--b. Stolpec z imenom »ImeStranke«, ki vsebuje priimek in naziv kontakta (na primer Mr
--Smith)
--c. Telefonsko številko stranke
select SalesPerson, isnull(Title,'')+' '+LastName as [Ime stranke], Phone from [SalesLT].[Customer]
--4. Izpiši seznam vseh strank v obliki <Customer ID> : <Company Name> na primer 78: Preferred Bikes.
select CONCAT(CustomerID,' : ',CompanyName) as Customers from [SalesLT].[Customer]
--5. Iz tabele SalesOrderHeader (vsebuje podatke o naroèilih) izpiši podatke
--a. Številka naroèila v obliki <Order Number> (<Revision>) –na primer SO71774 (2).
--b. Datum naroèila spremenjen v ANSI standarden format (yyy.mm.dd – na primer
--2015.01.31)
--Nekateri podatki v bazi manjkajo ali pa so vrnjeni kot NULL. Tvoja naloga je ustrezno obravnavati te podatke.
select CONCAT(isnull(SalesOrderNumber,''), ' (', isnull(RevisionNumber,''), ')'), format(isnull(OrderDate,''), 'yyyy.MM.dd') from [SalesLT].[SalesOrderHeader]
select CONCAT(isnull(SalesOrderNumber,''), ' (', isnull(RevisionNumber,''), ')'), convert(nvarchar(30), OrderDate, 102) from [SalesLT].[SalesOrderHeader]
--6. Ponovno je treba izpisati vse podatke o kontaktih, èe kontakt nima srednjega imena v obliki
--<first name> <last name>, èe ga pa ima <first name> <middle name> <last name> (na primer
--Keith Harris, Jane M. Gates)
select FirstName+' '+isnull(MiddleName,'') as FirstAndMiddleName, LastName from [SalesLT].[Customer]
--7. Stranka nam je posredovala e-mail naslov, telefon ali oboje. Èe je dostopen e-mail, ga
--uporabimo za primarni kontakt, sicer uporabimo telefonsko številko. Napiši poizvedbo, ki
--vrne CustomerID in stolpec »PrimarniKontakt«, ki vsebuje e-mail ali telefonsko številko. (v
--podatkovni bazi imajo vsi podatki e-mail. Èe hoèeš preveriti ali poizvedba deluje pravilno
--najprej izvedi stavek
--UPDATE SalesLT.Customer
--SET EmailAddress = NULL
--WHERE CustomerID % 7 = 1;
select  EmailAddress, Phone, CustomerID, case when EmailAddress is not null then CONCAT(CustomerID,' ',EmailAddress) else CONCAT(CustomerID,' ',Phone) end as Ime from [SalesLT].[Customer]
--8. Izdelaj poizvedbo, ki vraèa seznam naroèil (order ID), njihove datume in stolpec
--»StatusDobave«, ki vsebuje besedo »Dobavljeno« za vsa naroèila, ki imajo znan datum
--dobave in »Èaka« za vsa naroèila brez datuma dobave. V bazi imajo vsa naroèila datum
--dobave. Èe želiš preveriti, ali poizvedba deluje pravilno, predhodno izvedi stavek
--UPDATE SalesLT.SalesOrderHeader
--SET ShipDate = NULL
--WHERE SalesOrderID > 71899; 
SELECT SalesOrderID, OrderDate,
 CASE
 WHEN ShipDate IS NULL THEN 'Dobavljeno'
 ELSE 'Èaka'
 END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;