
---

### Netflix Data Analysis in PostgreSQL

### Table Creation:

```sql
DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix (
    show_id      VARCHAR(10),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

---

### 15 Business Problems & Solutions

**1. Count the number of Movies vs TV Shows**

```sql
SELECT TYPE, COUNT(*) 
FROM NETFLIX 
GROUP BY TYPE;
```

---

**2. Find the most common rating for movies and TV shows**

```sql
SELECT type, rating
FROM (
    SELECT type, rating, COUNT(*),
           RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking 
    FROM NETFLIX 
    GROUP BY 1, 2 	
    ORDER BY 1, 3 DESC
) AS te 
WHERE ranking = 1;
```

---

**3. List all movies released in a specific year (e.g., 2020)**

```sql
SELECT * FROM netflix 
WHERE type = 'Movie' AND release_year = 2020;
```

---

**4. Find the top 5 countries with the most content on Netflix**

```sql
SELECT COUNT(show_id), 
       UNNEST(STRING_TO_ARRAY(country, ',')) AS new_country 
FROM netflix
GROUP BY 2 
ORDER BY 1 DESC 
LIMIT 5;
```

---

**5. Identify the longest movie**

```sql
SELECT * FROM netflix 
WHERE type = 'Movie' 
  AND duration = (SELECT MAX(duration) FROM netflix);
```

---

**6. Find content added in the last 5 years**

```sql
SELECT * FROM netflix 
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 YEARS';
```

---

**7. Find all the movies/TV shows by director 'Rajiv Chilaka'**

```sql
-- Exact match (case-sensitive):
SELECT * FROM netflix 
WHERE director = 'Rajiv Chilaka';

-- Case-insensitive search:
SELECT * FROM netflix 
WHERE director ILIKE '%Rajiv Chilaka%';
```

---

**8. List all TV shows with more than 5 seasons**

```sql
SELECT * FROM netflix 
WHERE type != 'Movie' 
  AND SPLIT_PART(duration, ' ', 1)::NUMERIC > 5 
ORDER BY duration;
```

---

**9. Count the number of content items in each genre**

```sql
SELECT UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre, COUNT(*)
FROM netflix
GROUP BY 1
ORDER BY 2 DESC;
```

---

**10. Find each year and the average number of content releases in India on Netflix. Return top 5 years with the highest average content release.**

```sql
SELECT release_year, COUNT(*) / 12 AS average_count_per_year
FROM netflix 
WHERE country ILIKE '%India%'
GROUP BY release_year 
ORDER BY 2 DESC 
LIMIT 5;
```

---

**11. List all movies that are documentaries**

```sql
SELECT * FROM netflix 
WHERE listed_in ILIKE '%documentaries%';
```

---

**12. Find all content without a director**

```sql
SELECT * FROM netflix 
WHERE director IS NULL;
```

---

**13. Find how many movies actor 'Salman Khan' appeared in the last 10 years**

```sql
SELECT * FROM netflix 
WHERE casts ILIKE '%Salman Khan%' 
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

---

**14. Find the top 10 actors who have appeared in the highest number of movies produced in India**

```sql
SELECT UNNEST(STRING_TO_ARRAY(casts, ',')) AS new_cast, COUNT(*)
FROM netflix 
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
```

---

**15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.**

```sql
WITH categorized_content AS (
    SELECT CASE 
             WHEN description ILIKE '%kill%' 
              OR description ILIKE '%violence%' THEN 'bad'
             ELSE 'good' 
           END AS category 
    FROM netflix
)
SELECT category, COUNT(*) AS count 
FROM categorized_content
GROUP BY 1 
ORDER BY 2 DESC;
```

---

