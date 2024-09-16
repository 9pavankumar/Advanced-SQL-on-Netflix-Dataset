# Advanced-SQL-on-Netflix-Dataset

Here’s a list of the key SQL operators and functions used in the queries you provided, along with explanations of why they are used in PostgreSQL:

---

### 1. **`SELECT`**
- **Usage**: Retrieves data from a database.
- **Why**: It is used to fetch specific columns or entire rows from a table or tables. Without `SELECT`, you wouldn’t be able to query data from the database.

---

### 2. **`COUNT(*)`**
- **Usage**: Counts the number of rows that match a specified condition.
- **Why**: Commonly used to get the number of records that satisfy certain conditions. `COUNT(*)` returns the total count of rows, which is useful for summarizing data.

---

### 3. **`GROUP BY`**
- **Usage**: Groups rows that have the same values in specified columns into aggregated data.
- **Why**: It is used when performing aggregate functions (e.g., `COUNT()`, `AVG()`). Without `GROUP BY`, you cannot create grouped summaries of data based on common values.

---

### 4. **`ORDER BY`**
- **Usage**: Sorts the result set by one or more columns.
- **Why**: Useful when you want to arrange the output in ascending or descending order based on specific criteria. In PostgreSQL, the default is ascending order, but `DESC` can be added for descending order.

---

### 5. **`LIMIT`**
- **Usage**: Restricts the number of rows returned by a query.
- **Why**: This operator limits the result to a specific number of rows, which is often used for pagination or when you need a subset of results (e.g., top 5 or top 10).

---

### 6. **`ILIKE`**
- **Usage**: Performs a case-insensitive search in PostgreSQL.
- **Why**: It allows you to match text regardless of letter case (upper/lower). For example, `ILIKE '%india%'` will match "India", "india", or "INDIA". `LIKE` is case-sensitive, but `ILIKE` ignores case differences.

---

### 7. **`TO_DATE()`**
- **Usage**: Converts a string to a `DATE` type.
- **Why**: This function is used when you need to convert string-formatted dates into a date type to perform date-based operations such as filtering data by time ranges.

---

### 8. **`INTERVAL`**
- **Usage**: Specifies a time interval (e.g., `5 YEARS`, `1 DAY`).
- **Why**: It is used in date arithmetic for comparing or calculating differences between dates and time periods. For example, `CURRENT_DATE - INTERVAL '5 YEARS'` gives a date 5 years before today.

---

### 9. **`CASE`**
- **Usage**: Performs conditional logic in SQL queries.
- **Why**: Used to create if-else logic in SQL queries. It’s a way to categorize or label data based on certain conditions (e.g., 'Good' or 'Bad' content based on keywords).

---

### 10. **`RANK() OVER (PARTITION BY...)`**
- **Usage**: Assigns ranks to rows within a partition (group) of a result set.
- **Why**: It is useful when you want to rank rows based on specific conditions (e.g., find the most common rating for movies/TV shows). The `PARTITION BY` clause allows the ranking to reset for each group (e.g., for each `type`).

---

### 11. **`UNNEST()`**
- **Usage**: Expands an array to a set of rows.
- **Why**: It is used to break arrays into individual rows, which is useful when dealing with fields that contain multiple values (e.g., a `casts` column with multiple actors listed). This allows the data to be handled more effectively.

---

### 12. **`STRING_TO_ARRAY()`**
- **Usage**: Splits a string into an array using a delimiter.
- **Why**: This function is used when you have a column that contains multiple values as a string (e.g., a comma-separated list of countries or actors) and you need to split it into individual values.

---

### 13. **`SPLIT_PART()`**
- **Usage**: Splits a string and returns the specified part based on a delimiter.
- **Why**: It's a simpler function for extracting specific parts of a string when you know the exact structure of the string and want, for example, just the number of seasons from a `duration` field.

---

### 14. **`EXTRACT()`**
- **Usage**: Extracts specific fields (like year, month, or day) from a date or timestamp.
- **Why**: This function allows you to pull out parts of a date, like extracting the year from a date to find content released within the last 10 years.

---

### 15. **`MAX()`**
- **Usage**: Returns the maximum value in a set.
- **Why**: It is used to find the largest value, such as the longest movie (`MAX(duration)`), or any other maximum value in the dataset.

---

### 16. **`IS NULL`**
- **Usage**: Checks if a value is `NULL`.
- **Why**: It is used to identify records that have missing or `NULL` values in specific columns (e.g., finding content that doesn’t have a director assigned).

---

### 17. **`::numeric`**
- **Usage**: Casts a value to a `numeric` data type.
- **Why**: It is used to convert a string or other types of data into a numeric format. This is essential when you need to perform numerical comparisons or arithmetic, such as checking if a TV show has more than 5 seasons.

---

These operators and functions are fundamental for performing various data manipulation tasks in PostgreSQL, such as filtering, grouping, ranking, and analyzing data from complex datasets.
