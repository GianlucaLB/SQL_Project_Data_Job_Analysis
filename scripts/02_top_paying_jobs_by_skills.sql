/*
Question: What skills are required for the top-paying data analyst jobs in UK?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/
WITH uk_top_salaries as 
(
SELECT
j.job_id,
c.name as company,
j.job_title,
j.job_location,
j.salary_year_avg
FROM job_postings_fact j
LEFT JOIN company_dim c
ON j.company_id = c.company_id
WHERE j.job_title_short = 'Data Analyst' AND
	  j.job_country = 'United Kingdom' AND
	  j.salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC
LIMIT 10
)
SELECT 
u.job_id,
u.company,
u.job_title,
sd.skills
FROM uk_top_salaries u
INNER JOIN skills_job_dim jd
ON u.job_id = jd.job_id
INNER JOIN skills_dim sd 
ON jd.skill_id = sd.skill_id
ORDER BY u.salary_year_avg DESC

/*In 2023, UK job postings show that SQL remains the most in-demand skill for Data Analysts, appearing in 9 of the top listings.
Python follows with 5 mentions, while other key skills such as Power BI, Azure, AWS, and Excel also appear frequently */
