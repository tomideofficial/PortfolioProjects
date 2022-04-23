--Selecting the right database

USE MyPortfolioProject;

--selecting all the data in the WHO COVID data table;

SELECT * FROM whodata1;

--Creating procedure to select all the covid deaths data

CREATE PROCEDURE AllDeathData
AS 
SELECT * FROM whodata1
GO; 

EXEC AllDeathData

--selecting the data we need

SELECT date_reported, country, WHO_region, new_cases, cumulative_cases, new_deaths, cumulative_deaths
FROM whodata1
ORDER BY 2,1;

--creating a new table of the data we need

CREATE VIEW DeathData
AS
SELECT date_reported, country, WHO_region, new_cases, cumulative_cases, new_deaths, cumulative_deaths
FROM whodata1;

SELECT * FROM DeathData;

--Checking the countries with the highest reported cases

SELECT TOP 10 country, MAX(cumulative_cases) AS HighestCases
FROM DeathData
GROUP BY Country
ORDER BY HighestCases DESC;

--Checking the countries with the highest reported covid deaths

SELECT TOP 10 country, MAX(cumulative_deaths) AS HighestDeaths
FROM DeathData
GROUP BY Country
ORDER BY HighestDeaths DESC;

--Checking country with the highest deaths in a day

SELECT TOP 10 country, MAX(new_deaths) AS HighestDeathCountInOneDay
FROM DeathData
GROUP BY country
ORDER BY HighestDeathCountInOneDay DESC;

--To get the date for the highest death in a day from the previous query

SELECT date_reported, country FROM DeathData
WHERE new_deaths = 11447

--Checking country with the highest cases in a day

SELECT TOP 10 country, MAX(new_cases) AS HighestCaseCountInOneDay
FROM DeathData
GROUP BY country
ORDER BY HighestCaseCountInOneDay DESC;

--To get the date for the highest cases in a day from the previous query

SELECT date_reported, country FROM DeathData
WHERE new_cases = 1252624

--Checking the likelihood of dying after contracting the virus in any country

SELECT date_reported, country, new_cases, cumulative_cases, new_deaths, cumulative_deaths, ISNULL((cumulative_deaths/NULLIF(cumulative_cases, 0))*100, 0) AS DeathPercentage
FROM DeathData
--WHERE country = 'Nigeria'
ORDER BY 2, 1;

--Checking the WHO region with the highest death rate

SELECT who_region, Maxcases, Maxdeaths, (Maxdeaths/Maxcases) * 100 AS DeathRate
FROM (
SELECT who_region, MAX(cumulative_cases) MaxCases, MAX(cumulative_deaths) MaxDeaths 
FROM DeathData
GROUP BY who_region
) AS HDR
ORDER BY DeathRate DESC;
