CREATE TABLE t1 (i1 INT);
INSERT INTO t1 VALUES (1),(-2147483648),(2147483647),(-2147483648),(2147483647);;
ALTER TABLE t1 CHANGE i1 s1 CHAR(4);
SELECT * FROM t1 order by 1;
DROP TABLE t1;

CREATE TABLE t1 (i1 INT);
INSERT INTO t1 VALUES (1),(-2147483648),(2147483647),(-2147483648),(2147483647);;
ALTER TABLE t1 CHANGE i1 s1 VARCHAR(4);
SELECT * FROM t1 order by 1;
DROP TABLE t1;

CREATE TABLE t1 (i1 INT);
INSERT INTO t1 VALUES (1),(-2147483648),(2147483647),(-2147483648),(2147483647);;
ALTER TABLE t1 CHANGE i1 s1 NCHAR(4);
SELECT * FROM t1 order by 1;
DROP TABLE t1;

CREATE TABLE t1 (i1 INT);
INSERT INTO t1 VALUES (1),(-2147483648),(2147483647),(-2147483648),(2147483647);;
ALTER TABLE t1 CHANGE i1 s1 NCHAR VARYING(4);
SELECT * FROM t1 order by 1;
DROP TABLE t1;