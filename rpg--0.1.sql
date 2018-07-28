/*
This function is passed a `DATE` field and an optional delimiter, and returns a
`TEXT` field representing the parsed year/month value. The default delimiter
is '-', and so will return year/months as e.g. '2018-01'.
*/
CREATE OR REPLACE FUNCTION year_month (
    date_field DATE,
    delim TEXT = '-')
RETURNS TEXT AS
$BODY$
BEGIN
    RETURN (
        extract(year FROM date_field)::TEXT(4) ||
        delim ||
        lpad(extract(month FROM date_field)::TEXT(2), 2, '0'));
END;
$BODY$
LANGUAGE 'plpgsql';

/*
This function returns an array containing the letters of the English alphabet. It defaults to
returning the lowercase letters (a-z), but passing 'upper' as its argument
returns uppercase letters instead (A-Z).
*/
CREATE OR REPLACE FUNCTION letters (letter_case TEXT = 'lower')
RETURNS TEXT[] AS
$BODY$
DECLARE
    letters_lowercase TEXT[] = ARRAY['a', 'b', 'c', 'd', 'e', 'f', 'g',
                                     'h', 'i', 'j', 'k', 'l', 'm', 'n',
                                     'o', 'p', 'q', 'r', 's', 't', 'u',
                                     'v', 'w', 'x', 'y', 'z'];
    letters_uppercase TEXT[] = ARRAY['A', 'B', 'C', 'D', 'E', 'F', 'G',
                                     'H', 'I', 'J', 'K', 'L', 'M', 'N',
                                     'O', 'P', 'Q', 'R', 'S', 'T', 'U',
                                     'V', 'W', 'X', 'Y', 'Z'];
BEGIN
    CASE letter_case
        WHEN 'lower' THEN RETURN letters_lowercase;
        WHEN 'upper' THEN RETURN letters_uppercase;
    END CASE;
END;
$BODY$
LANGUAGE 'plpgsql';


/*
bind_rows(tbl_out TEXT, tbl_a TEXT, tbl_b TEXT)
This function provides a means to perform a `UNION ALL` query on two tables with
different numbers of columns, without the need to create "dummy" columns during
the respective `SELECT` queries (as this can get quite verbose when there exist
multiple columns). This should provide mos of the functionality of R's
`dplyr::bind_rows()` function.
Conditions are that:
    - All arguments must be passed as strings
    - Both referenced tables to row-bind already exist (can be temp tables)
    - 
*/

CREATE OR REPLACE FUNCTION bind_rows (tbl_out TEXT, tbl_a TEXT, tbl_b TEXT)
RETURNS VOID AS
$BODY$
DECLARE
    cols_a TEXT;
    cols_b TEXT;
    stmt_out TEXT;
BEGIN
    SELECT INTO cols_a (
        SELECT string_agg(column_name, ', ' ORDER BY column_name)
        FROM information_schema.columns
        WHERE table_name = tbl_a);
        raise notice '%', cols_a;
    SELECT INTO cols_b (
        SELECT string_agg(column_name, ', ' ORDER BY column_name)
        FROM information_schema.columns
        WHERE table_name = tbl_b);

    stmt_out =
    'SELECT ' || cols_a || ' FROM ' || tbl_a ||
    ' UNION ALL ' ||
    'SELECT ' || cols_b || ' FROM ' || tbl_b;

    EXECUTE format('CREATE TABLE %s AS (%s)', tbl_out, stmt_out);
END;
$BODY$
LANGUAGE 'plpgsql';
