CREATE DATABASE University;

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
    department VARCHAR(100)
);

-- Courses table
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
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


