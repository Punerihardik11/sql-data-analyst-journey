SELECT * 
FROM healthcare.claims;

SELECT claim_date, payer_id, claim_amount,
(claim_amount + 1800) * 2 
FROM healthcare.claims;

# PEMDAS : P = Parenthesis, E = Exponent, M = Multiplication, D = Division, A = Addition, S = Subtraction

SELECT DISTINCT patient_id, payer_id, provider_id
FROM healthcare.claims;

-- Filtering Data with the WHERE Clause & LIKE Operator

SELECT *
FROM healthcare.patients
WHERE patient_name = 'Priya Patil';

SELECT *
FROM healthcare.patients
WHERE age > 34;

SELECT *
FROM healthcare.patients
WHERE age >= 34;

SELECT *
FROM healthcare.patients
WHERE age < 28;

SELECT *
FROM healthcare.patients
WHERE age <= 28;

SELECT *
FROM healthcare.providers;

SELECT *
FROM healthcare.providers
WHERE city = 'Pune';

SELECT *
FROM healthcare.providers
WHERE city != 'Pune';

-- AND OR NOT -- Logical Operators
SELECT *
FROM healthcare.providers
WHERE city = 'Pune'
AND specialty = 'Cardiology';

SELECT *
FROM healthcare.providers
WHERE city = 'Pune'
OR specialty = 'Neurology';

# SELECT *
# FROM healthcare.providers;
# WHERE (first_name = 'Leslie' AND age = 44) OR age > 55

-- LIKE STATEMENT 
-- % and _ 
-- % anything which comes before 
-- _ shows the length of character like pune, u take %u__ which translates to anything before u and 2 letters after u.

SELECT *
FROM healthcare.providers
WHERE city LIKE 'u%' ;

SELECT *
FROM healthcare.providers
WHERE city LIKE '%u%' ;

SELECT *
FROM healthcare.providers
WHERE city LIKE '%u__' ;

SELECT *
FROM healthcare.providers
WHERE provider_id LIKE '%104%'
;

--  GROUP BY and ORDER BY Statements

SELECT *
FROM healthcare.provider_contacts;

-- 1. Create the table
CREATE TABLE employee_data (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    occupation VARCHAR(100),
    salary DECIMAL(10, 2),
    department VARCHAR(50)
);

-- 2. Insert 25 rows of practice data
INSERT INTO employee_data VALUES
(1, 'John', 'Doe', 32, 'Male', 'Data Analyst', 75000.00, 'IT'),
(2, 'Jane', 'Smith', 28, 'Female', 'Data Analyst', 72000.00, 'IT'),
(3, 'Mike', 'Johnson', 45, 'Male', 'Software Engineer', 110000.00, 'IT'),
(4, 'Emily', 'Davis', 34, 'Female', 'Software Engineer', 105000.00, 'IT'),
(5, 'Chris', 'Wilson', 29, 'Male', 'HR Manager', 65000.00, 'Human Resources'),
(6, 'Sarah', 'Brown', 41, 'Female', 'HR Manager', 68000.00, 'Human Resources'),
(7, 'David', 'Miller', 52, 'Male', 'Sales Rep', 55000.00, 'Sales'),
(8, 'Laura', 'Garcia', 26, 'Female', 'Sales Rep', 52000.00, 'Sales'),
(9, 'James', 'Martinez', 38, 'Male', 'Accountant', 62000.00, 'Finance'),
(10, 'Jessica', 'Rodriguez', 31, 'Female', 'Accountant', 64000.00, 'Finance'),
(11, 'Robert', 'Hernandez', 48, 'Male', 'Data Analyst', 85000.00, 'IT'),
(12, 'Amanda', 'Lopez', 27, 'Female', 'Software Engineer', 98000.00, 'IT'),
(13, 'Daniel', 'Gonzalez', 35, 'Male', 'HR Manager', 70000.00, 'Human Resources'),
(14, 'Olivia', 'Wilson', 44, 'Female', 'Sales Rep', 60000.00, 'Sales'),
(15, 'Matthew', 'Anderson', 55, 'Male', 'Accountant', 75000.00, 'Finance'),
(16, 'Sophia', 'Thomas', 24, 'Female', 'Data Analyst', 68000.00, 'IT'),
(17, 'Andrew', 'Taylor', 39, 'Male', 'Software Engineer', 115000.00, 'IT'),
(18, 'Isabella', 'Moore', 33, 'Female', 'HR Manager', 66000.00, 'Human Resources'),
(19, 'Joshua', 'Jackson', 47, 'Male', 'Sales Rep', 58000.00, 'Sales'),
(20, 'Mia', 'Martin', 30, 'Female', 'Accountant', 63000.00, 'Finance'),
(21, 'Ryan', 'Lee', 29, 'Male', 'Data Analyst', 74000.00, 'IT'),
(22, 'Ava', 'Perez', 36, 'Female', 'Software Engineer', 108000.00, 'IT'),
(23, 'Nathan', 'Thompson', 51, 'Male', 'HR Manager', 72000.00, 'Human Resources'),
(24, 'Emma', 'White', 25, 'Female', 'Sales Rep', 54000.00, 'Sales'),
(25, 'Ethan', 'Harris', 42, 'Male', 'Accountant', 69000.00, 'Finance');

-- GROUP BY and ORDER BY Statements

SELECT *
FROM healthcare.employee_data ;

SELECT gender
FROM healthcare.employee_data
GROUP BY gender
;

SELECT occupation, salary
FROM employee_data
GROUP BY occupation, salary
;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_data
GROUP BY gender
;

-- ORDER BY , DEFAULT IS ASC , THERE IS DESC ASWELL
SELECT *
FROM employee_data
ORDER BY first_name
;

SELECT *
FROM employee_data
ORDER BY first_name DESC
;

SELECT *
FROM employee_data
ORDER BY gender, age
;

SELECT *
FROM employee_data
ORDER BY gender, age DESC
;

-- HAVING vs. WHERE Clauses

SELECT *
FROM employee_data;

SELECT occupation, AVG(salary)
FROM employee_data 
GROUP BY occupation
; 

SELECT occupation, AVG(salary)
FROM employee_data 
WHERE occupation LIKE '%Manager%'
GROUP BY occupation
; 

SELECT occupation, AVG(salary)
FROM employee_data 
WHERE occupation LIKE '%Manager%'
GROUP BY occupation
HAVING AVG(salary) > 65000
; 

-- LIMIT Clause and Aliasing

SELECT *
FROM employee_data
LIMIT 5
;

SELECT *
FROM employee_data
ORDER BY age DESC
LIMIT 5
;

SELECT *
FROM employee_data
ORDER BY age DESC
LIMIT 3, 2
;

-- Aliasing

SELECT gender, AVG(age) AS avg_age
FROM employee_data
GROUP BY gender
HAVING avg_age > 40
;