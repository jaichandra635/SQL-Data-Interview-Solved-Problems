# 💼 SQL Interview Question – High Earners by Department
## 📌 Problem Statement
As part of an ongoing analysis of salary distribution within the company, your manager has requested a report identifying high earners in each department.
A **high earner** is defined as an employee whose salary ranks among the **top three salaries within their department**.
Write a SQL query to display:
- `department_name`
- `employee name`
- `salary`
### Sorting Requirements
- Sort results by `department_name` in ascending order.
- Then sort by `salary` in descending order.
- If multiple employees have the same salary, order them alphabetically by `name`.
> Note: Use an appropriate ranking window function to correctly handle duplicate salaries.
> As of June 18th, the requirement for unique salaries was removed and sorting order was revised.
## 🗂 Table: employee
| Column Name    | Type    | Description                                |
|---------------|---------|--------------------------------------------|
| employee_id   | integer | The unique ID of the employee              |
| name          | string  | The name of the employee                   |
| salary        | integer | The salary of the employee                 |
| department_id | integer | The department ID of the employee          |
| manager_id    | integer | The manager ID of the employee             |
## 📥 employee Example Input
| employee_id | name              | salary | department_id | manager_id |
|-------------|------------------|--------|--------------|------------|
| 1           | Emma Thompson     | 3800   | 1            | 6          |
| 2           | Daniel Rodriguez  | 2230   | 1            | 7          |
| 3           | Olivia Smith      | 2000   | 1            | 8          |
| 4           | Noah Johnson      | 6800   | 2            | 9          |
| 5           | Sophia Martinez   | 1750   | 1            | 11         |
| 6           | Liam Brown        | 13000  | 3            | NULL       |
| 7           | Ava Garcia        | 12500  | 3            | NULL       |
| 8           | William Davis     | 6800   | 2            | NULL       |
| 9           | Isabella Wilson   | 11000  | 3            | NULL       |
| 10          | James Anderson    | 4000   | 1            | 11         |
## 🗂 Table: department
| Column Name     | Type    | Description                       |
|----------------|---------|-----------------------------------|
| department_id  | integer | The department ID                 |
| department_name| string  | The name of the department        |
## 📥 department Example Input
| department_id | department_name |
|---------------|-----------------|
| 1             | Data Analytics  |
| 2             | Data Science    |
## 📤 Expected Output
| department_name | name             | salary |
|-----------------|------------------|--------|
| Data Analytics  | James Anderson   | 4000   |
| Data Analytics  | Emma Thompson    | 3800   |
| Data Analytics  | Daniel Rodriguez | 2230   |
| Data Science    | Noah Johnson     | 6800   |
| Data Science    | William Davis    | 6800   |
## 💡 Explanation
In the **Data Analytics** department:
- James Anderson earns $4,000
- Emma Thompson earns $3,800
- Daniel Rodriguez earns $2,230  
These are the top three salaries within the department.
In the **Data Science** department:
- Noah Johnson and William Davis both earn $6,800  
Since their salaries are equal, they are sorted alphabetically.
> The dataset you are querying against may have different input and output. This example is for illustration purposes only.

Solution
with ranking as(
SELECT 
  d.department_name,
  e.name,
  e.salary,
  dense_rank() over(
  partition by d.department_name
  order by e.salary desc, d.department_name asc
  ) dep_rank
FROM employee e 
join department d on d.department_id = e.department_id
order by d.department_name, e.salary desc, e.name
)
select 
  department_name,
  name,
  salary
from ranking
where dep_rank <= 3;
