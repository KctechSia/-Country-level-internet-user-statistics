CREATE DATABASE Portfolio_Projects;

USE Portfolio_Projects;

SELECT  *
FROM portfolio_projects.`number of internet users`;

SELECT  *
FROM portfolio_projects.`number of internet users`
order by 1,3;

SELECT DISTINCT entity
FROM `number of internet users`;

-- number of users in africa over the years
SELECT *
FROM `number of internet users`
WHERE entity = 'africa';

-- number of users the year internet was first used
SELECT entity, num_of_users
FROM `number of internet users`
WHERE num_of_years = 1990
ORDER BY num_of_users DESC;

-- number of countries that had zero users in the year 1990
SELECT Entity
FROM `number of internet users`
WHERE num_of_years = 1990 AND num_of_users = 0;

-- number of countries that had users in the year 1990
SELECT Entity, num_of_users 
FROM `number of internet users`
WHERE num_of_years = 1990 AND num_of_users > 0
ORDER BY num_of_users DESC;


-- Progressive development of users
SELECT entity, num_of_users
FROM `number of internet users`
WHERE num_of_years = 1991
ORDER BY num_of_users DESC;

-- Top number of users each year 
SELECT num_of_years, SUM(num_of_users) AS Total_users
FROM `number of internet users`
GROUP BY num_of_years
ORDER BY num_of_years;

-- Top 5 countries with the most users in 2021
SELECT entity, num_of_users
FROM `number of internet users`
WHERE num_of_years = 2021
ORDER BY num_of_users DESC
LIMIT 5;

-- difference between the number of users in the present year over the previous year
SELECT Entity, num_of_years, num_of_users,
    LAG(num_of_users) OVER(PARTITION BY Entity ORDER BY num_of_years) AS Previous_Year,
   num_of_users - LAG(num_of_users) OVER (PARTITION BY Entity ORDER BY num_of_years) AS Yearly_Change
FROM `number of internet users`
ORDER BY Entity, num_of_years;

-- difference between the number of users in the present year over the previous year in australia
SELECT num_of_years, num_of_users,
LAG(num_of_users) OVER(ORDER BY num_of_years) AS Previous_year,
num_of_users - LAG(num_of_users) OVER(ORDER BY num_of_years) AS Yearly_change
FROM `number of internet users`
WHERE entity = 'Australia';

-- avg number of users in each country
SELECT Entity, AVG(num_of_users) AS Avg_Users
FROM `number of internet users`
GROUP BY Entity
ORDER BY Avg_Users DESC;

-- Top 5 countries with the highest percentage growth of users over the past 21 years
SELECT
    a.Entity,
    a.num_of_users AS Users_2000,
    b.num_of_users AS Users_2021,
    b.num_of_users - a.num_of_users AS Absolute_Growth
FROM `number of internet users` a
JOIN `number of internet users` b ON a.Entity = b.Entity
WHERE a.num_of_years = 2000 AND b.num_of_years = 2021
ORDER BY Absolute_Growth DESC
LIMIT 5;

-- countries ranked by internet users per year
SELECT num_of_years, Entity, num_of_users,
       RANK() OVER (PARTITION BY num_of_years ORDER BY num_of_users DESC) AS Usage_Rank
FROM `number of internet users`
WHERE num_of_years >= 1990;

-- average number of internet users over the last 3 years
SELECT num_of_years,
      num_of_users, 
      AVG(num_of_users) OVER (ORDER BY num_of_years 
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Moving_Avg
FROM `number of internet users`
WHERE Entity = 'United states';

-- countries with over 10 million users each year
SELECT Entity
FROM `number of internet users`
WHERE num_of_years BETWEEN 2010 AND 2021
GROUP BY Entity
HAVING MIN(num_of_users) > 10000000;









