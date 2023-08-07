CREATE TABLE employee(
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
    branch_id INT,
    supplier_name VARCHAR(40),
    supplier_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- inserting data

INSERT INTO employee VALUES(100, "ullas", "kunder", "1999-07-30", "M", 1000000, NULL, NULL);

INSERT INTO branch VALUES(1, "Corporate", 100, "2022-07-30")

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, "knight", "Kingsman", "1999-09-09", "M", 900000, NULL, NULL);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

SELECT * FROM employee;

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

SELECT * FROM works_with;

-- find all emp order by sex then name
SELECT *
FROM employee
ORDER BY sex, first_name, last_name;

-- find the first five emp
SELECT *
FROM employee
LIMIT 5;

-- find first and last name from emp
SELECT first_name, last_name AS surname
FROM employee;

-- find out all different gender
SELECT DISTINCT sex
FROM employee;

SELECT DISTINCT branch_id
FROM employee;

-- sql functions
-- find the num of emp

SELECT COUNT(emp_id)
FROM employee;

SELECT COUNT(super_id)
FROM employee;

SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_day > '1971-01-01';

SELECT AVG(salary)
FROM employee;

SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

SELECT SUM(salary)
FROM employee;

-- agration
-- find out how many f and m in emp

SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

-- find total sales of each salesman

SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

-- wildcard: % = any # charachers, _ = one character
-- find any client whos are an LLC

SELECT *
FROM client
WHERE client_name LIKE '%LLC';

-- find any branch suppliers who are in teh label business

SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '% Labels%';

-- find any emp born in october
SELECT *
FROM employee
WHERE birth_day LIKE '____-10%';

-- find any client who are schools
SELECT *
FROM client
WHERE client_name LIKE '%school%';

-- union: combining

-- find the list of emp and branch name
-- rules: same num of column in each select, must be similar data type
SELECT first_name
FROM employee
UNION
SELECT branch_name
FROM branch;

-- SELECT client_name, branch_id
-- FROM client
-- UNION
-- SELECT supplier_name, branch_id
-- FROM branch_supplier;

SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

-- find a list of all money spent or earned by the company

SELECT salary
FROM employee
UNION
SELECT total_sales
from works_with;

-- joins: 
-- combine rows from two or more table based on a related comumn between theme

INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

-- find all branchs and the names of their managers

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;

-- nested queries

-- find names of all employess who have sold over 30,000 to a single client

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);

-- find all client who are handled by the branch that michael scott manages
--  assume you know Michaels ID

SELECT client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
    LIMIT 1
);

-- triggers

CREATE TABLE trigger_test (
    message VARCHAR(100)
);

-- comment : this gave error I dont know why
-- DELIMITER $$
-- CREATE
--     TRIGGER my_trigger BEFORE INSERT
--     ON employee
--     FOR EACH ROW BEGIN
--         INSERT INTO trigger_test VALUES('added new employes');
--     END$$
-- DELIMITER ;

CREATE TRIGGER my_trigger BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO trigger_test VALUES('added new employees');
END;

INSERT INTO employee
VALUES(110, "Osc", "Mart", "1968-02-19", "M", 79000, 106, 3);

SELECT * FROM trigger_test;

-- ER diagram

