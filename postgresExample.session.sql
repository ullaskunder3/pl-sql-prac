DROP TABLE users; 
DROP TABLE accounts;
DROP TABLE employee;
DROP TABLE audit_log;

CREATE TABLE users (
    id serial PRIMARY KEY,
    name text,
    age integer
);

CREATE TABLE accounts (
    user_id serial PRIMARY KEY,
    balance integer
);

CREATE TABLE employees (
    emp_id serial PRIMARY KEY,
    emp_name text,
    salary numeric
);

CREATE TABLE audit_log (
    log_id serial PRIMARY KEY,
    event_type text,
    event_time timestamp,
    emp_id integer
);

INSERT INTO employees (emp_name, salary) VALUES
    ('John Doe', 50000),
    ('Alice Smith', 60000),
    ('Bob Johnson', 55000);

INSERT INTO accounts (balance) VALUES (1000), (2000);


CREATE OR REPLACE FUNCTION normalize_si(input_text text) RETURNS text AS
$$
BEGIN
    RETURN substring(input_text, 9, 2) ||
           substring(input_text, 7, 2) ||
           substring(input_text, 5, 2) ||
           substring(input_text, 1, 4);
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

SELECT normalize_si('1118090878');

-- 

CREATE OR REPLACE FUNCTION calculate_circumference(radius double precision) RETURNS double precision AS
$$
DECLARE
    pi double precision := 3.141592653589793;
BEGIN
    RETURN 2 * pi * radius;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

SELECT calculate_circumference(5.0);

-- 

CREATE OR REPLACE FUNCTION calculate_area(radius double precision) RETURNS double precision AS
$$
DECLARE
    pi double precision := 3.141592653589793;
BEGIN
    RETURN pi * radius * radius;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

SELECT calculate_area(5);

-- 

CREATE OR REPLACE FUNCTION factorial(n integer) RETURNS bigint AS
$$
DECLARE
    result bigint := 1;
    i integer := 1;
BEGIN
    WHILE i <= n LOOP
        result := result * i;
        i := i + 1;
    END LOOP;
    RETURN result;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

SELECT factorial(4)

-- 

CREATE OR REPLACE FUNCTION is_prime(number integer) RETURNS boolean AS
$$
DECLARE
    i integer := 2;
BEGIN
    IF number <= 1 THEN
        RETURN false;
    END IF;

    WHILE i * i <= number LOOP
        IF number % i = 0 THEN
            RETURN false;
        END IF;
        i := i + 1;
    END LOOP;

    RETURN true;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

SELECT is_prime(2);

-- variable declaration

CREATE OR REPLACE FUNCTION example_variable() RETURNS integer AS
$$
DECLARE
    x integer := 10;
    y integer;
BEGIN
    y := 5;
    RETURN x + y;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

SELECT example_variable();

-- if else

CREATE OR REPLACE FUNCTION example_if_else(age integer) RETURNS text AS
$$
BEGIN
    IF age >= 18 THEN
        RETURN 'Adult';
    ELSE
        RETURN 'Minor';
    END IF;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

SELECT example_if_else(23);

-- loops

CREATE OR REPLACE FUNCTION example_while_loop(n integer) RETURNS integer AS
$$
DECLARE
    result integer := 0;
    i integer := 1;
BEGIN
    WHILE i <= n LOOP
        result := result + i;
        i := i + 1;
    END LOOP;
    RETURN result;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

SELECT example_while_loop(4);

-- execption handling

CREATE OR REPLACE FUNCTION example_exception_handling(dividend integer, divisor integer) RETURNS integer AS
$$
BEGIN
    IF divisor = 0 THEN
        RAISE EXCEPTION 'Division by zero is not allowed.';
    END IF;

    RETURN dividend / divisor;
EXCEPTION
    WHEN division_by_zero THEN
        RETURN NULL;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;

SELECT example_exception_handling(5, 2);

-- transactions

CREATE OR REPLACE FUNCTION example_transaction() RETURNS void AS
$$
BEGIN
    UPDATE accounts SET balance = balance - 100 WHERE user_id = 1;
    UPDATE accounts SET balance = balance + 100 WHERE user_id = 2;
END;
$$
LANGUAGE 'plpgsql';


SELECT * from accounts;
SELECT example_transaction();
SELECT * from accounts;

-- cursors

CREATE OR REPLACE FUNCTION example_cursor() RETURNS SETOF text AS
$$
DECLARE
    val text;
    my_cursor CURSOR FOR SELECT name FROM users;
BEGIN
    OPEN my_cursor;
    LOOP
        FETCH NEXT FROM my_cursor INTO val;
        EXIT WHEN NOT FOUND;
        RETURN NEXT val;
    END LOOP;
    CLOSE my_cursor;
    RETURN;
END;
$$
LANGUAGE 'plpgsql';

SELECT example_cursor();

-- cursor example for employee

CREATE OR REPLACE FUNCTION get_employee_names() RETURNS SETOF text AS
$$
DECLARE
    emp_cursor CURSOR FOR SELECT emp_name FROM employees;
    emp_name text;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH NEXT FROM emp_cursor INTO emp_name;
        EXIT WHEN NOT FOUND;
        RETURN NEXT emp_name;
    END LOOP;
    CLOSE emp_cursor;
    RETURN;
EXCEPTION
    WHEN others THEN
        CLOSE emp_cursor;
        RAISE;
END;
$$
LANGUAGE 'plpgsql';

-- SELECT get_employee_names();
SELECT * FROM get_employee_names();

-- trigger

CREATE OR REPLACE FUNCTION log_employee_updates() RETURNS TRIGGER AS
$$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (event_type, event_time, emp_id)
        VALUES ('UPDATE', NOW(), NEW.emp_id);
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

SELECT * from audit_log;
SELECT * from employees;

CREATE TRIGGER trigger_log_employee_updates
AFTER UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_updates();

-- Perform an update on an employee
UPDATE employees SET salary = 65000 WHERE emp_id = 1;

-- Perform another update on a different employee
UPDATE employees SET salary = 70000 WHERE emp_id = 2;

-- Check the contents of the audit_log table
SELECT * FROM audit_log;