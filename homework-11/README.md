# Домашнее задание

SQL выборка.

## Цель

+ Научиться джойнить таблицы и использовать условия в SQL выборке.

## Описание задание

+ Напишите запрос по своей базе с inner join.
+ Напишите запрос по своей базе с left join.
+ Напишите 5 запросов с WHERE с использованием разных операторов, опишите для чего вам в проекте нужна такая выборка
  данных.

## Реализация

+ Получения списка файлов активных пользователей(для дальнейшей чистки и освобождения свободного места).

```SQL
SELECT gg.*
FROM ghost.g_file gg
         INNER JOIN user u ON gg.user_name = u.name AND u.active = false;
```

+ Получени все заметок созданных определенной группой.

```SQL
SELECT grb.*
FROM ghost.reference_book grb
         LEFT JOIN ghost.user gu on grb.user_id = gu.id
WHERE gu.role = 'ADMIN';
```

+ Получени все заметок созданных определенным пользователем.

```SQL
SELECT grb.*
FROM ghost.reference_book grb
         LEFT JOIN ghost.user gu on grb.user_id = gu.id
WHERE gu.name = 'ghost';
```

+ Получени отсортированных песен определенной категории.

```SQL
SELECT *
FROM ghost.music gm
WHERE gm.genre = 'rook'
ORDER BY gm.sorted;
```

+ Получени количества фильмов по категории.

```SQL
SELECT category, count(*) AS quantity
FROM ghost.movie gm
GROUP BY gm.category;
```

+ Получени фильмов по названию.

```SQL
SELECT *
FROM ghost.movie gm
WHERE gm.title LIKE '%test%';
```

+ Получени постов только активных пользователей.

```SQL
SELECT gp.*
FROM ghost.post gp
WHERE gp.user_id IN (SELECT id FROM ghost.user gu WHERE gu.active = true);
```

