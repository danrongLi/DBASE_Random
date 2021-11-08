drop table Years_Ranked_First;
drop table Tennis_Players;
drop table Countries;

-- GDP in billion, population in million
create table Countries (
  name varchar(16) primary key,
  GDP integer,
  population integer
);

create table Tennis_Players (
  name varchar(16) primary key,
  country varchar(16),
  ATP_rank integer,
  age integer,
  points integer,
  foreign key (country) references Countries (name)
);

create table Years_Ranked_First (
 name varchar(16),
 year integer,
 primary key (name, year),
 foreign key (name) references Tennis_Players (name)
);

insert into Countries (name, gdp, population)  values ('USA', 21439, 330);
insert into Countries (name, gdp, population)  values ('China', 14140, 1405);
insert into Countries (name, gdp, population)  values ('Japan', 5154, 126);
insert into Countries (name, gdp, population)  values ('Germany', 3863, 83);
insert into Countries (name, gdp, population)  values ('UK', 2743, 67);
insert into Countries (name, gdp, population)  values ('Russia', 1464, 145);
insert into Countries (name, gdp, population)  values ('Spain', 1398, 47);
insert into Countries (name, gdp, population)  values ('Switzerland', 715, 9);
insert into Countries (name, gdp, population)  values ('Austria', 448, 9);
insert into Countries (name, gdp, population)  values ('Greece', 214, 11);
insert into Countries (name, gdp, population)  values ('Serbia', 51, 7);

insert into Tennis_Players (name, country, ATP_rank, age, points) values ('Djokovic', 'Serbia', 1, 33, 11260);
insert into Tennis_Players (name, country, ATP_rank, age, points) values ('Nadal', 'Spain', 2, 31, 9850);
insert into Tennis_Players (name, country, ATP_rank, age, points) values ('Thiem', 'Austria', 3, 27, 9125);
insert into Tennis_Players (name, country, ATP_rank, age, points) values ('Federer', 'Switzerland', 4, 39, 66630);
insert into Tennis_Players (name, country, ATP_rank, age, points) values ('Medvedev', 'Russia', 5, 24, 5890); 
insert into Tennis_Players (name, country, ATP_rank, age, points) values ('Tsitsipar', 'Greece', 6, 22, 5385);
insert into Tennis_Players (name, country, ATP_rank, age, points) values ('Zverev', 'Germany', 7, 23, 4650);
insert into Tennis_Players (name, country, age) values ('Rublev', 'Russia', 21);
insert into Tennis_Players (name, country, age) values ('Murray', 'UK', 33);  
insert into Tennis_Players (name, country) values ('Ferrero', 'Spain');

insert into Years_Ranked_First (name, year) values ('Djokovic', 2020);
insert into Years_Ranked_First (name, year) values ('Nadal', 2019);
insert into Years_Ranked_First (name, year) values ('Djokovic', 2018);
insert into Years_Ranked_First (name, year) values ('Nadal', 2017);
insert into Years_Ranked_First (name, year) values ('Federer', 2016);
insert into Years_Ranked_First (name, year) values ('Murray', 2015);
insert into Years_Ranked_First (name, year) values ('Djokovic', 2014);
insert into Years_Ranked_First (name, year) values ('Nadal', 2013);
insert into Years_Ranked_First (name, year) values ('Djokovic', 2012);
insert into Years_Ranked_First (name, year) values ('Djokovic', 2011);
insert into Years_Ranked_First (name, year) values ('Rublev', 2010);
insert into Years_Ranked_First (name, year) values ('Federer', 2009);
insert into Years_Ranked_First (name, year) values ('Zverev', 2008);
insert into Years_Ranked_First (name, year) values ('Federer', 2007);
insert into Years_Ranked_First (name, year) values ('Federer', 2006);
insert into Years_Ranked_First (name, year) values ('Federer', 2005);
insert into Years_Ranked_First (name, year) values ('Federer', 2004);
insert into Years_Ranked_First (name, year) values ('Ferrero', 2003);
