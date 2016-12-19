--inet_aton_ntoa_select_002.sql
SELECT INET_NTOA(167773449);
SELECT INET_ATON('10.0.5.9');

select (INET_NTOA(167773449)=('10.0.5.9'));
select (167773449=INET_ATON('10.0.5.9'));

--
SELECT INET_NTOA(167772170);
SELECT INET_ATON('10.0.0.10');

select (INET_NTOA(167772170)=('10.0.0.10'));
select (167772170=INET_ATON('10.0.0.10'));

--
SELECT INET_NTOA(2130706433);
SELECT INET_ATON('127.0.0.1');

select (INET_NTOA(2130706433)=('127.0.0.1'));
select (2130706433=INET_ATON('127.0.0.1'));

--
SELECT INET_NTOA(3724609023);
SELECT INET_ATON('222.1.5.255');

select (INET_NTOA(3724609023)=('222.1.5.255'));
select (3724609023=INET_ATON('222.1.5.255'));

--
SELECT INET_ATON('255.255.255.255');
SELECT INET_NTOA(4294967295);

select (INET_NTOA(4294967295)=('255.255.255.255'));
select (4294967295=INET_ATON('255.255.255.255'));

--
SELECT INET_ATON('0.255.255.255');
SELECT INET_NTOA(16777215);

select (INET_NTOA(16777215)=('0.255.255.255'));
select (16777215=INET_ATON('0.255.255.255'));

--
SELECT INET_ATON('255.0.255.255');
SELECT INET_NTOA(4278255615);

select (INET_NTOA(4278255615)=('255.0.255.255'));
select (4278255615=INET_ATON('255.0.255.255'));

--
SELECT INET_ATON('0.0.0.0');
SELECT INET_NTOA(0);

select (INET_NTOA(0)=('0.0.0.0'));
select (0=INET_ATON('0.0.0.0'));

--
SELECT INET_ATON('0.0.0.255');
SELECT INET_NTOA(255);

select (INET_NTOA(255)=('0.0.0.255'));
select (255=INET_ATON('0.0.0.255'));