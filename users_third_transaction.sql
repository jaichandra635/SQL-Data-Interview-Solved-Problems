# 🚗 Uber SQL Interview Question – Third Transaction Per User - Medium
## 📌 Problem Statement
Assume you are given a table of Uber transactions made by users.
Write a SQL query to obtain the **third transaction of every user**.
Return the following columns:
- `user_id`
- `spend`
- `transaction_date`
---
## 🗂 Table: transactions
| Column Name       | Type      |
|------------------|----------|
| user_id           | integer  |
| spend             | decimal  |
| transaction_date  | timestamp |
---
## 📥 Example Input
| user_id | spend  | transaction_date       |
|----------|--------|------------------------|
| 111      | 100.50 | 01/08/2022 12:00:00    |
| 111      | 55.00  | 01/10/2022 12:00:00    |
| 121      | 36.00  | 01/18/2022 12:00:00    |
| 145      | 24.99  | 01/26/2022 12:00:00    |
| 111      | 89.60  | 02/05/2022 12:00:00    |
---
## 📤 Expected Output
| user_id | spend | transaction_date       |
|----------|--------|------------------------|
| 111      | 89.60 | 02/05/2022 12:00:00    |

  
## My Solution
SELECT
t.user_id,
t.spend,
t.transaction_date from(
SELECT 
  user_id,
  spend,
  transaction_date,
  row_number() over(partition by user_id order by transaction_date) as rnk
FROM transactions)t
where rnk = 3;


## Output
user_id	spend	transaction_date
111	90	2022-02-05 12:00:00
121	68	2022-04-03 12:00:00
263	100	2022-07-12 12:00:00

