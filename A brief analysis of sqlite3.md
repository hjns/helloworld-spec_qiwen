### Overview

SQlite is a lightweight, open source, embedded relational database.

Good portability, simple to use, small, efficient, no network required.

### Software Environment

Ubuntu 18.04 、sqlite3 

### Download and install

Install

```
sudo apt-get install sqlite3
```

View version information

```
sqlite3 -version
```

### Database field type

### Ubuntu command line using sqlite3

The sqlite library includes a sqlite3 command line that allows users to manually enter and execute sqlite database SQL commands.

Open a database, or create one if it does not exist

```
sqlite3 [database name.db]
eg:
sqlite3 department.db
```

Create a table in the database

```c
creat table [table name]
(	
	[column name 1] [data type] ["constraint"],
	[column name 2] [data type] ["constraint"],
	...
	[column name n] [data type] ["constraint"]
);
eg:
CREATE TABLE library(
	number int "primary key",
	name varchar "not null",
	price real "default",
	type text "not null",
	amount int "not null"
);
```

Deleting a table

```c
drop table [Table name];
eg:
drop table library;
```

Modify the structure of a table

```
Modify the name of the table：
ALTER TABLE [Table name] RENAME TO [New Name]
eg:
sqlite> .table
library
sqlite> ALTER TABLE library RENAME TO library2;
sqlite> .table
library2
Add Field：
ALTER TABLE [table name] ADD [field name] [field type]；
sqlite> .schema
CREATE TABLE IF NOT EXISTS "library"(
number int "primary key",
name varchar "not null",
price real "default",
type text "not null",
amount int "not null"
);

sqlite> ALTER TABLE library ADD remark text;

CREATE TABLE IF NOT EXISTS "library"(
number int "primary key",
name varchar "not null",
price real "default",
type text "not null",
amount int "not null"
, remark text);

sqlite> INSERT INTO library VALUES (2,"English",23.5,"langue",562,"note");

sqlite> SELECT * FROM library ;
1|chinese|23.5|langue|236|
2|English|23.5|langue|562|note
```

View the structure of the table

```c
.schema	// View the structure of all tables
.schema	[Table name]	// View the structure of a table
sqlite> .schema library
CREATE TABLE library(
number int "primary key",
name varchar "not null",
price real "default",
type text "not null",
amount int "not null"
);
```

View Table

```
.table	
```



Add data to the table

```c
insert into [Table name] values([value 1], [value 2]...);
eg:
INSERT INTO library VALUES (
01, "chinese", 23.5, "langue", 52);
```

Database Operators

```
= equal to
<> not equal to
> greater than
< less than
If there are multiple conditions:
and and
or or
```

Deleting data from a table

```c
DELETE FROM [table name] WHERE [column] [operator] [value];
eg:
DELETE FROM library WHERE name="English";
```

Modify data in table

```c
UPDATA [Table name] SET [Column name 1] = [new value], [Column name 2] = [new value]... WHERE [Column name] [Operator] [Value]；
sqlite> select * from library ;
1|chinese|23.5|langue|52
sqlite> UPDATE library SET amount=236 WHERE name = "chinese";
sqlite> select * from library ;
1|chinese|23.5|langue|236
```

Lookup table data

```c
select [column name 1], [column name 2], ... from [table name] where [column] [operator] [value];
sqlite> SELECT * FROM library ;c
1|chinese|23.5|langue|236
```

### sqlite3 C program compilation environment preparation

1、You need to prepare the source code of sqlite3

sqlite-autoconf-3110100

2、Code Compilation

```c
tar -zxvf sqlite-autoconf-3110100.tar.gz
cd sqlite-autoconf-3110100
./configure -prefix=[absolute path] #-prefix is ​​used to specify the sqlite target path
make
make install
/* After successful execution, it will be generated under the specified path
-bin: store executable files
-include: header files
-lib: library file path */
```

3、Move to correct locations

```
- Copy the files in the bin directory to /usr/local/bin
- Copy the files in the lib directory to /usr/local/lib Pay special attention to the soft link during the copying process
- include –> /usr/local/include
- share –> /usr/local/share
```

### C function interface of sqlite3

**1、sqlite3_open: Used to open or create a connection to the sqlite3 database engine**
In the sqlite3 database engine, the structure sqlite3 is used to represent the connection of the sqlite3 database engine.
When we call the sqlite3_open function, it will create a connection to the sqlite3 database engine for us.

```c
int sqlite3_open(
	const char *filename, //database filename, The file name of the database you want to open or create
	sqlite3 **ppdb; //Secondary pointer of the sqlite3 structure
);

Return Value:
    If successful, SQLITE_OK is returned, and ppdb points to the connection of the newly created sqlite3 database engine.
    Other values ​​indicate failure.
```

#### 2、sqlite3_exec: Operate a SQL engine database system, which actually executes SQL statements on this database engine

```c
int sqlite3_exec(
        sqlite * db; //Connection to the sqlite3 database system engine
	const char *sql; //String of the SQL statement you want to execute
	int (*callback)(void *, int, char **, char **), //Function pointer, pointing to the callback function
	void *, //Passed to the callback function as the first parameter of callback
	char **errmsg //Pointing to the error string
);

    Return Value:
        //Returns 0 if successful
	// Returns other values ​​if failed, error information is in errmsg
        
        int (*callback)(void *, int, char **, char **), //Function pointer, pointing to callback function. callback is mainly used when the SQL statement is SELECT. The result returned by SELECT is a two-dimensional table. In sqlite3_exec, the query statement is implemented. Every time a record is found, the result will be returned. Every time a record that meets the condition is found, the function pointed to by callback is called.
	int (*callback)(void *, //
	int, //How many columns in the result
	char **, //char* column_value[], pointer array, value of each column
	char **, //char* column_name[], pointer array, field name of each column
)
```

#### 3、Close the database connection

```
int sqlite3_close(sqlite3 *ppDb);
```

### Use the sqlite3_exec() function to complete the addition, deletion, modification and query

add：

```c
sqlite> select * from library;	
1|English|0.5|language|83
2|Chinese|22.3|language|88
****************after insert****************
china@ubuntu:/mnt/hgfs/WmShare$ gcc insert.c -lsqlite3 -o insert
china@ubuntu:/mnt/hgfs/WmShare$ ./insert
china@ubuntu:/mnt/hgfs/WmShare$ sqlite3 test.db 
SQLite version 3.23.0 2018-03-27 15:13:43
Enter ".help" for usage hints.
sqlite> select * from	library;
1|English|0.5|language|83
2|Chinese|22.3|language|88
3|math|34.0|langue|112
```

Delete, modify: Omitted

search：

```c
sqlite> select * from library;
1|English|0.5|language|83
2|Chinese|22.3|language|88
3|math|34.0|langue|112
*************after select*****************
china@ubuntu:/mnt/hgfs/WmShare$ vim select.c 
china@ubuntu:/mnt/hgfs/WmShare$ gcc select.c -o select -lsqlite3
china@ubuntu:/mnt/hgfs/WmShare$ ./select
number	name		price		type		amount	
1		English		0.5			language	83	
2		Chinese		22.3		language	88	
3		math		34.0		langue		112	
```

