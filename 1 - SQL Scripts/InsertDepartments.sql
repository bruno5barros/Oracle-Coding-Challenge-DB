set define off
INSERT INTO departments (Department_Id, Department_Name, Location) 
  WITH newdepartments AS ( 
    SELECT 1, 'Management',             'London'    FROM dual UNION ALL 
    SELECT 2, 'Engineering',            'Cardiff'   FROM dual UNION ALL 
    SELECT 3, 'Research & Development', 'Edinburgh' FROM dual UNION ALL 
    SELECT 4, 'Sales',                  'Belfast'   FROM dual 
  ) 
  SELECT * FROM newdepartments;