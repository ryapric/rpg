/*
This function is passed a `DATE` field and an optional delimiter, and returns a
`VARCHAR` field representing the parsed year/month value. The default delimiter
is '-', and so will return year/months as e.g. '2018-01'.
*/
CREATE OR REPLACE FUNCTION year_month (
    date_field DATE,
    delim VARCHAR = '-')
RETURNS VARCHAR AS
$BODY$
BEGIN
    RETURN (
        extract(year FROM date_field)::VARCHAR(4) ||
        delim ||
        lpad(extract(month FROM date_field)::VARCHAR(2), 2, '0'));
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
