--test implicit type conversion of char type



create table char_conversion(
	col1 datetime,
	col2 date,
	col3 time,
	col4 timestamp,
	col5 double,
	col6 float,
	col7 numeric,
	col8 bigint,
	col9 int,
	col10 short,
	col11 monetary,
	col12 bit(30),
	col13 bit varying,
	col14 char(30),
	col15 varchar(30),
	col16 nchar(30),
	col17 nchar varying(30),
	col18 set,
	col19 multiset,
	col20 list,
	col21 sequence,
	col22 blob,
	col23 clob
);


insert into char_conversion values (
        datetime'11/09/2010 14:40:22.222',
        date'2010-11-9',
        time'14:40:44',
        timestamp'11/09/2010 14:40:22 PM',
        1234.56789,
        1234.567,
        1234.55555,
        12345678999,
        12345,
        123,
        12345.67,
        B'1010111',
        b'1100101',
        'abc',
        'aabbcc',
        n'abc',
        n'aabbcc',
        {1,2,3,4,5},
        {1,2,3,4,5},
        {1,2,3,4,5},
        {1,2,3,4,5},
        bit_to_blob(X'aabbc'),
        char_to_clob('aabbcc')
);


select col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21,blob_to_bit(col22),clob_to_char(col23) from char_conversion;


--[ok]datetime
update char_conversion set col1 = cast('11/08/2010 16:10:22.123' as char(30));
--[ok]date
update char_conversion set col2 = cast('11/08/2010 16:10:22' as char(30));
--[ok]time
update char_conversion set col3 = cast('11/08/2010 16:10:22' as char(30));
--[ok]timestamp
update char_conversion set col4 = cast('11/08/2010 16:10:22' as char(30));
select col1, col2, col3, col4 from char_conversion;

--[ok]double
update char_conversion set col5 = cast('1234654345.78623871' as char(30));
--[ok]float
update char_conversion set col6 = cast('23423.3423423' as char(30));
--[ok]numeric
update char_conversion set col7 = cast('754.123' as char(30));
--[ok]bigint
update char_conversion set col8 = cast('779238429347230' as char(30));
--[ok]int
update char_conversion set col9 = cast('7383724' as char(30));
--[ok]short
update char_conversion set col10 = cast('6372' as char(30));
--[ok]monetary
update char_conversion set col11 = cast('12342.9380' as char(30));
select col5, col6, col7, col8, col9, col10, col11 from char_conversion;

--[ok]bit
update char_conversion set col12 = cast('0b1010111' as char(30));
--[ok]varbit
update char_conversion set col13 = cast(B'1010111' as char(30));
select col12, col13 from char_conversion;

--[nr]char
update char_conversion set col14 = cast('11/08/2010 16:10:22.123' as char(30));
--[ok]varchar
update char_conversion set col15 = cast('11/08/2010 16:10:22.123' as char(30));
--[ok]nchar
update char_conversion set col16 = cast('11/08/2010 16:10:22.123' as char(30));
--[ok]varnchar
update char_conversion set col17 = cast('11/08/2010 16:10:22.123' as char(30));
select col14, col15, col16, col17 from char_conversion;

--[er]set
update char_conversion set col18 = cast('11/08/2010 16:10:22.123' as char(30));
--[er]multiset
update char_conversion set col19 = cast('11/08/2010 16:10:22.123' as char(30));
--[er]list
update char_conversion set col20 = cast('11/08/2010 16:10:22.123' as char(30));
--[er]sequence
update char_conversion set col21 = cast('11/08/2010 16:10:22.123' as char(30));
--[ok]blob
update char_conversion set col22 = cast('11/08/2010 16:10:22.123' as char(30));
select blob_to_bit(col22) from char_conversion;
--[ok]clob
update char_conversion set col23 = cast('11/08/2010 16:10:22.123' as char(30));
select clob_to_char(col23) from char_conversion;

select col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21,blob_to_bit(col22),clob_to_char(col23) from char_conversion;


delete from char_conversion;
drop table char_conversion;
	
