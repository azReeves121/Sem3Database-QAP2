CREATE DATABASE University;

-- TABLES 

-- Students table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    school_enrollment_date DATE
);

-- Professors table
CREATE TABLE professors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);

-- Courses table
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(50),
    course_description TEXT,
    professor_id INT REFERENCES professors(id)
);

-- Enrollments table
CREATE TABLE enrollments (
    student_id INT REFERENCES students(id),
    course_id INT REFERENCES courses(id),
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id)
);


-- INSERTS


-- Insert Students
INSERT INTO students (first_name, last_name, email, school_enrollment_date)
VALUES 
('John', 'Wicks', 'john.wicks@example.com', '2022-09-01'),
('Jane', 'Bond', 'jane.bond@example.com', '2023-01-15'),
('Mike', 'Johnson', 'mike.johnson@example.com', '2021-08-25'),
('Emily', 'Davis', 'emily.davis@example.com', '2022-02-10'),
('Chris', 'Brown', 'chris.brown@example.com', '2023-05-11');

-- Insert Professors
INSERT INTO professors (first_name, last_name, department)
VALUES 
('Albert', 'Einstein', 'Physics'),
('Marie', 'Curie', 'Chemistry'),
('Isaac', 'Newton', 'Mathematics'),
('Ada', 'Lovelace', 'Computer Science');

-- Insert Courses
INSERT INTO courses (course_name, course_description, professor_id)
VALUES 
('Physics 101', 'Introduction to Physics', 1),
('Chemistry 101', 'Basics of Chemistry', 2),
('Mathematics 101', 'Basic Calculus and Algebra', 3);

-- Insert Enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES 
(1, 1, '2024-09-01'),
(2, 1, '2024-09-01'),
(3, 2, '2024-09-01'),
(4, 3, '2024-09-01'),
(5, 3, '2024-09-01');


--QUERIES


-- Retrieve the full names of all students enrolled in “Physics 101”
SELECT CONCAT(s.first_name, ' ', s.last_name) AS full_name
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE c.course_name = 'Physics 101';

-- Retrieve a list of all courses along with the professor’s full name
SELECT c.course_name, CONCAT(p.first_name, ' ', p.last_name) AS professor_name
FROM courses c
JOIN professors p ON c.professor_id = p.id;

-- Retrieve all courses that have students enrolled in them
SELECT DISTINCT c.course_name
FROM courses c
JOIN enrollments e ON c.id = e.course_id;

-- UPDATE

-- Update one of the student’s emails
UPDATE students
SET email = 'john.updated@example.com'
WHERE id = 1;

-- DELETE

-- Remove a student from one of their courses
DELETE FROM enrollments
WHERE student_id = 1 AND course_id = 1;
