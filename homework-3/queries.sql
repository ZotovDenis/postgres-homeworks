-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT ship_name AS customer, CONCAT(employees.first_name, ' ', employees.last_name) AS employee
FROM orders
INNER JOIN employees USING(employee_id)
INNER JOIN customers USING(customer_id)
WHERE orders.ship_country=employees.country AND employees.city = 'London'
AND orders.ship_country = customers.country AND customers.city = 'London' AND orders.ship_via = 2;

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT products.product_name, products.units_in_stock, suppliers.contact_name, suppliers.phone FROM products
JOIN suppliers ON products.supplier_id = suppliers.supplier_id
WHERE products.discontinued = 0
AND products.units_in_stock < 25
AND products.category_id IN (
    SELECT categories.category_id
    FROM categories
    WHERE categories.category_name IN ('Dairy Products', 'Condiments')
  )
ORDER BY products.units_in_stock;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT customers.company_name AS company_name
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.company_name
HAVING COUNT(orders.ship_name) = 0;

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT product_name FROM products
WHERE product_id IN (
	SELECT product_id FROM order_details
	WHERE quantity = 10
);