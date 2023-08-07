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


<!-- start -->

<!-- mariaDB -->

sudo systemctl status mariadb
sudo systemctl enable mariadb
sudo systemctl start mariadb

sudo systemctl stop mariadb

mysql -u root -p

show databases;

<!-- postres SQL -->

sudo service postgresql stop
sudo service postgresql start
sudo service postgresql restart

sudo -u postgres psql

-- List all databases via \l (or \list), or \l+ for more details
postgres=# \l