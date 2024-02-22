-- Database Management Systems - SDSU SPRING 2024
-- DBMS_A1_University\Assignment2\AKUJOBI2.sql
/*
- John Akujobi
- Izak Benitez-Lopez
- Frezer Berhanu
*/

-- ! Queries

-- Write the following queries in SQL, using the University database
--     Create a university2 database consisting of the large relation data set
-- o Results should include a maximum of 10 rows – simply only screenshot the first 10 rows
-- o Add the total row count to your answer
--     Write an appropriate SQL query statement for each problem
-- o Whenever multiple tables/relations are used together write an appropriate join query statement


-- Consider the university database schema – use the join clause
-- a. List the IDs of all students who are advised by the instructor named Sullivan
SELECT student.ID as student_ID
FROM student
JOIN advisor ON student.ID = advisor.s_ID
JOIN instructor ON advisor.i_ID = instructor.ID
WHERE instructor.name = 'Sullivan'
LIMIT 10;

--Count
SELECT COUNT(student.ID) as Total_students
FROM student
JOIN advisor ON student.ID = advisor.s_ID
JOIN instructor ON advisor.i_ID = instructor.ID
WHERE instructor.name = 'Sullivan';


-- b. List all instructors in alphabetical order by department name, and then by instructor’s name
SELECT id, name, dept_name
FROM instructor
ORDER BY dept_name, name
LIMIT 10;

SELECT COUNT(*) AS total_instructor_count
FROM instructor;


-- c. List all instructors with the lowest salary
--     There may be more than one instructor with the same salary
-- This one checks accross the board
SELECT *
FROM instructor
WHERE salary = (
    SELECT MIN(salary)
    FROM instructor );

SELECT COUNT(*) AS total_instructors_with_min_salary
FROM instructor
WHERE salary = (SELECT MIN(salary) FROM instructor);



-- d. List the number of students in each department
SELECT dept_name, COUNT(ID) AS student_count
FROM student
GROUP BY dept_name
ORDER BY dept_name
LIMIT 10;

SELECT COUNT(DISTINCT ID) AS total_students
FROM student;


-- e. List the ID, name, salary of all instructors whose salary is greater than every average salary of every department
SELECT id, name, salary, dept_name
FROM instructor
WHERE salary > ALL(SELECT AVG(salary) FROM instructor GROUP BY dept_name)
LIMIT 10;

SELECT COUNT(*) AS total_instructors_above_avg_salary
FROM instructor
WHERE salary > ALL (
    SELECT AVG(salary) FROM instructor GROUP BY dept_name
);


-- f. List the department name and the number of instructors for all departments with 2 or more instructors
SELECT dept_name, COUNT(ID) AS instructor_count
FROM instructor
GROUP BY dept_name
HAVING COUNT(ID) >= 2
LIMIT 10;

SELECT COUNT(dept_name)
FROM instructor
GROUP BY dept_name
HAVING COUNT(ID) >= 2;


-- g. List the ID, name, and course_id of all students enrolled in Fall 2004
SELECT student.ID, student.name, takes.course_id
FROM student
JOIN takes ON student.ID = takes.ID
JOIN section ON takes.course_id = section.course_id AND takes.sec_id = section.sec_id
WHERE takes.semester = 'Fall' AND takes.year = 2004
LIMIT 10;

SELECT COUNT(student.ID)
FROM student
JOIN takes ON student.ID = takes.ID
JOIN section ON takes.course_id = section.course_id AND takes.sec_id = section.sec_id
WHERE takes.semester = 'Fall' AND takes.year = 2004;


-- h. List the course_id and the number of students enrolled of each course offered in Spring 2010
--     Courses with different sec_id values are the same course
SELECT section.course_id, COUNT(takes.ID) AS enrolled_students
FROM section
JOIN takes ON section.course_id = takes.course_id AND section.sec_id = takes.sec_id
WHERE section.semester = 'Spring' AND section.year = 2010
GROUP BY section.course_id
ORDER BY section.course_id
LIMIT 10;

SELECT COUNT(DISTINCT section.course_id) AS total_courses_spring_2010
FROM section
JOIN takes ON section.course_id = takes.course_id AND section.sec_id = takes.sec_id
WHERE section.semester = 'Spring' AND section.year = 2010;



-- i. List all student’s names who have never received an A or A- grade in any course
SELECT s.name
FROM student s
WHERE NOT EXISTS ( --Learned from stack overflow
    SELECT 1
    FROM takes t
    WHERE t.ID = s.ID AND t.grade IN ('A', 'A-') )
LIMIT 10;

SELECT COUNT(*) AS total_students_never_A_Aminus
FROM student s
WHERE NOT EXISTS (
    SELECT 1
    FROM takes t
    WHERE t.ID = s.ID AND t.grade IN ('A', 'A-')
);




-- j. List all student IDs and names for students who have not taken any courses offered before 2005
SELECT DISTINCT s.ID, s.name
FROM student s
LEFT JOIN (takes t JOIN section sec ON t.course_id = sec.course_id AND t.sec_id = sec.sec_id) 
ON s.ID = t.ID AND sec.year < 2005
WHERE t.ID IS NULL
ORDER BY s.name
LIMIT 10;

SELECT COUNT(DISTINCT s.ID) AS total_students_no_pre2005_courses
FROM student s
LEFT JOIN (takes t JOIN section sec ON t.course_id = sec.course_id AND t.sec_id = sec.sec_id) 
ON s.ID = t.ID AND sec.year < 2005
WHERE t.ID IS NULL;


-- k. List the highest instructor salary for each department, except Marketing
SELECT dept_name, MAX(salary) AS max_salary
FROM instructor
WHERE dept_name <> 'Marketing'
GROUP BY dept_name
ORDER BY dept_name
LIMIT 10;

SELECT COUNT(*) AS total_departments_excl_marketing
FROM (
    SELECT dept_name, MAX(salary) AS max_salary
    FROM instructor
    WHERE dept_name <> 'Marketing'
    GROUP BY dept_name
) AS subquery;



-- l. List the ID, name and the number of courses taught for all instructors
--     The number of courses is 0 for instructors who have not taught any courses
SELECT i.ID, i.name, COUNT(t.course_id) AS number_of_courses_taught
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID, i.name
ORDER BY i.ID
LIMIT 10;

SELECT COUNT(*) AS total_instructors
FROM instructor;


-- m. List the name and the number of instructors assigned to each department
--     The number of instructors is 0 for departments that have no instructors
SELECT d.dept_name, COUNT(i.ID) AS instructor_count
FROM department d
LEFT JOIN instructor i ON d.dept_name = i.dept_name
GROUP BY d.dept_name
ORDER BY d.dept_name
LIMIT 10;

SELECT COUNT(*) AS total_departments
FROM department;


-- n. List the ID and name of all students who took courses in both Fall 2009 and Spring 2010
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN takes t1 ON s.ID = t1.ID
JOIN takes t2 ON s.ID = t2.ID
WHERE t1.semester = 'Fall' AND t1.year = 2009
AND t2.semester = 'Spring' AND t2.year = 2010
ORDER BY s.name
LIMIT 10;

SELECT COUNT(DISTINCT s.ID) AS total_students_fall2009_spring2010
FROM student s
JOIN takes t1 ON s.ID = t1.ID
JOIN takes t2 ON s.ID = t2.ID
WHERE t1.semester = 'Fall' AND t1.year = 2009
AND t2.semester = 'Spring' AND t2.year = 2010;



-- o. List the ID and name of all students who have never taken a course at the university
SELECT DISTINCT s.ID, s.name
FROM student s
LEFT JOIN takes t ON s.ID = t.ID
WHERE t.course_id IS NULL
LIMIT 10;

SELECT COUNT(DISTINCT s.ID) AS total_students_never_taken_course
FROM student s
LEFT JOIN takes t ON s.ID = t.ID
WHERE t.course_id IS NULL;