:<< END
This test case verifies CBRD-26165 : SQL statement execution fails after COMMIT is executed inside a loop.
Test Scenarios:
    1. COMMIT inside a loop
    2. COMMIT via EXECUTE IMMEDIATE inside a loop
    3. COMMIT within a recursive call
END

#!/bin/bash
. $init_path/init.sh
init test

set -x

dbname=db_26165
cubrid deletedb $dbname

cubrid_createdb -r $dbname --db-volume-size=20M --log-volume-size=20M
cubrid server start $dbname
cubrid broker start

# Test Case 1: COMMIT inside a loop
# Expectation: All inserts succeed; COMMIT does not break the loop execution.
csql -u dba $dbname <<EOF > output_case1.log 2>&1
DROP TABLE IF EXISTS test_tbl;
CREATE TABLE test_tbl(id INT);
CREATE OR REPLACE PROCEDURE test_pl()
AS
    i INT DEFAULT 1;
BEGIN
    WHILE i <= 5 LOOP
        INSERT INTO test_tbl(id) VALUES(i);
        i := i + 1;

        IF i = 3 THEN
            COMMIT; 
        END IF;
    END LOOP;

    INSERT INTO test_tbl(id) VALUES(999); 
    COMMIT;
END;

CALL test_pl();
SELECT * FROM test_tbl ORDER BY id;
EOF

format_csql_output output_case1.log
# Verification
if [ $(grep -E "^[[:space:]]*(1|2|3|4|5|999)$" output_case1.log | wc -l) -eq 6 ]; then
    write_ok
else
    write_nok output_case1.log
fi

# Test Case 2: COMMIT via EXECUTE IMMEDIATE inside a loop
# Expectation: All inserts succeed; COMMIT via EXECUTE IMMEDIATE does not break the loop execution.
csql -u dba $dbname <<EOF > output_case2.log 2>&1
DROP TABLE IF EXISTS test_tbl;
CREATE TABLE test_tbl(id INT);

CREATE OR REPLACE PROCEDURE test_pl()
AS
    i INT DEFAULT 1;
BEGIN
    WHILE i <= 5 LOOP
        INSERT INTO test_tbl(id) VALUES(i);
        i := i + 1;

        IF i = 3 THEN
            EXECUTE IMMEDIATE 'COMMIT';  
        END IF;
    END LOOP;
   
    INSERT INTO test_tbl(id) VALUES(999);
    COMMIT;
END;

CALL test_pl();
SELECT * FROM test_tbl ORDER BY id;
EOF

format_csql_output output_case2.log
# Verification
if [ $(grep -E "^[[:space:]]*(1|2|3|4|5|999)$" output_case2.log | wc -l) -eq 6 ]; then
    write_ok
else
    write_nok output_case2.log
fi

# Test Case 3: COMMIT within a recursive call
# Expectation: 
# Recursive call succeeds.
# COMMIT inside recursive does not interrupt inserts.
# and the function returns 3.
csql -u dba $dbname <<EOF > output_case3.log 2>&1
DROP TABLE IF EXISTS ttt;
CREATE TABLE ttt(m INT);

CREATE OR REPLACE FUNCTION foo(n INT) RETURN INT AS
BEGIN
    RETURN NULL;
END;

CREATE OR REPLACE FUNCTION foo(n INT) RETURN INT AS
    r INT;
BEGIN
    IF n <= 0 THEN
        COMMIT;
        RETURN 0;
    END IF;

    FOR i IN 1..n LOOP
        INSERT INTO ttt VALUES (n);
        SELECT foo(n-1) INTO r;
        -- (*)
    END LOOP;

    RETURN n;
END;

SELECT foo(3);
EOF

format_csql_output output_case3.log
# Verification
if [ $(grep -E "^[[:space:]]*(3)$" output_case3.log | wc -l) -eq 1 ]; then
    write_ok
else
    write_nok output_case3.log
fi

cubrid server stop $dbname
cubrid deletedb $dbname

rm -rf $dbname
rm -rf *.log

finish