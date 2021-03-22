-- Courses and their prerequisites
SELECT course.course_id, course.title, prereq.prereq_id, c.title 
FROM (course INNER JOIN prereq ON course.course_id = prereq.course_id)
LEFT JOIN course c ON c.course_id = prereq.prereq_id;



-- Instructors with their students
SELECT instructor.ID, instructor.name,advisor.s_ID,student.name
FROM (instructor LEFT JOIN advisor ON instructor.ID = advisor.i_ID)
LEFT JOIN student ON advisor.s_ID = student.ID;

-- NON teaching staffs
SELECT instructor.ID,Instructor.name FROM instructor WHERE instructor.ID NOT IN
(SELECT instructor.ID FROM (instructor INNER JOIN advisor ON instructor.ID = advisor.i_ID)
LEFT JOIN student ON advisor.s_ID = student.ID);

-- View for non teaching staffs
CREATE VIEW NonTeachingStaffs AS
SELECT instructor.ID,Instructor.name FROM instructor WHERE instructor.ID NOT IN
(SELECT instructor.ID FROM (instructor INNER JOIN advisor ON instructor.ID = advisor.i_ID)
LEFT JOIN student ON advisor.s_ID = student.ID);

SELECT * FROM NonTeachingStaffs;




-- Students with their courses
SELECT student.ID,student.name,takes.course_id,course.title
FROM (student LEFT JOIN takes ON student.ID = takes.ID)
LEFT JOIN course ON takes.course_id = course.course_id;

-- ONLY CS students
CREATE VIEW CS_students AS 
SELECT student.ID,student.name,course.course_id,course.title
FROM ((student LEFT JOIN takes ON student.ID = takes.ID)
LEFT JOIN course ON takes.course_id = course.course_id)
WHERE takes.course_id LIKE "CS%";

SELECT * FROM CS_students;


-- Students with no course enrolled
-- SELECT * FROM student;
-- CREATE VIEW NoCourse AS 
-- SELECT * FROM student WHERE tot_cred = 0;

-- SELECT * FROM NoCourse;


--Group students and instructors department wise
SELECT student.ID,student.name,department.dept_name
FROM student LEFT JOIN department ON student.dept_name = department.dept_name;

SELECT instructor.ID,instructor.name,department.dept_name
FROM instructor LEFT JOIN department ON instructor.dept_name = department.dept_name;

SELECT department.dept_name,COUNT(department.dept_name) AS Students_Department_Wise
FROM student LEFT JOIN department ON student.dept_name = department.dept_name
GROUP BY department.dept_name;

SELECT department.dept_name,COUNT(department.dept_name) AS Instructors_Dept_Wise
FROM instructor LEFT JOIN department ON instructor.dept_name = department.dept_name
GROUP BY department.dept_name;



-- Find number of course each student has enrolled in
SELECT student.ID,student.name,COUNT(takes.course_id) AS No_Of_Courses
FROM student LEFT JOIN takes ON student.ID = takes.ID
GROUP BY student.ID;