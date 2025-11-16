create database employeedb;
use employeedb;

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT,
    budget DECIMAL(10,2),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Employee_Projects (
    emp_id INT,
    project_id INT,
    hours_worked INT,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Finance');

INSERT INTO Employees VALUES
(101, 'Alice', 1, 60000, '2020-01-15'),
(102, 'Bob', 2, 80000, '2019-05-10'),
(103, 'Charlie', 2, 75000, '2021-03-20'),
(104, 'David', 3, 50000, '2022-11-05'),
(105, 'Eve', 4, 90000, '2018-07-18');

INSERT INTO Projects VALUES
(201, 'Recruitment System', 1, 20000),
(202, 'AI Platform', 2, 150000),
(203, 'Ad Campaign', 3, 50000),
(204, 'Accounting Revamp', 4, 80000);

INSERT INTO Employee_Projects VALUES
(101, 201, 120),
(102, 202, 200),
(103, 202, 180),
(104, 203, 90),
(105, 204, 220);
# EASY SQL CHALLENGES (5)
-- List all employees along with their department names.
select emp_name, dept_name
from Employees as e
join Departments as d
on e.dept_id = d.dept_id;
-- Show the total number of employees in each department.
select dept_name, count(emp_id) as Total_employees
from Employees as e 
join Departments as d
on e.dept_id = d.dept_id
group by dept_name;

-- Find the average salary for each department.
select dept_name, avg(salary) as Avg_Salary
from Employees as e
join Departments as d
on e.dept_id = d.dept_id
group by dept_name;

-- Display all departments having more than 1 employee.
select dept_name, count(emp_id) as Total_emp
from Employees as e
join Departments as d
on e.dept_id = d.dept_id
group by dept_name
having count(emp_id) > 1;

-- Show all projects and their associated department names.
select project_name, dept_name
from Projects as p
join Departments as d
on p.dept_id = d.dept_id;

# MEDIUM SQL CHALLENGES (15)

 -- List employees who don’t belong to any project (use LEFT JOIN).
select e.emp_name
from Employees as e
left join Employee_Projects as ep
on e.emp_id = ep.emp_id
where ep.project_id is null;

 -- Show total project hours worked by each employee.
 select e.emp_name, sum(ep.hours_worked) as Total_Hours
 from Employees as e
 join Employee_Projects as ep
 on e.emp_id = ep.emp_id
 group by emp_name;
 
 -- Find employees working in departments where average salary > 70000.
select emp_name, dept_name
from Employees as e
join Departments as d
on e.dept_id = d.dept_id
where e.dept_id in( select dept_id
                    from Employees
					group by dept_id
                    having avg(salary) > 70000);
 
 -- List all departments with total salary expense > 100000.
select d.dept_name, sum(e.salary) as total_salary
from Employees as e
join Departments d 
on e.dept_id = d.dept_id
group by d.dept_name
having sum(e.salary) > 100000;

  -- Display employees who earn more than the average salary of their department.
select e.emp_name, e.salary, d.dept_name
from Employees e
join Departments d on e.dept_id = d.dept_id
where e.salary > (
      select avg(salary)
      from Employees
      where dept_id = e.dept_id
);

  -- List all projects with department name and average hours worked by employees.
  select p.project_name, d.dept_name, avg(ep.hours_worked) as avg_hours
  from Projects as p
  join Departments d on p.dept_id = d.dept_id
  join Employee_Projects ep 
  on p.project_id = ep.project_id
  group by p.project_name, d.dept_name;

  -- Show the highest-paid employee in each department.
     select e.emp_name, e.salary, d.dept_name
     from Employees as e
     join Departments as d on e.dept_id = d.dept_id
     where e.salary = (select MAX(salary)
	                   from Employees
                       where dept_id = e.dept_id
                       );

  
  -- Find all employees who joined before 2020 and work in Finance.
    select e.emp_name, e.hire_date
    from Employees as e
    join Departments as d 
    on e.dept_id = d.dept_id
    where d.dept_name = 'Finance' and e.hire_date < '2020-01-01';
  
  -- List all departments that have no projects assigned.
     select d.dept_name
     from Departments as d
     left join Projects as p 
     on d.dept_id = p.dept_id
     where p.project_id is null;

  -- Display the total number of projects per department using GROUP BY.
  select d.dept_name, count(p.project_id) as total_projects
  from Departments as d
  left join Projects as p on d.dept_id = p.dept_id
  group by d.dept_name;

  -- Find departments where the average project budget exceeds 60000.
  select d.dept_name, avg(p.budget) as avg_budget
  from Departments as d
  join Projects as p 
  on d.dept_id = p.dept_id
  group by d.dept_name
  having avg(p.budget) > 60000;

  -- List employees and the number of projects they are assigned to.
  select e.emp_name, count(ep.project_id) as total_projects
  from Employees as e
  left join Employee_Projects ep 
  on e.emp_id = ep.emp_id
  group by e.emp_name;

  -- Find employees who have worked more than 150 total hours across projects.
  select e.emp_name, sum(ep.hours_worked) as total_hours
  from Employees as e
  join Employee_Projects ep 
  on e.emp_id = ep.emp_id
  group by e.emp_name
  having sum(ep.hours_worked) > 150;

  -- Show departments that have at least one project with budget < 50000.
  select distinct d.dept_name
  from Departments as d
  join Projects as p 
  on d.dept_id = p.dept_id
  where p.budget < 50000;

-- Display all employees with their department name and total hours worked, even if they have no project.
select e.emp_name, d.dept_name, coalesce(sum(ep.hours_worked), 0) as total_hours
from Employees as e
join Departments as d 
on e.dept_id = d.dept_id
left join Employee_Projects ep on e.emp_id = ep.emp_id
group by e.emp_name, d.dept_name;


 # HARD SQL CHALLENGES (10)
 -- Find employees whose salary is above their department’s average salary.
    select e.emp_name, e.salary, d.dept_name
	from Employees e
    join Departments d 
    on e.dept_id = d.dept_id
    where e.salary > (
      select avg(salary)
      from Employees
      where dept_id = e.dept_id
);
 -- Show departments where every project has a budget greater than 40000.
  select d.dept_name
  from Departments d
  join Projects p 
  on d.dept_id = p.dept_id
  group by d.dept_name
  having min(p.budget) > 40000;

 -- Display the top 2 highest-paid employees per department.
 select e1.emp_name, e1.salary, e1.dept_id
 from Employees as e1
 where (
  select count(distinct e2.salary)
  from Employees e2
  where e2.dept_id = e1.dept_id and e2.salary > e1.salary
) < 2;

 -- Find the employee who worked the most hours on any project.
 select e.emp_name, ep.hours_worked
 from Employees as e
 join Employee_Projects as ep 
 ON e.emp_id = ep.emp_id
 where ep.hours_worked = (select max(hours_worked)
                          from Employee_Projects
                          );

 -- List departments whose total employee salary is greater than the total project budget.
  select d.dept_name
  from Departments as d
  join Employees as e 
  on d.dept_id = e.dept_id
  join Projects as p 
  on d.dept_id = p.dept_id
  group by d.dept_name
  having sum(e.salary) > sum(p.budget);

 -- Show the second highest salary in each department.
 select dept_id, max(salary) as second_highest_salary
 from Employees
 where salary < (
 select max(salary)
  from Employees as e2
  where e2.dept_id = Employees.dept_id
)
 group by dept_id;

 -- Find employees who have worked on all projects in their department.
select e.emp_name
from Employees as e
join Employee_Projects as ep 
on e.emp_id = ep.emp_id
join Projects as p 
on ep.project_id = p.project_id
group by e.emp_name, e.dept_id
having count(distinct ep.project_id) = (
  select count(*)
  from Projects
  where dept_id = e.dept_id
);

 -- Display the department(s) with the maximum number of projects.
select d.dept_name
from Departments as d
join Projects as p 
on d.dept_id = p.dept_id
group by d.dept_name
having count(p.project_id) = (select max(project_count)
                             from (select count(project_id) as project_count
                                   FROM Projects
								   GROUP BY dept_id
                                   ) sub
                                   );

 -- Show the total number of employees who earn above the overall average salary (using subquery).
 select count(*) AS total_above_avg
 from Employees
 where salary > (select avg(salary) 
                 from Employees);

 -- List employees who have never worked on a project whose budget is above 100000.
 select e.emp_name
 from Employees as e
 where e.emp_id not in (
  select ep.emp_id
  from Employee_Projects ep
  join Projects as p 
  on ep.project_id = p.project_id
  where p.budget > 100000
);


