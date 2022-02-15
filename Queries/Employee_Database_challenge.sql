-- Employee Database Challenge
-- Create retirement_titles table
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    t.title,
	t.from_date,
    t.to_date
	INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--Create unique_titles table
SELECT DISTINCT ON (r.emp_no) r.emp_no,
	r.first_name,
	r.last_name,
	r.title
    INTO unique_titles
FROM retirement_titles as r
ORDER BY r.emp_no, r.to_date DESC;

-- Create retiring_titles table
SELECT COUNT(u.title), 
	u.title
	INTO retiring_titles
FROM unique_titles as u
GROUP BY title
ORDER BY u.count DESC;

-- Create mentorship_eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
	INTO mentorship_eligibility
FROM employees as e
JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND de.to_date = ('9999-01-01')
ORDER BY e.emp_no;

-- Additional Analysis queries 
-- Number of employees eligible for mentorship program by title
SELECT COUNT(m.title), 
	m.title
	--INTO mentor_titles
FROM mentorship_eligibility as m
GROUP BY title
ORDER BY m.count DESC;

-- Number of retirees by department
SELECT COUNT(ce.emp_no), de.dept_no,
	u.title
	INTO dept_title_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
LEFT JOIN unique_titles as u
ON ce.emp_no = u.emp_no
GROUP BY de.dept_no, u.title
ORDER BY de.dept_no;