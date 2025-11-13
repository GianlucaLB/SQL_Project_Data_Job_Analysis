🧠 Data Analyst Job Market Analysis — United Kingdom (2023)

📋 Overview

This project explores Data Analyst job postings in the United Kingdom, focusing on the relationship between skills, demand, and salary.
By analyzing job listings and associated skill data, the project identifies:
- The top-paying roles for Data Analysts
- The most in-demand skills in the UK market
- The skills that offer both high demand and high salary potential

The goal is to help aspiring or current Data Analysts (like me!) make strategic career decisions about which tools and technologies to focus on.

🧰 Tools & Technologies

- SQL (PostgreSQL / SQL Server) — for data exploration and analysis
- CTEs (Common Table Expressions) — to structure complex queries
- JOINs & Aggregations — for combining and summarizing job and skill data
- GitHub Markdown — for documentation and presentation

💼 Dataset

The dataset includes:
- job_postings_fact — job listings and salary data
- company_dim — company details
- skills_dim — a list of standardized skills
- skills_job_dim — a bridge table linking jobs to skills

All queries focus on:
WHERE job_title_short = 'Data Analyst'
AND job_country = 'United Kingdom'

📊 Key Analyses
1️⃣ Top 10 Highest-Paying Data Analyst Roles
```
SELECT
    j.job_id,
    c.name AS company,
    j.job_title,
    j.job_location,
    j.salary_year_avg
FROM job_postings_fact j
LEFT JOIN company_dim c
    ON j.company_id = c.company_id
WHERE j.job_title_short = 'Data Analyst'
  AND j.job_country = 'United Kingdom'
  AND j.salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC
LIMIT 10;
```


💡 Insight:
Top-paying Data Analyst roles in the UK often require strong technical expertise (SQL, Python, cloud tools) and are increasingly hybrid or remote.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

2️⃣ Most In-Demand Skills in the UK
```
SELECT 
    sd.skills,
    COUNT(jd.job_id) AS demand_count
FROM job_postings_fact j
INNER JOIN skills_job_dim jd ON j.job_id = jd.job_id
INNER JOIN skills_dim sd ON jd.skill_id = sd.skill_id
WHERE j.job_title_short = 'Data Analyst'
  AND j.job_country = 'United Kingdom'
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 5;
```
```
| Skill   | Demand Count |
|---------|--------------|
| SQL     | 4480         |
| Excel   | 4281         |
| PowerBI | 2865         |
| Python  | 2129         |
| Tableau | 1644         |
|---------|--------------|
```

💡 Insight:
SQL remains the dominant skill for Data Analysts, closely followed by Excel and visualization tools like Power BI and Tableau.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

3️⃣ Highest-Paying Skills (UK)
```
SELECT 
    sd.skills,
    ROUND(AVG(j.salary_year_avg),2) AS avg_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim jd ON j.job_id = jd.job_id
INNER JOIN skills_dim sd ON jd.skill_id = sd.skill_id
WHERE j.job_title_short = 'Data Analyst'
  AND j.job_country = 'United Kingdom'
  AND j.salary_year_avg IS NOT NULL 
GROUP BY sd.skills
ORDER BY avg_salary DESC
LIMIT 25;
```

💡 Insight:
Specialized tools like Python, Snowflake, and Azure tend to correlate with higher salaries.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

4️⃣ Most Optimal Skills — Balancing Demand and Salary
```
SELECT
    sd.skill_id,
    sd.skills,
    COUNT(jd.job_id) AS demand_count,
    ROUND(AVG(j.salary_year_avg), 2) AS avg_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim jd ON j.job_id = jd.job_id
INNER JOIN skills_dim sd ON jd.skill_id = sd.skill_id
WHERE j.job_title_short = 'Data Analyst'
  AND j.job_country = 'United Kingdom'
  AND j.salary_year_avg IS NOT NULL
GROUP BY sd.skill_id, sd.skills
HAVING COUNT(jd.job_id) > 10
ORDER BY demand_count DESC, avg_salary DESC;
```
```
|---------|--------------|----------------|
| Skill   | Demand Count | Avg Salary (£) |
|---------|--------------|----------------|
| SQL     | 33           | 87,156.41      |
| Excel   | 29           | 83,361.64      |
| Python  | 25           | 95,305.70      |
| Tableau | 13           | 82,079.80      |
|---------|--------------|----------------|
```
💡 Insight:
Skills such as Python, SQL, and Excel offer the best combination of demand and salary potential, making them essential for any Data Analyst career path.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

🧭 Conclusion

SQL is foundational — it appears in almost every high-paying job.
Python offers excellent salary growth potential and versatility.
Excel and Power BI remain highly demanded for business-oriented roles.
Cloud and automation tools (AWS, Azure, Snowflake) are emerging differentiators for higher salaries.

This analysis provides a data-driven roadmap for anyone aiming to maximize their career opportunities as a Data Analyst in the UK.

Big thanks to Luke Barousse for the inspiration!
This project was inspired by his YouTube video on analyzing Data Analyst job postings and skills.
His work helped me structure SQL queries, combine skill and salary data, and present insights in a meaningful way — helping aspiring Data Analysts (myself included) make smarter career decisions.
