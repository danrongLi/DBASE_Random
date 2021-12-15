with recursive is_sub(x,y) as (
select s.parent, s.child
from subsidiary as s
union
select is_sub.x, s.child
from is_sub, subsidiary as s
where is_sub.y = s.parent)
select i1.pname as pname1, i2.pname as pname2
from invested i1, invested i2, is_sub
where i1.cname=is_sub.x
and i2.cname = is_sub.y
order by i1.pname, i2.pname;


