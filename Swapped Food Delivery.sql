# 🍽️ Zomato SQL Interview Question – Swapped Food Delivery
## 📌 Problem Statement
Zomato is a leading online food delivery service that connects users with restaurants and cuisines, allowing them to browse menus, place orders, and receive meals at their doorsteps.
Recently, Zomato encountered an issue in their delivery system. Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row.
As a data analyst, your task is to correct this swapping error and return the proper pairing of order IDs and items.
---
## 📝 Requirements
- Each row's `item` was swapped with the next row.
- You must correct the order so that items are properly aligned.
- If the last order has an **odd order_id**, it should remain unchanged.
- Return the corrected order ID and item pairing.
---
## 🗂 Table: orders

| Column Name | Type    | Description                          |
|------------|---------|--------------------------------------|
| order_id   | integer | The ID of each Zomato order.        |
| item       | string  | The name of the food item ordered.  |
---

## 📥 Example Input
| order_id | item               |
|----------|-------------------|
| 1        | Chow Mein         |
| 2        | Pizza             |
| 3        | Pad Thai          |
| 4        | Butter Chicken    |
| 5        | Eggrolls          |
| 6        | Burger            |
| 7        | Tandoori Chicken  |
---

## 📤 Expected Output
| corrected_order_id | item               |
|-------------------|-------------------|
| 1                 | Pizza             |
| 2                 | Chow Mein         |
| 3                 | Butter Chicken    |
| 4                 | Pad Thai          |
| 5                 | Burger            |
| 6                 | Eggrolls          |
| 7                 | Tandoori Chicken  |

---
## 💡 Explanation
- Order ID 1 is now associated with Pizza.
- Order ID 2 is paired with Chow Mein.
- Order IDs 3 and 4 are swapped.
- Order IDs 5 and 6 are swapped.
- Order ID 7 remains unchanged since it is the last odd order ID.

This ensures that the original swapping error is corrected while preserving the sequence when the total number of rows is odd.
---
## ⚠️ Note

The dataset used in evaluation may differ from the example shown above.  
This sample is provided for illustration purposes only.
# SQL Query
with counting as (
select
  count(order_id) as total_count
from orders
)
select 
  case 
  when order_id % 2 != 0 and order_id != total_count then order_id +1
  when order_id % 2 != 0 and order_id = total_count then order_id
  else order_id - 1 end as corrected_order_id,
  item
from orders
cross join counting
order by corrected_order_id;
