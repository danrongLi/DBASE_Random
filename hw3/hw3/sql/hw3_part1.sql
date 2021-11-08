select cs.candidate, js.job, js.grade
from Candidates_Skills cs, Jobs_Skills js
where cs.skill = js.skill and cs.years >= js.years
group by cs.candidate, js.job, js.grade
having count(*) >= 2
order by cs.candidate, js.job, js.grade;


select c.candidate, p.company
from Candidates c, Positions p
where c.salary <= p.salary
or c.salary is null
order by c.candidate, p.company;


select distinct cs.candidate
from Candidates_Skills cs, Jobs_Skills js
where js.job = 'DEV' and js.grade = 3 and cs.skill = js.skill and cs.years >= js.years
order by cs.candidate;


select f1.candidate candidate1, f2.candidate candidate2
from (select cs.candidate, sum(cs.years), c.salary
from Candidates_Skills cs, Candidates c
where c.candidate = cs.candidate and c.salary is not null
and c.candidate in (select cs.candidate
from Candidates_Skills cs
where cs.skill = 'python'
intersect
select cs.candidate
from Candidates_Skills cs
where cs.skill = 'DB')
group by cs.candidate, c.salary) f1, 
(select cs.candidate, sum(cs.years), c.salary
from Candidates_Skills cs, Candidates c
where c.candidate = cs.candidate and c.salary is not null
and c.candidate in (select cs.candidate
from Candidates_Skills cs
where cs.skill = 'python'
intersect
select cs.candidate
from Candidates_Skills cs
where cs.skill = 'DB')
group by cs.candidate, c.salary) f2
where f1.sum > f2.sum
and f1.salary < f2.salary
order by f1.candidate, f2.candidate;


select cs.skill, min(cs.years) min_years, max(cs.years) max_years, round( avg(cs.years),1 ) avg_years, min(c.salary) min_salary, max(c.salary) max_salary, round( avg(c.salary),1 ) avg_salary
from Candidates_Skills cs, Candidates c
where c.candidate = cs.candidate
group by cs.skill
order by cs.skill;


select f1.job job1, f1.grade grade1, f1.company company1, f2.job job2, f2.grade grade2, f2.company company2
from (select p.job,p.grade,p.company
from Jobs_Skills js, Positions p
where js.skill = 'Linux'
and js.job = p.job and js.grade = p.grade) f1,
(select p.job,p.grade,p.company
from Jobs_Skills js, Positions p
where js.skill = 'Linux'
and js.job = p.job and js.grade = p.grade) f2
where (f1.job < f2.job or f1.job < f2.job or f1.company < f2.company)
order by f1.job, f1.grade, f1.company, f2.job, f2.grade, f2.company;

