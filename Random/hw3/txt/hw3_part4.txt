select *
from (
select distinct r.cname
from Recipes r
where r.iname = 'ice'                 
union
select distinct r.cname
from Recipes r
group by r.cname
having sum(r.units) < 4
) f
order by f.cname;


select *
from( select fo.cname, round(fo.total_cost/fo.total_unit,1) avg_cost
from (select f.cname, sum(f.icost) total_cost, sum(f.iunit) total_unit
from (select r.cname, r.iname, r.units*i.unit_cost icost, r.units iunit
from Recipes r, Ingredients i
where r.iname = i.iname) f
group by f.cname) fo) foo
where foo.avg_cost < 3.5
order by foo.cname;


select foo.cname, foo.price-foo.combined_cost profit
from (select fo.cname, sum(fo.iunit*fo.icost) combined_cost ,round( avg(fo.price),0) price
from (select r.cname, r.iname, r.units iunit, i.unit_cost icost, c.price
from Recipes r, Ingredients i, Cocktails c,
(select r.cname
from Recipes r
group by r.cname
having count(*) <= 2) f
where f.cname = r.cname
and r.cname = c.cname
and r.iname = i.iname) fo
group by fo.cname) foo
order by foo.cname;


create view Total_Abv(cname,total_abv) as
select f.cname, sum(f.iabv) total_abv
from (select r.cname, r.iname, r.units*i.abv iabv
from Recipes r, Ingredients i
where r.iname = i.iname) f
group by f.cname;
select t1.cname cname1, t2.cname cname2
from Total_Abv t1, Total_Abv t2
where t1.total_abv > t2.total_abv
order by t1.cname, t2.cname;

