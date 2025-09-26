create database zepto_data;
CREATE TABLE zepto (
    sku_id INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp DECIMAL(8,2),
    discountPercent DECIMAL(8,2),
    availableQuantity INT,
    discountedSellingPrice DECIMAL(8,2),
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);

drop table zepto;

alter table zepto_v2
add column sku_id INT auto_increment primary key first;

alter table zepto_v2
modify column Category varchar(120);

ALTER TABLE zepto_v2
modify column name varchar(150) not null;

alter table zepto_v2
modify column mrp decimal(8,2);

alter table zepto_v2
modify column discountPercent decimal(8,2);

alter table zepto_v2
modify column discountedSellingPrice INT;

alter table zepto_v2
modify column outOfStock boolean;

DESCRIBE zepto_v2;

SELECT DISTINCT outOfStock FROM zepto_v2;


UPDATE zepto_v2
SET outOfStock = CASE 
    WHEN outOfStock IN ('Yes','TRUE','1') THEN '1'
    ELSE '0'
END;

ALTER TABLE zepto_v2
MODIFY COLUMN outOfStock BOOLEAN;

-- data exploration
-- count of rows

select count(*) from zepto_v2;

-- sample data

select * from zepto_v2
limit 15;

-- null values

select * from zepto_v2
where name IS NULL
OR
Category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
availableQuantity IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

-- different product categories 

select distinct category from zepto_v2
order by Category;

-- products in stock and how many products are out of stocks
select outOfStock,count(sku_id) from zepto_v2
group by outOfStock;

-- product name presents multiple times

select name,count(sku_id) as "No of SKUS" from zepto_v2
group by name 
having count(sku_id) > 1
order by count(sku_id) desc;

-- data cleaning
-- products with price  = 0

select* from zepto_v2
where mrp = 0 or discountedSellingPrice = 0;

delete from zepto_v2
where mrp = 0;


-- convert paise into rupees
update zepto_v2
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

select * from zepto_v2;


-- Q1 - find top 10 best value products based on the discount percentage
select distinct name,mrp,discountPercent from zepto_v2
order by discountPercent desc
limit 10;


-- Q2 - what are the products with high MRP but out of stock
select distinct name,mrp from zepto_v2
where outOfStock = 1 AND mrp > 300
order by mrp desc;

-- Q3 CALCULATE ESTIMATED TOTAL REVENUE FOR EACH CATEGORY
select Category,
sum(discountedSellingPrice * availableQuantity)as Total_revenue from zepto_v2
group by Category
order by Total_revenue;

-- Q4 Find all products where mrp is greater than Rs 500 and discount is less than 10%

select distinct name,mrp,discountPercent from zepto_v2
where mrp > 500 and discountPercent < 10
order by mrp desc,discountPercent desc;

-- Q5 identify the top 5 catgories offering the highest average discount percentage

select Category,
round(avg(discountPercent),2) as Avg_discount from zepto_v2
group by Category
order by Avg_discount desc
limit 5;


-- Q6 find the price per grams for products above 100gm and sort best values
select distinct name , weightInGms, discountedSellingPrice,
round((discountedSellingPrice / weightInGms),2)as price_per_gms from zepto_v2
where weightInGms >= 100
order by price_per_gms;

-- Q7 Group the products into categories like low,medium,bulk
select distinct name , weightInGms,
case 
when weightInGms < 1000 then 'low'
when weightInGms < 5000 then 'medium'
else 'bulk'
end as weight_category

from zepto_v2;


-- Q8 what is the total inventory weight per category

select Category,sum(weightInGms * availableQuantity) as total_weight from zepto_v2
group by Category
order by total_weight desc;
