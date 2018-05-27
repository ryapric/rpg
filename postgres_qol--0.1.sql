CREATE OR REPLACE FUNCTION year_month(date_field date, delim varchar(3))
RETURNS VARCHAR(7) AS
$BODY$
BEGIN
	RETURN (extract(year from date_field)::varchar(4) || '-' || lpad(extract(month from date_field)::varchar(2), 2, '0'));
END;
$BODY$
LANGUAGE 'plpgsql';
