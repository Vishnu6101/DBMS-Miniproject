-- 1. What are the courses that require prerequisites?

SELECT course.course_id, course.title, prereq.prereq_id, c.title 
FROM (course INNER JOIN prereq ON course.course_id = prereq.course_id)
LEFT JOIN course c ON c.course_id = prereq.prereq_id;


-- 2. Who are the instructors without teaching any students?

SELECT instructor.ID,Instructor.name FROM instructor WHERE instructor.ID NOT IN
(SELECT instructor.ID FROM (instructor INNER JOIN advisor ON instructor.ID = advisor.i_ID)
LEFT JOIN student ON advisor.s_ID = student.ID);

-- View for non teaching staffs
CREATE VIEW NonTeachingStaffs AS
SELECT instructor.ID,Instructor.name FROM instructor WHERE instructor.ID NOT IN
(SELECT instructor.ID FROM (instructor INNER JOIN advisor ON instructor.ID = advisor.i_ID)
LEFT JOIN student ON advisor.s_ID = student.ID);

SELECT * FROM NonTeachingStaffs;


-- 3. Write a query to get the students who have enrolled in CS related courses.

-- ONLY CS students
CREATE VIEW CS_students AS 
SELECT student.ID,student.name,course.course_id,course.title
FROM ((student LEFT JOIN takes ON student.ID = takes.ID)
LEFT JOIN course ON takes.course_id = course.course_id)
WHERE takes.course_id LIKE "CS%";

SELECT * FROM CS_students;


-- 4. How many students are there in each department?

SELECT dept_name,COUNT(dept_name) FROM student GROUP BY dept_name;


-- 5. Find the number of courses each student has enrolled in.

SELECT student.ID,student.name,COUNT(takes.course_id) AS No_Of_Courses
FROM student LEFT JOIN takes ON student.ID = takes.ID
GROUP BY student.ID;
