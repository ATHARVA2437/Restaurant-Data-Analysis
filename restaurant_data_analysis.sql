
-- Step 1: Create Database
CREATE DATABASE IF NOT EXISTS RestaurantAnalysis;
USE RestaurantAnalysis;

-- Step 2: Create Table
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    Restaurant_ID INT PRIMARY KEY,
    Restaurant_Name VARCHAR(255),
    Country_Code INT,
    City VARCHAR(100),
    Address TEXT,
    Locality VARCHAR(255),
    Locality_Verbose VARCHAR(255),
    Longitude DECIMAL(10,6),
    Latitude DECIMAL(10,6),
    Cuisines VARCHAR(255),
    Average_Cost_for_two INT,
    Currency VARCHAR(50),
    Has_Table_booking VARCHAR(3),
    Has_Online_delivery VARCHAR(3),
    Is_delivering_now VARCHAR(3),
    Switch_to_order_menu VARCHAR(3),
    Price_range INT,
    Rating FLOAT,
    Rating_color VARCHAR(50),
    Rating_text VARCHAR(50),
    Votes INT
);

-- Step 3: Sample Queries

-- View sample data
SELECT * FROM restaurants LIMIT 10;

-- Total restaurants per city
SELECT City, COUNT(*) AS Total_Restaurants
FROM restaurants
GROUP BY City
ORDER BY Total_Restaurants DESC;

-- Most popular cuisines
SELECT Cuisines, COUNT(*) AS Count
FROM restaurants
GROUP BY Cuisines
ORDER BY Count DESC
LIMIT 10;

-- Online delivery pattern
SELECT Has_Online_delivery, COUNT(*) AS Total
FROM restaurants
GROUP BY Has_Online_delivery;

-- Localities with most restaurants
SELECT City, Locality, COUNT(*) AS Total_Restaurants
FROM restaurants
GROUP BY City, Locality
ORDER BY Total_Restaurants DESC
LIMIT 10;

-- Step 4: Advanced Queries with CTEs and Views

-- CTE: Top 5 Cities with Highest Average Rating
WITH city_ratings AS (
    SELECT City, AVG(Rating) AS Avg_Rating
    FROM restaurants
    GROUP BY City
)
SELECT * FROM city_ratings
ORDER BY Avg_Rating DESC
LIMIT 5;

-- View: Top cuisines by count
CREATE OR REPLACE VIEW top_cuisines AS
SELECT Cuisines, COUNT(*) AS Count
FROM restaurants
GROUP BY Cuisines
ORDER BY Count DESC;

-- Use the view
SELECT * FROM top_cuisines LIMIT 10;

SELECT Cuisines, ROUND(AVG(Rating),2) AS Avg_Rating, SUM(Votes) AS Total_Votes
FROM restaurants
GROUP BY Cuisines
HAVING Total_Votes > 100
ORDER BY Avg_Rating DESC
LIMIT 10;

SELECT City, ROUND(AVG(Average_Cost_for_two),2) AS Avg_Cost
FROM restaurants
GROUP BY City
ORDER BY Avg_Cost DESC
LIMIT 5;



