--  Deep Dive into SQL Joins (Inner, Left, Right, Self)

-- Create employee_performance table
CREATE TABLE employee_performance (
    employee_id INT PRIMARY KEY,
    annual_review_score DECIMAL(3,2),
    projects_completed INT,
    bonus_amount DECIMAL(10,2),
    last_review_date DATE,
    manager_id INT,
    performance_rating VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employee_data(employee_id)
);

-- Insert performance data for your employees
INSERT INTO employee_performance VALUES
(1, 4.2, 8, 5000.00, '2024-01-15', 3, 'Excellent'),
(2, 3.8, 6, 3000.00, '2024-01-15', 3, 'Good'),
(3, 4.5, 12, 8000.00, '2024-01-20', NULL, 'Outstanding'),
(4, 4.1, 9, 6000.00, '2024-01-20', 3, 'Excellent'),
(5, 3.5, 5, 2000.00, '2024-01-18', 6, 'Good'),
(6, 3.9, 7, 4000.00, '2024-01-18', NULL, 'Good'),
(7, 3.2, 4, 1500.00, '2024-01-22', 8, 'Average'),
(8, 3.7, 6, 3500.00, '2024-01-22', NULL, 'Good'),
(9, 4.0, 8, 5500.00, '2024-01-25', 10, 'Excellent'),
(10, 3.6, 5, 2500.00, '2024-01-25', NULL, 'Good'),
(11, 4.3, 10, 7000.00, '2024-01-28', 3, 'Excellent'),
(12, 3.4, 4, 2000.00, '2024-01-28', 6, 'Average');

SELECT *
FROM employee_data;
SELECT *
FROM employee_performance;

SELECT *
FROM employee_data
INNER JOIN employee_performance -- Normally how we write
	ON employee_data.employee_id = employee_performance.employee_id
;

SELECT *
FROM employee_data AS edata
INNER JOIN employee_performance AS eperformance -- More Optimized way where we made employee_data as edata
	ON edata.employee_id = eperformance.employee_id
;

SELECT employee_id, age, occupation
FROM employee_data AS edata
INNER JOIN employee_performance AS eperformance
	ON edata.employee_id = eperformance.employee_id
;
-- now this thing gives error because we didn't properly specified from which specific table we wanted employee_id , age and occupation
-- so what we do is we either take the alias as edata or employee_data but employee data becomes more big so we will use aliases

SELECT edata.employee_id, age, occupation
FROM employee_data AS edata
INNER JOIN employee_performance AS eperformance
	ON edata.employee_id = eperformance.employee_id
; -- proper optimized way and very interesting 

### Left / Outer Joins 
SELECT *
FROM employee_data AS edata
LEFT JOIN employee_performance AS eperformance
	ON edata.employee_id = eperformance.employee_id
;

SELECT *
FROM employee_data AS edata
RIGHT JOIN employee_performance AS eperformance
	ON edata.employee_id = eperformance.employee_id
;

### Self Join

SELECT *
FROM employee_data emp1
JOIN employee_data emp2
	ON emp1.employee_id + 1  = emp2.employee_id
;

SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_data emp1
JOIN employee_data emp2
	ON emp1.employee_id + 1  = emp2.employee_id
;

-- Joining multiple tables together 
SELECT *
FROM employee_data AS edata
RIGHT JOIN employee_performance AS eperformance
	ON edata.employee_id = eperformance.employee_id
;

SELECT *
FROM employee_data;
SELECT *
FROM employee_performance;
DROP TABLE IF EXISTS employee_performance;

CREATE TABLE employee_performance (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    annual_review_score DECIMAL(3,2),
    projects_completed INT,
    bonus_amount DECIMAL(10,2),
    last_review_date DATE,
    manager_id INT,
    performance_rating VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employee_data(employee_id)
);

-- Insert performance data WITH names
INSERT INTO employee_performance VALUES
(1, 'John', 'Doe', 4.2, 8, 5000.00, '2024-01-15', 3, 'Excellent'),
(2, 'Jane', 'Smith', 3.8, 6, 3000.00, '2024-01-15', 3, 'Good'),
(3, 'Mike', 'Johnson', 4.5, 12, 8000.00, '2024-01-20', NULL, 'Outstanding'),
(4, 'Emily', 'Davis', 4.1, 9, 6000.00, '2024-01-20', 3, 'Excellent'),
(5, 'Chris', 'Wilson', 3.5, 5, 2000.00, '2024-01-18', 6, 'Good'),
(6, 'Sarah', 'Brown', 3.9, 7, 4000.00, '2024-01-18', NULL, 'Good'),
(7, 'David', 'Miller', 3.2, 4, 1500.00, '2024-01-22', 8, 'Average'),
(8, 'Laura', 'Garcia', 3.7, 6, 3500.00, '2024-01-22', NULL, 'Good'),
(9, 'James', 'Martinez', 4.0, 8, 5500.00, '2024-01-25', 10, 'Excellent'),
(10, 'Jessica', 'Rodriguez', 3.6, 5, 2500.00, '2024-01-25', NULL, 'Good'),
(11, 'Robert', 'Hernandez', 4.3, 10, 7000.00, '2024-01-28', 3, 'Excellent'),
(12, 'Amanda', 'Lopez', 3.4, 4, 2000.00, '2024-01-28', 6, 'Average');

### Combining Results with UNIONS

SELECT first_name, last_name
FROM employee_data
UNION -- It becomes distinct by default 
SELECT first_name, last_name
FROM employee_performance;

SELECT first_name, last_name
FROM employee_data
UNION ALL -- This doesnt has distinction it brings everything 
SELECT first_name, last_name
FROM employee_performance;

SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_data
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_data
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Skilled Employee' AS Label
FROM employee_performance
WHERE projects_completed > 7
ORDER BY first_name, last_name
;

### String Functions 

SELECT LENGTH('skyfall');

SELECT first_name, LENGTH(first_name)
FROM employee_data
ORDER BY 2;

SELECT UPPER('shivneri');
SELECT LOWER('SHIVSHAHI');

SELECT first_name, UPPER(first_name)
FROM employee_data;

SELECT TRIM('            HIRKANI             ');

SELECT LTRIM('            HIRKANI             ');

SELECT RTRIM('            HIRKANI             ');

SELECT first_name, LEFT(first_name, 4)
FROM employee_data;

SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4)
FROM employee_data;

SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name,3,2),
birth_date,
SUBSTRING(birth_date,6,2)
FROM employee_data;

SELECT first_name, REPLACE(first_name, 'a','z')
FROM employee_data;

SELECT LOCATE('x','Alexander');

SELECT first_name, LOCATE('An', first_name)
FROM employee_data;

SELECT first_name, last_name,
CONCAT(first_name,' ' ,last_name) AS full_name
FROM employee_data;

-- he didnt covered other string functions -- 