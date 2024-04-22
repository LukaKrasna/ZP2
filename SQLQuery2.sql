--izpiši Id in naslov, kot en stolpecz imenom naslov iz tabele Address
select str([AddressID])+' '+[AddressLine1] as Naslov from [SalesLT].[Address]
--druga možnost
select cast([AddressID] as varchar(5))+' '+[AddressLine1] as Naslov from [SalesLT].[Address]
--tretja možnost
select convert(varchar(5),[AddressID])+' '+[AddressLine1] as Naslov from [SalesLT].[Address]
--spremeni datum SellsStartDate iz tabele Product v razliène formate
--123 je ISO foramt, 104 pa je slovenski
select [Name], [SellStartDate], convert(nvarchar(30), [SellStartDate], 126),
convert(nvarchar(30), [SellStartDate], 104) 
from [SalesLT].[Product]
-- isnull(stolpec,vr1) zamenja v izpisu vrednost v stolpcu, kjer je null z vrednostjo vr1
select * from [SalesLT].[Product]
select Name,ISNULL(weight,0) from [SalesLT].[Product]
--nulliff(stolpec, vr2) - èe je v stolpcu vrednost = 2 nastavi jo na null
select Name,nullif(Color,'Black') from [SalesLT].[Product]
--coalesce(st1,st2,st3...) - v rezultatu so st1, kjer ni null, èe je st1 null, potem je st2...
select Name, Color, Size, coalesce(Size, Color) from [SalesLT].[Product]
--case
select Name, 
	case when [SellEndDate] IS NULL then 'Na razpolago'
	else 'Razprodano'
	end as status
from [SalesLT].[Product]

select Name,
	case when size='M' then 'Medium'
		 when size='S' then 'Small'
		 when Size='L' then 'Large'
		 else isnull(Size, 'n/a')
	end as Velikost
from [SalesLT].[Product]