/*
Question: What are the top-paying data analyst jobs in UK?
- Identify the top 10 highest-paying Data Analyst roles
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT
j.job_id,
c.name as company,
j.job_title,
j.job_location,
j.job_schedule_type,
j.salary_year_avg
FROM job_postings_fact j
LEFT JOIN company_dim c
ON j.company_id = c.company_id
WHERE j.job_title_short = 'Data Analyst' AND
	    j.job_country = 'United Kingdom' AND
	    j.salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC
LIMIT 10
