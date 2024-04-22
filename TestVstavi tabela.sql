create table T1
(
  st_1 as 'Izraèunan stolpec '+st_2,
  st_2 nvarchar(30)
    constraint prevzeta default('moja privzeta vrednost'),
  st_3 rowversion,
  st_4 nvarchar(40)
)

insert into T1 (st_4)
values ('eksplicitna vrednost')

select * from T1

insert into T1 (st_2,st_4)
values ('Barbara','ZP2')

insert into T1 (st_2)
values ('bbbbb')

insert into T1 default values 
create table T2
(
  st_1 as 'Izraèunan stolpec '+st_2,
  st_2 nvarchar(30)
    constraint prevzeta2 default('moja privzeta vrednost'),
  st_3 rowversion,
  st_4 nvarchar(40)
)

insert into T2 (st_2,st_4) select st_2,st_4 from T1

select * from T2
select * from T1

create table T3
(
  st1 int identity(1,1),--(od kod zaène šteti, za koliko mest šteje)/(seed,increment)
  st2 nvarchar(30)
)

insert into T3 values('vvvvvvwvv')

select * from T3
delete from T3

set identity_insert T3 on
insert into T3 (st1,st2) values (5,'aaaaa')

alter table T3 add primary key (st1)

set identity_insert T3 off
insert into T3 values ('bbbbb')

print SCOPE_IDENTITY()
print ident_current('T3')

--unique identifier
create table t4
(
  st1 int identity,
  st2 uniqueidentifier
)

insert into t4 values (NEWID())

select * from T4

create table T5 
(
  st1 int identity primary key,
  st2 nvarchar(3) unique
)
insert into T5 values ('aaa')
insert into T5 values ('bbb    ')
insert into T5 values ('cvasasa')--ta ne dela, ker je veè kot 3 znakov

select * from T5