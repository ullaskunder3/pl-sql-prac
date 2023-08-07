DROP TABLE student;

CREATE TABLE student (
    student_id INT AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    adjective VARCHAR(20) UNIQUE,
    major VARCHAR(20) DEFAULT 'undecided',
    PRIMARY KEY(student_id)
);

-- DESCRIBE student;

-- DROP TABLE student;

-- ALTER TABLE student ADD gpa DECIMAL(3, 2);

-- ALTER TABLE student DROP COLUMN gpa;

-- comment inserting data

SELECT * FROM student;

INSERT INTO student(name, adjective, major) VALUES(
    "Ullas", "unique", "IT"
);

INSERT INTO student(name, adjective, major) VALUES(
    "geriya", "GOAT", "IT"
);

-- what if no major then: (specify what you want to insert)
INSERT INTO student(name) VALUES("noMajorStu");

-- default value example
INSERT INTO student(name, adjective) VALUES(
    "kumar", "knight"
);

INSERT INTO student(name, adjective, major) VALUES(
    "ullaskunder", "unique2", "Tech"
);

-- comment how to update

SELECT * FROM student;

UPDATE student
SET major = "Tech"
WHERE major = "IT";

UPDATE student
SET major = "Tech 2"
WHERE name = "ullas" or name = "ullaskunder";

DELETE FROM student
WHERE name = "kumar";

-- querying from db

SELECT name
FROM student;

SELECT student.name
FROM student;

SELECT student.name
FROM student
ORDER BY name;

SELECT student.name
FROM student
ORDER BY student_id DESC;

SELECT *
FROM student
ORDER BY student_id ASC;

SELECT *
FROM student
LIMIT 3;

-- <> means not equal to
SELECT *
FROM student
WHERE major <> "undecided";

SELECT *
FROM student
WHERE name IN ("ullas", "ullaskunder");