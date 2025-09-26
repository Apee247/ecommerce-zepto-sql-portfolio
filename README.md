# ecommerce-zepto-sql-portfolio
**Project Overview**

This project simulates how data analysts work behind the scenes in the e-commerce and retail industry. Using SQL, I worked on a messy, real-world style dataset to:

Set up an inventory database similar to what an e-commerce company uses

Perform Exploratory Data Analysis (EDA) to explore categories, stock availability, and pricing gaps

Apply data cleaning techniques to fix nulls, invalid entries, and unit mismatches

Write business-focused SQL queries to extract insights around pricing, discounts, stock levels, and potential revenue

**📁 Dataset Overview**

The dataset was sourced from Kaggle, originally scraped from Zepto’s product listings. It closely resembles what a real e-commerce catalog looks like, where:

Each row represents a SKU (Stock Keeping Unit)

The same product name may appear multiple times (different package sizes, weights, or discounts)

Data includes categories, prices, discounts, availability, and product weights

**Columns in the dataset:**

sku_id: Synthetic primary key for each product

name: Product name as listed on the app

category: Product category (Fruits, Snacks, Beverages, etc.)

mrp: Maximum Retail Price (converted from paise to ₹)

discountPercent: Discount applied on MRP

discountedSellingPrice: Final price after discount (₹)

availableQuantity: Units available in inventory

weightInGms: Product weight in grams

outOfStock: Boolean flag (0 = In stock, 1 = Out of stock)

quantity: Units per package

**🔧 Workflow
1️⃣ Database Setup**

* Created a SQL table with appropriate data types to store product details: * 

CREATE TABLE zepto (
  sku_id INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp DECIMAL(8,2),
  discountPercent DECIMAL(5,2),
  availableQuantity INT,
  discountedSellingPrice DECIMAL(8,2),
  weightInGms INT,
  outOfStock BOOLEAN,
  quantity INT
);

**2️⃣ Data Import**

Imported CSV file into MySQL Workbench using the Table Data Import Wizard

Resolved common issues like UTF-8 encoding errors by re-saving the file in UTF-8 format

**3️⃣ Data Exploration**

Counted total records and viewed sample rows

Checked for null or missing values across columns

Listed distinct product categories

Compared in-stock vs out-of-stock counts

Detected duplicate product names across different SKUs

**4️⃣ Data Cleaning**

Removed rows with invalid values (MRP = 0 or discountedSellingPrice = 0)

Converted mrp and discountedSellingPrice from paise to rupees for consistency

Standardized values in boolean and quantity fields


**5️⃣ Business Insights (via SQL Queries)**

Found Top 10 products offering the highest discounts

Listed high-MRP items that are currently out of stock

Estimated potential revenue per category

Identified expensive products (MRP > ₹500) with low discounts

Ranked top 5 categories by highest average discount percentage

Calculated price per gram to spot best value products

Grouped products by weight: Low (<250g), Medium (250–1000g), Bulk (>1kg)

Measured total inventory weight per product category
