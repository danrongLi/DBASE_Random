drop table Subsidiary;
drop table Invested;
drop table Company;
drop table Politician;

create table Politician (
 pname varchar(16) primary key,
 party char(1) not null
 );

create table Company (
 cname  varchar(16),
 revenue integer not null,
 primary key (cname)
 );

create table Subsidiary (
 parent varchar(16),
 child varchar(16),
 primary key (parent, child),
 foreign key (parent) references Company(cname),
 foreign key (child) references Company(cname)
 );

create table Invested (
 pname varchar(16),
 cname  varchar(16),
 primary key (pname, cname),
 foreign key (pname) references Politician(pname),
 foreign key (cname) references Company(cname)
 );

insert into Politician (pname, party) values ('Don', 'R');
insert into Politician (pname, party) values ('Ron', 'R');
insert into Politician (pname, party) values ('Hil', 'D');
insert into Politician (pname, party) values ('Bill', 'D');

insert into Company (cname, revenue) values ('C1', 110);
insert into Company (cname, revenue) values ('C2', 30);
insert into Company (cname, revenue) values ('C3', 50);
insert into Company (cname, revenue) values ('C4', 250);
insert into Company (cname, revenue) values ('C5', 75);
insert into Company (cname, revenue) values ('C6', 15);

insert into Invested (pname, cname) values ('Don', 'C1');
insert into Invested (pname, cname) values ('Don', 'C4');
insert into Invested (pname, cname) values ('Ron', 'C1');
insert into Invested (pname, cname) values ('Hil', 'C3');

insert into Subsidiary (parent, child) values ('C1', 'C2');
insert into Subsidiary (parent, child) values ('C2', 'C3');
insert into Subsidiary (parent, child) values ('C2', 'C5');
insert into Subsidiary (parent, child) values ('C4', 'C6');
