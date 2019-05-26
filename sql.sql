/*----like---*/
select * from employee;
select * from employee where name like "bob";
select * from employee where name like "b%";
select * from employee where name like "bo_";
select * from employee where name like "%b";
select * from employee where name like "%om";

/*---relationnal operator----*/

select * from books;
select * from books where cost > 450;
select * from books where cost  >=450;
select * from books where cost < 450;
select * from books where cost <= 450;
select * from books where cost = 450;
select * from books where cost != 450;
select * from books where cost > 450 and cost <600;
select * from books where cost < 400 or category = "database";
select * from books where cost <> 300;

/*---update---*/
update books set category = "rdbms" where book_no = 101;
/*--truncate---*/
select * from deptsal;
truncate table deptsal;

select * from issue;
delete from issue where book_no = 104;

/*---autocommit on/off--*/
show local variables like 'autocommit';
set autocommit=on;

/*-----to rolled back--*/
commit;
savepoint back;
insert into issue  values (7002, 102 ,3, "2016-05-09",null);
savepoint back1;
savepoint back2;
rollback;
insert into issue  values (7002, 102 ,3, "2016-05-09",null);
insert into issue  values (7005, 105 ,2, "2015-07-08",null);
update issue set book_no=null where lib_issue_id=7005;
delete from issue where lib_issue_id=7002;
select * from issue;

/*----null operator--*/
select * from issue where return_date is null;
update issue set return_date = "2016-09-08" where lib_issue_id=7001;
select * from issue where return_date is not null;

/*----in/not in operator--*/
select * from issue where book_no in (102,105);
select * from issue where book_no not in (102,105);

/*---copying table/data---*/

drop table issue_copy;
drop table issue_copy1;

create table issue_copy as select * from issue;
select * from issue_copy;
select * from issue;
create table issue_copy1 as select * from issue where book_no=102;
select * from issue_copy1;
/*------------copy data--*/

insert into issue_copy1 select *from issue where book_no=101;
-----------------------------------------

select * from department;
select * from deptsal;
insert into deptsal values (1,1000),(2,585476),(3,378743),(4,85829);

/*---inner join---*/
select * from department join deptsal on department.dnumber=deptsal.dnumber;
/*----join---*/
select dname,totalsalary from department , deptsal where department.dnumber=deptsal.dnumber;
/*---left outer join----*/
select dname,totalsalary from department left outer join deptsal on department.dnumber=deptsal.dnumber;
/*---right outer join--*/
select dname,totalsalary from department right outer join deptsal on department.dnumber=deptsal.dnumber;

/*----subqueries---*/
select * from deptsal;
select * from department;

select * from deptsal where dnumber >(select dnumber from department where dname="Payroll");

/*---union---*/
select * from deptsal union select * from department;
select dname from department union select totalsalary from deptsal;

/*---view---*/
select * from books;
create view sam as select * from books;
select * from sam;

/*----alias--*/
select * from books as tab where tab.book_no=102;
/*----rename table--*/
alter table issue_copy1 rename iss;

/*--rename column name--*/
select * from books;
alter table books change column cost price int;