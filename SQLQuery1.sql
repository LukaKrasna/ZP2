--1. izpiši vse podatke o èlanih (rezultat ima 760 vrstic)
select * from Clani
--2. izpiši vse podatke o èlanih, urejene po priimku èlana
select * from Clani
order by Ime
--3. izpiši vse podatke o èlanih, urejene po številki vasi, nato pa po imenih
select * from Clani
order by Vas, Ime
--4. izpiši ime èlana, naslov in ime vasi, urejene po imenu vasi, nato po imenih èlana
select [Ime], Naslov, Ime_vasi from clani c
join vasi v on c.vas=v.Sifra_vas
order by v.Ime_vasi,c.Ime
--5. izpiši imena èlanov, ki vsebujejo besedo 'FRANC' (17 takih je)
select Ime from Clani
where Ime like '%FRANC%'
--6. izpiši skupno kolièino pripeljanega grozdja po posameznem èlanu iz tabele prevzem. V izpisu naj bo šifra
-- èlana in skupna kolièina grozdja, izpis uredi po šifri èlana
select Sifra_clan, sum(Kolicina) as 'Skupa kolièina grozdja' from Prevzem
group by sifra_clan order by sifra_clan
--7. izpiši skupno kolièino grozdja po letnikih iz tabele Prevzem
select letnik, sum(kolicina) as 'Skupna kolièina grodzja' from Prevzem
group by letnik
--8. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah
select sorta, sum(kolicina) from Prevzem
where letnik=2000
group by Sorta order by Sorta
--9. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah, uporabi imena sort
select s.Imes, sum(kolicina) from prevzem p
join sorta s on p.sorta=s.Sifra_sorta
where p.letnik=2000
group by s.ImeS order by s.ImeS
--10. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po odkupni kolièini padajoèe, uporabi imena sort
select s.Imes, sum(kolicina) from prevzem p
join sorta s on p.Sorta=s.Sifra_sorta
where p.Letnik=2000
group by s.Imes order by sum(kolicina) desc
--11. kateri èlan je pripeljal najveè grozdja naenkrat? Izpiši šifro èlana (9270120)
select top 1 sifra_clan from Prevzem order by kolicina desc
--12. izpiši ime èlana, ki je pripeljal najveè grozdja naenkrat (Koncut Damijan)
select top 1 ime from Prevzem p
join clani c on c.Sifra_clan=p.Sifra_clan
order by kolicina desc
--13. izpiši šifro èlana, ki je v letu 2003 pripeljal najveè grozdja (9330030)
select top 1 sifra_clan, sum(kolicina) as 'Vsa kolièina' from Prevzem
where Letnik = 2003
group by sifra_clan	
order by sum(kolicina) desc
--14. Koliko je vseh èlanov (760)
select count(*) from Clani
--15. Koliko èlanov je pripeljalo grozdje v letu 2001 (720)
select count(distinct Sifra_clan) from Prevzem  --distinct = razliène podatke, ne šteje enakih
where Letnik=2001
--16. Koliko èlanov ni pripeljalo grozdja v letu 2001 (40)
select count(*) from Clani
where Sifra_clan not in
(select distinct Sifra_clan from Prevzem
where Letnik=2001)
--17. izpiši imena in naslove èlanov, ki niso pripeljali grozdja v letu 2001, uredi po imenu
select sifra_clan, Ime from Clani
where Sifra_clan not in
(select distinct Sifra_clan from Prevzem
where Letnik=2001)
--18. izpiši imena in naslove èlanov, ki niso pripeljali grozdja v letu 2000 ali 2001ali 2002 ali 2003, uredi po imenu

--19. izpiši povpreèno sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorte skupna kolièina in povpreèna stopnja sladkorje
-- povpreèno sladkorno stopnjo izraèunamo kot povreèje kolièina*sladkor nato delimo s kolièino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajoèe
select letnik, Sorta, sum(Kolicina*sladkor)/sum(Kolicina) from Prevzem
group by Letnik, Sorta
--20. izpiši povpreèno sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorte skupna kolièina in povpreèna stopnja sladkorje
-- povpreèno sladkorno stopnjo izraèunamo kot povpreèje sladkornih stopenj nato delimo s kolièino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajoèe
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
--3. vstavi v tabelo grozdje sorto 501 z imenom Laški rizling
INSERT INTO Grozdje (Sifra_sorte, ImeS)
VALUES (501, 'Laški rizling')
--4. popravi barvo vseh sort, kjer je vrednost barve null v belo
UPDATE grozdje set barva='belo' where barva is null
--5. izbriši podatke iz tabele Grozdje
delete from Grozdje
--6. izbriši tabelo Grozdje
drop table Grozdje