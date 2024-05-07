--predmeti
alter  table Predmeti
add id int identity(1,1)

alter table dbo.Predmeti
add primary key (id)

delete from dbo.Predmeti
where Kratica is null

--enote
select * from dbo.Enote
alter  table dbo.Enote
add id int identity(1,1)

alter table dbo.Enote
add primary key (ID)

delete from dbo.Enote
where Šola_enota is null

--VrstaObveze
select * from [dbo].[VrstaObveze]
alter  table [dbo].[VrstaObveze]
add id int identity(1,1)

alter table [dbo].[VrstaObveze]
add primary key (ID)

--zaposleni
select * from [dbo].[Zaposleni]
alter  table dbo.Zaposleni
add id int identity(1,1)

alter table dbo.Zaposleni
add primary key (ID)

ALTER TABLE dbo.Zaposleni
DROP COLUMN column6 -- ali pa greš v design naèin in jih tam izbrišeš


select * from [dbo].[Zaposleni]
select * from [dbo].[VrstaObveze]

--zamenjaj ime predmeta z njegovim idjem
select * from dbo.VSS
delete from vss where Oddelek_Projekt is NULL

alter table dbo.VSS
add ID int identity(1,1)
alter table dbo.VSS
add primary key (ID)

declare @id int=1 --id iz vss
declare @opis nvarchar(100) --opis predmeta iz vss
declare @idp int --id predmeta iz tabele predmeti
while @id<=148
begin
	select @opis=[Predmet_Opis_dela] from vss where ID = @id
	select @idp=ID from Predmeti where [Skupaj]=@opis
	--update vss kjer ime predmeta zamenjamo z ID predmeta
	update vss set [Predmet_Opis_dela]=@idp where ID=@id
	print @idp
	set @id=@id+1
end
update vss set Sola_enota = 8


select * from dbo.ovss
alter table dbo.ovss
add ID int identity(1,1)
alter table dbo.ovss
add primary key (ID)




select * from dbo.vss
select * from Predmeti

declare @id int=1
declare @opis nvarchar(100)
declare @ido int
while @id<=148
begin
	
end