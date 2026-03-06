
--- Clean LF to Low fat and Reg to regular 

 SELECT* FROM Blinkit_Data
 SELECT COUNT (*) FROM Blinkit_Data

 UPDATE Blinkit_Data
 SET Item_Fat_Content = 
 CASE 
 WHEN Item_Fat_Content IN ( 'LF' , 'Low Fat ' ) THEN 'Low Fat ' 
 WHEN Item_Fat_Content= 'REG' then 'Regular'  
 else Item_Fat_Content
 end

 -- Let's find some KPI'S Requirements 

 -- Total Sales 
 select sum( Total_Sales) from Blinkit_Data


 select  cast (sum (total_Sales) /1000000 AS DECIMAL(10,2)) AS Total_Sales
 from Blinkit_Data


 -- Average sales 

 Select  cast (avg(Total_sales) AS  decimal  (10,2)) Averge_Sales from Blinkit_Data
 
-- NUMBER OF ITEMS SOLD 
SELECT COUNT (*) AS No_of_Items FROM Blinkit_Data


-- Averge Rating 

Select cast(avg(rating) AS Decimal (10,2)) AS Avg_Rating from Blinkit_Data

-- Granular requirements






-- Total Sales by fat content
--  will be taking the excess of decimals away 
SELECT Item_Fat_Content, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS
Total_Sales
FROM blinkit_data
GROUP BY Item_Fat_Content


-- Total Sales by Item Type
SELECT Item_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC

-- Fat Content by Outlet for Total Sales


SELECT Outlet_Location_Type,
ISNULL([Low Fat], 0) AS Low_Fat,
ISNULL([Regular], 0) AS Regular
FROM
(
SELECT Outlet_Location_Type, Item_Fat_Content,
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT
(
SUM(Total_Sales)
FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

-- Total Sales by Outlet Establishment
SELECT Outlet_Establishment_Year, CAST(SUM(Total_Sales) AS DECIMAL(10,2))
AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year

--Percentage of Sales by Outlet Size
SELECT
Outlet_Size,
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS
DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;


-- Sales by Outlet Location


SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS
Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC


-- All Metrics by Outlet Type
SELECT Outlet_Type,
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
COUNT(*) AS No_Of_Items,
CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
from Blinkit_Data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC





     














 




