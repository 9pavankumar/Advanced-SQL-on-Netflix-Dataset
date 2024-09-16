-- NETFLIX DATA ANALYSIS --
"""
Topics I Applied from this Netflix project in postgresql
rank
over 
partition by
string_to_array(column_name, ','(delimiter is space comma))
unnest
like
ilike
split_part(column_name, ' '(delimiter is space here), 1(no of space in the selected column))
EXTRACT(YEAR FROM CURRENT_DATE)
Current_date - intervel 'no years'
to_date()
"""


drop table if exists netflix;

CREATE TABLE netflix
(
    show_id      VARCHAR(10),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year int,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550));

select * from netflix;

-- 15 Business Problems & Solutions



"""1. Count the number of Movies vs TV Shows"""

SELECT TYPE,  COUNT(*) FROM NETFLIX GROUP BY TYPE;



"""2. Find the most common rating for movies and TV shows"""

select type, rating
from
	(SELECT type, rating, count(*),
			rank() over (partition by type order by count(*) desc) as ranking 
			FROM NETFLIX 
			group by 1, 2 	
			order by 1, 3 desc)
as te where ranking =1


"""3. List all movies released in a specific year (e.g., 2020)"""  

select * from netflix 
where type = 'Movie' and release_year = 2020;


"""4. Find the top 5 countries with the most content on Netflix"""

select count(SHOW_ID), 
UNNEST(STRING_TO_ARRAY(country, ',' )) AS new_country 
from netflix
group by 2 
order by 1  desc 
limit 5


"""5. Identify the longest movie"""

select * from netflix 
where type = 'Movie' and DURATION = (select max(duration) from netflix)


"""6. Find content added in the last 5 years"""

select * from netflix 
where TO_DATE(date_added, 'month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 YEARS'


"""7. Find all the movies/TV shows by director 'Rajiv Chilaka'!"""

SELECT * FROM NETFLIX WHERE DIRECTOR = 'Rajiv Chilaka'; -- search for exact match and don't consider other names with the selected name in same cell
SELECT * FROM NETFLIX WHERE DIRECTOR LIKE '%Rajiv Chilaka%';-- select with only capital  names as given in first name
SELECT * FROM NETFLIX WHERE DIRECTOR ILIKE '%Rajiv Chilaka%'; --(Correct) considers both(lower and upper case) with that name 


"""8. List all TV shows with more than 5 seasons"""

select * from netflix 
where type != 'Movie' and split_part(duration, ' ', 1)::numeric  > 5 order by duration 



"""9. Count the number of content items in each genre"""

select  unnest(string_to_array(listed_in, ',')) as genre, 
count(*)
from netflix
group by 1
order by 2 desc;


"""10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!"""

select  release_year, 
count(*)/12 average_count_per_year 
from netflix 
where country ilike '%india%'
group by release_year 
order by 2 desc 
limit 5


"""11. List all movies that are documentaries"""

select * from netflix 
where listed_in ilike '%documentaries%';


"""12. Find all content without a director"""

select * from netflix 
where director is null


"""13. Find how many movies actor 'Salman Khan' appeared in last 10 years!"""

select * from netflix 
where casts ilike '%Salman Khan%' 
and 
release_year >extract(year from  current_date)-10


"""14. Find the top 10 actors who have appeared in the highest number 
of movies produced in India."""

select 
unnest(string_to_array(casts, ',')) as new_cast,count(*)
from netflix 
where country ilike '%india%'
group by 1
order by 2 desc
limit 10;


"""15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category."""

select case 
			when 
				description ilike '%kill%' or description ilike '%violence%' then 'bad'
			else 'good' end as category, 
count(*) as count from netflix 
group by category 
order by 2 desc











