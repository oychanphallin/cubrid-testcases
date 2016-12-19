-- string - date function with 'use_locale_date_format' system parameter
--+ holdcas on;
set names utf8;
set system parameters 'intl_number_lang = ja_JP';
set system parameters 'intl_date_lang = ja_JP';

select to_date ('2001-10-11');

select to_datetime ('10:11:12.123 AM 2001-10-11');

select to_timestamp ('10:11:12 AM 2001-10-11');

select to_time ('10:11:12');

select to_time ('10:11:12 AM');

select to_char (date'2001-10-11');

select to_char (datetime'10:11:12.123 AM 2001-10-11');

select to_char (timestamp'10:11:12 AM 2001-10-11');

select to_char (time'10:11:12 AM');

select to_char (time'10:11:12');




select to_date ('2001-10-11');

select to_datetime ('10:11:12.123 AM 2001-10-11');

select to_timestamp ('10:11:12 AM 2001-10-11');

select to_time ('10:11:12');

select to_time ('10:11:12 AM');

select to_char (date'2001-10-11');

select to_char (datetime'10:11:12.123 AM 2001-10-11');

select to_char (timestamp'10:11:12 AM 2001-10-11');

select to_char (time'10:11:12 AM');

select to_char (time'10:11:12');

set system parameters 'intl_date_lang = ja_JP';
set system parameters 'intl_number_lang = ja_JP';
set names iso88591;
commit;
--+ holdcas off;