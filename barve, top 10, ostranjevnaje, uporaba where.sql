--barve
select distinct Color from [SalesLT].[Product]
--top 10, 10 percent
select top 10 percent * from [SalesLT].[Product] order by ProductNumber
--ostranjevanje
select Name,Listprice from [SalesLT].[Product]
order by ProductNumber offset 0 rows --od katere vrstice naprej
fetch next 10 rows only --koliko vrstic prikažem
--uporaba where
-- <,<=,>,>=,=,!= ali <>, and, or, !, like, between, in
--%=0 ali veè znakov, _ natanko en znak, [A-Z] so vse èrke med A in Z, [0-9]
--^R ne sme biti R

--izberi vse produkte, kjer so ProductNumber zaène na FR
select ProductNumber, [Name] from [SalesLT].[Product]
where ProductNumber like 'FR%'
--ProductNumber naj se zaène na FR, potem naj sledi znak -, nato kateri koli znak, nato dve številki, spet katerikoli znak, - in dve številki
select ProductNumber, [Name] from [SalesLT].[Product]
where ProductNumber like 'FR-_[0-9][0-9]_-[0-9][0-9]'
--Zaène se na BK-, naslednji znak pa ni R, sledi veè poljubnih znakov, konèa se -dve številki
select ProductNumber, [Name] from [SalesLT].[Product]
where ProductNumber like 'BK-[^R]%-[0-9][0-9]'

select ProductNumber, [Name] from [SalesLT].[Product]
where ProductNumber like 'BK%'

--izberi vse produkte, ki niso v kategoriji 5,6 ali 7
select ProductNumber, [Name] from [SalesLT].[Product]
where ProductCategoryID =5 or ProductCategoryID = 6 or ProductCategoryID = 7

select ProductNumber, [Name] from [SalesLT].[Product]
where ProductCategoryID in (5,6,7)
