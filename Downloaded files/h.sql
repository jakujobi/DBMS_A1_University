/* 
Consider the university database schema
Write an SQL query for each of the following scenarios:
*/
SELECT *
FROM instructor;

/* 
a. Find the ID and name of each instructor in the Finance department
*/
SELECT ID, name
FROM instructor
WHERE dept_name = 'Finance';


/* 
b. Find the ID and name of each instructor in a department located in the Painter building
*/

SELECT DISTINCT instructor.*
FROM instructor
JOIN department ON instructor.dept_name = department.dept_name
WHERE department.building = 'Painter';


-- -- View students
SELECT id
FROM student;

-- /* 
-- c. Find the ID and name of each student who has taken at least one course in the Music department
-- */
SELECT distinct student.id, student.name
FROM student
JOIN takes on student.id = takes.id
WHERE course_id LIKE '%MU%';

-- /* 
-- d. Find the ID and name of each student who has taken at least one course section in the year 2017
-- */
SELECT distinct student.id, student.name
FROM student
JOIN takes on student.id = takes.id
WHERE year = 2017

-- /* 
-- e. List the ID and name of those instructors who are not from Biology dept
-- */
SELECT ID, name
FROM instructor
WHERE dept_name <> 'Biology';

-- /* 
-- f. List the courses_id, semester, year of all courses that were taught in Fall 2017 or in Spring 2018
-- */
SELECT distinct course_id, semester, year
FROM section
WHERE 
	(semester = 'Fall' AND year = 2017)
	OR
	(semester = 'Spring' and year = 2018);
-- /* 
-- g. List the information of all courses which include ‘Co’ as a substring in its title
-- */
SELECT *
FROM course
WHERE title LIKE '%Co%';


-- /* 
-- h. Find the titles of all courses in the Comp. Sci. dept that have 4 credits
-- */
SELECT title
FROM course
WHERE credits = 4 AND dept_name = 'Comp. Sci.'


-- /* 
-- i. Find the id and name of the students from the ‘Comp. Sci.’ dept whose name has 5 characters
-- */
SELECT id, name
FROM student
WHERE dept_name = 'Comp. Sci.'
  AND length(name) = 5;
  -- name LIKE '_____';



-- /* 
-- j. Find the information of the students from ‘Comp. Sci.’ and ‘Elec. Eng.’ Department whose total credits are above 55
-- */
SELECT *
FROM student
WHERE dept_name IN ('Comp. Sci.','Elec. Eng.')
  AND tot_cred > 55;