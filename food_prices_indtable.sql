SELECT * FROM food_prices_indtable;

-- Q1. Count of records
SELECT COUNT(date)
FROM food_prices_indtable;

-- Q2. Find out from how many states data are taken 
-- A2. 27 states and 4 Union terrirories (Andaman nicobar, Chandigargh, Delhi, Puducheri)

SELECT count(DISTINCT admin1) as state
FROM food_prices_indtable
WHERE admin1 is not null;

-- Q3. How to find out the states which have had the highest prices of Rice under cereals and tubers category - Retail purchases



SELECT admin1 as state, market, category, commodity, pricetype, MAX(price) as mprice 
FROM food_prices_indtable 
WHERE category = 'cereals and tubers' 
  AND pricetype = 'Retail' 
  AND commodity = 'Rice' 
GROUP BY admin1, market, category, commodity, pricetype 
ORDER BY mprice DESC;

-- Q4. Find out the states and market which have had the highest prices of Rice under cereals and tubers category- Wholesale purchases

SELECT admin1 as state, market, category, commodity, unit, pricetype, max(price) as mprice
FROM food_prices_indtable
WHERE category ='cereals and tubers' 
  AND pricetype = 'Wholesale' 
  AND commodity ='Rice'
group by admin1, market, category, commodity, unit, pricetype
order by mprice desc;


-- Q5.Find out the states and market which have had the highest prices of Milk under milk and dairy category- Retail purchases only
-- A5.Only in 7 states Raw milk is sold

SELECT admin1 as state, market, category, commodity, pricetype, max(price) as mprice
FROM food_prices_indtable
WHERE category ='milk and dairy' 
AND pricetype = 'Retail' 
AND commodity ='Milk'
group by admin1, market, category, commodity, pricetype order by mprice desc;

-- Q6.Find out the states and market which have had the highest prices of Milk (pasteurized) under milk and dairy category- Retail purchases only

SELECT admin1 as state, market, category, commodity, pricetype, max(price) as mprice
FROM food_prices_indtable
WHERE category ='milk and dairy'
AND pricetype = 'Retail' 
AND commodity = 'Milk (pasteurized)'
group by admin1, market, category, commodity, pricetype order by mprice desc;

-- Q7. Find out the states and market which have had the highest prices of Ghee (vanaspati) under oil and fats- Retail purchases only
-- A7. Mysore(Karnataka) seems to have the highest of Ghee(vanaspathi) prices

SELECT admin1 as state,market,category,commodity,pricetype,max(price) as mprice
FROM food_prices_indtable
WHERE admin1 is not null 
AND category = 'oil and fats' 
AND commodity ='Ghee (vanaspati)'
group by admin1, market, category, commodity, pricetype order by mprice desc;

-- Q8. Finding out the avegarge price of oil and fats as whole

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='oil and fats';

-- Q9. Find out the average prices for each type of oil under oil and fats
-- A9. Groundnut Oil has the highest average price of 148.5 INR and palm oil has the lowest average price of 100 INR

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='oil and fats' 
AND commodity ='oil (mustard)';

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='oil and fats' 
AND commodity ='oil (groundnut)';

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='oil and fats' 
AND commodity ='oil (sunflower)';

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='oil and fats' 
AND commodity ='oil (palm)';

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='oil and fats' 
AND commodity ='oil (soybean)';

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='oil and fats'
AND commodity ='Ghee (vanaspati)';


-- Q10. Finding out the average prices of lentils
-- A10. Urad has the highest average price of 102.13 INR and chickpeas has the lowest average price of 46.23 INR

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='pulses and nuts' 
AND commodity = 'Lentils (moong)';

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='pulses and nuts' 
AND commodity = 'Lentils (urad)';

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='pulses and nuts'  
AND commodity = 'Lentils (masur)';

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='pulses and nuts' 
AND commodity = 'chickpeas';


-- Q11. Finding out the average price of Onions and tomatoes
-- A11. Average price of Onion is 28 INR and Average price of Tomato is 30.3 INR

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category = 'vegetables and fruits'
AND commodity = 'Onions';

SELECT AVG(price) as Averageprice
FROM food_prices_indtable
WHERE category ='vegetables and fruits' 
AND commodity = 'Tomatoes';


-- Q12 Find out which commodity has the highest price 
-- A12 Tea(black) has the highest price throughout all the years (Data for Tea available only from the year 2013)

SELECT admin1 as state,market,category,commodity,pricetype,max(price) as mprice
FROM food_prices_indtable
WHERE pricetype = 'Retail'
group by admin1, market,category,commodity,pricetype order by mprice desc;

-- Q13 Find out the commodities which has the highest prices recently year 2022
-- A Tea comes first,oil comes second, lentils comes third

SELECT 
    MIN(date) as Min_date, 
    market, 
    zone, 
    category, 
    commodity, 
    MAX(price) as Highest_price
FROM 
    commodity_prices
WHERE 
    CONVERT(date, date, 103) = '2022-07-15' 
    AND pricetype = 'Retail'
GROUP BY 
    market, 
    zone, 
    category, 
    commodity
ORDER BY 
    Highest_price DESC;

	SELECT TOP 10 
    commodity, 
	
    MAX(price) as Highest_Price
FROM 
    commodity_prices
WHERE 
    date >= '2022-01-01' 
    AND date <= '2022-12-31'
GROUP BY 
    commodity
ORDER BY 
    Highest_Price DESC;






-- Q14 Create a table for zones
-- Select city and State from food prices ind table and insert it into zones table

DROP Table if exists zones;
CREATE TABLE 'zones' (
  'City' VARCHAR(255),
  'State' VARCHAR (255),
  'zone' VARCHAR(255),
  PRIMARY KEY('City', 'State')
);

DROP TABLE IF EXISTS "zones";
CREATE TABLE "zones" (
    "City" VARCHAR(255),
    "State" VARCHAR(255),
    "zone" VARCHAR(255),
    PRIMARY KEY ("City", "State")
);

Insert into zones
select DISTINCT admin2, admin1, NULL
from food_prices_indtable
where admin2 is not NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE "zones" SET zone ='South'  WHERE State LIKE 'Tamil Nadu';
UPDATE "zones" SET zone ='South'  WHERE State LIKE 'Telangana';
UPDATE "zones" SET zone ='South'  WHERE State LIKE 'Andhra Pradesh';
UPDATE "zones" SET zone ='South'  WHERE State LIKE 'Kerala';
UPDATE "zones" SET zone ='South'  WHERE State LIKE 'Karnataka';

update "zones"set zone = 'North' WHERE State = 'Himachal Pradesh';
update "zones"set zone = 'North' WHERE State = 'Punjab';
update "zones"set zone = 'North' WHERE State = 'Uttarakhand';
update "zones"set zone = 'North' WHERE State = 'Uttar Pradesh';
update "zones"set zone = 'North' WHERE State = 'Haryana';

update "zones"set zone = 'East' WHERE State = 'Bihar';
update "zones"set zone = 'East' WHERE State = 'Orissa';
update "zones"set zone = 'East' WHERE State = 'Jharkhand';
update "zones"set zone = 'East' WHERE State = 'West Bengal';

update "zones"set zone = 'West' WHERE State = 'Rajasthan';
update "zones"set zone = 'West' WHERE State = 'Gujarat';
update "zones"set zone = 'West' WHERE State = 'Goa';
update "zones"set zone = 'West' WHERE State = 'Maharashtra';

update "zones"set zone = 'Central' WHERE State = 'Madhya Pradesh';
update "zones"set zone = 'Central' WHERE State = 'Chhattisgarh';

update "zones"set zone = 'North East' WHERE State = 'Assam';
update "zones"set zone = 'North East' WHERE State = 'Sikkim';
update "zones"set zone = 'North East' WHERE State = 'Manipur';
update "zones"set zone = 'North East' WHERE State = 'Meghalaya';
update "zones"set zone = 'North East' WHERE State = 'Nagaland';
update "zones"set zone = 'North East' WHERE State = 'Mizoram';
update "zones"set zone = 'North East' WHERE State = 'Tripura';
update "zones"set zone = 'North East' WHERE State = 'Arunachal Pradesh';

update "zones"set zone = 'Union Territory' WHERE State = 'Chandigarh';
update "zones"set zone = 'Union Territory' WHERE State = 'Delhi';
update "zones"set zone = 'Union Territory' WHERE State = 'Puducherry';
update "zones"set zone = 'Union Territory' WHERE State = 'Andaman and Nicobar';

Select *
from zones;

-- Q15 JOIN zones table and food_prices_indtable AND Create a view

Create view commodity_prices as
Select fo.date,zo.City,zo.State,fo.market,zo.zone,fo.latitude,fo.longitude,fo.category,fo.commodity,fo.unit,fo.priceflag,fo.pricetype,fo.currency,fo.price,fo.usdprice
from zones zo
JOIN food_prices_indtable fo
ON
zo.State = fo.admin1;

select DISTINCT market
from commodity_prices;

-- Q16 Average price of commodities zone wise 
--
Select min(date),zone,category,commodity, AVG(price) as Average_price
FROM commodity_prices
WHERE CONVERT(date,date,103) = '2022-07-15'
    

Group by zone,category,commodity
order by commodity,Average_price DESC;

-- Q17 Find out the price differences between  2022 and 2012 

DROP Table if exists price_differencesB;
Create Table price_differencesB
(
State varchar(255),
zone varchar(255),
category varchar(255),
commodity varchar(255),
Average_price_2012 float
);

INSERT INTO price_differencesB
SELECT State,zone,category,commodity,round(avg(price),2) from commodity_prices
WHERE date = '2012-12-15' AND pricetype = 'Retail'
group by State,zone,category,commodity;

DROP Table if exists price_differencesC;
Create Table price_differencesC
(
State varchar(255),
zone varchar(255),
category varchar(255),
commodity varchar(255),
Average_price_2022 float
);

INSERT INTO price_differencesC
SELECT State,zone,category,commodity,round(avg(price),2) from commodity_prices
WHERE date = '2022-07-15' and pricetype = 'Retail'
group by State,zone,category,commodity;




SELECT 
    B.State, 
    B.zone, 
    B.category, 
    B.commodity, 
    B.Average_price_2012,
	C.Average_price_2022,
    C.Average_price_2022 - B.Average_price_2012 as Diff_bw_price
FROM 
    price_differencesB B
JOIN 
    price_differencesC C
ON 
    B.category = C.category 
    AND B.commodity = C.commodity
ORDER BY 
    B.zone;

	select * from  price_differencesB;
	select * from  price_differencesC;


-- Q18 Find out the average prices of each category food products zone wise

-- South zone has the highest avg price for cereals and tubers(Potatoes,rice,wheat,wheat flour),North zone hasthe lowest average
-- North East zone has the highest avg price for Milk and dairy, South zone has the lowest average
-- North East zone has the highest avg price for Miscellaneous food(Sugar,salt,jaggery,Tea(black)),Union territory has the lowest average
-- Union Territory has the highest avg price for oil and fats(Ghee,Groundnut,Mustard,palm,soybean,sunflower),Central has the lowest average
-- Union Territory,North East has the highest avg price for pulses and nuts(chickpeas and other types of lentils), Central has the lowest average
-- North East zone has the highest avg price for vegetablesand fruits, South has the lowest average

SELECT zone,category, round(avg(price)) as avgprice
from commodity_prices
where pricetype = "Retail" and date = "15/07/22" 
group by 1,2
order by category,avgprice DESC;

-- Q19 Find out the average prices of each commodity zone wise

SELECT zone,commodity, round(avg(price)) as avgprice
from commodity_prices
where pricetype = "Retail" and date = "15/07/22" 
group by 1,2
order by commodity,avgprice DESC;

-- Q20 Drop unnecessary tables
DROP table FOOD_PRICES.food_pricesnew;