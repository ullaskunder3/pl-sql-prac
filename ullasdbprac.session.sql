DROP TABLE student;

-- CREATE TABLE student (
--     student_id INT PRIMARY KEY,
--     name VARCHAR(20) NOT NULL,
--     adjective VARCHAR(20) UNIQUE,
--     major VARCHAR(20)
-- );

CREATE TABLE student (
    student_id INT,
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

INSERT INTO student VALUES(
    1, "Ullas", "unique", "IT"
);

INSERT INTO student VALUES(
    2, "geriya", "GOAT", "IT"
);

-- what if no major then: (specify what you want to insert)
INSERT INTO student(student_id, name) VALUES(
    3, "noMajorStu"
);

-- default value example
INSERT INTO student(student_id, name, adjective) VALUES(
    4, "kumar", "knight"
);
