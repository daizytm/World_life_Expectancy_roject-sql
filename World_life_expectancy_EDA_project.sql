-- World life expectancy project (Exploratory Data Analysis)
SELECT * 
FROM worldlifeexpectancy
;

SELECT Country,
       MIN(`Life expectancy`),
       MAX(`Life expectancy`)
FROM worldlifeexpectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <>0
AND MAX(`Life expectancy`) <>0
ORDER BY Country DESC
;

-- Which countries performing well interms of life expectancy over 15 years
SELECT Country,
       MIN(`Life expectancy`),
       MAX(`Life expectancy`),
	   ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`),1) AS life_increase_over_15_years
FROM worldlifeexpectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <>0
AND MAX(`Life expectancy`) <>0
ORDER BY life_increase_over_15_years ASC
;

-- which years? 
SELECT YEAR,ROUND(AVG (`Life expectancy`),2)
FROM worldlifeexpectancy
WHERE `Life expectancy` <>0
GROUP BY Year
ORDER BY Year
;

-- What is the correlation between life_expectancy and other columns
# with GDP
SELECT *
FROM worldlifeexpectancy
;

SELECT Country, ROUND(AVG(`Life expectancy`) ,2) AS life_exp,ROUND(AVG(GDP),2) AS GDP
FROM worldlifeexpectancy
GROUP BY Country
HAVING life_exp> 0
AND GDP>0
ORDER BY GDP ASC
;

SELECT 
SUM(CASE WHEN GDP >=1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >=1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_expectancy,
SUM(CASE WHEN GDP <=1500 THEN 1 ELSE 0 END) low_GDP_Count,
AVG(CASE WHEN GDP <=1500 THEN `Life expectancy` ELSE NULL END) low_GDP_Life_expectancy
FROM worldlifeexpectancy
;

--  Positive High Correlation


#status

SELECT *
FROM worldlifeexpectancy
;

SELECT Status,ROUND(AVG (`Life expectancy`),2)
FROM worldlifeexpectancy
GROUP BY Status
;

SELECT Status,COUNT(DISTINCT Country),ROUND(AVG (`Life expectancy`),2)
FROM worldlifeexpectancy
GROUP BY Status
;
 -- positive correlation

#BMI
SELECT *
FROM worldlifeexpectancy
;

SELECT Country, ROUND(AVG(`Life expectancy`) ,2) AS life_exp,ROUND(AVG(BMI),2) AS BMI
FROM worldlifeexpectancy
GROUP BY Country
HAVING life_exp> 0
AND BMI>0
ORDER BY BMI ASC
;


#Mortality
SELECT *
FROM worldlifeexpectancy
;

SELECT Country,
       Year,
	  `Life expectancy`,
      `Adult Mortality`,
      SUM(`Adult Mortality`)OVER(PARTITION BY Country ORDER BY Year) as Rolling_total
FROM worldlifeexpectancy
WHERE Country = 'Kenya'
;
