use qwerty;

delimiter //
create procedure prime(in x int)
begin
declare i int;
declare flag int default 0;
set i=2;
label1: loop
while (i <= x/2) do
  if (x mod i = 0) then 
   set flag=1;
   leave label1;
  else 
    set i=i+1;
end if;
end while;
end loop;
if(flag=1) then
 select "Not Prime number";
else 
 select "Prime number";
end if;
end; //

call prime(3);

drop procedure prime;
