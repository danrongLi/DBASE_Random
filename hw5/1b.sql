
drop view company_new;
drop view company_sub;
drop view is_sub_view;
drop view party_invest;


create view party_invest(party, cname) as (
select p.party, i.cname
from politician p, invested i
where p.pname = i.pname
group by p.party, i.cname);


create view is_sub_view(x,y) as (
with recursive is_sub(x,y) as (
select s.parent, s.child
from subsidiary as s
union
select is_sub.x, s.child
from is_sub, subsidiary as s
where is_sub.y = s.parent)
select * from is_sub);

create view company_sub(cname, revenue) as (
select f1.x cname, f1.total_sub+f1.revenue as revenue
from (select f.x, f.total_sub, c.revenue
from (select is_sub_view.x, sum(c.revenue) as total_sub
from is_sub_view, company c
where c.cname = is_sub_view.y
group by is_sub_view.x) f, company c
where c.cname = f.x) f1);

create view company_new (cname, revenue) as (
select * from company as c
where c.cname not in (
select company_sub.cname
from company_sub)
union
select * from company_sub);

select p.party, sum(c.revenue) total_revenue
from party_invest p, company_new c
where p.cname = c.cname
group by p.party
order by p.party;





