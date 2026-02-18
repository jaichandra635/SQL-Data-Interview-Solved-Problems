# 💳 Stripe SQL Interview Question (Hard) – Repeated Payments
## 📌 Problem Statement
Sometimes payment transactions are repeated by accident. This could be due to:
- User error  
- API failure  
- Retry errors causing a credit card to be charged twice  
Using the `transactions` table, identify payments made:
- At the **same merchant**
- Using the **same credit card**
- For the **same amount**
- Within **10 minutes** of each other
Return the total number of such **repeated payments**.
---
## 📝 Assumptions
- The **first transaction** in such a pair should **NOT** be counted.
- If two transactions meet the repeated-payment condition, only **1 repeated payment** should be counted.
- If more than two qualifying transactions occur consecutively within 10 minutes, only the subsequent ones should be counted.
---
## 🗂 Table: transactions
| Column Name            | Type     |
|------------------------|----------|
| transaction_id         | integer  |
| merchant_id            | integer  |
| credit_card_id         | integer  |
| amount                 | integer  |
| transaction_timestamp  | datetime |
---
## 📥 Example Input
| transaction_id | merchant_id | credit_card_id | amount | transaction_timestamp |
|---------------|------------|---------------|--------|------------------------|
| 1             | 101        | 1             | 100    | 09/25/2022 12:00:00    |
| 2             | 101        | 1             | 100    | 09/25/2022 12:08:00    |
| 3             | 101        | 1             | 100    | 09/25/2022 12:28:00    |
| 4             | 102        | 2             | 300    | 09/25/2022 12:00:00    |
| 6             | 102        | 2             | 400    | 09/25/2022 14:00:00    |
---
## 📤 Expected Output
| payment_count |
|---------------|
| 1             |
---
## 💡 Explanation
- Transaction 2 occurs within **10 minutes** of Transaction 1  
- Same `merchant_id`  
- Same `credit_card_id`  
- Same `amount`  
✅ Therefore, Transaction 2 is counted as a repeated payment.
Transaction 3 occurs **20 minutes after Transaction 2** and **28 minutes after Transaction 1**, so it does **not** qualify.
Transactions 4 and 6 have **different amounts**, so they do not qualify either.
---
## 🎯 Task
Write a SQL query to return the count of repeated payments.
  
## My Query
with trans as (
  select 
      transaction_id,
      merchant_id,
      credit_card_id,
      amount,
      transaction_timestamp,
      lag(transaction_timestamp)
      over(partition by merchant_id, credit_card_id, amount
           order by transaction_timestamp) as prev_trans
  from transactions
)
select 
  count(*) as payment_count
from trans
where prev_trans is not NULL 
and transaction_timestamp - prev_trans <= interval '10 minutes';

## Output
| payment_count |
|---------------|
| 4             |
