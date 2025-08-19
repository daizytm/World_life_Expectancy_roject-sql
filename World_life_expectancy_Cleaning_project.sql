#World life expectancy project(Data Cleaning)

SELECT *
FROM world_life_expectancy.worldlifeexpectancy;

SELECT Country,Year,CONCAT(Country,Year),COUNT(CONCAT(Country,Year))
FROM world_life_expectancy.worldlifeexpectancy
GROUP BY Country,Year,CONCAT(Country,Year)
HAVING COUNT(CONCAT(Country,Year))>1 ;

SELECT * 
FROM (SELECT Row_ID,
       CONCAT(Country,Year) ,
       ROW_NUMBER() OVER(PARTITION BY  CONCAT(Country,Year) ORDER BY CONCAT(Country,Year)) as Row_num 
	   FROM worldlifeexpectancy
  ) AS row_table
WHERE row_num>1
;


DELETE FROM worldlifeexpectancy
WHERE Row_ID IN (
		SELECT Row_ID 
        FROM (SELECT Row_ID,
       CONCAT(Country,Year) ,
       ROW_NUMBER() OVER(PARTITION BY  CONCAT(Country,Year) ORDER BY CONCAT(Country,Year)) as Row_num 
	   FROM worldlifeexpectancy
  ) AS row_table
WHERE row_num>1
);

SELECT *
FROM world_life_expectancy.worldlifeexpectancy
WHERE status='';

SELECT DISTINCT(Status)
FROM world_life_expectancy.worldlifeexpectancy
WHERE status <> '';

SELECT DISTINCT(Country)
FROM world_life_expectancy.worldlifeexpectancy
WHERE status ='Developing';

UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
    ON t1.country=t2.country
SET t1.status= 'Developing'
WHERE t1.status=''
AND t2.status  <> ''
AND t2.status = 'Developing';

UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
    ON t1.country=t2.country
SET t1.status= 'Developed'
WHERE t1.status=''
AND t2.status  <> ''
AND t2.status = 'Developed';

SELECT *
FROM world_life_expectancy.worldlifeexpectancy
WHERE `Life expectancy` = '';

SELECT Country,Year,`Life expectancy`
FROM world_life_expectancy.worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
#WHERE `Life expectancy` = ''

