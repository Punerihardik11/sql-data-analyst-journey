-- Case Statements in MySQL

SELECT first_name,
last_name,
age,
CASE 
	WHEN age <= 30 THEN 'Young'
END
FROM employee_data;
#############################################################################################

SELECT first_name,
last_name,
age,
CASE 
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Old'
END
FROM employee_data;
#############################################################################################

SELECT first_name,
last_name,
age,
CASE 
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Old'
    WHEN age >= 50 THEN 'Old goes Young'
END AS Age_Category
FROM employee_data;

#############################################################################################

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS New_Salary,
CASE
	WHEN department = 'Finance'  THEN salary * .10
END AS Bonus
FROM employee_data;

#############################################################################################
--  Introduction to SQL Subqueries
SELECT *
FROM employee_performance;


SELECT *
FROM employee_data
WHERE employee_id in
				(SELECT employee_id
					FROM employee_performance
                    WHERE performance_rating = 'Excellent' OR 'Outstanding')
;

SELECT first_name, salary,
(SELECT AVG(salary)
FROM employee_data) AS avg_salary
FROM employee_data;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_data
GROUP BY gender;


Select gender, AVG(`MAX(age)`)
FROM
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_data
GROUP BY gender) AS Agg_table
GROUP BY gender
;

Select  AVG(max_age)
FROM
(SELECT gender,
 AVG(age) AS avg_age,
 MAX(age) AS max_age,
 MIN(age) AS min_age,
 COUNT(age)
FROM employee_data
GROUP BY gender) AS Agg_table
;

#############################################################################################
-- Window Functions (ROW_NUMBER, RANK, DENSE_RANK)

SELECT gender, AVG(salary) AS avg_salary
FROM employee_data
GROUP BY gender;

SELECT gender, AVG(salary) OVER()
FROM employee_data
GROUP BY gender;


SELECT 
first_name,
last_name,
gender,
occupation,
salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS Rankings,
RANK () OVER (ORDER BY salary DESC) AS OG_Rankings,
DENSE_RANK() OVER (ORDER BY Salary DESC) AS refined_rankings
FROM employee_data;

SELECT *
FROM (
SELECT 
first_name,
last_name,
projects_completed,
ROW_NUMBER () OVER (PARTITION BY manager_id ORDER BY performance_rating) AS standings
FROM employee_performance
)t WHERE standings = 1;
  
  

  SELECT 
	employee_id,
    SUM(bonus_amount) TotalAmount
  FROM employee_performance
  GROUP BY employee_id ;
  
  SELECT 
  first_name,
  last_name,
  projects_completed,
  NTILE(3) OVER (ORDER BY performance_rating DESC) ThreeBucket,
  NTILE(2) OVER (ORDER BY performance_rating DESC) TwoBucket,
  NTILE(1) OVER (ORDER BY performance_rating DESC) OneBucket
  FROM employee_performance;
  
  
  