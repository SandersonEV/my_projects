-- ----------------------------------------------------------------------- QUERY OPTIMIZATION ---------------------------------------------------------------------------------
/*As a database engineer, you can assist the MySQL query optimizer by applying simple techniques such as:

- Avoiding the use of unnecessary columns in the SELECT clause.
- Avoiding the use of functions in predicates (WHERE clause conditions).
- Avoiding the use of leading wildcards in predicates, particularly with the LIKE operator.
- Using INNER JOIN instead of OUTER JOIN. 
- Using DISTINCT and UNION sparingly in SELECT queries. */

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Optimizing SELECT queries with the EXPLAIN statement
When a SELECT query is issued against a database, the MySQL Query Optimizer devises an optimal plan for query execution. You can see what this plan looks like by prefixing the query with EXPLAIN. 
The EXPLAIN statement provides information about how the query is executed. 

EXPLAIN SELECT column_name 
FROM table_name 
WHERE VALUE
*/

-- Too better understand this concept We'll use the meta_lucky_shrub database:

USE meta_lucky_shrub;
SELECT * FROM meta_lucky_shrub.clients;

EXPLAIN SELECT ContactNumber 
FROM Clients 
WHERE FullName='Jane Delgado'; -- This command explain the query 

/* Overview of the results:
- Column 01: ID. The ID column is a sequential identifier for each SELECT statement within the query. This piece of information is more meaningful when there are nested queries, or subqueries.
- Column 02: SELECT_TYPE. This column displays the type of SELECT query to be executed. (There are several types of select - SUBQUERY, UNION, UNION RESULT, DERIVED...)
- Column 03: Table. This column displays the name of the table referred to in the SELECT query. Lucky Shrub's SELECT query refers to the Clients table.
- Column 04: Partitions. This column displays the partition in which the data resides (the area of physical storage that's scanned). Partitioning allows for the distribution of portions of table data across the file system.
If the queries access only a fraction of table data, then there's less records to scan and queries can execute faster. However, partitioning is more meaningful when dealing with large data sets.
- Column 05: type. Scanning the table means performing a search operation or finding matches specified by the SELECT query. (all, system, index, full text, ref...)
- Column 06: possible_keys. This column shows the keys that can be used by MySQL to find rows from the table. However, these keys may or may not be used in practice. 
If the column value is NULL, then it indicates that no relevant indexes are found.
- Column 07: key. Indicates the actual index used by MySQL. 
- Column 08: key_len. This column indicates the length of the index the Query Optimizer chooses to use. For example, a key_len value of 4 means it requires memory to store four characters. 
- Column 09: ref. This column shows which table columns have been compared to the index to perform the search. A value of const means a constant, 
while a value of func means that the value that was used was derived from a function.
- Column 10: rows. Lists the number of records that were examined to produce the output.
- Column 11: filtered. This column indicates an approximate percentage of the number of table rows that have been filtered by a specified condition. The higher the percentage is, the better the performance of the query.
Column 12: Extra. Contains additional information regarding the query execution plan. Pay attention if there are values like  Using temporary or Using filesort in this column as they indicate a problematic query. 
Let's take a quick look at what these values mean.
*/

/* Planning a more efficient SELECT query
The use of an index on the required column, or columns, results in more efficient SELECT queries that processes records faster using less resources. */

-- when you perform the 'CREATE INDEX' you're creating a secondary index. A secondary index is and index that is created after the table and can be every column in the table
CREATE INDEX IdxFullName ON Clients(FullName); -- create the index in the columns that you frequentily perform searchs.

-- Now let's repeat the same command and observe the answer:
show columns from clients;

EXPLAIN SELECT ContactNumber 
FROM Clients 
WHERE FullName='Jane Delgado';

/* 
An indexed column’s data is stored in a separate location known as the index. The data is ordered according to type (for example numeric, alphabetical or date order).
Each piece of data in the index points to the original table row. By creating a relationship, or reference, between the index and table, it becomes easier and faster to search for data.

It is important to note that indexes may hinder the performance of data change queries (INSERT, UPDATE or DELETE queries) while improving the performance of SELECT queries. The reason for this is that when inserting, 
updating or deleting a row in a table, data also needs to be inserted, updated or deleted in the index as well. 
*/

