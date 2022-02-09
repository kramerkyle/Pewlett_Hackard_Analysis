-- Use SELECT, INTO,INNER JOIN, WHERE, BETWEEN, and ORDER BY to create a table of retirement titles.
SELECT  e.emp_no,
		e.first_name,
		e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date
	INTO retirement_titles
    FROM employees as e
    INNER JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
	WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
	ORDER BY e.emp_no ASC;
--
-- USE DISTINCT ON to only take the most recent job title of current employees.
SELECT DISTINCT ON(rt.emp_no)	
		rt.emp_no,
		rt.first_name,
		rt.last_name,
		rt.title
	INTO unique_tables
    FROM retirement_titles as rt
    WHERE rt.to_date = '9999-01-01'
    ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- COUNT and GROUP BY title
SELECT 	COUNT (ut.title), 
		ut.title
	INTO retiring_titles
	FROM unique_tables as ut
	GROUP BY ut.title
	ORDER BY ut.count DESC;

-- Mentorship Eligibility Table
SELECT	DISTINCT ON (e.emp_no)
		e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		ti.title
	INTO mentorship_eligibility
	FROM employees as e
	INNER JOIN dept_employees as de
		ON (de.emp_no = e.emp_no)
	INNER JOIN titles as ti
		ON (ti.emp_no = e.emp_no)
	WHERE ti.to_date = '9999-01-01'
		AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
	ORDER BY e.emp_no ASC;

-- Mentorship titles
SELECT COUNT (me.title), 
 		me.title
 	 INTO mentorship_titles
  	FROM mentorship_eligibility as me
  	GROUP BY me.title
	ORDER BY me.count DESC;

-- Mentorship Longevity
SELECT * 
	INTO mentorship_longevity
FROM mentorship_eligibility as me
	ORDER BY me.from_date ASC;