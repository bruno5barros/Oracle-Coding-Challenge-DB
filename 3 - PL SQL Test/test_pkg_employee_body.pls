create or replace PACKAGE BODY test_pkg_employee IS

   PROCEDURE p_get_employee IS
      l_actual   INTEGER := 90001;
      v_emp_row_actual employees%rowtype;
      l_expected employees%rowtype;
   BEGIN
      select * into v_emp_row_actual from employees where employee_id = l_actual;
      l_expected := pkg_employee.get_employee(l_actual);

      ut.expect(v_emp_row_actual.EMPLOYEE_NAME).to_equal(l_expected.EMPLOYEE_NAME);
   END p_get_employee;
   
   PROCEDURE p_employee_no_data_found IS
      l_expected   INTEGER := 0;
      v_emp_name_expected varchar2(3):= null;
      l_actual employees%rowtype;
   BEGIN
      l_actual := pkg_employee.get_employee(l_expected);

      ut.expect(l_actual.EMPLOYEE_NAME).to_equal(v_emp_name_expected);
   END p_employee_no_data_found;

   PROCEDURE p_create_employee IS
      l_actual   varchar2(50);
      l_expected varchar2(50) := 'Employee created with sucess.';
   BEGIN
      l_actual := PKG_EMPLOYEE.CREATE_EMPLOYEE(
        V_EMPLOYEE_NAME => 'Bruno Barros',
        V_JOB_TITLE => 'Developer',
        V_MANAGER_ID => 1,
        V_DATE_HIRED => to_date('2021-04-01','yyyy-MM-dd'),
        V_SALARY => 40000,
        V_DEPARTMENT_ID => 1
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_create_employee;
   
   PROCEDURE p_create_emp_fk_constraing IS
      l_actual   varchar2(100);
      l_expected varchar2(100) := null;
   BEGIN
      l_actual := PKG_EMPLOYEE.CREATE_EMPLOYEE(
        V_EMPLOYEE_NAME => 'Bruno Barros',
        V_JOB_TITLE => 'Developer',
        V_MANAGER_ID => 1,
        V_DATE_HIRED => to_date('2021-04-01','yyyy-MM-dd'),
        V_SALARY => 40000,
        V_DEPARTMENT_ID => 0
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_create_emp_fk_constraing;
   
   
   PROCEDURE p_emp_not_null_const IS
      l_actual   varchar2(100);
      l_expected varchar2(100) := null;
   BEGIN
      l_actual := PKG_EMPLOYEE.CREATE_EMPLOYEE(
        V_EMPLOYEE_NAME => 'Bruno Barros',
        V_JOB_TITLE => 'Developer',
        V_MANAGER_ID => 1,
        V_DATE_HIRED => to_date('2021-04-01','yyyy-MM-dd'),
        V_SALARY => null,
        V_DEPARTMENT_ID => 1
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_emp_not_null_const;

   PROCEDURE p_increase_salary IS
      l_actual   VARCHAR2(50);
      l_expected VARCHAR2(50) := 'Employee salary updated with sucess.';
   BEGIN
      l_actual := PKG_EMPLOYEE.INCREASE_SALARY(
        V_ID => 90001,
        V_SALARY_RAISE => 1.2
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_increase_salary;
   
   
   PROCEDURE p_inc_sal_no_user IS
      l_actual   VARCHAR2(50);
      l_expected VARCHAR2(50) := 'There is no employee with the selected id.';
   BEGIN
      l_actual := PKG_EMPLOYEE.INCREASE_SALARY(
        V_ID => 0,
        V_SALARY_RAISE => 1.2
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_inc_sal_no_user;
   
   
   PROCEDURE p_inc_sal_w_sal_percent IS
      l_actual   VARCHAR2(100);
      l_expected VARCHAR2(100) := 'The Percentage of the salary increase has to be between 1 and 2.';
   BEGIN
      l_actual := PKG_EMPLOYEE.INCREASE_SALARY(
        V_ID => 0,
        V_SALARY_RAISE => 0
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_inc_sal_w_sal_percent;
   
   PROCEDURE p_inc_sal_w_sal_percent2 IS
      l_actual   VARCHAR2(100);
      l_expected VARCHAR2(100) := 'The Percentage of the salary increase has to be between 1 and 2.';
   BEGIN
      l_actual := PKG_EMPLOYEE.INCREASE_SALARY(
        V_ID => 0,
        V_SALARY_RAISE => 3
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_inc_sal_w_sal_percent2;

   PROCEDURE p_decrease_salary IS
      l_actual   VARCHAR2(100);
      l_expected VARCHAR2(100) := 'Employee salary updated with sucess.';
   BEGIN
      l_actual := PKG_EMPLOYEE.DECREASE_SALARY(
        V_ID => 90001,
        V_SALARY_DECREASE => 0.5
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_decrease_salary;
   
   PROCEDURE p_dec_sal_no_user IS
      l_actual   VARCHAR2(100);
      l_expected VARCHAR2(100) := 'There is no employee with the selected id.';
   BEGIN
      l_actual := PKG_EMPLOYEE.DECREASE_SALARY(
        V_ID => 0,
        V_SALARY_DECREASE => 0.5
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_dec_sal_no_user;
   
   
   PROCEDURE p_dec_sal_wrg_perc IS
      l_actual   VARCHAR2(100);
      l_expected VARCHAR2(100) := 'The Percentage of the salary decrease has to be between 0 and 1.';
   BEGIN
      l_actual := PKG_EMPLOYEE.DECREASE_SALARY(
        V_ID => 0,
        V_SALARY_DECREASE => 0
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_dec_sal_wrg_perc;
   
   PROCEDURE p_dec_sal_wrg_perc2 IS
      l_actual   VARCHAR2(100);
      l_expected VARCHAR2(100) := 'The Percentage of the salary decrease has to be between 0 and 1.';
   BEGIN
      l_actual := PKG_EMPLOYEE.DECREASE_SALARY(
        V_ID => 0,
        V_SALARY_DECREASE => 2
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_dec_sal_wrg_perc2;

   PROCEDURE p_transfer_employee IS
      l_actual   VARCHAR2(100);
      l_expected VARCHAR2(100) := 'Employee transferred with sucess.';
   BEGIN
      l_actual := PKG_EMPLOYEE.TRANSFER_EMPLOYEE(
        V_ID => 90002,
        V_DEPARTMENT_ID => 2
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_transfer_employee;
   
   PROCEDURE p_transf_emp_empty IS
      l_actual   VARCHAR2(100);
      l_expected VARCHAR2(100) := null;
   BEGIN
      l_actual := PKG_EMPLOYEE.TRANSFER_EMPLOYEE(
        V_ID => null,
        V_DEPARTMENT_ID => 2
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_transf_emp_empty;
   
   PROCEDURE p_transf_emp_wrg_dep IS
      l_actual   VARCHAR2(100);
      l_expected VARCHAR2(100) := null;
   BEGIN
      l_actual := PKG_EMPLOYEE.TRANSFER_EMPLOYEE(
        V_ID => 90002,
        V_DEPARTMENT_ID => 0
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_transf_emp_wrg_dep;

   PROCEDURE p_get_salary IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 32000;
   BEGIN
      l_actual := PKG_EMPLOYEE.GET_SALARY(
        V_ID => 90004
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_get_salary;
   
   PROCEDURE p_get_sal_no_usr IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := null;
   BEGIN
      l_actual := PKG_EMPLOYEE.GET_SALARY(
        V_ID => 0
      );

      ut.expect(l_actual).to_equal(l_expected);
   END p_get_sal_no_usr;

END test_pkg_employee;