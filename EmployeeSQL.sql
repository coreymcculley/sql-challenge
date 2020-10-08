-- Drop table if exists
DROP TABLE departments;

-- Create table and view column datatypes
CREATE TABLE departments (
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY (dept_no)
);

-- View table columns and datatypes
SELECT * FROM departments;

-- Drop table if exists
DROP TABLE dept_emp;

-- Create table and view column datatypes
CREATE TABLE dept_emp (
	emp_no	INT NOT NULL REFERENCES salaries(emp_no),
	dept_no VARCHAR NOT NULL REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- View table columns and datatypes
SELECT * FROM dept_emp;

-- Drop table if exists
DROP TABLE dept_manager;

-- Create table and view column datatypes
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL REFERENCES departments(dept_no),
	emp_no  INT NOT NULL REFERENCES salaries(emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

-- View table columns and datatypes
SELECT * FROM dept_manager;

-- Drop table if exists
DROP TABLE employees;

-- Create table and view column datatypes
CREATE TABLE employees (
	emp_no INT NOT NULL REFERENCES salaries(emp_no),
	title_id VARCHAR NOT NULL REFERENCES titles(title_id),
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE,
	PRIMARY KEY (emp_no, title_id)
);

-- View table columns and datatypes
SELECT * FROM employees;

-- Drop table if exists
DROP TABLE salaries;

-- Create table and view column datatypes
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT,
	PRIMARY KEY (emp_no)
);

-- View table columns and datatypes
SELECT * FROM salaries;

-- Drop table if exists
DROP TABLE titles;

-- Create table and view column datatypes
CREATE TABLE titles (
	title_id VARCHAR NOT NULL,
	title VARCHAR,
	PRIMARY KEY (title_id)
);

-- View table columns and datatypes
SELECT * FROM titles;

--1 List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no=salaries.emp_no;

--2 List first name, last name, and hire date for employees who were hired in 1986.
SELECT * FROM employees;

SELECT first_name, last_name, hire_date
FROM EMPLOYEES
WHERE
	 EXTRACT (YEAR FROM hire_date) = 1986;
	 
--3 List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
INNER JOIN dept_manager ON
departments.dept_no=dept_manager.dept_no
INNER JOIN employees ON
dept_manager.emp_no=employees.emp_no;

--4 List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no;

--5 List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'

--6 List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no
WHERE dept_emp.dept_no = 'd007';

--7 List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no
WHERE dept_emp.dept_no = 'd007'
OR dept_emp.dept_no = 'd005';

--8 In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, count (emp_no) as "count last_name"
FROM employees
GROUP BY last_name
ORDER BY "count last_name" DESC;