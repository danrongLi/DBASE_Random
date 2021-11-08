drop table Dishes;
drop table Foods;

create table Foods (
  food varchar(128) primary key,
  category varchar(128) not null,
  calories_per_unit integer not null
);

create table Dishes (
  dish varchar(128),
  food varchar(128),
  units integer default 1,
  primary key (dish, food),
  foreign key (food) references Foods(food)
);

insert into Foods (food, category, calories_per_unit) values ('chicken', 'meat', 185);
insert into Foods (food, category, calories_per_unit) values ('beef', 'meat', 200);
insert into Foods (food, category, calories_per_unit) values ('lamb', 'meat', 150);
insert into Foods (food, category, calories_per_unit) values ('fish', 'seafood', 150);
insert into Foods (food, category, calories_per_unit) values ('lobster', 'seafood', 95);
insert into Foods (food, category, calories_per_unit) values ('shrimp', 'seafood', 80);
insert into Foods (food, category, calories_per_unit) values ('potato', 'veg', 25);
insert into Foods (food, category, calories_per_unit) values ('garlic', 'veg', 45);
insert into Foods (food, category, calories_per_unit) values ('onion', 'veg', 30);
insert into Foods (food, category, calories_per_unit) values ('pepper', 'veg', 25);
insert into Foods (food, category, calories_per_unit) values ('tomato', 'veg', 25);
insert into Foods (food, category, calories_per_unit) values ('carrot', 'veg', 45);
insert into Foods (food, category, calories_per_unit) values ('apple', 'fruit', 70);
insert into Foods (food, category, calories_per_unit) values ('banana', 'fruit', 85);
insert into Foods (food, category, calories_per_unit) values ('lemon', 'fruit', 15);
insert into Foods (food, category, calories_per_unit) values ('orange', 'fruit', 80);
insert into Foods (food, category, calories_per_unit) values ('rice', 'grain', 100);
insert into Foods (food, category, calories_per_unit) values ('noodles', 'grain', 200);

insert into Dishes (dish, food, units) values ('pepper lamb', 'lamb', 3);
insert into Dishes (dish, food, units) values ('pepper lamb', 'pepper', 2);
insert into Dishes (dish, food) values ('pepper lamb', 'lemon');
insert into Dishes (dish, food, units) values ('chicken rice', 'chicken', 3);
insert into Dishes (dish, food, units) values ('chicken rice', 'rice', 5);
insert into Dishes (dish, food, units) values ('big plate chicken', 'chicken', 4);
insert into Dishes (dish, food, units) values ('big plate chicken', 'potato', 4);
insert into Dishes (dish, food, units) values ('lemon garlic steak', 'beef',8);
insert into Dishes (dish, food) values ('lemon garlic steak', 'lemon');
insert into Dishes (dish, food) values ('lemon garlic steak', 'garlic');
insert into Dishes (dish, food, units) values ('stew', 'beef', 5);
insert into Dishes (dish, food, units) values ('stew', 'onion', 1);
insert into Dishes (dish, food, units) values ('stew', 'pepper', 2);
insert into Dishes (dish, food, units) values ('soup', 'chicken', 4);
insert into Dishes (dish, food, units) values ('soup', 'noodles', 4);
insert into Dishes (dish, food, units) values ('soup', 'carrot', 2);
insert into Dishes (dish, food) values ('soup', 'pepper');
insert into Dishes (dish, food, units) values ('salad', 'tomato', 3);
insert into Dishes (dish, food) values ('salad', 'onion');
insert into Dishes (dish, food, units) values ('salad', 'pepper',3 );
insert into Dishes (dish, food, units) values ('fruit_salad', 'apple', 2);
insert into Dishes (dish, food, units) values ('fruit_salad', 'orange', 2);
insert into Dishes (dish, food) values ('fruit_salad', 'banana');
insert into Dishes (dish, food, units) values ('bouillabaisse', 'fish', 3);
insert into Dishes (dish, food, units) values ('bouillabaisse', 'lobster', 2);
insert into Dishes (dish, food, units) values ('bouillabaisse', 'shrimp', 3);
insert into Dishes (dish, food, units) values ('bouillabaisse', 'onion', 1);
insert into Dishes (dish, food, units) values ('bouillabaisse', 'tomato', 2);
insert into Dishes (dish, food, units) values ('bouillabaisse', 'potato', 3);
