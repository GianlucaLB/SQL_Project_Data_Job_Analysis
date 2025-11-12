/*
Answer: What are the top skills based on salary in UK?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, in United Kingdom
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    sd.skills,
    ROUND(AVG(j.salary_year_avg), 2) AS avg_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim jd
    ON j.job_id = jd.job_id
INNER JOIN skills_dim sd
    ON jd.skill_id = sd.skill_id
WHERE j.job_title_short = 'Data Analyst'
  AND j.job_country = 'United Kingdom'
  AND j.salary_year_avg IS NOT NULL
GROUP BY sd.skills
ORDER BY avg_salary DESC
LIMIT 25;
