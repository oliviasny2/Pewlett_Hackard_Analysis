-- Tables for import in the schema.sql file
-- Retrieve emp_no, first_name, and last_name from employees table
SELECT emp_no, first_name, last_name FROM employees

-- Retrieve title, from_date, and to_date from titles table
SELECT title, from_date, to_date FROM titles

-- Create new table to join employees and titles tables
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	tl.title,
	tl.from_date,
	tl.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Exported to Data folder under retirement_titles.csv

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.titles
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

-- Create a table to obtain the count of all the employees about to retire
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;