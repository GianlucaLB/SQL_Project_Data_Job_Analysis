/*
Answer: Most optimal skills for Data Analysts in UK
- Combines skill demand and average salary into a single query
- Why? Highlights skills that are both in high demand and associated with high salaries
*/

SELECT
    sd.skill_id,
    sd.skills,
    COUNT(jd.job_id) AS demand_count,
    ROUND(AVG(j.salary_year_avg), 2) AS avg_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim jd
    ON j.job_id = jd.job_id
INNER JOIN skills_dim sd
    ON jd.skill_id = sd.skill_id
WHERE j.job_title_short = 'Data Analyst'
  AND j.job_country = 'United Kingdom'
  AND j.salary_year_avg IS NOT NULL
GROUP BY sd.skill_id, sd.skills
HAVING COUNT(jd.job_id) > 10 -- filter out skills with very low demand
ORDER BY demand_count DESC, avg_salary DESC;
/* 
The most in-demand skills for Data Analysts in UK are:

|---------|--------------|------------|
| Skill   | Demand Count | avg_salary |
|---------|--------------|------------|
| SQL     | 33           | 87156.41   |
| Excel   | 29           | 83361.64   |
| Python  | 25           | 95305.70   |
| Tableau | 13           | 82079.80   |

*/
