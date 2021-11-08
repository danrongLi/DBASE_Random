select distinct d.dish
from Dishes d, Foods f
where d.food = f.food
and d.dish not in (select distinct d.dish
from Dishes d, Foods f
where d.food = f.food
and f.category = 'fruit')
and (f.category = 'meat' or f.category = 'seafood')
order by d.dish;

select distinct d.food
from Dishes d
where d.food in (
select d.food
from Dishes d
group by d.food
having count(*) >= 2)
and d.food not in (
select distinct d.food
from Dishes d
where d.food in (
select d.food
from Dishes d
group by d.food
having count(*) >= 2)
and d.units < 3)
order by d.food;


select d.dish, cal.category, sum(cal.food_calories) calories
from Dishes d, (select d.dish, d.food, d.units, f.category, f.calories_per_unit, f.calories_per_unit*d.units food_calories 
from Dishes d, Foods f
where d.food = f.food) cal
group by d.dish, cal.category
order by d.dish, cal.category;

select *
from (select cal.dish, sum(cal.food_calories) total_calories
from (select d.dish, d.units*f.calories_per_unit food_calories
from Dishes d, Foods f
where d.food = f.food
and d.dish in (
select d.dish
from Dishes d
group by d.dish
having count(*) <= 3)) cal
group by cal.dish) cal2
where cal2.total_calories >= 1000
order by cal2.dish;



