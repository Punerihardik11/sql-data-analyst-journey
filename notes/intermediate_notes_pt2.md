

# 📝 SQL Interview Notes: CASE, Subqueries & Window Functions

## 1️⃣ CASE Statements (Conditional Logic)
**What it is:** SQL’s version of IF-ELSE. Used to create custom categories or flags.
**Syntax:**
```sql
CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result 
END AS new_column
```
💡 **Interview Cheat Code:** Order matters! SQL stops at the **first** true condition. Always put your strictest/highest condition first (e.g., `> 100` before `> 50`).

---

## 2️⃣ Subqueries (Query inside a Query)
**What it is:** Used when you need to calculate a value (like an average) *before* you can filter your main data.
**Syntax:**
```sql
SELECT name FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);
```
💡 **Interview Cheat Codes:**
1. You **CANNOT** put `AVG()`, `SUM()`, or `MAX()` directly inside a `WHERE` clause. You *must* use a subquery.
2. If the subquery returns a list of multiple items, use `IN` or `NOT IN` (e.g., `WHERE id IN (SELECT id...)`).

---

## 3️⃣ Window Functions (ROW_NUMBER, RANK, DENSE_RANK)
**What it is:** Calculates values across a group of rows **without collapsing them** (unlike `GROUP BY`).

**The #1 Most Asked Question: What's the difference?**
*Imagine salaries: $10k, $10k, $8k*
* **ROW_NUMBER:** 1, 2, 3 (Ignores ties. Every row gets a unique number).
* **RANK:** 1, 1, 3 (Skips numbers. Two 1s, so next is 3).
* **DENSE_RANK:** 1, 1, 2 (No skipping. Two 1s, next is 2).

💡 **Interview Cheat Codes:**
1. **PARTITION BY** resets the counter for each group (e.g., "Rank employees *within each department*").
2. **THE GOLDEN RULE:** You **CANNOT** use a window function directly in a `WHERE` clause. You must wrap it in a CTE or Subquery first, then filter it.

---

