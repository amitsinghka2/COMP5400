								
                                -- Assignment2 COMP 5400 Amit Kumar GRAD --

-- 1. Briefly describe the “employees” database that is used in the course. 

				DESCRIBE departments; 			-- is a relation with 2-tuples and 1 PK  - dept_no(PK) and dept_name
				DESCRIBE dept_emp;				-- is a relation with 4-tuples and 2 PK  - emp_no(PK),dept_no(PK),from_date and to_date
				DESCRIBE dept_manager;			-- is a relation with 4-tuples and 2 PK  - emp_no(PK),dept_no(PK),from_date and to_date
				DESCRIBE employees;				-- is a relation with 6-tuples and 1 PK  - emp_no(PK),birth_date,first_name,last_name,gender and hire_date
				DESCRIBE salaries;				-- is a relation with 4-tuples and 2 PK  - emp_no(PK),salary,from_date(PK) and to_date
				DESCRIBE titles;				-- is a relation with 4-tuples and 3 PK  - emp_no(PK),title(PK),from_date(PK) and to_date
				DESCRIBE current_dept_emp;		-- is a VIEW,    with 4-tuples and NO PK - emp_no,dept_no,from_date and to_date
				DESCRIBE dept_emp_latest_date;	-- is a VIEW,    with 3-tuples and NO PK - emp_no,from_date and to_date

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. What are the average, minimum, and maximum salaries of male and female employees? 

				SELECT gender, MIN(salary) AS myMIN, MAX(salary) AS myMAX, AVG(salary) AS myAVG
				FROM employees e , salaries s
				WHERE e.emp_no = s.emp_no
				GROUP BY gender;

		-- How many male and female employees are listed in the database? 
        -- Show the SQL script to retrieve this information from the database along with the answer.
				SELECT gender, COUNT(gender) AS GenderCount
				FROM employees
				GROUP BY gender;
					-- OR
				SELECT COUNT(*) FROM employees WHERE gender = 'M'; -- 179973 rows OR
				SELECT COUNT(*) FROM employees WHERE gender = 'F'; -- 120051 rows OR
				SELECT COUNT(*) FROM employees; 				   -- 300024 = (179973 + 120051) rows
				
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3. How many employees were working for the dept. number ‘d007’ between 1985-01-01 and 1991-03-07? 
		-- Show the SQL script along with the answer.

				SELECT dept_no , COUNT(emp_no) AS empCOUNT
				FROM dept_emp 
				WHERE from_date > '1985-01-01' AND to_date < '1991-03-07' AND dept_no = 'd007';


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4. How many distinct employee numbers do you have in the database? 

				SELECT DISTINCT * FROM employees;			-- 300024 rows
				SELECT * FROM employees;					-- 300024 rows
				
		-- Group the employees in terms of employee numbers and obtain the average salary for each group. 
		-- Show the SQL script and also first 5 rows of the new table.

				SELECT emp_no, AVG(salary) AS salAVG
				FROM  salaries
				GROUP BY emp_no;							-- 300024 rows


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5. How many employees are listed as either senior staff or staff?
        
				SELECT * 
				FROM titles
				WHERE title = 'Senior Staff'; -- 92853 rows

				SELECT * 
				FROM titles
				WHERE title = 'Staff'; -- 107391 rows

				SELECT * 
				FROM titles
				WHERE title IN ('Senior Staff' , 'Staff'); -- 200244 (107391 + 92853) rows

				SELECT COUNT(*)
				FROM titles
				WHERE title IN ('Senior Staff' , 'Staff'); -- 200244 rows

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
