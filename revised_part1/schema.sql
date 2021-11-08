drop table assigned;
drop table offer_by;
drop table with_details;
drop table have_examples;
drop table follow_constraints;
drop table language;
drop table comment;
drop table students;
drop table questions;
drop table departments;
drop table classes_instructed;
drop table professors;


create table questions(
	qid int primary key,
	difficulty int,
	title varchar(255) ,
	picture varchar(1024) ,
	question_content varchar(255) 
);

create table have_examples(
	eid int ,
	qid int ,
	primary key(eid,qid),
	input_content varchar(255) ,
	output_content varchar(255) ,
	foreign key(qid) references questions(qid) on delete cascade
);

create table follow_constraints(
	cid int ,
	constraints_content varchar(255) ,
	qid int ,
	primary key(cid,qid),
	foreign key(qid) references questions(qid) on delete cascade
);


create table students(
	sid int primary key,
	name varchar(255) ,
	pwd varchar(255) 
);

create table comment(
	sid int ,
	qid int ,
	time timestamp ,
	primary key(sid,qid),
	foreign key(sid) references students(sid),
	foreign key(qid) references questions(qid)
);

create table assigned(
	ddl timestamp ,
	sid int ,
	qid int ,
	primary key(sid,qid),
	foreign key(sid) references students(sid),
	foreign key(qid) references questions(qid)
);

create table language(
	lid int primary key,
	lname varchar(255) 
);

create table with_details(
	grade varchar(255) ,
	completion_date timestamp ,
	lid int ,
	sid int ,
	qid int ,
	primary key(lid,sid,qid),
	foreign key(sid) references students(sid),
	foreign key(qid) references questions(qid),
	foreign key(lid) references language(lid)
);

create table professors(
	pid int primary key,
	name varchar(255) ,
	pwd varchar(255) 
);

create table classes_instructed(
	cid int primary key,
	title varchar(255) ,
	pid int not null,
	foreign key(pid) references professors(pid)
);

create table departments(
	did int primary key,
	name varchar(255) 
);

create table offer_by(
	term varchar(255) ,
	cid int ,
	did int ,
	primary key(cid, did),
	foreign key(cid) references classes_instructed(cid),
	foreign key(did) references departments(did)
);





































