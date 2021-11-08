drop table Recipes;
drop table Ingredients;
drop table Cocktails;

create table Cocktails (
 cname  varchar(32) primary key,
 price  integer);

create table Ingredients (
 iname  varchar(32) primary key,
 unit_cost decimal,
 abv   integer);

create table Recipes (
 cname  varchar(32),
 iname  varchar(32),
 units   integer,
 primary key (cname, iname),
 foreign key (cname) references Cocktails(cname),
 foreign key (iname) references Ingredients(iname)
);

insert into Cocktails (cname, price) values ('Aprerol spritz', 10);
insert into Cocktails (cname, price) values ('Gimlet', 14);
insert into Cocktails (cname, price) values ('Manhattan', 10);
insert into Cocktails (cname, price) values ('Whiskey sour', 12);
insert into Cocktails (cname, price) values ('Gin fizz', 11);
insert into Cocktails (cname, price) values ('Vodka Martini', 20);
insert into Cocktails (cname, price) values ('Mojito', 10);
insert into Cocktails (cname, price) values ('Hurricane', 8);

insert into Ingredients (iname, unit_cost, abv) values ('vodka', 5, 40);
insert into Ingredients (iname, unit_cost, abv) values ('rum', 4, 40);
insert into Ingredients (iname, unit_cost, abv) values ('Irish coffee', 3, 0);
insert into Ingredients (iname, unit_cost, abv) values ('ice', 0.1, 0);
insert into Ingredients (iname, unit_cost, abv) values ('gin', 1, 40);
insert into Ingredients (iname, unit_cost, abv) values ('whiskey', 2, 43);
insert into Ingredients (iname, unit_cost, abv) values ('vermouth', 0.5, 18);
insert into Ingredients (iname, unit_cost, abv) values ('lemon juice', 0.1, 0);
insert into Ingredients (iname, unit_cost, abv) values ('soda water', 0.1, 0);

insert into Recipes (cname, iname, units) values ('Gimlet', 'gin', 4);
insert into Recipes (cname, iname, units) values ('Gimlet', 'lemon juice', 1);
insert into Recipes (cname, iname, units) values ('Gin fizz', 'gin', 3);
insert into Recipes (cname, iname, units) values ('Gin fizz', 'soda water', 2);
insert into Recipes (cname, iname, units) values ('Gin fizz', 'lemon juice', 2);
insert into Recipes (cname, iname, units) values ('Manhattan', 'whiskey', 3);
insert into Recipes (cname, iname, units) values ('Manhattan', 'vermouth', 1);
insert into Recipes (cname, iname, units) values ('Whiskey sour', 'whiskey', 2);
insert into Recipes (cname, iname, units) values ('Whiskey sour', 'lemon juice', 1);
insert into Recipes (cname, iname, units) values ('Vodka Martini', 'vodka', 2);
insert into Recipes (cname, iname, units) values ('Vodka Martini', 'ice', 1);
insert into Recipes (cname, iname, units) values ('Mojito', 'rum', 2);
insert into Recipes (cname, iname, units) values ('Mojito', 'soda water', 2);
insert into Recipes (cname, iname, units) values ('Mojito', 'ice', 1);
insert into Recipes (cname, iname, units) values ('Hurricane', 'rum', 1);
