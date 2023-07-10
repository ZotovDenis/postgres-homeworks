-- SQL-команды для создания таблиц

CREATE TABLE employees
(
	employee_id int PRIMARY KEY,
	first_name varchar(20) NOT NULL,
	last_name varchar(20) NOT NULL,
	title varchar(100),
	birth_date date,
	notes text
);

SELECT * FROM employees;

CREATE TABLE customers
(
	customer_id varchar(5) PRIMARY KEY,
	company_name varchar(70),
	contact_name varchar(50)
);

SELECT * FROM customers;

CREATE TABLE orders
(
	order_id int PRIMARY KEY,
	customer_id varchar(5) REFERENCES customers(customer_id) NOT NULL,
	employee_id int REFERENCES employees(employee_id) NOT NULL,
	order_date date,
	ship_city varchar(50)
);

SELECT * FROM orders