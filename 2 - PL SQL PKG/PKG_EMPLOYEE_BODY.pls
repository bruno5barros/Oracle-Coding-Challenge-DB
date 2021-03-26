create or replace PACKAGE BODY PKG_EMPLOYEE AS

  function get_employee(v_id employees.employee_id%type) 
  return employees%rowtype is
  BEGIN
    select * into v_emp_row_g from employees where employee_id = v_id;
    RETURN v_emp_row_g;
    
  exception
    when no_data_found then
      dbms_output.put_line('There is no employee with the selected id');
      return null;
    when others then
      dbms_output.put_line('An unexpected error happened. Connect with the programmer..');
      return null;
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
    
  exception
    when others then
      dbms_output.put_line('An unexpected error happened.
                            Validate the input if the error persists,
                            contact the programmer.');
      return null;
  END create_employee;

  function increase_salary(v_id employees.employee_id%type, 
  v_salary_raise employees.Salary%type) return VARCHAR2 AS
  BEGIN
    if v_salary_raise > 1 and v_salary_raise <= 2 then
      v_emp_row_g:= get_employee(v_id);
      if v_emp_row_g.salary is null then 
        dbms_output.put_line('No employee returned.');
        RETURN 'There is no employee with the selected id.';
      else
        v_emp_row_g.salary := v_emp_row_g.salary * v_salary_raise;
        update employees SET salary = v_emp_row_g.salary where employee_id = v_id;
        commit;
        RETURN 'Employee salary updated with sucess.';
      end if;
    else
      dbms_output.put_line('The Percentage of the salary increase has to be 
                            between 1 and 2.');
      RETURN 'The Percentage of the salary increase has to be between 1 and 2.';
    end if;
    
  exception
    when others then
      dbms_output.put_line('An unexpected error happened. Connect with the 
                            programmer..');
      return null;
  END increase_salary;

  function decrease_salary(v_id employees.employee_id%type, 
  v_salary_decrease employees.Salary%type) return VARCHAR2 AS
  BEGIN
    if v_salary_decrease > 0 and v_salary_decrease <= 1 then
      v_emp_row_g := get_employee(v_id);
      if v_emp_row_g.salary is null then 
        dbms_output.put_line('No employee returned.');
        RETURN 'There is no employee with the selected id.';
      else
        v_emp_row_g.salary := v_emp_row_g.salary - v_emp_row_g.salary * v_salary_decrease;
        update employees SET salary = v_emp_row_g.salary where employee_id = v_id;
        commit;
        RETURN 'Employee salary updated with sucess.';
      end if;
    else
      dbms_output.put_line('The percentage of the salary decrease has to be 
                            between 0 and 1.');
      RETURN 'The Percentage of the salary decrease has to be between 0 and 1.';
    end if;
    
  exception
    when others then
      dbms_output.put_line('An unexpected error happened. Connect with the 
      programmer..');
      return null;
  END decrease_salary;

  function transfer_employee(v_id employees.employee_id%type, 
  v_Department_Id employees.Department_Id%type) return VARCHAR2 AS
  BEGIN
    update employees SET Department_Id = v_Department_Id where employee_id = v_id;
    commit;
    RETURN 'Employee transferred with sucess.';
    
  exception
    when others then
      dbms_output.put_line('An unexpected error happened. Connect with the programmer..');
      return null;
  END transfer_employee;

  function get_salary(v_id employees.employee_id%type) 
  return employees.salary%type AS
  BEGIN
    v_emp_row_g:= get_employee(v_id);
    
    if v_emp_row_g.salary is null then 
      dbms_output.put_line('No employee returned.');
      RETURN null;
    else
      dbms_output.put_line('The employee salary is: ' || v_emp_row_g.salary);
      RETURN v_emp_row_g.salary;
    end if;  
    
  exception
    when others then
      dbms_output.put_line('An unexpected error happened. Connect with the programmer..');
      return null;
  END get_salary;

END PKG_EMPLOYEE;