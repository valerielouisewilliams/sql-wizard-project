Exam 1 Practice

1️⃣ Relational Algebra & Expression Trees
Definitions
1. What is relational algebra?
    1. Relational algebra is a way to mathematically/functionally describe the relating of sets of data
2. Why is relational algebra considered procedural?
    1. Relational algebra is considered procedural because you are doing each step one at a time
3. What is a relation in relational algebra?
    1. A relation in relational algebra is basically the equivalent of a table in actual SQL. It contains attributes + data types
4. What is an expression tree?
    1. An expression tree in the context of relational algebra shows us the order in which the expressions are done
5. What does each node in an expression tree represent?
    1. Each node in an expression tree represents an operation or a relation
6. Why are expression trees useful in query optimization?
    1. Expression trees are useful because it allows us to see the order in which an operation is ran and to see if there can be any equivalences made to other operations in order to speed up the query

Core Operators
1. What does selection (σ) do?
    1. Selection shows data from a relation
2. What does projection (π) do?
    1. Projection filters data from a relation
3. What does rename (ρ) do?
    1. Rename aliases a subset of data from ar elation
4. What does the Cartesian product (×) produce?
    1. Cartesian product produces every combination of data in a relation
5. What does join (⨝) do?
    1. Join combines the data from different relations
6. What is the difference between natural join and theta join?
    1. Natural join will join on a common attribute where as a theta join is more specific in that you can join on differing attributes and make comparisons using relational operations
7. What is the difference between selection and join conditions?
    1. 
8. What happens if you perform a Cartesian product without selection?
    1. You will literally get every combination of data from the relations that you are selecting the product of

Conceptual Understanding
1. Why is projection often applied after selection?
    1. Projection is applied after selection so that you have data to filter on in the first place
2. Why is pushing selection down the expression tree an optimization?
    1. Because it is more computationally heavy than most operations since it returns a lot of data
3. How do joins reduce the size of intermediate relations?
    1. Joins can reduce the size of intermediate relations when you join on good attributes
4. How do expression trees help DBMS optimize SQL queries?
    1. Expression trees can help with rearranging the query while maintaining the results

Translation & Reasoning
1. Translate a relational algebra expression into plain English
2. Translate an English query into relational algebra
3. Explain how a JOIN in SQL maps to relational algebra
4. Given two equivalent expression trees, explain why one is more efficient

2️⃣ Basic SQL & Joins
SQL Fundamentals
1. What is the purpose of the SELECT clause?
    1. The select clause allows you to specify exactly what data you want from a table
2. What does the FROM clause specify?
    1. The from clause specifies what table/data (because you can join multiple tables) you want to use in your query
3. When is the WHERE clause applied?
    1. The where clause is applied after the SELECT and FROM clause
4. What is the difference between WHERE and HAVING?
    1. WHERE makes a comparison on all of the data in the table and HAVING makes a comparison on what you are grouping by
5. What is an alias and why is it useful?
    1. An alias is basically a nickname for a table and it is useful when you have attributes from different tables that have the same name or when you are joining a table with itself

Join Types
1. What does an INNER JOIN return?
    1. An inner join returns only whatever the left and right table have in common
2. What does a LEFT JOIN return?
    1. A left join returns everything from the left table and then only what the right table has in common with it
3. What does a RIGHT JOIN return?
    1. A right join returns everything from the right table and then only what the left table has in common with it
4. What is a FULL OUTER JOIN?
    1.  A full outer join returns literally everything and is not even supported in MYSQL
5. Why does MySQL not support FULL OUTER JOIN?
    1. It is very computationally heavy and not needed 
6. How can FULL OUTER JOIN be simulated in MySQL?
    1. You can do a left join and a right join on the same tables
7. What is a CROSS JOIN?
    1. A cross join is essentially the same thing as the cross product in relational algebra
8. What happens if a JOIN condition is missing?
    1. When a join condition is missing, the tables will be joined on a common attribute

Join Reasoning
1. How does a foreign key enable joins?
    1. A foreign key enables joins because a foreign key basically tells SQL how data in one table relates to another
2. What happens when a LEFT JOIN is followed by a restrictive WHERE clause?
    1. Then the left join is essentially an inner join
3. How can you find rows that do not have matches in another table?
    1. Use a left join with a where clause that checks for a null value on the right table
4. Why is INNER JOIN more restrictive than LEFT JOIN?
    1. All of the data must match and it only returns rows with a match in BOTH tables, it does not return all data from either or table unless it matches
5. When would a RIGHT JOIN be logically equivalent to a LEFT JOIN?
    1. When you are joining a table with itself
    2. When you swap the tables and keep the same join condition
    3. Right joins are normally never used in industry and is just here to make the language mathematically symmetrical

3️⃣ Aggregation & GROUP BY
Definitions
1. What is aggregation?
    1. Aggregation is the grouping of numbers in some way, like averaging or summing; combining multiple rows into a single value
2. What does GROUP BY do conceptually?
    1. GROUP BY groups rows by common attributes, and then applies aggregation separately to each grop
3. What does the COUNT function do?
    1. Count function counts how many rows EXIST for a given attribute
4. What is the difference between COUNT(*) and COUNT(column)?
    1. COUNT(*) counts every row in the database, it also includes rows with NULL
    2. COUNT(column) counts only a specific column, it also does NOT include rows with a NULL value for the specified column
5. What do SUM, AVG, MIN, and MAX return?
    1. Sum returns the sum of the data for a specified attribute
    2. Average returns the average of the data for a specified attribute
    3. Min returns the minimum of the data for a specified attribute
    4. Max returns the maximum of the data for a specified attribute

Rules & Constraints
1. What columns are allowed in the SELECT clause when using GROUP BY?
    1. You need to have every column in your GROUP BY clause also be in your SELECT clause, and nothing else except aggregate columns 
2. Why must non-aggregated columns appear in GROUP BY?
    1. Because each group produces a single output row and any non-aggregated column must have an unambiguous value per group
3. What happens if you violate GROUP BY rules?
    1. Your query will not run
4. What does HAVING filter that WHERE cannot?
    1. It filters your groups; WHERE filters each individual row.
5. When is HAVING evaluated relative to GROUP BY?
    1. It is evaluated after GROUP BY

Reasoning & Pitfalls
1. Why can’t WHERE be used with aggregate conditions?
    1. WHERE filters each individual row, and since grouping essentially collapses multiple rows into one aggregate value, it is impossible and just not needed to filter each individual row when you collapse it. Thus, we use HAVING to filter the collapsed rows by something.
2. Why is HAVING often slower than WHERE?
    1. HAVING is slower than WHERE because in order to use HAVING you have to aggregate rows and group them which is more computationally expensive than simply going row to row checking for a condition
3. How does GROUP BY affect the number of rows returned?
    1. GROUP BY partitions the data into specific groups which truncates the number of rows returned since they are essentially all being combined into mini cliques
4. Explain grouping with a real-world example
    1. Let's say you have a group of models
    2. Each model has a different hair color
    3. You want to group the models by their hair color, so brunettes go into one room, blondes go into another room, and redheads go into another room (GROUP BY)
    4. Now, we want to get a single value from each room (like how many models we have for each hair color) (AGGREGATING)
    5. And now, we only want hair colors that have at least 10 models in that room (HAVING)
5. How do joins interact with GROUP BY?
    1. FROM / JOIN -> Tables are joined and rows are combined
    2. WHERE -> Row level filtering happens
    3. GROUP BY -> Remaining rows after the WHERE are grouped
    4. HAVING -> Group level filtering happens
    5. SELECT -> Final columns are produced
    6. NOTE: Group By never groups tables, it groups rows after the join. If a join creates duplicate rows, those duplicates affect aggregation

4️⃣ DML & Subqueries
DML Basics
1. What does DML stand for?
    1. Data Manipulation Language
2. What SQL statements are considered DML?
    1. Select, insert, update, delete. 
    2. Anything that manipulates data in some way
    3. Select retrieves, insert adds new data, update modifies data, and delete removes the data
3. What is the difference between INSERT and INSERT INTO ... SELECT?
    1. INSERT has you specify the values to add
    2. INSERT INTO ... SELECT allows you to insert data from one table into another, and you get the data from the other table by using a select statement
4. What does UPDATE modify?
    1. UPDATE modifies a row but it can also modify a specific attribute like change its name or data type
5. What does DELETE remove?
    1. DELETE removes a whole row or multiple rows from a table

Subquery Concepts
1. What is a subquery?
    1. A subquery is a query that is inside query
    2. The subquery (i.e. inner query) is executed first before its parent query

Operators & Logic
1. What does IN do in a subquery?
    1. IN in a subquery checks if a value is inside a list basically
2. What does EXISTS check?
    1. Exists checks if a relationship is true/exists
3. What is the difference between IN and EXISTS?
    1. You use IN when you are checking if something is inside of a small list and you use EXIST when you are checking if a relationship between two rows exists (example when you are checking for a foreign key and primary key relationship i.e. checking a relationship between different tables)
4. What does ANY mean?
    1. ANY checks if a condition is true for at least one value in a subquery
5. What does ALL mean?
    1. ALL checks if a condition is true for every single value in a subquery

Reasoning & Errors
1. Why does NOT IN behave unexpectedly with NULLs?
2. When does a correlated subquery execute?
3. How can a subquery be rewritten as a join?
4. When should a subquery NOT be used?
5. What happens if a subquery returns more rows than expected?

5️⃣ DDL, Data Types & Constraints
DDL Basics
1. What does DDL stand for?
    1. Data Definition Language
2. Which SQL commands are DDL?
    1. CREATE, ALTER, DROP, TRUNCATE 
3. What does CREATE TABLE do?
    1. Creates a table inside a database
4. What does DROP TABLE do?
    1. Deletes a table in a database
5. What does ALTER TABLE allow you to change?
    1. Allows you to add or change primary keys
    2. Allows you to change the names of attributes
    3. Allows you to change the data types of attributes

Data Types
1. What is the difference between INT and BIGINT?
    1. INT goes up to 2^32, BIGINT goes up to 2^64
2. When should VARCHAR be used instead of CHAR?
    1. VARCHAR(len) is used when your data will have a varying number of characters, i.e. variable length string. The length can be UP TO whatever is specified inside the parentheses.
    2. CHAR(len) is used when your data will have a fixed number of characters, and it will 100% have the number of characters specified inside the parentheses 
3. What is the purpose of DECIMAL?
    1. DECIMAL(X,Y) allows you to specify the amount of numbers before and after the decimal point
4. Why is FLOAT dangerous for money?
    1. Its behavior is not predictable during calculations, rounding can be incorrect and this is not good when dealing with money
5. What does DATE store vs DATETIME?
    1. Date only stores the date in YYYY-DD-MM
    2. DATETIME stores the data and the time like YYYY-DD-MM 00:00:00

Constraints
1. What is a constraint?
    1. A constraint is a rule that an attribute in the table must follow 
2. What does PRIMARY KEY enforce?
    1. Primary key is a way to identify unique rows of data in one table
3. What does FOREIGN KEY enforce?
    1. Foreign key is a way to relate data from one table to data inside another table
    2. JOINS are usually done on primary keys, foreign keys
4. What is referential integrity?
    1. Referential integrity ensures that there are no dangling pointers
    2. Constraints help enforce referential integrity 
5. What does UNIQUE enforce?
    1. UNIQUE enforces that an attribute is unique and cannot be used again, this is especially useful for PKs (primary keys)
6. What does NOT NULL enforce?
    1. Enforces a value exists i.e. not being null
7. What does CHECK enforce?
    1. Enforces a boolean value essentially, this can be anything like x > 100 or x < 100.
8. What is DEFAULT used for?
    1. When a value is not specified, we can use the DEFAULT keyword to make the value equal to whatever comes after the DEFAULT keyword

Constraint Behavior
1. What happens when a PRIMARY KEY constraint is violated?
2. What happens when a FOREIGN KEY constraint is violated?
3. What does ON DELETE CASCADE do?
4. What does ON DELETE SET NULL do?
5. What is the difference between RESTRICT and CASCADE?


