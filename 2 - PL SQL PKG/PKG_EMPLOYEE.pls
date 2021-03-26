create or replace PACKAGE PKG_EMPLOYEE AS 

  --v_pk_res_g VARCHAR2(50) := '';
  v_emp_row_g employees%rowtype;

  function get_employee(v_id employees.employee_id%type) 
  return employees%rowtype;
  
  function create_employee(v_employee_name employees.employee_name%type, 
  v_Job_Title employees.Job_Title%type, v_Manager_Id employees.Manager_Id%type, 
  v_Date_Hired employees.Date_Hired%type, v_Salary employees.Salary%type,
  v_Department_Id employees.Department_Id%type) return VARCHAR2;
  
  function increase_salary(v_id employees.employee_id%type, 
  v_salary_raise employees.Salary%type) return VARCHAR2;
  
  function decrease_salary(v_id employees.employee_id%type, 
  v_salary_raise employees.Salary%type) return VARCHAR2;
  
  function transfer_employee(v_id employees.employee_id%type, 
  v_Department_Id employees.Department_Id%type) return VARCHAR2;
  
  function get_salary(v_id employees.employee_id%type) 
  return employees.salary%type;

END PKG_EMPLOYEE;