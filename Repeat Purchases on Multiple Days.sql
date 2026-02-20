# 🛍️ Stitch Fix SQL Interview Question – Repeat Purchases on Multiple Days
This is the same question as Problem #7 in the SQL Chapter of *Ace the Data Science Interview*!
## 📌 Problem Statement
Assume you are given a table containing information on user purchases.
Write a SQL query to obtain the number of users who purchased the same product on **two or more different days**.
Return the number of **unique users**.
> PS: On 26 Oct 2022, the purchases dataset was expanded, so the official output may vary from earlier versions.
## 🗂 Table: purchases
| Column Name   | Type     |
|--------------|----------|
| user_id      | integer  |
| product_id   | integer  |
| quantity     | integer  |
| purchase_date| datetime |
## 📥 Example Input
| user_id | product_id | quantity | purchase_date        |
|----------|------------|----------|----------------------|
| 536      | 3223       | 6        | 01/11/2022 12:33:44  |
| 827      | 3585       | 35       | 02/20/2022 14:05:26  |
| 536      | 3223       | 5        | 03/02/2022 09:33:28  |
| 536      | 1435       | 10       | 03/02/2022 08:40:00  |
| 827      | 2452       | 45       | 04/09/2022 00:00:00  |
## 📤 Expected Output
| repeat_purchasers |
|-------------------|
| 1                 |
## 💡 Explanation
User **536** purchased product **3223** on two different dates:
- 01/11/2022  
- 03/02/2022  
Therefore, the total number of unique users who made repeat purchases of the same product on multiple days is **1**.
> The dataset you are querying against may have different input and output. This example is for illustration purposes only.

# SQL Query

with repeat_purchases as (
select
  distinct user_id as users
from purchases
group by user_id, product_id
having count(distinct purchase_date::date) > 1
)
select
  count(distinct users) as repeated_purchasers
from repeat_purchases
