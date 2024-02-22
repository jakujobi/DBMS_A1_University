/*
- John Akujobi
- Izak Benitez-Lopez
- Frezer Berhanu
*/


--Part a. List the IDs of all students who are advised by the instructor named Sullivan	
select S.ID as Student_ID
from instructor as I join advisor as A on (I.ID = A.i_ID)
join student as S on (S.ID = A.s_ID)
where I.name = 'Sullivan';


--Part b. List all instructors in alphabetical order by department name, and then by instructor’s name
select name, dept_name
from instructor 
ORDER BY (dept_name, name) ASC;

--Part c. List all instructors with the lowest salary
select name, salary
from instructor 
ORDER BY (salary) ASC;

--Part d. List the number of students in each department
SELECT dept_name, COUNT(*) AS department_count
FROM student
GROUP BY dept_name;

--Part e. List the ID, name, salary of all instructors whose salary is greater than every average salary of every department
SELECT ID, name, salary
FROM Instructor
WHERE salary > (SELECT AVG(salary) FROM Instructor);


--Part f. List the department name and the number of instructors for all departments with 2 or more instructors
SELECT dept_name, COUNT(DISTINCT name) AS num_individuals
FROM instructor
GROUP BY dept_name
HAVING COUNT(DISTINCT name) > 2;


--Part g. List the ID, name, and course_id of all students enrolled in Fall 2004
select distinct S.ID, S.name, T.course_id
from takes as T 
join student as S on (T.ID = S.ID)
where T.year = '2004' and T.semester = 'Fall';



--Part h. List the course_id and the number of students enrolled of each course offered in Spring 2010
select course_id, COUNT(Distinct ID) AS num_individuals
FROM takes
where semester = 'Spring' AND year = 2010
GROUP BY course_id;


--Part i. List all student’s names who have never received an A or A- grade in any course
SELECT distinct student.name
FROM takes
INNER JOIN student ON takes.ID = student.ID
WHERE NOT EXISTS (
    SELECT 1
    FROM takes
    WHERE takes.ID = student.ID AND takes.grade like ('A%')
    );

--Part j. List all student IDs and names for students who have not taken any courses offered before 2005
SELECT distinct student.name, student.id
FROM takes
INNER JOIN student ON takes.ID = student.ID
WHERE NOT EXISTS (
    SELECT 1
    FROM takes
    WHERE takes.ID = student.ID AND takes.year < '2005'
    );
	

--Part k. List the highest instructor salary for each department, except Marketing		
select dept_name, MAX(salary)
FROM instructor
where dept_name != 'Marketing'
group by dept_name;

--Part l. List the ID, name and the number of courses taught for all instructors
select I.ID as Instructor_ID, name, COUNT(T.course_id) as CoursesTaught
FROM instructor as I 
LEFT JOIN teaches as T on (I.ID = T.ID)
GROUP BY I.ID;

--Part m. List the name and the number of instructors assigned to each department
SELECT d.dept_name, COUNT(DISTINCT i.name) AS num_individuals
FROM department d
LEFT JOIN instructor i ON d.dept_name = i.dept_name
GROUP BY d.dept_name;

--Part n. List the ID and name of all students who took courses in both Fall 2009 and Spring 2010
SELECT T.ID, S.name
FROM takes as T 
JOIN student as S ON T.ID = S.ID
WHERE T.ID IN (
    SELECT T1.ID
    FROM takes as T1
    JOIN course as C1 ON T1.course_id = C1.course_id
    WHERE (T1.semester = 'Fall' AND T1.year = 2009)
)
AND T.ID IN (
    SELECT T2.ID
    FROM takes as T2
    JOIN course as C2 ON T2.course_id = C2.course_id
    WHERE (T2.semester = 'Spring' AND T2.year = 2010)
);



--Part o. List the ID and name of all students who have never taken a course at the university
Select name, ID
from Student S
Where S.tot_cred = '0';