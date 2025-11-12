/*
Question: What are the most in-demand skills for data analysts in UK?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
	sd.skills,
	COUNT(jd.job_id) as demand_count
FROM job_postings_fact j
INNER JOIN skills_job_dim jd
    ON j.job_id = jd.job_id
INNER JOIN skills_dim sd 
    ON jd.skill_id = sd.skill_id
WHERE j.job_title_short = 'Data Analyst'
      AND j.job_country = 'United Kingdom'
GROUP BY sd.skills
ORDER BY demand_count DESC
limit 5
/* 
The most in-demand skills for Data Analysts in UK are:
|---------|--------------|
| Skill   | Demand Count |
|---------|--------------|
| SQL     | 4480         |
| Excel   | 4281         |
| PowerBI | 2865         |
| Python  | 2129         |
| Tableau | 1644         |
*/
