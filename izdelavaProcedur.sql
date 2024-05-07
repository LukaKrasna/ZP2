create procedure Moja
	@custID int = 5
as 
	begin 
		declare @lname nvarchar(20)
		while @custID<=5
		begin
			select @lname=LastName from [SalesLT].[Customer] where CustomerID=@custID
			print @custID
			set @custID +=1
		end
	end


--uporaba procedure

exec Moja @custID=1



select * from [HumanResources].[Shift]
create procedure M1 --procedura brez parametrov 
as
select * from [HumanResources].[Shift]
exec M1

create procedure M2 --procedura z enim parametrom
 @P varchar(50)='Night'
as
select * from [HumanResources].[Shift] where [Name]=@P
exec M2

create procedure M3 --procedura z enim parametrom
 @P varchar(50)='Night', @s time
as
select * from [HumanResources].[Shift] where [Name]=@P and StartTime>@s

exec M3 @P='Day' @s='06:00:00,000000'

--izhodni parametri
create procedure M4
@vrh nvarchar(50) output
as
set @vrh (select top 1 from [HumanResources].[Shift])

--klic 
declare @a nvarchar(50)
exec M4 @a output
print @a