-- this is the 3 module from the Meta Database Engineer Course --

SELECT * FROM table_nam WHERE column_nam IN	(value1, value2 ...)
SELECT * FROM table_nam WHERE column_nam NOT IN	(value1, value2 ...)

SELECT * FROM table_nam WHERE column_nam BETWEEN value1 AND value2

/*_ means one single character and % represents zero, one or more characters */
SELECT * FROM table_nam WHERE column_nam LIKE 'g__%' /**The name has only 4 chacaracters, starts with g and ends with 0 or 1*/
