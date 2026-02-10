# Basic SQL and Joins
* SELECT allows you to select certain columns from a table, or you can use 'SELECT *' if you want every column from a table
* INNER JOIN returns all rows that match exactly from both the right and left table
* LEFT JOIN returns all rows from the left table and then only rows that match from the right table
* RIGHT JOIN returns all rows from the right table and then only rows that match from the left table. Right joins are not used too much in industry but they are here so that the language is mathematically complete i.e. symmetrical.
* FULL OUTER JOIN is not supported by MySQL; it returns literally everything from both tables
* You can join on certain conditions like a.id = b.id

# Aggregation and Group By
* Aggregation is basically truncatin the values from multiple rows into one super value. This is done through functions like MAX, MIN, AVG, SUM, etc.
* GROUP BY helps aggregation by truncating values based on a common attribute.
* HAVING clause allows you to filter these truncated values/groups.
* The HAVING clause is different than the WHERE clause because it filters based on the aggregations/group-by data, meanwhile
  the WHERE clause filters on a row by row basis. 

# DML and SubQuery
* DML stands for Data Manipulation Language. DML is any SQL statement that manipulates or returns data, like...
1. SELECT
2. UPDATE
3. DELETE
4. INSERT


# DDL, DataType, Constraints.
