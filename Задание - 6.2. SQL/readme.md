# Задание - 6.2. SQL

##        1. Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

### Ответ:
```
docker-compose.yaml

version: "3.9"

volumes:
  postgres_data:  
  backup_postgres:

services:
  
  postgres:
    image: postgres:12-bullseye 
    environment:
      PGDATA: "/var/lib/postgresql/data/"
      POSTGRES_PASSWORD: "ps123"
    volumes:
      - ./postgres_data:/var/lib/postgresql/data
      - ./backup_postgres:/backup
      - ./config:/docker-entrypoint-initdb.d
    ports:
      - "5432:5432"
```
##        2. В БД из задачи 1:

- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
Таблица orders:

- id (serial primary key)
- наименование (string)
- цена (integer)
Таблица clients:

- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)
Приведите:

- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db



### Ответ:

- итоговый список БД после выполнения пунктов выше
```
\l
  List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)
```
- описание таблиц (describe)

```
postgres=# \d+ orders
  Table "public.orders"
 Column |  Type   | Collation | Nullable |              Default               | Storage  | Stats target | Description 
--------+---------+-----------+----------+------------------------------------+----------+--------------+-------------
 id     | integer |           | not null | nextval('orders_id_seq'::regclass) | plain    |              | 
 name   | text    |           |          |                                    | extended |              | 
 price  | integer |           |          |                                    | plain    |              | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_name_fkey" FOREIGN KEY (order_name) REFERENCES orders(id)
Access method: heap

postgres=# \d+ clients
 Table "public.clients"
   Column    |  Type   | Collation | Nullable |               Default               | Storage  | Stats target | Description 
-------------+---------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id          | integer |           | not null | nextval('clients_id_seq'::regclass) | plain    |              | 
 lastname    | text    |           |          |                                     | extended |              | 
 countryname | text    |           |          |                                     | extended |              | 
 order_name  | integer |           |          |                                     | plain    |              | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "countryname_index" btree (countryname)
Foreign-key constraints:
    "clients_order_name_fkey" FOREIGN KEY (order_name) REFERENCES orders(id)
Access method: heap
```

- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
SELECT table_name,grantee,privilege_type 
FROM information_schema.table_privileges
WHERE table_name='orders' OR table_name='clients';
```

- список пользователей с правами над таблицами test_db
```
table_name |     grantee      | privilege_type 
------------+------------------+----------------
 orders     | postgres         | INSERT
 orders     | postgres         | SELECT
 orders     | postgres         | UPDATE
 orders     | postgres         | DELETE
 orders     | postgres         | TRUNCATE
 orders     | postgres         | REFERENCES
 orders     | postgres         | TRIGGER
 orders     | test-admin-user  | INSERT
 orders     | test-admin-user  | SELECT
 orders     | test-admin-user  | UPDATE
 orders     | test-admin-user  | DELETE
 orders     | test-admin-user  | TRUNCATE
 orders     | test-admin-user  | REFERENCES
 orders     | test-admin-user  | TRIGGER
 orders     | test-simple-user | INSERT
 orders     | test-simple-user | SELECT
 orders     | test-simple-user | UPDATE
 orders     | test-simple-user | DELETE
 clients    | postgres         | INSERT
 clients    | postgres         | SELECT
 clients    | postgres         | UPDATE
 clients    | postgres         | DELETE
 clients    | postgres         | TRUNCATE
 clients    | postgres         | REFERENCES
 clients    | postgres         | TRIGGER
 clients    | test-admin-user  | INSERT
 clients    | test-admin-user  | SELECT
 clients    | test-admin-user  | UPDATE
 clients    | test-admin-user  | DELETE
 clients    | test-admin-user  | TRUNCATE
 clients    | test-admin-user  | REFERENCES
 clients    | test-admin-user  | TRIGGER
 clients    | test-simple-user | INSERT
 clients    | test-simple-user | SELECT
 clients    | test-simple-user | UPDATE
 clients    | test-simple-user | DELETE
(36 rows)
```


##       3. Используя SQL синтаксис - наполните таблицы следующими тестовыми данными

Используя SQL синтаксис:

вычислите количество записей для каждой таблицы
приведите в ответе:
запросы
результаты их выполнения.

### Ответ:
```
INSERT INTO orders (name, price) VALUES ('Шоколад', 10), ('Принтер', 3000), ('Книга', 500), ('Монитор', 7000), ('Гитара', 4000);
```
```
INSERT INTO clients (lastname, countryname) VALUES ('Иванов Иван Иванович', 'USA'), ('Петров Петр Петрович', 'Canada'), ('Иоганн Себастьян Бах', 'Japan'), ('Ронни Джеймс Дио', 'Russia'), ('Ritchie Blackmore', 'Russia');
```
вычислите количество записей для каждой таблицы:
```
select count(*) from orders;
```
```
count 
-------
     5
(1 row)
```
```
select count(*) from clients;
```
```
count 
-------
     5
(1 row)
```

##        4. Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице
Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.

Подсказк - используйте директиву UPDATE.

### Ответ: 
       Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
```
update  clients set order_name = 3 where id = 1;
update  clients set order_name = 4 where id = 2;
update  clients set order_name = 5 where id = 3;
```
```
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
SELECT * FROM clients WHERE order_name is not NULL;
 id |       lastname       | countryname | order_name 
----+----------------------+-------------+------------
  1 | Иванов Иван Иванович | USA         |          3
  2 | Петров Петр Петрович | Canada      |          4
  3 | Иоганн Себастьян Бах | Japan       |          5
(3 rows)
```

##        5.Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

### Ответ:
```
explain SELECT * FROM clients WHERE order_name is not NULL;
```
```
                        QUERY PLAN                         
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: (order_name IS NOT NULL)
(2 rows)
```

Считываем последовательно данные из таблицы clients
Стоимость получения первого значения 0.00
Стоимость получения всех строк 18.10
Приблизительное количество проверенных строк 806
Средний размер каждой строки в байтах составил 72
Используется фильтр order_name IS NOT NULL

##        6. Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.

### Ответ:
Создаем бекап
```
docker exec -t docker-postgres-1 pg_dump -U postgres test_db -f /backup
```
Восстанавливаем бекап в новом пустом контейнере
```
docker exec -t docker-postgres-2 psql -U postgres test_db -f /backup
