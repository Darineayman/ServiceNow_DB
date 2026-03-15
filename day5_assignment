CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary NUMERIC(10,2),
    hire_date DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    budget NUMERIC(12,2)
);


CREATE TABLE works_on (
    emp_id INT,
    project_id INT,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO departments (dept_name) VALUES
('IT'),
('HR'),
('Finance'),
('Marketing');

INSERT INTO employees (emp_name, salary, hire_date, dept_id) VALUES
('Ahmed Ali', 7000, '2022-01-10', 1),
('Sara Mohamed', 7500, '2023-03-15', 1),
('Omar Khaled', 6000, '2021-06-20', 2),
('Mona Ibrahim', 6500, '2023-03-15', 2),
('Hassan Mahmoud', 9000, '2020-11-05', 3),
('Laila Adel', 7200, '2024-02-12', 4);

INSERT INTO projects (project_name, budget) VALUES
('Website Development', 50000),
('Mobile App', 80000),
('Accounting System', 40000);

INSERT INTO works_on (emp_id, project_id) VALUES
(1,1),
(2,1),
(3,2),
(4,2),
(5,3),
(6,1);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;
SELECT * FROM works_on;



SELECT e.emp_id, e.emp_name, e.hire_date, e.dept_id
FROM employees e
WHERE e.hire_date = (
    SELECT MAX(e2.hire_date)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);


SELECT emp_id, emp_name, dept_name
FROM employees
NATURAL JOIN departments;


SELECT p.project_id, p.project_name, p.budget, COUNT(w.emp_id) AS employee_count
	FROM projects p
	LEFT JOIN works_on w
	ON p.project_id = w.project_id
	GROUP BY p.project_id, p.project_name, p.budget;



SELECT e1.emp_name AS employee1, e2.emp_name AS employee2, e1.salary
	FROM employees e1
	JOIN employees e2
	ON e1.salary = e2.salary
	AND e1.emp_id < e2.emp_id;


SELECT p.project_name, e.emp_name
	FROM projects p
	JOIN works_on w
	ON p.project_id = w.project_id
	JOIN employees e
	ON w.emp_id = e.emp_id
	ORDER BY p.project_name, e.emp_name;


SELECT emp_name AS name
	FROM employees
	UNION
	SELECT dept_name AS name
	FROM departments;

