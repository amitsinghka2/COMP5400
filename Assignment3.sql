								
                                -- Assignment3 , COMP 5400 , Amit Kumar , GRAD --

-- PART – I ---------------------------------------------------------------------------------------------------------------------------------------------------
		-- Problem 01 - Retrieving Records: you have a table and want to see all of the data.
        
						SELECT * FROM employees;
        
		-- Problem 02 - View only selective columns of the table.
        
						SELECT emp_no, birth_date, gender 
                        FROM employees;
        
		-- Problem 03 - View only selective rows that satisfy certain conditions. 
                        
						SELECT emp_no, first_name, last_name, birth_date, YEAR(curdate()) AS CURDATE, (YEAR(curdate()) - YEAR(birth_date)) AS Age
                        FROM employees
                        WHERE (YEAR(curdate()) - YEAR(birth_date)) > 65;
                                                
		-- Problem 04 - Display rows that satisfy multiple conditions. Following the WHERE clause use the OR and AND statements. 
                        
                        SELECT *
						FROM dept_emp 
						WHERE from_date >= '1986-01-01' AND to_date <= '1991-03-07' AND dept_no = 'd007';
                        
		-- Problem 05 - Rename the columns and then view the table with the newly named column. Here, sal and dept are the original column names in the table.
						
                        SELECT emp_no, emp_no AS EMPLOYEE_NEW , salary , salary AS SALARY_NEW
                        FROM salaries;
        
		-- Problem 06 - Concatenating column values to combine multiple columns into one.
						
                        SELECT gender, first_name, last_name
                        FROM employees;
                        
                        SELECT gender, CONCAT(first_name," ",last_name) AS NAMES_CONCAT 
                        FROM employees 
                        WHERE gender = 'F';
                                
		-- Problem 07 - Implement IF-ELSE statement: 
						-- for example: if the customer pays less than $100, more than $100, 
						-- and equal to $100, mark him as underpaid, overpaid, and paid, respectively.
                        
                        SELECT e.emp_no, e.first_name, e.last_name, s.salary,
                        CASE 
							WHEN s.salary <= 90000 THEN "UNDERPAID"
							WHEN s.salary >= 120000 THEN "OVERPAID"
							ELSE "PAID" 
                        END AS paymentStatus
                        FROM employees e , salaries s
                        WHERE e.emp_no = s.emp_no;
        
		-- Problem 08 - Limit the number of rows – show only top n rows of the table. 
						
                        SELECT *
                        FROM employees 
                        LIMIT 25;
        
		-- Problem 09 - Returning n random records from a table
        
						SELECT * FROM employees ORDER BY rand() limit 5;
						SELECT * FROM employees ORDER BY rand();
                        
                        SELECT emp_no, first_name, last_name
                        FROM employees
                        ORDER BY rand()
                        LIMIT 8;
        
		-- Problem 10 - Find all the rows that have NULL or missing entries in a particular column
						
                        SELECT COUNT(*) 
                        FROM departments 
                        WHERE dept_name IS NULL; -- None of the columns in all the tables in employees Database has NULL value. Cannot find any.
        
						SELECT * 
                        FROM employees 
                        WHERE birth_date IS NOT NULL;
                        
		-- Problem 10 - Transforming NULL entries into REAL values. Use COALESCE function to substitute real values for NULL
						
                        SELECT COALESCE (birth_date, 0) 
                        FROM employees;							-- None of the columns in all the tables in employees Database has NULL value.
                        
                        SELECT 
							CASE 
								WHEN birth_date is NULL THEN 0 
								ELSE birth_date 
							END 
                        From employees;							-- None of the columns in all the tables in employees Database has NULL value.
        
		-- Problem 11 - Search rows with specific patterns in a particular column. 
						-- Below is an example of selecting student name and age from the table belonging to 5th and 8th grade.
                        
                        SELECT DISTINCT emp_no, salary 
                        FROM salaries 
                        WHERE salary IN (66000,80000);
        
        -- Problem 11 - Use of wildcard operator % to search rows that have specific substring pattern.
						
                        SELECT emp_no, first_name, last_name
                        FROM employees
                        WHERE emp_no IN (10000,500000) OR (first_name LIKE '%Mari%' AND last_name LIKE '%Sch%');
                        
        
-- PART – II ---------------------------------------------------------------------------------------------------------------------------------------------------
		-- Problem 01 - Sort the rows based on ascending order of the salary(from lowest to highest).Default is asc: For desc order: ORDER BY salary desc
                        
                        SELECT *
                        FROM salaries 
                        WHERE salary > 79990 AND salary < 80000
                        ORDER BY salary asc;												-- 307 rows
				-- OR
                        SELECT e.emp_no, e.first_name, e.last_name, s.salary
                        FROM employees e , salaries s
                        WHERE e.emp_no = s.emp_no AND (salary > 79990 AND salary < 80000)
						ORDER BY s.salary;													-- 307 rows
        
		-- Problem 02 - Sort the rows based on multiple fields or columns. 
						-- For example, sort the table first based on ascending order of the age and then descending order of the salary.
        
                        SELECT * 
                        FROM employees 
                        ORDER BY birth_date, hire_date desc;
        
		-- Problem 03 - Sort the rows based on the alphabetic order of substring in a column.
						-- Here SUBSTR (column_name, start_index of the string). Where, length(name) – 2 → last two characters of a string.
                        
                        SELECT *, substr(first_name,2,4) AS ExtractString
                        FROM employees
                        LIMIT 10;
       
		-- Problem 04 - Order NULL entries of the salary field in descending order and non-null in ascending order. 
						-- We create a new field called is_null that contains the flag related to the NULL status – 
                        -- we use CASE to implement IF-ELSE condition on the salary column
                        "None of the columns in all the tables in employees Database has NULL value."
						SELECT name, age, salary 
                        FROM ( SELECT name, age, salary, 
							CASE 
								WHEN salary IS NULL THEN 0 
                                ELSE 1 
							END AS is_null 
                            FROM table_name ) x 
                            ORDER BY is_null desc, salary
							)
                        
		-- Problem 05 - Sort rows based on a conditional logic. When Sex = Female, create a separate column to display their salary in ascending order.
        
                         SELECT e.emp_no, e.first_name, e.last_name, s.salary,
							CASE 
								WHEN e.gender = 'F' THEN "Female"
                                WHEN e.gender = 'M' THEN "Male"
							END AS gencolumn
                         FROM employees e , salaries s
                         WHERE e.emp_no = s.emp_no AND e.gender = 'F'
                         ORDER BY s.salary, gencolumn desc;
                         
		-- Problem 06 - Find the age in years at the time of hire use the date of hire and the birth date of male employees only.
        
                        SELECT first_name, last_name,birth_date,hire_date, DATEDIFF(hire_date, birth_date)/365 AS age_hire 
                        FROM employees 
                        WHERE gender = 'M';
        
		-- Problem 07 - You cannot use field aliases in the WHERE clause as below.
        
						SELECT first_name, DATEDIFF(hire_date, birth_date)/365 AS age_hire 
						FROM employees 
						WHERE (DATEDIFF(hire_date, birth_date)/365) > 28;    
        
-- PART – III ---------------------------------------------------------------------------------------------------------------------------------------------------
		-- Problem 01 - Stack one table on the top of other. 
						-- Merge department name and employee name into one column named name_and_dept and stack two tables together.

                        SELECT CONCAT(first_name," ",last_name) AS name_and_dept, emp_no
                        FROM employees
                        UNION ALL 							-- doesnot remove duplicates
                        SELECT dept_name, dept_no 
                        FROM departments;
				-- OR    
                        SELECT first_name AS name_and_dept
                        FROM employees
                        UNION 								-- using only UNION removes duplicates
                        SELECT dept_name 
                        FROM departments;
                        
		-- Problem 02 - You want to return rows from multiple tables by joining on a known common columns or joining on columns that share common values. 
						-- Say you want to know names of all students in the CS department who live in Franklin – 
                        -- they are provided in two different tables- the name table tb_1 and location table tb_2.

                        SELECT e.emp_no, first_name, last_name, gender, title
						FROM employees e LEFT JOIN titles t 
						ON e.emp_no = t.emp_no
						WHERE title = 'Engineer'; -- 115003 rows
                        
                        -- above query using RIGHT JOIN, JOIN, INNER JOIN returns the same result which is 115003 rows
        
		-- Problem 03 - Find the student t-numbers that are in the CS_dept table but not in the Sci_dept table.
						select DISTINCT emp_no from dept_manager; -- 24 rows     - A
                        select DISTINCT emp_no from employees;    -- 300024 rows - B
                        
                        SELECT emp_no 
                        FROM  employees
                        WHERE emp_no NOT IN (SELECT emp_no FROM dept_manager); -- 300000 rows = B-A
        
		-- Problem 04 - Obtain the sum or aggregate values from the numeric columns. 
						-- Create a column displaying the sum of salaries or count of all female employees. 
						-- From the salary table calculate the total number of employees, total salaries, and average salaries.

                        SELECT gender, count(s.emp_no) AS total_emp, SUM(salary) AS total_salary, AVG(salary) AS avg_salary
						FROM salaries s , employees e
                        WHERE e.emp_no = s.emp_no AND e.gender = 'F'
						GROUP BY gender;  
				-- OR     
						SELECT count(emp_no) AS total_emp, SUM(salary) AS total_salary, AVG(salary) AS avg_salary
						FROM salaries;  
								-- total salary -> M 108928421890 + F 72552335529 = 181480757419

-- PART – IV ---------------------------------------------------------------------------------------------------------------------------------------------------
		-- 4.1 - Inserting a new record
					SELECT COUNT(*) FROM employees; -- before inserting a row = 300024
					SELECT COUNT(*) FROM employees; -- after  inserting a row = 300025
                    
					INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date) 
                    VALUES (500000,'1958-01-01','New','One','M','1978-01-01');
        
		-- 4.2 - Inserting default values
        
                    INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date) VALUES (DEFAULT);
							-- Error Code: 1136. Column count doesn't match value count at row 1
                    
					INSERT INTO employees VALUES (); 
							-- Error Code: 1364. Field 'emp_no' doesn't have a default value
                    
		-- 4.3 - Overriding a default value with NULL
					
                    CREATE TABLE newtable1 (t1col1 INTEGER DEFAULT 0, t1col2 VARCHAR(10)); -- 0 row(s) affected
                    
					INSERT INTO newtable1 (t1col1, t1col2) VALUES (null, 'TSU_TIGERS'); -- 1 row(s) affected
                    
					INSERT INTO newtable1 VALUES (); -- 1 row(s) affected

					DESCRIBE newtable1;
                    
                    SELECT * FROM newtable1;
        
		-- 4.4 - Copying rows from one table into another , Steps: Perform query in one table, take the query result to insert into another table

                    INSERT INTO salaries(emp_no, from_date, to_date)
					SELECT emp_no, from_date, to_date 
                    FROM titles 
                    WHERE emp_no IN ('10000', '10005'); -- Error Code: 1364. Field 'salary' doesn't have a default value
        
		-- 4.5 - Copying table definitions (column names), but not the contents (rows)

					CREATE TABLE newtable2 
                    AS 
                    SELECT * FROM employees WHERE 1 = 0;
                    
                    DESCRIBE newtable2;
                    
                    DESCRIBE employees;

					SELECT * FROM newtable2;

					SELECT * FROM employees;
		
		-- 4.6 - Update records in a table.Say, you want to increase the salary of all employees who served more than 10 years by 10%.
					SELECT * FROM salaries where emp_no = 10002; -- 6 row(s) returned
                    
					UPDATE salaries 
                    SET salary = salary*1.10
                    WHERE emp_no = 10002; -- 6 row(s) affected Rows matched: 6  Changed: 6  Warnings: 0
        
		-- 4.7 - Update records in a table corresponding to another table , Increase the salary of the employees who appear in another table named Emp_bonus
                    select * from salaries where emp_no = 10008; -- 3 row(s) returned
                    
                    UPDATE salaries 
                    SET salary = salary * 1.10
                    WHERE emp_no = 10008; -- can not find any 1 table to corresponding 2nd table to execute the problem	
        
		-- 4.8 - Deleting specific records, Example, delete all the rows that have dept_no

					DELETE FROM employees WHERE emp_no = 500000;
                    
                    SELECT * FROM employees; -- before deleting a record = 300025
  					SELECT * FROM employees; -- after deleting a record  = 300024
        
		-- 4.9 - Delete records in the main that do not exist in another table Delete those student records from main_table who do not appear in the new_table.

                    -- Cannot solve the problem on EMPLOYEES DB as there is no FKey in any table.
        
		-- 4.10 - Delete duplicate records.

					-- Cannot solve the problem on EMPLOYEES DB as there no duplicate records in any table.
        
		-- 4.11 - Delete records from the main_table of students who failed more than or equal to 3 times and appear in the table named fail_grade
							
					-- Cannot solve the problem on EMPLOYEES DB as there are no such records in any table.
                    