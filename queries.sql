select first_name, last_name
from employees
where birth_date between '1952-01-01' and '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name, birth_date, hire_date
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select count(first_name)
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Creating a new table for retirement eligibility
select first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

DROP TABLE retirement_info;

select emp_no, first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining departments and dept_manager tables
select retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
from retirement_info
left join dept_emp
on retirement_info.emp_no = dept_emp.emp_no;

-- Joining departments and dept_manager tables with aliasis
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no;

-- Exporting the current employees data in a new table
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no
where de.to_date = ('1999-01-01');

-- Employee count by deparmtent number
SELECT COUNT(ce.emp_no), de.dept_no
into dept_empcount
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
order BY de.dept_no;

-- To get Employee Information
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender, 
	s.salary, 
	de.to_date
into emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
		AND (de.to_date = '9999-01-01');

-- To get manager information
select dm.dept_no, 
	d.dept_name, 
	dm.emp_no, 
	ce.last_name, 
	ce.first_name, 
	dm.from_date, 
	dm.to_date
into manager_info
from dept_manager as dm
	inner join departments as d
		on (dm.dept_no = d.dept_no)
	inner join current_emp as ce
		on (dm.emp_no = ce.emp_no);


-- Skill Drill: Retirement data for Sales
select ri.emp_no, 
	ri.first_name,
	ri.last_name,
	d.dept_name
from retirement_info as ri
left join dept_emp as de
	on (ri.emp_no=de.emp_no)
left join departments as d
	on (de.dept_no=d.dept_no)
where (d.dept_name = 'Sales')


-- Skill Drill 2: Retirement data for Sales
select ri.emp_no, 
	ri.first_name,
	ri.last_name,
	d.dept_name
from retirement_info as ri
left join dept_emp as de
	on (ri.emp_no=de.emp_no)
left join departments as d
	on (de.dept_no=d.dept_no)
where d.dept_name in ('Sales','Development');

