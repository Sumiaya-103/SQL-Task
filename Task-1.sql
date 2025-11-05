CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Employees (
  emp_id INT PRIMARY KEY,
  name VARCHAR(50),
  department VARCHAR(50),
  salary DECIMAL(10,2),
  city VARCHAR(50),
  join_year INT
);

CREATE TABLE Sales (
  sale_id INT PRIMARY KEY,
  emp_id INT,
  product VARCHAR(50),
  quantity INT,
  price_per_unit DECIMAL(10,2)
);
INSERT INTO Employees VALUES
(1, 'Alice', 'HR', 50000, 'Dhaka', 2019),
(2, 'Bob', 'Sales', 65000, 'Chittagong', 2018),
(3, 'Charlie', 'Sales', 62000, 'Dhaka', 2020),
(4, 'Dina', 'IT', 70000, 'Sylhet', 2017),
(5, 'Ehsan', 'HR', 48000, 'Khulna', 2021),
(6, 'Fahim', 'IT', 72000, 'Dhaka', 2019);

INSERT INTO Sales VALUES
(101, 2, 'Laptop', 3, 75000),
(102, 2, 'Mouse', 10, 800),
(103, 3, 'Keyboard', 5, 1200),
(104, 3, 'Monitor', 2, 15000),
(105, 4, 'Server', 1, 250000),
(106, 6, 'Router', 4, 9000),
(107, 6, 'Cable', 10, 300),
(108, 2, 'Tablet', 2, 35000),
(109, 3, 'Mouse', 3, 800);

# 1. Display all records from the Employees table.
select *
from Employees;

# 2. Show the names and cities of all employees.
select name, city
from Employees;

# 3. List all products sold in the Sales table.
select product
from Sales;

# 4. Find the employee(s) who joined in the year 2019.
select *
from Employees
where join_year = 2019;

# 5. Show all employees whose salary is greater than 50,000.
select *
from Employees
where salary > 50000;

# 6. Display all employees who work in the “Sales” department and have a salary greater than 60,000.
select *
from Employees
where department = 'Sales' and salary > 60000;

# 7. Show all products sold by employee ID 2 that cost more than 10,000 per unit.
select product
from Sales
where emp_id = 2 and price_per_unit > 10000;

# 8. List the names of employees who joined after 2018, sorted by their joining year in ascending order.
select name, join_year
from Employees
where join_year > 2018 
order by join_year asc;

# 9. Retrieve the top 3 highest-paid employees.
select *
from Employees
order by salary desc
limit 3;

# 10. Display all sales where the total sale value (quantity × price_per_unit) is more than 50,000.
select *
from Sales
where quantity * price_per_unit > 50000;

# 11. Increase the salary of all employees in the “HR” department by 10%.
update Employees
set salary = salary + (salary * 0.1)
where department = 'HR';

select *
from Employees;

# 12. Delete all sales records where the product is “Cable”.
delete from Sales
where product = 'Cable';

select *
from sales;

# 13. Find the total number of employees from the city “Dhaka”.
select count(emp_id) as total_emp_Dhaka
from Employees
where city = 'Dhaka';

# 14. Count how many distinct products have been sold overall.
select count(distinct product) as total_distinct_prod
from Sales;

# 15. Show the lowest and highest salary in the company.
select min(salary) as Lowest_Salary,
       max(salary) as Highest_Salary
from Employees;

# 16. Display the employee(s) who have made at least one sale of a product priced above 20,000.
select distinct e.emp_id, e.name, e.department
from Employees as e join Sales as s
on e.emp_id = s.emp_id
where price_per_unit > 20000;

# 17. Find the total sales amount made by employee ID 3. (Total = SUM(quantity × price_per_unit))
select SUM(quantity * price_per_unit) as Total_sales_amount, e.name
from Employees as e join Sales as s
on e.emp_id = s.emp_id
where e.emp_id = 3;

# 18. Find the employee(s) who joined before 2020 and whose salary is below the average salary of all employees.

select emp_id, name, department, join_year, salary
from Employees
where join_year < 2020 and salary < (select avg(salary)
                                     from Employees);
                                     
# 19. Display the average salary of employees in Dhaka only if there are more than 2 employees from Dhaka.
select avg(salary) as Average_salary, city
from Employees
where city = 'Dhaka'
group by city
having count(emp_id) > 2;

# 20. Show the name and city of the employee(s) who have the second highest salary.
select name, city
from Employees 
where salary =(select max(salary)
from Employees
where salary < (select max(salary)
                 from Employees));
                 
# 21. Find the total revenue (sum of all quantity × price_per_unit) from all sales where quantity is greater than 3.
select sum(quantity * price_per_unit) as Total_Revenue
from Sales
where quantity > 3;

# 22. Update the price of all products named “Mouse” by increasing them 20%.
update Sales
set price_per_unit = price_per_unit + (price_per_unit * 0.20)
where product = 'Mouse';

select * 
from Employees;

# 23. Delete any employee whose city name starts with ‘S’.
delete from Employees
where city like 'S%';

select * 
from Employees;

# 24. Display all employees whose name contains the letter ‘a’ (case-insensitive) and salary between 50,000 and 70,000.

select emp_id, name, salary
from Employees
where lower(name) like '%a%'
and salary between 50000 and 70000;




