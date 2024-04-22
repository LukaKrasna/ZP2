--vaja 9
--1.
insert into [SalesLT].[Product]
(
  [Name],[ProductNumber], [StandardCost], [ListPrice], [ProductCategoryID], [SellStartDate]
)
values ('LED Lights 2','LT-L123 2', 2.56, 12.99, 37, GETDATE())

select * from [SalesLT].[Product]
WHERE ProductID = SCOPE_IDENTITY()


--2.
INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name)
values (4,'Bells and Horns');

declare @NewID int;
set @NewID = IDENT_CURRENT('SalesLT.ProductCategory')
INSERT INTO  SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
values ('Bicycle Bell','BB-RING', 2.47, 4.99,@NewID, GETDATE()),
		('Bicycle Horn','BB-PARG',1.29,3.75,@NewID,GETDATE())

--Zvišaj ceno (ListPrice) vsem produktom iz SalesLT.Product v kategoriji »Bells and Horns« za
--10%.
select ListPrice from [SalesLT].[Product]
--Nastavi DiscountinueDate za vse produkte iz tabele SalesLT.Product v kategoriji luèi (ID
--kategorije je 37) na današnji datum, razen za luè, ki si jo dodal v toèki ena.

--Izbriši produkte iz tabele SalesLT.Product v kategoriji »Bells and Horns«, nato pa izbriši tudi
--kategorijo »Bells and Horns« v tabeli SalesLT.ProductCategory

--3.