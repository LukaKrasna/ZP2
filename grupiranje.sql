--grupiranje
select * from [Sales]
select Country,region,SUM(sales) from Sales
group by Country, Region
SELECT SUM(SALES) FROM Sales

select Country,region,SUM(sales) from Sales
group by rollup (Country, Region)

select Country,region,SUM(sales) from Sales
group by cube (Country, Region)

select Country,region,SUM(sales) from Sales
group by grouping sets (Region, Country,())

select Country, Region, SUM(sales), GROUPING_ID(country) as IDCountry,
GROUPING_ID(region) as IDRegion
from Sales group by rollup (Country,region)

select IIF(GROUPING_ID(country)=1 and GROUPING_ID(region)=1,'Vse skupaj',
		iif(grouping_ID(region)=1,'Skupaj '+Country,Region)
) as Level , SUM(Sales) as Total from Sales
group by rollup(Country,Region)