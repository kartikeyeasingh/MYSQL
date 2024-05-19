-- create db
create database db1;

-- show db
show databases;

-- use db
use db1;

-- create table
create table emp_tab
	(
    id int primary key auto_increment,
    name varchar(255) not null,
    age int
    );
    
-- show table    
show tables;

-- desc table
desc emp_tab;

-- add column
alter table emp_tab
	add loc varchar(255);

-- modify column
alter table emp_tab
	modify loc varchar(255) not null;

-- drop column
alter table emp_tab
	drop column loc;

-- rename column
alter table emp_tab
	change id ID int auto_increment;

-- rename table
alter table emp_tab
	rename to tab1;

-- insert values
insert into tab1 (name, age)
	values
    ('rohit', 21),
    ('mohit', 23),
    ('Suman', 21);

-- show columns
select * from tab1;

-- truncate table
truncate table tab1;

-- drop table
drop table tab1;

create table stu
	(
    id int auto_increment primary key,
    name varchar(255),
    age int,
    city int
    );
insert into stu (name, age, city)
	values
    ('arun', 23, '1'),
    ('bablu', 24, '2'),
    ('chiku', 23, '3');
    
create table cit
	(
    cid int auto_increment primary key,
    city_name varchar (255)
    );
insert into cit (city_name)
	values
	('chennai'),
    ('bombay'),
    ('ahmedabad');
    
-- create view
create view stu_data
	as
	select id, name, age, city_name
	from stu s inner join cit c
	on s.city = c.cid;

-- show columns
select * from stu_data;

-- drop view
drop view stu_data;

-- update table data
set sql_safe_updates = 0;

update stu
	set age = 32
	where name = 'arun';

-- replace table data
replace into stu (id, city)
	values 
    (2, '5');
    
-- delete table data
delete from stu
	where age = 32;

set sql_safe_updates = 1;

create table stu_new
	(
    id int auto_increment primary key,
    name varchar(255),
    dob date
    );
insert into stu_new (name, dob)
	values
    ('mohit', '2003-05-03'),
	('rohit', '2001-02-04'),
	('mohan', '2002-03-05'),
	('menu', '2002-01-06'),
	('pritam', '2001-02-07'),
	('shyam', '2002-07-08'),
	('rahul', '2001-09-09'),
	('parul', '2003-04-10'),
	('kangana', '2001-01-11');
    
select * from stu_new
	where dob = '2001-09-09';
    
-- create index
create index stu_ind on stu_new (name);

-- show index
show index from stu_new;

-- drop index
drop index stu_ind on stu_new;

-- % wildcard
select * from stu_new
	where name like 'm%';
    
-- _ wildcard
select * from stu_new
	where name like '_ohit';
    
create table emp
	(
    id int,
    name varchar (255),
    boss int
    );
insert into emp
	values
	(1001, 'ram', 1),
    (1002, 'shyam', 1),
    (1003, 'mohan', 3),
    (1004, 'radha', 4),
    (1005, 'rahul', 2);

create table boss
	(
    id int,
    name varchar (255)
    );
insert into boss
	values
    (1, 'preetam'),
    (2, 'ganga'),
    (3, 'mohit');

-- join
select *
	from emp e
    join boss b
    on e.boss = b.id;
    
-- union
select name from emp
	union
    select name from boss;

create table sch
	(
    id int,
    name varchar (255)
    );
 
 -- start transaction
 start transaction;
 
 insert into sch
	values
    (1, 'ram'),
    (2, 'shyam');
select * from sch;

-- commit
set autocommit = 0;
commit;

-- savepoint
savepoint one;
insert into sch
	values
    (3, 'luv'),
    (4, 'kush');
savepoint two;
select * from sch;

-- rollback
rollback to one;
select * from sch;

create table cus
	(
    id int,
    name varchar(255),
    age int
    );
insert into cus
	values
    (1, 'rohan', 32),
    (2, 'varun', 34),
    (3, 'hritik', 32),
    (4, 'pritam', 25),
    (5, 'savouik', 31);
    
-- create procedure
delimiter //
create procedure getcus (in cusage int)
	begin
	select * from cus where age = cusage;
	end //

-- call procedure
call getcus(32); 

-- create trigger
delimiter //
create trigger tri1
	before insert on cus for each row
	begin
	if new.age < 25 then set new.age = 0;
	end if;
	end //

-- invoke trigger
insert into cus
	values
    (9, 'indrapreet', 21);
    
-- drop trigger
drop trigger tri1;

create table sal
	(
    name varchar (255),
    year int,
    sales int
    );
insert into sal
	values
    ('a', 2001, 10000),
    ('b', 2002, 10030),
    ('c', 2003, 20200);

-- lag and lead function
select name, year, sales,
	lag (sales) over (order by year) 'pre_y_sal',
    lead (sales) over (order by year) 'nex_y_sal'
    from
    sal;