select f1.country country1, f2.country country2
from (select t.country, count(t.name), c.gdp
from Tennis_Players t, Countries c
where t.country = c.name
group by t.country, c.gdp) f1,
(select t.country, count(t.name), c.gdp
from Tennis_Players t, Countries c
where t.country = c.name
group by t.country, c.gdp) f2
where f1.count < f2.count
and f1.gdp < f2.gdp
order by f1.country, f2.country;


select f.name player_name, t.country country, c.gdp GDP
from (select distinct y1.name
from Years_Ranked_First y1, Years_Ranked_First y2
where y1.name = y2.name and y1.year = (y2.year-1)) f,
Tennis_Players t, Countries c
where t.name = f.name and c.name = t.country
order by f.name;



create view Distinct_First(top_ranked_player) as
select distinct y.name top_ranked_player
from Years_Ranked_First y;
create view Distinct_Tennis(top_ranked_player, country) as
select d.top_ranked_player, t.country
from Distinct_First d, Tennis_Players t
where d.top_ranked_player = t.name;
select c.name country, c.gdp, c.population, d.top_ranked_player
from Countries c left outer join Distinct_Tennis d
on (d.country = c.name)
order by c.name, d.top_ranked_player;



select distinct t.country
from Tennis_Players t, Years_Ranked_First y
where t.name = y.name
and (y.year%4!=0 or y.year >2010)
order by t.country;