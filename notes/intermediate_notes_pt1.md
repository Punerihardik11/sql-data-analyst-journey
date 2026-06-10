# SQL Interview Cheatsheet - JOINs, UNION, String Functions

---

## 🔗 1. SQL JOINs

### **What is JOIN?**
Combines rows from two or more tables based on a related column.

### **Types of JOINs:**

**INNER JOIN**
- Returns ONLY matching rows from both tables
- Example:
```sql
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id;



LEFT JOIN (LEFT OUTER JOIN)
Returns ALL rows from LEFT table + matching rows from RIGHT table
If no match, RIGHT side shows NULL
Example:
sql
SELECT c.name, o.order_idFROM customers cLEFT JOIN orders o ON c.id = o.customer_id;
RIGHT JOIN
Returns ALL rows from RIGHT table + matching rows from LEFT table
Rarely used (just reverse the tables and use LEFT JOIN)
SELF JOIN
Table JOINs with itself
Example (Employee-Manager):
sql
SELECT e.name AS employee, m.name AS managerFROM employees eLEFT JOIN employees m ON e.manager_id = m.id;
💡 Interview Tips:
INNER JOIN = Only matches
LEFT JOIN = All from left + matches from right
Always use table aliases (e, d, c, o) for cleaner code
Use table.column or alias.column when columns exist in both tables

-------------------------------------------------------------------------------------------
🔀 2. UNION Operator
What is UNION?
Combines results from two or more SELECT statements into one result set.
UNION vs UNION ALL:
UNION
Combines results + removes duplicates
Slower (needs to check for duplicates)
sql
SELECT name FROM table1UNIONSELECT name FROM table2;
UNION ALL
Combines results + keeps duplicates
Faster (no duplicate check)
sql
SELECT name FROM table1UNION ALLSELECT name FROM table2;
Rules for UNION:
✅ Same number of columns in each SELECT
✅ Compatible data types
✅ Columns in same order
✅ Use ORDER BY at the END (not in individual SELECTs)
Example:
sql
SELECT customer_name AS name, 'Customer' AS typeFROM customersUNIONSELECT supplier_name AS name, 'Supplier' AS typeFROM suppliersORDER BY name;
💡 Interview Tips:
UNION = removes duplicates (like DISTINCT)
UNION ALL = keeps everything (faster)
Column names from FIRST SELECT are used in final result

-------------------------------------------------------------------------------------------
🔤 3. String Functions
Most Used Functions:
CONCAT - Combine strings
sql
SELECT CONCAT(first_name, ' ', last_name) AS full_nameFROM employees;-- Result: 'John Doe'
UPPER / LOWER - Change case
sql
SELECT UPPER(name), LOWER(email)FROM users;-- Result: 'JOHN DOE', 'john@email.com'
LENGTH / CHAR_LENGTH - Count characters
sql
SELECT name, LENGTH(name)FROM products;-- LENGTH = bytes, CHAR_LENGTH = characters
SUBSTRING - Extract part of string
sql
SUBSTRING('Hello World', 1, 5)  → 'Hello'-- Syntax: SUBSTRING(text, start_position, length)
LOCATE / INSTR - Find position
sql
LOCATE('@', 'user@gmail.com')  → 5-- Returns position of first occurrence
REPLACE - Replace text
sql
REPLACE('Hello World', 'World', 'SQL')  → 'Hello SQL'-- Syntax: REPLACE(text, find, replace_with)
TRIM / LTRIM / RTRIM - Remove spaces
sql
TRIM('  Hello  ')   → 'Hello'LTRIM('  Hello')    → 'Hello'RTRIM('Hello  ')    → 'Hello'
LEFT / RIGHT - Extract from start/end
sql
LEFT('Hello', 2)   → 'He'RIGHT('Hello', 2)  → 'lo'
💡 Interview Tips:
Position starts at 1 (not 0 like in programming)
String functions are case-insensitive in MySQL by default
Use TRIM() before comparing strings (removes hidden spaces)
LENGTH() counts bytes, CHAR_LENGTH() counts characters
Real-World Use Cases:
Email parsing: SUBSTRING(email, LOCATE('@', email) + 1) → gets domain
Name formatting: CONCAT(UPPER(last_name), ', ', first_name)
Data cleaning: TRIM(REPLACE(phone, '-', '')) → removes spaces and dashes