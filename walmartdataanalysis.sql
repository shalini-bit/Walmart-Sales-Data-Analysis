SELECT * FROM walmartsalesdata;

-- FEATURE Engineering --

-- ADDING NEW COLUMN TIME OF DAY --

SELECT time, 
(CASE 
    WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
    WHEN time BETWEEN "12:00:01" AND "17:00:00" THEN "Afternoon"
    ELSE "Evening"
    END
  ) AS time_of_day
FROM walmartsalesdata;


ALTER table walmartsalesdata ADD COLUMN time_of_day VARCHAR(20);

UPDATE walmartsalesdata
SET time_of_day = (CASE
	WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
    WHEN time BETWEEN "12:00:01" AND "17:00:00" THEN "Afternoon"
    ELSE "Evening"
    END
);

-- ADDING A NEW COLUMN NAME DAYNAME --

ALTER TABLE walmartsalesdata ADD COLUMN day_name VARCHAR(10);

SELECT Date,DAYNAME(STR_TO_DATE(Date, '%d-%m-%Y')) AS day_name FROM walmartsalesdata;

UPDATE walmartsalesdata
SET day_name = DAYNAME(STR_TO_DATE(Date, '%d-%m-%Y')); 

-- ADDING a New column name monthname --

ALTER TABLE walmartsalesdata ADD COlUMN month_name VARCHAR(10);

SELECT Date,monthname(Date) AS month_name FROM walmartsalesdata;




UPDATE walmartsalesdata
SET month_name = monthname(STR_TO_DATE(Date, '%d-%m-%Y'));

-- Generic Question -------------

SELECT distinct city,branch from walmartsalesdata;

-- Product Question ----

SELECT count(distinct Product_line) from walmartsalesdata;

SELECT Payment AS payment_method, COUNT(Payment) AS cnt
FROM walmartsalesdata
group by Payment
order by cnt desc;


-- most selling product line -----

SELECT Product_line,
COUNT(Product_line) as cnt 
FROM walmartsalesdata
GROUP BY Product_line
ORDER BY cnt DESC;

-- what is total revenue by month 

SELECT month_name as month, sum(Total)  as Total_revenue
FROM walmartsalesdata
group by month_name 
order by Total_revenue desc;

-- What month had the largest cogs 

Select month_name as month, sum(cogs) as Total_cogs
From walmartsalesdata
group by month_name
order by total_cogs desc limit 1 ;

-- Which product line has the largest revenue 

Select product_line , sum(total) as Total_revenue
from walmartsalesdata
group by Product_line
order by total_revenue desc limit 1;

-- What is the city with largest revenue 

Select city , sum(total) as Total_revenue
from walmartsalesdata
group by city
order by total_revenue desc limit 1;

-- What product line had the largest VAT 

SELECT Product_line, AVG(VAT) as avg_tax
FROM walmartsalesdata
GROUP BY Product_line
ORDER BY avg_tax DESC limit 1;

-- Fetch each product line and add a column to those product line showing "Good" , "Bad". Good if its greater than average sales.

ALTER TABLE walmartsalesdata DROP COLUMN Review ;



-- Which branch sold more products than average products sold 

SELECT Branch, sum(Quantity) as qty
FROM walmartsalesdata
group by Branch
having sum(Quantity) > (select avg(Quantity) from walmartsalesdata);


-- What is the most common product line by gender.

SELECT gender , product_line , count(gender) as total_count
FROM walmartsalesdata
group by gender, product_line
order by total_count DESC;

-- What is the average rating of each product line.

SELECT  round(avg(rating),2) AS avg_rating, product_line
FROM walmartsalesdata
group by product_line
order by avg_rating desc;

-- SALES 
-- Number of sales made in each time of the day per weekday  (example = Monday)

SELECT time_of_day, COUNT(*) as Total_sales
from walmartsalesdata
where day_name = "Monday"
group by time_of_day
order by Total_Sales DESC;

-- Which of the customer type bring most revenue

SELECT customer_type , sum(total) as total_rev
from walmartsalesdata
group by customer_type
order by total_rev DESC;


-- Which city has the largest VAT 

SELECT City , avg(Vat) as vat
from walmartsalesdata
group by City
order by vat DESC;

-- Which customer type pays the most in VAT 

SELECT Customer_type , round(avg(Vat),2) as vat
from walmartsalesdata
group by Customer_type
order by vat DESC;


-- Customer --------------
-- How many unique customer types does the data have?
SELECT distinct Customer_type from walmartsalesdata;
-- How many unique payment methods does the data have?

SELECT distinct Payment from walmartsalesdata;
-- What is the most common customer type?

SELECT
	customer_type,
	count(*) as count
FROM walmartsalesdata
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?

SELECT
	customer_type,
    COUNT(*)
FROM walmartsalesdata
GROUP BY customer_type;
-- What is the gender of most of the customers?

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmartsalesdata
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmartsalesdata
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?

SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM walmartsalesdata
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings per branch?

SELECT
	time_of_day,
	round(AVG(rating),2) AS avg_rating
FROM walmartsalesdata
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day fo the week has the best avg ratings?

SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM walmartsalesdata
GROUP BY day_name 
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?

SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM walmartsalesdata
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;














