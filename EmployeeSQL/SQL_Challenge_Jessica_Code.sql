
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

--needed to adjust lengths for CHAR and VARCHAR so that SQL could import CSV files in their entirety

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(5)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(25)   NOT NULL,
    "last_name" VARCHAR(25)   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" CHAR(5)   NOT NULL,
    "title" VARCHAR(40)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "departments" (
    "dept_no" CHAR(4)   NOT NULL,
    "dept_name" VARCHAR(40)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

--needed composite key here so that it could import CSV with duplicate employee number

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" CHAR(4)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "emp_no" INT   NOT NULL,
    "dept_no" CHAR(4)   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

--foreign keys added here to create relationships between tables for analysis 

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");




--imported CSV's in the following order: titles, employees, salaries, dept_emp, departments, dept_manager
--determined this was based on my ERD connections, starting with minimal connections to larger and more complex connections

--checking my CSV imports and that all columns and data is correct

SELECT * FROM dept_manager;

SELECT * FROM dept_emp;

SELECT * FROM departments;

SELECT * FROM employees;

SELECT * FROM salaries;

SELECT * FROM titles;

--List the employee number, last name, first name, sex, and salary of each employee.

SELECT emp_no, last_name, first_name, sex
FROM employees;

SELECT * 
FROM salaries;


SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON (e.emp_no = s.emp_no);

--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT e.first_name, e.last_name, e.hire_date
FROM employees e;


SELECT e.first_name, e.last_name, EXTRACT(YEAR FROM hire_date) AS HIRE_DATE_YEAR
FROM employees e
WHERE EXTRACT(YEAR FROM hire_date) = '1986';


--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT e.emp_no, e.last_name, e.first_name, dm.dept_no, ds.dept_name
FROM employees e
INNER JOIN dept_manager dm
	ON e.emp_no = dm.emp_no
	INNER JOIN departments ds
	ON ds.dept_no = dm.dept_no;


--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, ds.dept_name
FROM employees e
INNER JOIN dept_emp de
	ON e.emp_no = de.emp_no
	INNER JOIN departments ds
	ON ds.dept_no = de.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name LIKE 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT e.emp_no, e.last_name, e.first_name, ds.dept_name
FROM employees e
INNER JOIN dept_emp de
	ON e.emp_no = de.emp_no
	INNER JOIN departments ds
	ON ds.dept_no = de.dept_no
	WHERE ds.dept_name LIKE 'Sales';


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, ds.dept_name
FROM employees e
INNER JOIN dept_emp de
	ON e.emp_no = de.emp_no
	INNER JOIN departments ds
	ON ds.dept_no = de.dept_no
	WHERE ds.dept_name LIKE 'Development' OR ds.dept_name LIKE 'Sales';



--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(last_name) AS frequency 
FROM employees 
GROUP BY last_name
ORDER BY frequency DESC










