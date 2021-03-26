create or replace PACKAGE BODY PKG_EMPLOYEE AS

  function get_employee(v_id employees.employee_id%type) 
  return employees%rowtype is
  BEGIN
    select * into v_emp_row_g from employees where employee_id = v_id;
    RETURN v_emp_row_g;
  END get_employee;

  function create_employee(v_employee_name employees.employee_name%type, 
  v_Job_Title employees.Job_Title%type, v_Manager_Id employees.Manager_Id%type, 
  v_Date_Hired employees.Date_Hired%type, v_Salary employees.Salary%type,
  v_Department_Id employees.Department_Id%type) return VARCHAR2 AS
  BEGIN
    INSERT INTO Employees (Employee_Id, Employee_Name, Job_Title, Manager_Id,
                           Date_Hired, Salary, Department_Id) 
                   values (employee_id_seq.nextval, v_employee_name, 
                           v_Job_Title, v_Manager_Id, v_Date_Hired, v_Salary, 
                           v_Department_Id);
    commit;
    RETURN 'Employee created with sucess.';
  END create_employee;

  function increase_salary(v_id employees.employee_id%type, 
  v_salary_raise employees.Salary%type) return VARCHAR2 AS
  BEGIN
    v_emp_row_g:= get_employee(v_id);
    v_emp_row_g.salary := v_emp_row_g.salary * v_salary_raise;
    update employees SET salary = v_emp_row_g.salary where employee_id = v_id;
    commit;
    RETURN 'Employee salary updated with sucess.';
  END increase_salary;

  function decrease_salary(v_id employees.employee_id%type, 
  v_salary_raise employees.Salary%type) return VARCHAR2 AS
  BEGIN
    v_emp_row_g:= get_employee(v_id);
    v_emp_row_g.salary := v_emp_row_g.salary - v_emp_row_g.salary * v_salary_raise;
    update employees SET salary = v_emp_row_g.salary where employee_id = v_id;
    commit;
    RETURN 'Employee salary updated with sucess.';
  END decrease_salary;

  function transfer_employee(v_id employees.employee_id%type, 
  v_Department_Id employees.Department_Id%type) return VARCHAR2 AS
  BEGIN
    update employees SET Department_Id = v_Department_Id where employee_id = v_id;
    commit;
    RETURN 'Employee transferred with sucess.';
  END transfer_employee;

  function get_salary(v_id employees.employee_id%type) 
  return employees.salary%type AS
  BEGIN
    v_emp_row_g:= get_employee(v_id);
    RETURN v_emp_row_g.salary;
  END get_salary;

END PKG_EMPLOYEE;