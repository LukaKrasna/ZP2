--Use AdventureWorksLT2012 database
--1.Vstavi v tabelo SalesLT.Product produkt
--Name ProductNumber StandardCost ListPrice ProductCategoryID SellStartDate
--LED Lights LT-L123 2.56 12.99 37 <Today>
--Ko je produkt ustvarjen, preveri kakšna je identiteta zadnjega vstavljenega produkta.
--Pomagaj si s SELECT SCOPE_IDENTITY();
--Opomba : ProductNumber mora biti edinstven. Ker delamo vsi na isti podatkovni bazi,
--zamenjaj ime v LT-L123xxxx, kjer xxxx nadomestiš s prvimi èrkami priimka.
insert into [SalesLT].[Product]
(Name,ProductNumber,StandardCost,ListPrice,ProductCategoryID,SellStartDate)
values('LED Lights1','LT-L1234',3.56,12.99,37,GETDATE())
print Scope_Identity() --ProductID=1013
--2. Vstavi v SalesLT.ProductCategory kategorijo z lastnostjo ParentProductCategoryID = 4 z
--imenom (Name) 'Bells and Horns'. Kljuè v tabeli je identiteta. Nato vstavi v tabelo produktov (SalesLT.Product) še spodnje produkte.
--Name ProductNumber StandardCost ListPrice ProductCategoryID SellStartDate
--Bicycle Bell BB-RING 2.47 4.99 <The new ID for Bells and Horns> <Today>
--Bicycle Horn BB-PARP 1.29 3.75 <The new ID for Bells and Horns> <Today>
--Novo identiteto, ki si jo ustvaril v tabeli SalesLT.ProductCategory lahko vstaviš v tabelo
--SalesLT.Product s pomoèjo IDENT_CURRENT('ime tabele'). Preveri ali so produkti pravilno
--vstavljeni tako, da zapišeš ustrezen SELECT stavek.
insert into [SalesLT].[ProductCategory]
(ParentProductCategoryID,Name)
values(4,'Bells and Horns1')
print scope_Identity() --ProductCategoryID=47

insert into [SalesLT].[Product]
(Name,ProductNumber,StandardCost,ListPrice,ProductCategoryID,SellStartDate)
values('Bicycle Bells1','BB-RING1',2.47,4.99,IDENT_CURRENT('[SalesLT].[ProductCategory]'),GETDATE())--namesto ident_current() lahko izpišeš product category id iz scope_identity ki je 47

insert into [SalesLT].[Product]
(Name,ProductNumber,StandardCost,ListPrice,ProductCategoryID,SellStartDate)
values('Bicycle Horns1','BB-PARP1',1.29,3.75,IDENT_CURRENT('[SalesLT].[ProductCategory]'),GETDATE())

select * from [SalesLT].[Product]
where ProductCategoryID=47
--3. Zvišaj ceno (ListPrice) vsem produktom iz SalesLT.Product v kategoriji »Bells and Horns« za
--10%.
select * from [SalesLT].[Product]
update [SalesLT].[Product]
set ListPrice=ListPrice*1.1 from [SalesLT].[Product]
where ProductCategoryID=47
--4. Nastavi DiscountinueDate za vse produkte iz tabele SalesLT.Product v kategoriji luèi (ID
--kategorije je 37) na današnji datum, razen za luè, ki si jo dodal v toèki ena.

--5. Izbriši produkte iz tabele SalesLT.Product v kategoriji »Bells and Horns«, nato pa izbriši tudi
--kategorijo »Bells and Horns« v tabeli SalesLT.ProductCategory