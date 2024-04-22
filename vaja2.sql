--1. Iz tabele Address izberi vsa mesta in province, odstrani duplikate. (atributi City,
--Province)
select distinct(City), StateProvince from [SalesLT].[Address]
--2. Iz tabele Product izberi 10% najtežjih produktov (izpiši atribut Name, teža je v
--atributu Weight)
select top 10 percent [Weight], [Name] from [SalesLT].[Product]
--3. Iz tabele Product izberi najtežjih 100 produktov, izpusti prvih 10 najtežjih.
select [Weight] from [SalesLT].[Product]
where weight is not null
order by weight offset 10 rows 
fetch next 100 rows only
--4. Poišèi ime, barvo in velikost produkta, kjer ima model produkta ID 1. (atributi Name,
--Color, Size in ProductModelID)
select ProductModelID, Name, Color, Size from [SalesLT].[Product]
where ProductModelID=1
--5. Poišèi številko produkta in ime vseh izdelkov, ki imajo barvo 'black', 'red' ali 'white' in
--velikost 'S' ali 'M'. (Izpiši ProductNumber, primerjaj Color in Size)
select ProductID, Name, Color, Size from [SalesLT].[Product]
--6. Poišèi številko produktov, ime in ceno produktov, katerih številka se zaène na BK-.
--(atributi ProductNumber, Name, ListPrice, primerjaj ProductNumer)
select ProductNumber, Name, ListPrice from [SalesLT].[Product]
where ProductNumber='BK%'
--7. Spremeni prejšnjo poizvedbo tako, da boš iskal produkte, ki se zaènejo na 'BK-' sledi
--katerikoli znak razen R in se konèajo na »–dve števki«. (atributi ProductNumber,
--Name, ListPrice, primerjaj ProductNumer, primer: BK-F1234J-11)