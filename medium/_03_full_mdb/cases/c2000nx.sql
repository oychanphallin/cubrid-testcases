autocommit off;
create class foo (x char(2000));
create index i_foo_x on foo(x);
insert into foo values ('xx');

--set optimization: level 257;
select count(*) from foo where x = 'xx';
insert into foo select '1' + trim(x) + trim(x) from foo; 
insert into foo select '2' + trim(x) + trim(x) from foo; 
insert into foo select '3' + trim(x) + trim(x) from foo; 
insert into foo select '4' + trim(x) + trim(x) from foo; 
insert into foo select '5' + trim(x) + trim(x) from foo; 
insert into foo select * from foo; 
select count(*) from foo where x = '54321xxxx1xxxx21xxxx1xxxx321xxxx1xxxx21xxxx1xxxx4321xxxx1xxxx21xxxx1xxxx321xxxx1xxxx21xxxx1xxxx'; 
select count(*) from foo where x = '12345xx'; 
select count(*) from foo where x > ' '; 
select count(*) from foo where x < '3'; 
update foo set x = '222' where x < '3';
select count(*) from foo where x = '222'; 
select count(*) from foo where x > '3' and x < '5'; 
delete from foo where x > '3' and x < '5'; 
select count(*) from foo where x > ' '; 
select count(*) from foo where x between '5' and '543'; 
update foo set x = '6' where x between '5' and '543'; 
select count(*) from foo where x = '6';  
select count(*) from foo where x between '5' and '5z'; 
delete from foo where x between '5' and '5z';
select count(*) from foo where x between '5' and '5z'; 
select count(*) from foo where x > ' '; 
delete from foo where x > '6'; 
select count(*) from foo where x > ' '; 
select count(*) from foo where x <= '6'; 
delete from foo where x = '6';
select count(*) from foo where x > ' '; 
update foo set x = trim(x) + 'the end of the line' where x = '222';
select count(*) from foo where x = '222the end of the line'; 
delete from foo where x = '222the end of the line'; 
select count(*) from foo where x > ' '; 

drop foo;

rollback;