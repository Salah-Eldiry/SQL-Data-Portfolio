-- ====================================================================
-- SQL Skills Portfolio Project
-- Author: [Salah Eldiry]
-- Description: Demonstrates core relational database concepts, 
--              including schema design, data insertion, and advanced querying.
-- Syntax: Standard SQL (Compatible with PostgreSQL / MySQL / SQLite)
-- ====================================================================

-- 1. DATABASE SCHEMA SETUP
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(50),
    salary INT,
    manager_id INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 2. DATA INGESTION
INSERT INTO departments (department_id, department_name, location) VALUES
(101, 'Engineering', 'Remote'),
(102, 'Security Operations', 'On-Site'),
(103, 'Infrastructure', 'Hybrid');

INSERT INTO employees (employee_id, first_name, last_name, role, salary, manager_id, department_id) VALUES
(1, 'Alice', 'Vance', 'Lead Engineer', 115000, NULL, 101),
(2, 'Bob', 'Miller', 'Security Analyst', 85000, 4, 102),
(3, 'Charlie', 'Smith', 'DevOps Specialist', 90000, NULL, 103),
(4, 'Diana', 'Prince', 'SOC Manager', 120000, NULL, 102),
(5, 'Evan', 'Wright', 'Junior Engineer', 70000, 1, 101);

-- 3. ANALYTICAL QUERIES (Demonstrating Joins & Aggregations)

-- Query A: Fetch employees with their respective department details (INNER JOIN)
SELECT 
    e.employee_id, 
    e.first_name || ' ' || e.last_name AS full_name, 
    e.role, 
    d.department_name, 
    d.location
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- Query B: Calculate average salary per department, filtered for high-earning units (GROUP BY & HAVING)
SELECT
    d.department_name, 
    COUNT(e.employee_id) AS total_staff,
    AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 80000;
