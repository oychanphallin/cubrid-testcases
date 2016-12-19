autocommit off;
create class num ( a numeric(38,10))
insert into num values (0);
insert into num values (null);
insert into num values (9876543210987654321012345678.0123456789);
insert into num values (-9876543210987654321012345678.0123456789);
insert into num values (9876543210987654321012345678.0123456789);
insert into num values (-9876543210987654321012345678.0123456789);
insert into num values (5);
select a from num
select min(a), max(a) from num  
select min(a), max(a) from num group by a 
select min(cast(a as numeric(38,9))), max(cast(a as numeric(38,9))) from num
rollback work;
rollback;