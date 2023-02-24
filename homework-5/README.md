# Домашнее задание

DML в PostgreSQL.

## Цель

+ Написать запрос с конструкциями SELECT, JOIN
+ Написать запрос с добавлением данных INSERT INTO
+ Написать запрос с обновлением данных с UPDATE FROM
+ Использовать using для оператора DELETE.

## Описание задание

+ Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.
+ Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на результат? Почему?
+ Напишите запрос на добавление данных с выводом информации о добавленных строках.
+ Напишите запрос с обновлением данные используя UPDATE FROM.
+ Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.

## Реализация

+ Поиск пользователей с неправильным EMAIL

```SQL
SELECT *
FROM core.user
WHERE email !~ '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-z]+$';
```

+ Запрос выведет все записи с левой таблицы и добавит данные из правой. Если какие то из строк связать не удасться, они заменяются на null

```SQL
SELECT *
FROM core.user AS cu
JOIN data.post dp ON dp.user_id = cu.id
WHERE cu."role" = 'ADMIN';
```

+ Выводит только строки которые удалось связать 

```SQL
SELECT *
FROM core.user AS cu
INNER JOIN data.post dp ON dp.user_id = cu.id
WHERE cu."role" = 'ADMIN';
```

+ Добавление новой категорию и возвращает id

```SQL
INSERT INTO data.category(name, created)
VALUES ('GO', '2021-11-09')
RETURNING id;
```

+ Обновление имени автора

```SQL
UPDATE data.post
SET author = cun."name"
FROM (SELECT "name" FROM core.user AS cu WHERE cu."role" = 'ADMIN') AS cun;
```

+ Удаление постов

```SQL
DELETE FROM data.post AS dp
USING core."user" AS cu
WHERE dp.user_id = cu.id AND cu."role" = 'ADMIN';
```
