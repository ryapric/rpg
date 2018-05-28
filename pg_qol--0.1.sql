-- Pass a date field to return a year/month field.
-- Useful for time-series monthly aggregation or labelling
-- Default delimiter is '-', i.e. returns '2018-05'
CREATE OR REPLACE FUNCTION year_month(date_field date, delim varchar(3) = '-')
RETURNS VARCHAR AS
$BODY$
BEGIN
	RETURN (extract(year from date_field)::varchar(4) || delim || lpad(extract(month from date_field)::varchar(2), 2, '0'));
END;
$BODY$
LANGUAGE 'plpgsql';
