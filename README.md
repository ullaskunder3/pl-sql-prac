in RDBMS data is stored in multiple tables each table can have a set of rows and colums
- tables related to their DB can have relations 

SQL command
- ddl: create , drop, alter, trunicate
- dml: insert, update, delete, merge
- dcl: grant, revoke
- tcl: commit, rollback, savepoint
- dql: select

data types
varchar, int, date, float, boolean

step 1:
CREATE TABLE student ();

## Real world example REST API with MariaDB sql

This API allows you to perform CRUD operations (Create, Read, Update, Delete) on user records stored in a MariaDB database.

project link
[User REST API](https://github.com/ullaskunder3/meriaDB-nodejs-restapi)

## With MariaDb

```bash
sudo systemctl enable mariadb
```
```bash
sudo systemctl start mariadb
```
```bash
sudo systemctl status mariadb
```
```bash
sudo systemctl stop mariadb
```

```bash
mysql -u root -p
```
```bash
show databases;
```

## With postres SQL

```bash
sudo service postgresql restart
```
```bash
sudo service postgresql start
```
```bash
sudo service postgresql stop
```

```bash
sudo -u postgres psql
```

-- List all databases via \l (or \list), or \l+ for more details
```bash
postgres=# \l
```