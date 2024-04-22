--1. izpi�i vse podatke o �lanih (rezultat ima 760 vrstic)
select * from Clani
--2. izpi�i vse podatke o �lanih, urejene po priimku �lana
select * from Clani
order by Ime
--3. izpi�i vse podatke o �lanih, urejene po �tevilki vasi, nato pa po imenih
select * from Clani
order by Vas, Ime
--4. izpi�i ime �lana, naslov in ime vasi, urejene po imenu vasi, nato po imenih �lana
select [Ime], Naslov, Ime_vasi from clani c
join vasi v on c.vas=v.Sifra_vas
order by v.Ime_vasi,c.Ime
--5. izpi�i imena �lanov, ki vsebujejo besedo 'FRANC' (17 takih je)
select Ime from Clani
where Ime like '%FRANC%'
--6. izpi�i skupno koli�ino pripeljanega grozdja po posameznem �lanu iz tabele prevzem. V izpisu naj bo �ifra
-- �lana in skupna koli�ina grozdja, izpis uredi po �ifri �lana
select Sifra_clan, sum(Kolicina) as 'Skupa koli�ina grozdja' from Prevzem
group by sifra_clan order by sifra_clan
--7. izpi�i skupno koli�ino grozdja po letnikih iz tabele Prevzem
select letnik, sum(kolicina) as 'Skupna koli�ina grodzja' from Prevzem
group by letnik
--8. izpi�i skupno koli�ino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah
select sorta, sum(kolicina) from Prevzem
where letnik=2000
group by Sorta order by Sorta
--9. izpi�i skupno koli�ino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah, uporabi imena sort
select s.Imes, sum(kolicina) from prevzem p
join sorta s on p.sorta=s.Sifra_sorta
where p.letnik=2000
group by s.ImeS order by s.ImeS
--10. izpi�i skupno koli�ino grozdja za posamezno sorto za Letnik 2000 urejeno po odkupni koli�ini padajo�e, uporabi imena sort
select s.Imes, sum(kolicina) from prevzem p
join sorta s on p.Sorta=s.Sifra_sorta
where p.Letnik=2000
group by s.Imes order by sum(kolicina) desc
--11. kateri �lan je pripeljal najve� grozdja naenkrat? Izpi�i �ifro �lana (9270120)
select top 1 sifra_clan from Prevzem order by kolicina desc
--12. izpi�i ime �lana, ki je pripeljal najve� grozdja naenkrat (Koncut Damijan)
select top 1 ime from Prevzem p
join clani c on c.Sifra_clan=p.Sifra_clan
order by kolicina desc
--13. izpi�i �ifro �lana, ki je v letu 2003 pripeljal najve� grozdja (9330030)
select top 1 sifra_clan, sum(kolicina) as 'Vsa koli�ina' from Prevzem
where Letnik = 2003
group by sifra_clan	
order by sum(kolicina) desc
--14. Koliko je vseh �lanov (760)
select count(*) from Clani
--15. Koliko �lanov je pripeljalo grozdje v letu 2001 (720)
select count(distinct Sifra_clan) from Prevzem  --distinct = razli�ne podatke, ne �teje enakih
where Letnik=2001
--16. Koliko �lanov ni pripeljalo grozdja v letu 2001 (40)
select count(*) from Clani
where Sifra_clan not in
(select distinct Sifra_clan from Prevzem
where Letnik=2001)
--17. izpi�i imena in naslove �lanov, ki niso pripeljali grozdja v letu 2001, uredi po imenu
select sifra_clan, Ime from Clani
where Sifra_clan not in
(select distinct Sifra_clan from Prevzem
where Letnik=2001)
--18. izpi�i imena in naslove �lanov, ki niso pripeljali grozdja v letu 2000 ali 2001ali 2002 ali 2003, uredi po imenu

--19. izpi�i povpre�no sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorte skupna koli�ina in povpre�na stopnja sladkorje
-- povpre�no sladkorno stopnjo izra�unamo kot povre�je koli�ina*sladkor nato delimo s koli�ino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajo�e
select letnik, Sorta, sum(Kolicina*sladkor)/sum(Kolicina) from Prevzem
group by Letnik, Sorta
--20. izpi�i povpre�no sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorte skupna koli�ina in povpre�na stopnja sladkorje
-- povpre�no sladkorno stopnjo izra�unamo kot povpre�je sladkornih stopenj nato delimo s koli�ino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajo�e
select letnik, Sorta, avg(sladkor) from Prevzem
group by Letnik, Sorta
-- primerjaj rezultate 24. in 25. naloge. Kateri so po tvojem mnenju pravilni? Zakaj?


--1. izdelaj novo tabelo, ki ima enako strukturo kot Sorta z imenom Grozdje
CREATE TABLE Grozdje(
	[Sifra_grozdja] [int] NOT NULL primary key,
	[ImeS] [nvarchar](50) NULL,
	[Sifrav] [int] NULL,
	[SifraUE] [int] NULL,
	[Barva] [nvarchar](50) NULL,)
--2. vstavi v tabelo podatke o sortah iz tabele sorta
INSERT INTO Grozdje select * from Sorta
--3. vstavi v tabelo grozdje sorto 501 z imenom La�ki rizling
INSERT INTO Grozdje (Sifra_sorte, ImeS)
VALUES (501, 'La�ki rizling')
--4. popravi barvo vseh sort, kjer je vrednost barve null v belo
UPDATE grozdje set barva='belo' where barva is null
--5. izbri�i podatke iz tabele Grozdje
delete from Grozdje
--6. izbri�i tabelo Grozdje
drop table Grozdje