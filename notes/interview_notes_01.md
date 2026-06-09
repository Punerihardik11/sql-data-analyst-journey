1️⃣ SELECT & Math Operations
What it does: Picks columns and does basic math (+, -, *, /) on the fly.
Rule: Math in SELECT does not change the actual data in the database. It just changes how it looks.
💡 Interview Cheat Code: If asked to divide two integers (like 5 / 2), SQL might give you 2 instead of 2.5. To fix it, multiply by 1.0 first: SELECT 5.0 / 2.

-----------------------------------------------------------------------------------------

2️⃣ WHERE & LIKE Operator
What it does: Filters specific rows based on a condition.
LIKE symbols:
% = Any number of characters (e.g., 'A%' = Starts with A).
_ = Exactly one character (e.g., '_at' = Cat, Bat, Hat).
💡 Interview Cheat Code: NEVER use = NULL to find missing data. Always use IS NULL. (e.g., WHERE manager_id IS NULL).

------------------------------------------------------------------------------------------

3️⃣ GROUP BY & ORDER BY
What it does:
GROUP BY groups identical values together to calculate totals/averages.
ORDER BY sorts the final result (ASC for A-Z, DESC for Z-A).
Rule: If you use GROUP BY, every column in your SELECT must either be in the GROUP BY or inside a math function like COUNT(), SUM(), or AVG().
💡 Interview Cheat Code: COUNT(*) counts all rows (even empty ones). COUNT(column_name) ignores empty (NULL) rows.

------------------------------------------------------------------------------------------

4️ HAVING vs. WHERE (Most Asked Question!)
The Difference: Both filter data, but at different times.
WHERE: Filters individual rows BEFORE they are grouped.
HAVING: Filters the groups AFTER they are grouped.
Rule: You cannot use HAVING without GROUP BY. You cannot use WHERE to filter aggregate functions (like AVG or SUM).
💡 Interview Cheat Code:
"I want employees earning > 50k" ➡️ Use WHERE.
"I want departments with an average salary > 50k" ➡️ Use HAVING.

------------------------------------------------------------------------------------------

5️⃣ LIMIT & Aliasing
What it does:
LIMIT stops the query after a certain number of rows.
AS (Alias) gives a temporary nickname to a column or table to make it readable.
OFFSET: LIMIT 1 OFFSET 2 means "Skip the first 2 rows, then show me 1 row."
💡 Interview Cheat Code: To find the 3rd highest salary, use:
SELECT salary FROM Employees ORDER BY salary DESC LIMIT 1 OFFSET 2;
(Note: You can NEVER use a column alias in the WHERE clause!)

-------------------------------------------------------------------------------------------