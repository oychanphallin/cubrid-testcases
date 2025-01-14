set system parameters 'create_table_reuseoid=no';
--test aggregate functions in subqueries of update statement in a view

autocommit off;

drop table if exists t1, t2;

create table t1(a int, b varchar(10), c int) 
partition by range(a) (
	partition p1 values less than(3),
	partition p2 values less than(6),
	partition p3 values less than(20)
);
create table t2(a int, b varchar(10), c int) partition by hash(a) partitions 3;

insert into t1 values(1, 'a', 1);
insert into t1 values(2, 'b', 1);
insert into t1 values(3, 'c', 2);
insert into t1 values(4, 'd', 2);
insert into t1 values(5, 'e', 3);
insert into t1 values(6, 'f', 3);
insert into t1 values(10, 'f', 4);
insert into t1 values(11, 'f', 4);

insert into t2 values(1, 'a', 100);
insert into t2 values(3, 'c', 100);
insert into t2 values(5, 'e', 200);
insert into t2 values(7, 'g', 200);
insert into t2 values(9, 'i', 300);

create view v1 as select * from t1 where a < 10 and c < 4; 

commit;

--test: 
update v1 ttt set c = (select avg(c) from v1 where a=ttt.a);  
select * from v1 order by 1, 2; 
rollback;

update v1 set c = (select sum(c) from t2 where a=v1.a); 
select * from v1 order by 1, 2;
rollback;

update v1 set c = (select count(v1.c) from t2 where b < 'f');  
select * from v1 order by 1, 2;
rollback;

update v1 set c = (select rank() over(partition by v1.b order by v1.a) from t2);
select * from v1 order by 1, 2;
rollback;

update t2 set a = (select avg(t2.c/100) from v1 where b in (select max(b) from t2));
select * from t1 order by 1, 2;
rollback;

update v1 set c = (select sum(v1.c) over(partition by b order by a) from t2 where c > 100);
select * from v1 order by 1, 2;
rollback;


drop view v1;
drop table t1, t2;

commit;
autocommit on;
set system parameters 'create_table_reuseoid=yes';
