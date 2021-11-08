drop table Jobs_Skills;
drop table Positions;
drop table Jobs;

drop table Candidates_Skills;
drop table Candidates;

create table Jobs (
  job    char(3),
  grade  integer,
  primary key (job, grade)
  );
  
create table Jobs_Skills (
  job    char(3),
  grade  integer,
  skill varchar(16) not null,
  years integer not null,
  primary key (job, grade, skill),
  foreign key (job, grade) references Jobs (job, grade)
  );

create table Positions (
  job char(3),
  grade integer,
  company varchar(16) not null,
  salary integer not null,
  primary key (job, grade, company),
  foreign key (job, grade) references Jobs (job, grade)
  );

create table Candidates (
  candidate varchar(16) primary key,
  salary integer
  );

create table Candidates_Skills (
   candidate varchar(16),
   skill varchar(16),
   years integer not null,
   primary key (candidate, skill),
   foreign key (candidate) references Candidates (candidate)
  );

insert into Jobs (job, grade) values ('QA', 1);
insert into Jobs (job, grade) values ('DEV', 1);
insert into Jobs (job, grade) values ('DEV', 2);
insert into Jobs (job, grade) values ('DEV', 3);

insert into Jobs_Skills (job, grade, skill, years) values ('QA', 1, 'python', 2);
insert into Jobs_Skills (job, grade, skill, years) values ('QA', 1, 'DB', 1);
insert into Jobs_Skills (job, grade, skill, years) values ('QA', 1, 'Linux', 1);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 1, 'python', 3);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 1, 'DB', 1);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 2, 'python', 5);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 2, 'DB', 3);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 2, 'Linux', 2);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 3, 'python', 5);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 3, 'C++', 5);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 3, 'DB', 5);
insert into Jobs_Skills (job, grade, skill, years) values ('DEV', 3, 'Linux', 3);

insert into Positions (job, grade, company, salary) values ('QA', 1, 'IBM', 100);
insert into Positions (job, grade, company, salary) values ('DEV', 2, 'IBM', 125);
insert into Positions (job, grade, company, salary) values ('DEV', 3, 'IBM', 150);
insert into Positions (job, grade, company, salary) values ('QA', 1, 'SAP', 85);
insert into Positions (job, grade, company, salary) values ('DEV', 1, 'SAP', 95);
insert into Positions (job, grade, company, salary) values ('DEV', 2, 'SAP', 110);
insert into Positions (job, grade, company, salary) values ('DEV', 3, 'SAP', 135);

insert into Candidates (candidate, salary) values ('Ann', 150);
insert into Candidates (candidate, salary) values ('Bob', 75);
insert into Candidates (candidate, salary) values ('Cathy', null);
insert into Candidates (candidate, salary) values ('Debbie', 130);
insert into Candidates (candidate, salary) values ('Emma', 100);
insert into Candidates (candidate, salary) values ('Frank', null);
insert into Candidates (candidate, salary) values ('Greg', 200);
insert into Candidates (candidate, salary) values ('Helen', 50);

insert into Candidates_Skills (candidate, skill, years) values ('Ann', 'python', 3);
insert into Candidates_Skills (candidate, skill, years) values ('Ann', 'DB', 3);
insert into Candidates_Skills (candidate, skill, years) values ('Bob', 'python', 10);
insert into Candidates_Skills (candidate, skill, years) values ('Cathy', 'python', 5);
insert into Candidates_Skills (candidate, skill, years) values ('Cathy', 'C++', 4);
insert into Candidates_Skills (candidate, skill, years) values ('Cathy', 'DB', 8);
insert into Candidates_Skills (candidate, skill, years) values ('Debbie', 'python', 3);
insert into Candidates_Skills (candidate, skill, years) values ('Debbie', 'DB', 5);
insert into Candidates_Skills (candidate, skill, years) values ('Emma', 'Ruby', 5);
insert into Candidates_Skills (candidate, skill, years) values ('Emma', 'DB', 7);
insert into Candidates_Skills (candidate, skill, years) values ('Emma', 'C++', 4);
insert into Candidates_Skills (candidate, skill, years) values ('Helen', 'DB', 2);
