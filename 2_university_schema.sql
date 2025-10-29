-- university_schema.sql
CREATE DATABASE IF NOT EXISTS university_db;
USE university_db;

-- Dimension tables
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    street VARCHAR(100),
    state VARCHAR(50),
    zip VARCHAR(10),
    location VARCHAR(50)
);

CREATE TABLE student_dim (
    stud_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    dob DATE,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE course_dim (
    course_id INT PRIMARY KEY,
    name VARCHAR(100),
    dept VARCHAR(50),
    level VARCHAR(10)
);

CREATE TABLE semester_dim (
    sem_id INT PRIMARY KEY,
    sem_name VARCHAR(20),
    start_date DATE,
    end_date DATE,
    academic_year VARCHAR(10)
);

CREATE TABLE time_dim (
    time_id INT PRIMARY KEY,
    date DATE,
    month VARCHAR(10),
    quarter VARCHAR(10),
    year INT
);

CREATE TABLE professor_dim (
    prof_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dept VARCHAR(50),
    title VARCHAR(20),
    hire_date DATE
);

-- Fact table
CREATE TABLE enrollment_fact (
    enroll_id INT PRIMARY KEY,
    stud_id INT,
    course_id INT,
    sem_id INT,
    course_time INT,
    grade VARCHAR(2),
    FOREIGN KEY (stud_id) REFERENCES student_dim(stud_id),
    FOREIGN KEY (course_id) REFERENCES course_dim(course_id),
    FOREIGN KEY (sem_id) REFERENCES semester_dim(sem_id),
    FOREIGN KEY (course_time) REFERENCES time_dim(time_id)
);

-- Sample data (from provided rudra.sql)
-- Address data
INSERT INTO address (address_id, street, state, zip, location) VALUES
(1, '123 Elm St', 'CA', '90001', 'Los Angeles'),
(2, '456 Oak St', 'NY', '10001', 'New York'),
(3, '789 Pine St', 'TX', '73301', 'Austin'),
(4, '135 Maple St', 'IL', '60007', 'Chicago'),
(5, '246 Cedar St', 'FL', '33101', 'Miami'),
(6, '357 Birch St', 'WA', '98001', 'Seattle'),
(7, '468 Spruce St', 'MA', '02101', 'Boston'),
(8, '579 Willow St', 'GA', '30301', 'Atlanta'),
(9, '680 Aspen St', 'OH', '44101', 'Cleveland'),
(10, '791 Redwood St', 'CO', '80001', 'Denver'),
(11, '802 Chestnut St', 'OR', '97001', 'Portland'),
(12, '913 Fir St', 'NV', '89501', 'Reno'),
(13, '1024 Cypress St', 'AZ', '85001', 'Phoenix'),
(14, '1135 Poplar St', 'MI', '48201', 'Detroit'),
(15, '1246 Palm St', 'NJ', '07001', 'Newark');

-- Student data
INSERT INTO student_dim (stud_id, first_name, last_name, gender, dob, address_id) VALUES
(1, 'John', 'Doe', 'M', '2000-01-15', 1),
(2, 'Jane', 'Smith', 'F', '1999-05-20', 2),
(3, 'Mike', 'Brown', 'M', '2001-07-10', 3),
(4, 'Emily', 'Davis', 'F', '2000-12-05', 4),
(5, 'Chris', 'Wilson', 'M', '1998-11-30', 5),
(6, 'Anna', 'Moore', 'F', '1999-03-22', 6),
(7, 'David', 'Taylor', 'M', '2002-09-17', 7),
(8, 'Laura', 'Anderson', 'F', '2001-06-25', 8),
(9, 'James', 'Thomas', 'M', '1998-10-02', 9),
(10, 'Sarah', 'Jackson', 'F', '2000-08-14', 10),
(11, 'Paul', 'White', 'M', '1999-04-11', 11),
(12, 'Nancy', 'Harris', 'F', '2001-02-28', 12),
(13, 'Mark', 'Martin', 'M', '2002-05-19', 13),
(14, 'Linda', 'Thompson', 'F', '2000-07-09', 14),
(15, 'Kevin', 'Garcia', 'M', '1998-09-23', 15);

-- Course data
INSERT INTO course_dim (course_id, name, dept, level) VALUES
(1, 'Intro to Psychology', 'Psychology', '100'),
(2, 'Calculus I', 'Mathematics', '100'),
(3, 'English Literature', 'English', '200'),
(4, 'Physics I', 'Physics', '100'),
(5, 'World History', 'History', '200'),
(6, 'Computer Science I', 'CS', '100'),
(7, 'Organic Chemistry', 'Chemistry', '300'),
(8, 'Art History', 'Art', '200'),
(9, 'Sociology Basics', 'Sociology', '100'),
(10, 'Economics I', 'Economics', '100'),
(11, 'Philosophy 101', 'Philosophy', '100'),
(12, 'Statistics', 'Mathematics', '200'),
(13, 'Biology I', 'Biology', '100'),
(14, 'Political Science', 'Political Science', '200'),
(15, 'Music Theory', 'Music', '200');

-- Semester data
INSERT INTO semester_dim (sem_id, sem_name, start_date, end_date, academic_year) VALUES
(1, 'Fall', '2023-09-01', '2023-12-15', '2023-2024'),
(2, 'Spring', '2024-01-10', '2024-05-05', '2023-2024'),
(3, 'Summer', '2024-06-01', '2024-08-15', '2023-2024'),
(4, 'Fall', '2024-09-01', '2024-12-15', '2024-2025'),
(5, 'Spring', '2025-01-10', '2025-05-05', '2024-2025'),
(6, 'Summer', '2025-06-01', '2025-08-15', '2024-2025'),
(7, 'Fall', '2025-09-01', '2025-12-15', '2025-2026'),
(8, 'Spring', '2026-01-10', '2026-05-05', '2025-2026'),
(9, 'Summer', '2026-06-01', '2026-08-15', '2025-2026'),
(10, 'Fall', '2026-09-01', '2026-12-15', '2026-2027'),
(11, 'Spring', '2027-01-10', '2027-05-05', '2026-2027'),
(12, 'Summer', '2027-06-01', '2027-08-15', '2026-2027'),
(13, 'Fall', '2027-09-01', '2027-12-15', '2027-2028'),
(14, 'Spring', '2028-01-10', '2028-05-05', '2027-2028'),
(15, 'Summer', '2028-06-01', '2028-08-15', '2027-2028');

-- Time data
INSERT INTO time_dim (time_id, date, month, quarter, year) VALUES
(1, '2023-09-01', 'September', 'Q3', 2023),
(2, '2023-09-02', 'September', 'Q3', 2023),
(3, '2023-09-03', 'September', 'Q3', 2023),
(4, '2023-09-04', 'September', 'Q3', 2023),
(5, '2023-09-05', 'September', 'Q3', 2023),
(6, '2023-09-06', 'September', 'Q3', 2023),
(7, '2023-09-07', 'September', 'Q3', 2023),
(8, '2023-09-08', 'September', 'Q3', 2023),
(9, '2023-09-09', 'September', 'Q3', 2023),
(10, '2023-09-10', 'September', 'Q3', 2023),
(11, '2023-09-11', 'September', 'Q3', 2023),
(12, '2023-09-12', 'September', 'Q3', 2023),
(13, '2023-09-13', 'September', 'Q3', 2023),
(14, '2023-09-14', 'September', 'Q3', 2023),
(15, '2023-09-15', 'September', 'Q3', 2023);

-- Professor data
INSERT INTO professor_dim (prof_id, first_name, last_name, dept, title, hire_date) VALUES
(1, 'Alice', 'Johnson', 'Psychology', 'Professor', '2010-08-15'),
(2, 'Bob', 'Williams', 'Mathematics', 'Associate Prof', '2012-06-10'),
(3, 'Carol', 'Lee', 'English', 'Professor', '2009-09-01'),
(4, 'David', 'Kim', 'Physics', 'Assistant Prof', '2015-01-15'),
(5, 'Eve', 'Clark', 'History', 'Professor', '2008-05-20'),
(6, 'Frank', 'Wright', 'CS', 'Associate Prof', '2011-12-01'),
(7, 'Grace', 'Hall', 'Chemistry', 'Professor', '2013-03-10'),
(8, 'Henry', 'Young', 'Art', 'Assistant Prof', '2016-07-25'),
(9, 'Ivy', 'King', 'Sociology', 'Professor', '2007-11-30'),
(10, 'Jack', 'Scott', 'Economics', 'Associate Prof', '2014-04-12'),
(11, 'Karen', 'Green', 'Philosophy', 'Professor', '2006-02-18'),
(12, 'Leo', 'Adams', 'Mathematics', 'Assistant Prof', '2017-10-09'),
(13, 'Mona', 'Baker', 'Biology', 'Professor', '2005-08-03'),
(14, 'Nina', 'Perez', 'Political Science', 'Associate Prof', '2012-11-15'),
(15, 'Oscar', 'Turner', 'Music', 'Assistant Prof', '2018-06-21');

-- Enrollment data
INSERT INTO enrollment_fact (enroll_id, stud_id, course_id, sem_id, course_time, grade) VALUES
(1, 1, 1, 1, 1, 'A'),
(2, 2, 2, 1, 2, 'B'),
(3, 3, 3, 2, 3, 'A'),
(4, 4, 4, 2, 4, 'C'),
(5, 5, 5, 3, 5, 'B'),
(6, 6, 6, 3, 6, 'A'),
(7, 7, 7, 4, 7, 'B'),
(8, 8, 8, 4, 8, 'A'),
(9, 9, 9, 5, 9, 'C'),
(10, 10, 10, 5, 10, 'B'),
(11, 11, 11, 6, 11, 'A'),
(12, 12, 12, 6, 12, 'B'),
(13, 13, 13, 7, 13, 'A'),
(14, 14, 14, 7, 14, 'A'),
(15, 15, 15, 8, 15, 'B');

-- Basic verification selects
SELECT * FROM address LIMIT 5;
SELECT * FROM student_dim LIMIT 5;
SELECT * FROM course_dim LIMIT 5;
SELECT * FROM semester_dim LIMIT 5;
SELECT * FROM time_dim LIMIT 5;
SELECT * FROM professor_dim LIMIT 5;
SELECT * FROM enrollment_fact LIMIT 5;
