-- olap_operations.sql
-- NOTE: This file contains ONLY OLAP queries. It does NOT create schema or insert data.
-- Run these statements against a populated database. If you want the file to select
-- a specific database, uncomment and change the USE line below on the machine where
-- the database exists. The file intentionally does not perform any data loads.

-- Example (uncomment to use):
-- USE university_db;

-- 1) ROLLUP example: department by academic year totals (department -> academic_year -> grand total)
SELECT
    c.dept,
    s.academic_year,
    COUNT(e.enroll_id) AS total_enrollments
FROM enrollment_fact e
JOIN course_dim c ON e.course_id = c.course_id
JOIN semester_dim s ON e.sem_id = s.sem_id
GROUP BY ROLLUP(c.dept, s.academic_year)
ORDER BY c.dept, s.academic_year;

-- 2) DRILL-DOWN: drill from department-level to course-level enrollments
SELECT c.dept, c.name AS course_name, COUNT(e.enroll_id) AS total_enrollments
FROM enrollment_fact e
JOIN course_dim c ON e.course_id = c.course_id
GROUP BY c.dept, c.name
ORDER BY c.dept, total_enrollments DESC;

-- 3) SLICE: get enrollments for a specific academic year (a 2D slice)
SELECT c.dept, COUNT(e.enroll_id) AS total_enrollments
FROM enrollment_fact e
JOIN course_dim c ON e.course_id = c.course_id
JOIN semester_dim s ON e.sem_id = s.sem_id
WHERE s.academic_year = '2023-2024'
GROUP BY c.dept
ORDER BY total_enrollments DESC;

-- 4) DICE: filter multiple dimensions (dept + semester name + academic year)
SELECT c.name AS course_name, COUNT(e.enroll_id) AS total_enrollments
FROM enrollment_fact e
JOIN course_dim c ON e.course_id = c.course_id
JOIN semester_dim s ON e.sem_id = s.sem_id
WHERE c.dept = 'Physics' AND s.sem_name = 'Spring' AND s.academic_year = '2023-2024'
GROUP BY c.name
ORDER BY total_enrollments DESC;

-- 5) PIVOT: show enrollments per course across semester types (Fall/Spring/Summer)
SELECT c.name AS course_name,
    SUM(CASE WHEN s.sem_name = 'Fall' THEN 1 ELSE 0 END) AS Fall,
    SUM(CASE WHEN s.sem_name = 'Spring' THEN 1 ELSE 0 END) AS Spring,
    SUM(CASE WHEN s.sem_name = 'Summer' THEN 1 ELSE 0 END) AS Summer
FROM enrollment_fact e
JOIN course_dim c ON e.course_id = c.course_id
JOIN semester_dim s ON e.sem_id = s.sem_id
GROUP BY c.name
ORDER BY c.name;

-- 6) Example aggregated cube-like query (multi-dimensional totals per dept/course/semester)
SELECT c.dept, c.name AS course_name, s.sem_name, COUNT(e.enroll_id) AS cnt
FROM enrollment_fact e
JOIN course_dim c ON e.course_id = c.course_id
JOIN semester_dim s ON e.sem_id = s.sem_id
GROUP BY c.dept, c.name, s.sem_name
ORDER BY c.dept, c.name, s.sem_name;

-- Notes:
-- - Run these queries after loading data from `university_schema.sql`.
-- - Adjust WHERE filters to perform additional slice/dice operations.
-- - For large real datasets consider adding indexes on foreign keys (stud_id, course_id, sem_id, course_time).
