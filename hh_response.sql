SELECT
	position_name,
	area_id,
	employer_name
FROM vacancy v 
INNER JOIN employer e ON v.employer_id = e.employer_id
WHERE
	compensation_from IS null
	AND compensation_to IS null
ORDER BY date_creation DESC
LIMIT 10;

WITH compensation AS (
	SELECT position_name,
	  CASE
	  	WHEN compensation_gross IS FALSE
	   	THEN compensation_from * 1.13
		ELSE compensation_from
		END AS compensation_from,
	  CASE
		WHEN compensation_gross IS FALSE
		THEN compensation_to * 1.13  
		ELSE compensation_to
		END AS compensation_to
	FROM vacancy
)
SELECT
	avg(compensation_from) AS avg_min,
	avg(compensation_to) AS avg_max,
	avg(compensation_to - compensation_from) AS avg_middle
FROM compensation;

WITH count_response AS (
SELECT
	count(r.vacancy_id),
	e.employer_name 
FROM response r
INNER JOIN vacancy v ON r.vacancy_id = v.vacancy_id
INNER JOIN employer e ON v.employer_id = e.employer_id
GROUP BY r.vacancy_id, e.employer_id
)
SELECT employer_name
FROM count_response
GROUP BY employer_name
ORDER BY max(count) DESC
LIMIT 5;

WITH vacancy_count AS (
SELECT
	count(vacancy_id),
	employer_id
FROM vacancy
GROUP BY employer_id
)
SELECT
	e.employer_name,
	percentile_cont(0.5) WITHIN GROUP(ORDER BY count)
FROM vacancy_count v
RIGHT JOIN employer e ON v.employer_id = e.employer_id
GROUP BY e.employer_id; 

WITH date_vacancy_response AS(
SELECT
	e.area_id,
	age(r.date_response, v.date_creation) AS time
FROM vacancy v
INNER JOIN response r ON v.vacancy_id = r.vacancy_id
INNER JOIN employer e ON v.employer_id = e.employer_id
)
SELECT
	area_id,
	max(time) AS max_time,
	min(time) AS min_time
FROM date_vacancy_response
GROUP BY area_id;

