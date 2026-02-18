# 💼 FAANG SQL Interview Question – Second Highest Salary
## 📌 Problem Statement
Imagine youre an HR analyst at a tech company tasked with analyzing employee salaries.
Your manager wants to understand the pay distribution and asks you to determine the **second highest salary** among all employees.
If multiple employees share the same second highest salary, display the salary **only once**.
---
## 🗂 Table: employee
| Column Name    | Type    | Description                                |
|---------------|---------|--------------------------------------------|
| employee_id   | integer | The unique ID of the employee.             |
| name          | string  | The name of the employee.                  |
| salary        | integer | The salary of the employee.                |
| department_id | integer | The department ID of the employee.         |
| manager_id    | integer | The manager ID of the employee.            |
---
## 📥 Example Input
| employee_id | name              | salary | department_id | manager_id |
|-------------|------------------|--------|--------------|------------|
| 1           | Emma Thompson     | 3800   | 1            | 6          |
| 2           | Daniel Rodriguez  | 2230   | 1            | 7          |
| 3           | Olivia Smith      | 2000   | 1            | 8          |
---
## 📤 Expected Output
| second_highest_salary |
|------------------------|
| 2230                   |
---
## 📝 Notes
- Return only the salary value.
- If duplicate salaries exist, return the second highest salary only once.
- If there is no second highest salary, return `NULL`.

## my query
select 
  t.salary as second_highest_salary
from (
SELECT 
  *,
  DENSE_RANK() over(order by salary desc) as rnk
FROM employee
)t
where t.rnk = 2;
