/*----------create primary key in new tabel*/
create table dept(dept_id int not null ,dept_name varchar(30) not null,primary key(dept_id));

/*-----create foriegn key in new table--*/
create table emp(emp_id int not null, emp_name varchar(30) not null,
				dept_id int,foreign key(dept_id)  references  dept(dept_id));

/*-------add column*/
alter table emp add column (salary int,manager int);

/*--------insert values in dept*/
insert into dept values(1,'finace'),(2,'training'),(3,'marketing');
select * from dept;

/*-------delete two column in single command*/
alter table dept drop column salary,drop manager ;
desc emp;
desc dept;
drop table emp;

insert into emp values (1,'Arun',1,8000,4),(2,'kiran',1,7000,1),(3,'Scott',1,3000,1);
insert into emp values (4,'Max',2,9000,null),(5,'jack',2,8000,4),(6,'king',null,6000,1);
select * from emp;
select * from books;

/*---order by*/
select * from books order by author_name;
select * from books order by book_name desc;

/*----group by will group and show*/
select dept_id ,sum(salary) from emp group by dept_id;
select dept_id,sum(salary) from emp where salary <= 6000 group by dept_id;

/*---group by ...having ---*/
select dept_id,sum(salary) from emp group by dept_id having sum(salary) <6000;

select * from emp;
select * from dept;
desc emp;
desc dept;
alter table emp add primary key(emp_id);

insert into emp values (8,'hulk',null,1000,5);
insert into dept values (4,'sale');
show create table emp;
use db49;

/*----drop foreign key-*/
alter table emp drop foreign key emp_ibfk_1;

/* --show the constraint of the table--*/
show create table emp;

/*---drop the primary key--*/
alter table dept drop primary key;

select * from dept;
select * from emp;
/*---join*/
select dept_name ,emp_name,salary from dept,emp where dept.dept_id=emp.dept_id;
select dept_name,emp_id,emp_name,salary,manager from dept,emp where dept.dept_id=emp.dept_id;

/*----left join--?*/
select emp_name,dept_name from emp left outer join dept on emp.dept_id=dept.dept_id;

/*---right join--*/
select emp_name,dept_name from emp right outer join dept on emp.dept_id=dept.dept_id;
use db49;
select emp_name ,manager from emp;
select emp_name from emp a where manager=a.manager; 
select emp_name ,dept_name from emp join dept on dept.dept_id=emp.dept_id;

/*-----union---*/
create table emp1(emp_no int,emp_name varchar(10));
create table emp2(emp_no int,emp_name varchar(10));

insert into emp1 values (1,'A'),(2,'B'),(3,'C');
insert into emp2 values (1,'A'),(2,'B'),(4,'D'),(5,'E');

drop table emp1;
select * from emp1;
select * from emp2;

select emp_no from emp1 union select emp_name from emp2;

select * from emp;
select * from dept;

/*---sub-queries--*/
select salary from emp where salary=(select salary from emp where emp_name='Arun');
select emp_name from emp where dept_id=(select dept_id from emp where emp_name='jack');
select emp_name from emp where salary=(select min(salary) from emp);
update emp set salary = 15000 where dept_id=
(select dept_id from(select dept_id from emp where emp_name='Max')emp);