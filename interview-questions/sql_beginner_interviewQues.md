Topic 1: SELECT Statement & Math Operations
What they are secretly testing: Can you manipulate data on the fly without altering the actual database?
Practical: Write a query to display the employee's full name (concatenate first_name and last_name) and their new salary after a 15% hike.
Practical: Write a query to calculate the total revenue (Price * Quantity) for a sales table and give this new column the name Total_Revenue.
Theory: What happens if you divide two integers in SQL (e.g., SELECT 5/2)? How do you fix it to get a decimal answer?
(Answer: It returns 2 because SQL drops the decimal. You fix it by multiplying by 1.0 or casting to decimal: SELECT 5.0/2)



Topic 2: WHERE Clause & LIKE Operator
What they are secretly testing: Do you know how to filter messy, real-world data?
Practical: How do you find all customers whose names start with 'J' and end with 'n'?
(Answer: WHERE name LIKE 'J%n')
Practical: Write a query to find all employees who do not have a manager assigned to them (the manager_id is missing).
*(Answer: WHERE manager_id IS NULL — Never use = NULL)*
Theory: What is the difference between the IN operator and the LIKE operator?



Topic 3: GROUP BY and ORDER BY Statements
What they are secretly testing: Can you summarize thousands of rows into business insights? (Myntra specifically asks this in their 1st technical round 
www.glassdoor.ca
).
Practical: Write a query to find the total number of employees in each department, and sort the result by the department with the highest number of employees.
Practical: How do you find the average salary for each job role in the company?
Theory: What is the difference between COUNT(*) and COUNT(column_name)?
(Answer: COUNT(*) counts all rows including NULLs. COUNT(column_name) ignores NULL values in that specific column).




Topic 4: HAVING vs. WHERE Clauses
What they are secretly testing: This is the #1 most asked theory question for freshers at Deloitte, EXL, and Uber 
www.ambitionbox.com
, 
www.ambitionbox.com
, 
medium.com
. They want to see if you understand the order of execution.
Theory: What is the exact difference between the WHERE clause and the HAVING clause?
(Answer: WHERE filters individual rows BEFORE grouping. HAVING filters groups AFTER the GROUP BY aggregation is done).
Practical: Write a query to find the departments that have more than 5 employees working in them.
Theory: Can we use the WHERE clause to filter the results of an aggregate function like SUM() or AVG()? Why or why not?
(Answer: No, because WHERE executes before the aggregation happens. You must use HAVING).



Topic 5: LIMIT Clause and Aliasing
What they are secretly testing: Can you write clean, readable code and extract specific top/bottom records?
Practical: Write a SQL query to find the 3rd highest salary from the Employee table. (This is literally the most common fresher question on AmbitionBox and Glassdoor 
www.ambitionbox.com
, 
www.ambitionbox.com
, 
learn.modernagecoders.com
).
(Answer: SELECT salary FROM Employees ORDER BY salary DESC LIMIT 1 OFFSET 2;)
Theory: What is the use of an alias (AS) in SQL? Can we use a column alias in the WHERE clause?
(Answer: Aliases make column names readable. No, you cannot use an alias in WHERE because WHERE executes before SELECT in the SQL order of execution 
stackinterview.dev
, 
www.ambitionbox.com
).
Practical: Write a query to display the top 5 highest-paid employees, renaming the output columns to Employee_Name and CTC.