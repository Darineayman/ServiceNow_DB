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

------------------------------------------------------------------------------------



-- 1
WITH dept_avg AS (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
)
SELECT d.dept_name, dept_avg.avg_salary
FROM dept_avg
JOIN departments d
    ON dept_avg.dept_id = d.dept_id
WHERE dept_avg.avg_salary > 4000;

-- 2
SELECT emp_id, emp_name
FROM employees

EXCEPT

SELECT e.emp_id, e.emp_name
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';

-- 3
SELECT emp_id, emp_name
FROM employees
WHERE emp_id IN (
    SELECT w.emp_id
    FROM works_on w
    JOIN projects p
        ON w.project_id = p.project_id
    WHERE p.project_name = 'Sales'

    INTERSECT

    SELECT w.emp_id
    FROM works_on w
    JOIN projects p
        ON w.project_id = p.project_id
    WHERE p.project_name = 'Marketing'
);

-- 4
START TRANSACTION;

UPDATE employees
SET salary = 6000
WHERE emp_id = 5;

UPDATE employees
SET dept_id = 3
WHERE emp_id = 5;

COMMIT;

-- 5
SELECT e.emp_id, e.emp_name
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Sales';



CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY,
    task_name VARCHAR(100) NOT NULL,
    emp_id INT REFERENCES employees(emp_id),
    priority VARCHAR(20),
    status VARCHAR(30),
    due_date DATE
);
INSERT INTO tasks (task_name, emp_id, priority, status, due_date) VALUES
('Prepare report', 1, 'High', 'Completed', CURRENT_DATE - 2),
('Call client', 2, 'Medium', 'Pending', CURRENT_DATE),
('Update system', 1, 'High', 'Pending', CURRENT_DATE + 3),
('Check inventory', 3, 'Low', 'Completed', CURRENT_DATE - 1),
('Team meeting', 2, 'High', 'Completed', CURRENT_DATE),
('Send email', 4, 'Medium', 'Pending', CURRENT_DATE + 1),
('Review files', 1, 'High', 'Pending', CURRENT_DATE + 5);

-- 6
SELECT DISTINCT e.emp_id, e.emp_name
FROM employees e
JOIN tasks t
    ON e.emp_id = t.emp_id
WHERE t.priority = 'High';

-- 7
SELECT DISTINCT e.emp_id, e.emp_name
FROM employees e
JOIN tasks t
    ON e.emp_id = t.emp_id
WHERE t.due_date = CURRENT_DATE;

-- 8
SELECT emp_id, emp_name
FROM employees
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM tasks
    WHERE status = 'Completed'
);

-- 9
SELECT e.emp_id, e.emp_name, COUNT(t.task_id) AS total_tasks
FROM employees e
JOIN tasks t
    ON e.emp_id = t.emp_id
GROUP BY e.emp_id, e.emp_name
HAVING COUNT(t.task_id) > 2;

-- 10
SELECT task_id, task_name, due_date
FROM tasks
WHERE due_date > (
    SELECT MAX(due_date)
    FROM tasks
    WHERE status = 'Completed'
);

-- 11
SELECT DISTINCT e.emp_name
FROM employees e
JOIN tasks t
    ON e.emp_id = t.emp_id
WHERE t.priority = 'High';

-- 12
SELECT DISTINCT e.emp_id, e.emp_name
FROM employees e
JOIN tasks t
    ON e.emp_id = t.emp_id
WHERE t.status = 'Completed';


