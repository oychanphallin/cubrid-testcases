/*
Test Case: delete & select
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/no_index_column/basic_sql/delete_select_01.ctl
Author: Lily

Test Point:
1. can see committed change made by a transaction which was over before start of current transaction.


NUM_CLIENTS = 2
C1: DELETE FROM tb1 WHERE name='Jonh'; 
C1: commit;
C2: SELECT * FROM tb1 ORDER BY dept_id,name;
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: CREATE TABLE tb1(dept_id INT NOT NULL, name VARCHAR(20), sex ENUM('F', 'M') );
C1: INSERT INTO tb1 VALUES(101,'Jonh','M');
C1: INSERT INTO tb1 VALUES(102,'Lucy','F');
C1: INSERT INTO tb1 VALUES(102,'Tom','M');
C1: INSERT INTO tb1 VALUES(101,'Mike','F');
C1: INSERT INTO tb1 VALUES(102,'Jonh','M');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: DELETE FROM tb1 WHERE name='Tom';
C1: SELECT * FROM tb1 ORDER BY dept_id,name;
C1: commit work;
MC: wait until C1 ready;
/* expect 4 rows */
C2: SELECT * FROM tb1 ORDER BY dept_id,name;
MC: wait until C2 ready;
C2: commit work;

C2: quit;
C1: quit;
