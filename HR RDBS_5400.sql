DROP DATABASE IF EXISTS hrdept;
CREATE DATABASE IF NOT EXISTS hrdept;
USE hrdept;

DROP TABLE IF EXISTS regions,
                     countries,
                     locations,
                     jobs, 
                     departments, 
                     employees,
					 dependents;

------------------------------------------------------------creating tables------------------------------------------------------------

CREATE TABLE regions (
    region_id 	INT (11) 	AUTO_INCREMENT 	PRIMARY KEY,
    region_name VARCHAR (25) 				DEFAULT NULL
);
 
CREATE TABLE countries (
    country_id 		CHAR (2) 		PRIMARY KEY,
    country_name 	VARCHAR (40) 	DEFAULT NULL,
    region_id 		INT (11) 		NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions (region_id) 	ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE locations (
    location_id 	INT (11) AUTO_INCREMENT 	PRIMARY KEY,
    street_address 	VARCHAR (40) 				DEFAULT NULL,
    postal_code 	VARCHAR (12) 				DEFAULT NULL,
    city 			VARCHAR (30) 				NOT NULL,
    state_province 	VARCHAR (25) 				DEFAULT NULL,
    country_id 		CHAR (2) 					NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries (country_id) 	ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE jobs (
    job_id 		INT (11) AUTO_INCREMENT PRIMARY KEY,
    job_title 	VARCHAR (35) 			NOT NULL,
    min_salary 	DECIMAL (8, 2) 			DEFAULT NULL,
    max_salary 	DECIMAL (8, 2) 			DEFAULT NULL
);
 
CREATE TABLE departments (
    department_id 	INT (11) AUTO_INCREMENT 	PRIMARY KEY,
    department_name VARCHAR (30) 				NOT NULL,
    location_id 	INT (11) 					DEFAULT NULL,
    FOREIGN KEY (location_id) REFERENCES locations (location_id) 	ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE employees (
    employee_id 	INT (11) AUTO_INCREMENT PRIMARY KEY,
    first_name 		VARCHAR (20) 			DEFAULT NULL,
    last_name 		VARCHAR (25) 			NOT NULL,
    email 			VARCHAR (100) 			NOT NULL,
    phone_number 	VARCHAR (20) 			DEFAULT NULL,
    hire_date 		DATE 					NOT NULL,
    job_id 			INT (11) 				NOT NULL,
    salary 			DECIMAL (8, 2) 			NOT NULL,
    manager_id 		INT (11) 				DEFAULT NULL,
    department_id 	INT (11) 				DEFAULT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs (job_id) 						ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments (department_id) 	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES employees (employee_id)
);
 
CREATE TABLE dependents (
    dependent_id 	INT (11) AUTO_INCREMENT PRIMARY KEY,
    first_name 		VARCHAR (50) 	NOT NULL,
    last_name 		VARCHAR (50) 	NOT NULL,
    relationship 	VARCHAR (25) 	NOT NULL,
    employee_id 	INT (11) 		NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

------------------------------------------------------------creating views------------------------------------------------------------

CREATE VIEW employee_contacts AS
    SELECT first_name, last_name, email, phone_number, department_name
    FROM
        employees e
            INNER JOIN
        departments d ON d.department_id = e.department_id
    ORDER BY first_name;


CREATE VIEW payroll (first_name , last_name , job, compensation) AS
    SELECT first_name, last_name, job_title, salary
    FROM
        employees e
            INNER JOIN
        jobs j ON j.job_id= e.job_id
    ORDER BY first_name;


CREATE OR REPLACE VIEW payroll (first_name , last_name , job , department , salary) AS
    SELECT first_name, last_name, job_title, department_name, salary
    FROM
        employees e
            INNER JOIN
        jobs j ON j.job_id = e.job_id
            INNER JOIN
        departments d ON d.department_id = e.department_id
    ORDER BY first_name;
	
------------------------------------------------------------LOADING DATA------------------------------------------------------------

SELECT 'LOADING regions' as 'INFO';
source load_regions.dump ;
SELECT 'LOADING countries' as 'INFO';
source load_countries.dump ;
SELECT 'LOADING locations' as 'INFO';
source load_locations.dump ;
SELECT 'LOADING jobs' as 'INFO';
source load_jobs.dump ;
SELECT 'LOADING departments' as 'INFO';
source load_departments.dump ;
SELECT 'LOADING employees' as 'INFO';
source load_employees.dump ;
SELECT 'LOADING dependents' as 'INFO';
source load_dependents.dump ;
