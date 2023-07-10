"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv
import os

import psycopg2

password = os.getenv('postgres')

script_dir = os.path.dirname(__file__)
csv_employees = os.path.join(script_dir, 'north_data', 'employees_data.csv')
csv_customers = os.path.join(script_dir, 'north_data', 'customers_data.csv')
csv_orders = os.path.join(script_dir, 'north_data', 'orders_data.csv')

# Подключаемся к базе данных
conn = psycopg2.connect(host="localhost", database="north", user="postgres", password=password)

# Заполняем таблицу employees
try:
    with conn:
        with conn.cursor() as cur:
            with open(csv_employees, 'r', encoding='utf-8') as file:
                reader = csv.reader(file)

                # Пропускаем заголовок с названиями столбцов
                next(reader)
                # Преобразуем каждую полученную из файла строку в кортеж и передаем его на запись в таблицу
                for row in reader:
                    tuple_info = tuple(row)
                    cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)", tuple_info)
                    cur.execute("SELECT * FROM employees")
finally:
    conn.close()

# Заполняем таблицу customers
try:
    with conn:
        with conn.cursor() as cur:
            with open(csv_customers, 'r', encoding='utf-8') as file:
                reader = csv.reader(file)

                # Пропускаем заголовок с названиями столбцов
                next(reader)
                # Преобразуем каждую полученную из файла строку в кортеж и передаем его на запись в таблицу
                for row in reader:
                    tuple_info = tuple(row)
                    cur.execute("INSERT INTO customers VALUES (%s, %s, %s)", tuple_info)
                    cur.execute("SELECT * FROM customers")
finally:
    conn.close()

# Заполняем таблицу orders
try:
    with conn:
        with conn.cursor() as cur:
            with open(csv_orders, 'r', encoding='utf-8') as file:
                reader = csv.reader(file)

                # Пропускаем заголовок с названиями столбцов
                next(reader)

                # Преобразуем каждую полученную из файла строку в кортеж и передаем его на запись в таблицу
                for row in reader:
                    tuple_info = tuple(row)
                    cur.execute("INSERT INTO orders VALUES (%s, %s, %s)", tuple_info)
                    cur.execute("SELECT * FROM orders")
finally:
    conn.close()
