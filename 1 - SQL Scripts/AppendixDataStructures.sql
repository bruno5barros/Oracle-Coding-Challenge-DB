create table Departments(
  Department_Id number(5) primary key,
  Department_Name VARCHAR2(50) not null,
  Location VARCHAR2(50) not null
);

COMMENT ON COLUMN Departments.Department_Id 
IS 'The unique identifier for the department';
   
COMMENT ON COLUMN Departments.Department_Name 
IS 'The name of the department';
   
COMMENT ON COLUMN Departments.Location 
IS 'The physical location of the department';


create table Employees(
  Employee_Id number(10) primary key,
  Employee_Name VARCHAR2(50) not null,
  Job_Title VARCHAR2(50) not null,
  Manager_Id number(10),
  Date_Hired Date default sysdate not null,
  Salary number(10) not null,
  Department_Id number(5) not null
);

alter table Employees add foreign key (Department_Id) references Departments
(Department_Id);

COMMENT ON COLUMN Employees.Employee_Id 
IS 'The unique identifier for the employee';
   
COMMENT ON COLUMN Employees.Employee_Name 
IS 'The name of the employee';
   
COMMENT ON COLUMN Employees.Job_Title 
IS 'The job role undertaken by the employee. Some employees
may undertaken the same job role';

COMMENT ON COLUMN Employees.Manager_Id 
IS 'Line manager of the employee';
   
COMMENT ON COLUMN Employees.Date_Hired 
IS 'The date the employee was hired';
   
COMMENT ON COLUMN Employees.Salary 
IS 'Current salary of the employee';

COMMENT ON COLUMN Employees.Department_Id 
IS 'Each employee must belong to a department';