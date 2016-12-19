-- [er]create a serial with an error that  MAXVALUE and MINVALUE is less than START WITH value

CREATE SERIAL ddl_0001_serial
START WITH 100000000000000000000000000000000001
INCREMENT BY 1
MINVALUE 10000000000000000000000000000000000
MAXVALUE 10000000000000000000000000000000003
NOCYCLE;





DROP SERIAL ddl_0001_serial;