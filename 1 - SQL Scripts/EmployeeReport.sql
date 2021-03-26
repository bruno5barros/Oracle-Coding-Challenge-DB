-- Write a report to show all Employees for a Department 
-- Option 1
select * from employees
where department_id = (select department_id from departments 
where department_id = &departmentId);

-- Option 2
select * from employees e
inner join departments d on e.department_id = d.department_id
where e.department_id = &departmentId;



-- Write a report to show the total of Employee Salary for a Department
-- Option 1
select d.department_name, sum(e.salary) from employees e
inner join departments d on e.department_id = d.department_id
where e.department_id = &departmentId
group by d.department_name;

-- Option 2
select department_id, sum(salary) from employees
where department_id = (select department_id from departments 
where department_id = &departmentId)
group by department_id;