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


-- 1
SELECT 
    t.emp_id,
    e.emp_name,
    t.task_id,
    t.task_name,
    t.due_date,
    ROW_NUMBER() OVER (
        PARTITION BY t.emp_id
        ORDER BY t.due_date
    ) AS row_num
FROM tasks t
JOIN employees e
    ON e.emp_id = t.emp_id;

-- 2
SELECT 
    emp_id,
    emp_name,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

-- 3
SELECT emp_id, emp_name, task_id, task_name, due_date
FROM (
    SELECT 
        t.emp_id,
        e.emp_name,
        t.task_id,
        t.task_name,
        t.due_date,
        ROW_NUMBER() OVER (
            PARTITION BY t.emp_id
            ORDER BY t.due_date DESC
        ) AS rn
    FROM tasks t
    JOIN employees e
        ON e.emp_id = t.emp_id
) x
WHERE rn = 1;

-- 4
SELECT 
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name,
    AVG(e.salary) OVER (
        PARTITION BY e.dept_id
    ) AS dept_avg_salary
FROM employees e
JOIN departments d
    ON d.dept_id = e.dept_id;

-- 5
SELECT 
    t.emp_id,
    e.emp_name,
    t.task_id,
    t.task_name,
    t.due_date,
    COUNT(*) OVER (
        PARTITION BY t.emp_id
        ORDER BY t.due_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_task_count
FROM tasks t
JOIN employees e
    ON e.emp_id = t.emp_id;

-- 6
SELECT 
    emp_id,
    emp_name,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

-- 7
SELECT emp_name, task_count
FROM (
    SELECT 
        e.emp_name,
        COUNT(t.task_id) AS task_count
    FROM employees e
    JOIN tasks t
        ON e.emp_id = t.emp_id
    GROUP BY e.emp_id, e.emp_name
) x
WHERE task_count > (
    SELECT AVG(task_count)
    FROM (
        SELECT COUNT(t.task_id) AS task_count
        FROM employees e
        JOIN tasks t
            ON e.emp_id = t.emp_id
        GROUP BY e.emp_id
    ) y
);

-- 8
SELECT 
    task_id,
    task_name,
    priority,
    DENSE_RANK() OVER (
        ORDER BY 
            CASE 
                WHEN priority = 'High' THEN 1
                WHEN priority = 'Medium' THEN 2
                WHEN priority = 'Low' THEN 3
                ELSE 4
            END
    ) AS priority_rank
FROM tasks;

-- 9
SELECT emp_id, emp_name, task_count
FROM (
    SELECT 
        e.emp_id,
        e.emp_name,
        COUNT(t.task_id) AS task_count,
        RANK() OVER (
            ORDER BY COUNT(t.task_id) DESC
        ) AS rnk
    FROM employees e
    JOIN tasks t
        ON e.emp_id = t.emp_id
    GROUP BY e.emp_id, e.emp_name
) x
WHERE rnk = 1;

-- 10
ALTER TABLE employees
ADD COLUMN manager_id INT;

-- 11
ALTER TABLE employees
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id)
REFERENCES employees(emp_id);

-- 12
UPDATE employees
SET manager_id = 2
WHERE emp_id IN (1, 6);

UPDATE employees
SET manager_id = 5
WHERE emp_id IN (3, 4);

-- 13
SELECT 
    emp.emp_name AS employee_name,
    mgr.emp_name AS manager_name,
    emp_tasks.task_count AS employee_task_count,
    mgr_tasks.task_count AS manager_task_count
FROM employees emp
JOIN employees mgr
    ON emp.manager_id = mgr.emp_id
JOIN (
    SELECT emp_id, COUNT(*) AS task_count
    FROM tasks
    GROUP BY emp_id
) emp_tasks
    ON emp.emp_id = emp_tasks.emp_id
JOIN (
    SELECT emp_id, COUNT(*) AS task_count
    FROM tasks
    GROUP BY emp_id
) mgr_tasks
    ON mgr.emp_id = mgr_tasks.emp_id
WHERE emp_tasks.task_count > mgr_tasks.task_count;