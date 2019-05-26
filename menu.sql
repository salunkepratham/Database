use db49;
/*--procedure for add,sub,divs,mul--*/

delimiter //
create procedure calc(in x int ,in y int,out adds int,out sub int,out mul int,out divs int)
begin
set adds=x+y;
set sub=x-y;
set mul=x * y; 
set divs=x/y;
select adds,sub,mul,divs;
end//

call calc(4,2,@adds,@sub,@mul,@divs);
select @adds,@sub,@mul,@divs;
drop procedure calc;

/*----prime number---*/

delimiter //
create procedure prime(in x int)
begin
declare i int default 2;
declare flag int default 0;
while (i <= x/2) do
  if (x % i = 0) then 
   set flag=1;
   end if;
    set i=i+1;
end while;
if(flag=1) then
 select "Not Prime number";
else 
 select "Prime number";
end if;
end; //

call prime(6);

drop procedure prime;

/*----create table procedure--*/

delimiter //
create procedure table1 ()
begin
create table emp_test (e_id int,e_name varchar(10),e_join_date date);
end; //

call table1();
desc emp_test;

/*-----count no of vowels and consonants in string--*/

drop procedure vow_conso;
delimiter //
create procedure vow_conso (in str varchar(20))
begin
declare vow int default 0;
declare con int default 0;
declare i int default 1;
declare l int;
declare z varchar(5);
set l=length(str);
while (i <= l)
do
set z=substr(str,i,1);
if (z in ('a','e','i','o','u'))
then
set vow = vow + 1 ;
else
set con = con + 1;
end if;
set i=i+1;
end while;
select vow,con;
end; //

call vow_conso('status');


/*-------reverse of string ---*/
drop procedure rev_str;
delimiter //
create procedure rev_str(in str varchar(20))
begin
declare var varchar(20) default '';
declare l int;
set l=length(str);
while(l>=0) do
set var = concat(var,substr(str,l,1));
set l=l-1;
end while;
select var;
end; //

call rev_str('my name is pratham');

/*-----procedure to insert values into emp table--*/
select * from emp;
desc emp;
drop procedure insert_;

delimiter //
create procedure insert_(in num int,in nam varchar(10),in num1 int,in sal int,in man int)
begin
insert into emp values (num,nam,num1,sal,man);
end; //

call insert_(9,'ganesh',3,6000,null);

/*---update values in salary --*/
drop procedure update_;

delimiter //
create procedure update_(in sal int)
begin
update emp set salary=sal where emp_id=9;
end; //

call update_(1000);

/*---procedure to delete records--*/
select * from emp;

delimiter //
create procedure delete_(in num int)
begin 
delete from emp where emp_id=num;
end; //

call delete_(9);


/*--function---*/
select * from employee;

delimiter //
create function giveraise(oldval double, amount double) returns double
begin
	declare newval double;
    set newval = oldval * (1+ amount);
    return newval;
end; //

select name , salary ,giveraise(salary,1) as newsal from employee;

select * from dept;
delimiter //
create function usr_valid(num int) returns bool
begin 
	declare n int;
    select dept_id into n from dept where dept_id=num;
    if(n=num) then
		return True;
	else 
		return False;
	end if;
end; //

select usr_valid(9);

/*--cursor---*/
select * from deptsal;
update deptsal set totalsalary=0;

delimiter //
create procedure updatesal()
begin
	declare done int default 0;
    declare curr_num int;
    declare dcurr cursor for select dnumber from deptsal;
    declare continue handler for not found set done =1;
    
    open dcurr;
    
    repeat 
		fetch dcurr into curr_num;
        update deptsal
        set totalsalary = (select sum(salary) from employee where dno = curr_num)
        where dnumber = curr_num;
	until done
    end repeat;
    
    close dcurr;
end; //

call updatesal;

select * from employee;
drop procedure max_sal;

delimiter //
create procedure max_sal()
begin
	declare done int default 0;
	declare var int;
    declare myID int;
	/*select id,name,salary into tab from employee order by salary desc;*/
	declare maxx cursor for select salary,id from employee order by salary desc limit 2;
    declare exit handler for not found set done =1;
    
    open maxx;
    
    while(done=0) do
    
    fetch maxx into var, myID;
		/*if done then
			close maxx;
            leave label;
        end if;*/

		select id, name ,salary from employee where id=myId;
    end while;
    close maxx;
end; //
    
call max_sal;
select salary,id from employee order by salary desc limit 3;


desc employee
desc deptsal

/*-----create trigger ---*/
select * from deptsal;
delimiter //
create trigger update_salary
before update on employee
for each row
begin
	if old.dno is not null then
		update deptsal
		set totalsalary = totalsalary-old.salary
		where dnumber=old.dno;
		end if;
    if new.dno is not null then
		update deptsal
		set totalsalary = totalsalary + new.salary
		where dnumber = new.dno;
    end if;
end; //

update employee set salary =1000 where dno=2;
select * from employee;
select * from deptsal;
drop trigger update_salary;
;;;;;;;



create table emp_log(id int , salary int);
desc emp_log;

insert into emp_log  values(1,1000); 
select * from emp_log;
desc employee;
select * from employee;
delimiter //
create trigger insertdata after insert on employee
for each row
begin
		insert into emp_log values(new.id,new.salary);
end; //

select * from emp_log;

drop trigger insertdata;
insert into employee(id, name, salary) values(10,'shr',30000);
show index from employee;
drop index dno on employee;
show create table employee;
alter table employee drop foreign key employee_ibfk_1;