# 🛒 Amazon SQL Interview Question – Highest-Grossing Items
This is the same question as Problem #12 in the SQL Chapter of *Ace the Data Science Interview*.
---
## 📌 Problem Statement
Assume youre given a table containing data on Amazon customers and their spending on products across different categories.
Write a SQL query to identify the **top two highest-grossing products within each category** for the year **2022**.
The output should include:
- `category`
- `product`
- `total_spend`
---
## 🗂 Table: product_spend
| Column Name       | Type      |
|------------------|----------|
| category          | string   |
| product           | string   |
| user_id           | integer  |
| spend             | decimal  |
| transaction_date  | timestamp|
---
## 📥 Example Input
| category    | product           | user_id | spend  | transaction_date       |
|------------|------------------|---------|--------|------------------------|
| appliance   | refrigerator      | 165     | 246.00 | 12/26/2021 12:00:00    |
| appliance   | refrigerator      | 123     | 299.99 | 03/02/2022 12:00:00    |
| appliance   | washing machine   | 123     | 219.80 | 03/02/2022 12:00:00    |
| electronics | vacuum            | 178     | 152.00 | 04/05/2022 12:00:00    |
| electronics | wireless headset  | 156     | 249.90 | 07/08/2022 12:00:00    |
| electronics | vacuum            | 145     | 189.00 | 07/15/2022 12:00:00    |
---
## 📤 Expected Output
| category    | product           | total_spend |
|------------|------------------|-------------|
| appliance   | refrigerator      | 299.99      |
| appliance   | washing machine   | 219.80      |
| electronics | vacuum            | 341.00      |
| electronics | wireless headset  | 249.90      |
---
## 📝 Notes
- Only transactions from the year **2022** should be considered.
- Total spend per product should be calculated before ranking.
- If two products have the same total spend, both should be included.
- The result should show the **top 2 products per category** based on total spend.

# My Query
  with product_spending as (
SELECT 
  category,
  product,
  sum(spend) 
  over(partition by category, product 
       order by spend desc) as total_spend
FROM product_spend
where year(transaction_date) = "2022"
), ranking as (
SELECT
  *,
  DENSE_RANK() over(partition by category order by total_spend desc) as rnk
from product_spending
)
select 
  distinct 
  category,
  product, 
  total_spend
from ranking
where rnk < 3;

