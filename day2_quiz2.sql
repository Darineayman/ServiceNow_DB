CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);


CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary NUMERIC(10,2) CHECK (salary > 0),
    dept_id INT,
    hire_date DATE
);


ALTER TABLE employees
ADD CONSTRAINT fk_employees_departments
FOREIGN KEY (dept_id)
REFERENCES departments(dept_id)
ON DELETE CASCADE
ON UPDATE CASCADE;


CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    dept_id INT
);


ALTER TABLE projects
ADD CONSTRAINT fk_projects_departments
FOREIGN KEY (dept_id)
REFERENCES departments(dept_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

INSERT INTO departments (dept_name)
VALUES
('HR'),
('IT'),
('Finance');


INSERT INTO employees (emp_name, salary, dept_id, hire_date)
VALUES
('Ali Hassan', 5000.00, 1, '2024-01-10'),
('Mona Ahmed', 6200.50, 2, '2023-11-15'),
('Omar Samy', 7100.00, 2, '2022-06-20'),
('Nour Khaled', 4500.75, 3, '2024-03-05'),
('Laila Tarek', 5300.00, 1, '2021-09-12');



INSERT INTO projects (project_id, project_name, dept_id)
VALUES
(101, 'Recruitment System', 1),
(102, 'Inventory App', 2),
(103, 'Budget Planning', 3);



UPDATE employees
SET salary = salary + 1000
WHERE emp_id = 1;


UPDATE employees
SET dept_id = 3
WHERE emp_id = 2;


ALTER TABLE employees
ADD COLUMN email VARCHAR(100) UNIQUE;


UPDATE employees SET email = 'ali@company.com' WHERE emp_id = 1;
UPDATE employees SET email = 'mona@company.com' WHERE emp_id = 2;
UPDATE employees SET email = 'omar@company.com' WHERE emp_id = 3;
UPDATE employees SET email = 'nour@company.com' WHERE emp_id = 4;
UPDATE employees SET email = 'laila@company.com' WHERE emp_id = 5;


ALTER TABLE departments
ADD COLUMN phone VARCHAR(20);



ALTER TABLE employees
ALTER COLUMN salary SET NOT NULL;


UPDATE departments
SET dept_id = 10
WHERE dept_id = 1;



SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;


