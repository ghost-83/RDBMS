
-- Поиск пользователей с неправильным EMAIL
SELECT *
FROM core.user
WHERE email !~ '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-z]+$';

-- Запросы left join и inner JOIN
SELECT *
FROM core.user AS cu
JOIN data.post dp ON dp.user_id = cu.id
WHERE cu."role" = 'ADMIN';

SELECT *
FROM core.user AS cu
INNER JOIN data.post dp ON dp.user_id = cu.id
WHERE cu."role" = 'ADMIN';

-- Добавление новой категории
INSERT INTO data.category(name, created)
VALUES ('GO', '2021-11-09')
RETURNING id;

-- Обновление имени автора
UPDATE data.post
SET author = cun."name"
FROM (SELECT "name" FROM core.user AS cu WHERE cu."role" = 'ADMIN') AS cun;

-- Удаление постов
DELETE FROM data.post AS dp
USING core."user" AS cu
WHERE dp.user_id = cu.id AND cu."role" = 'ADMIN';
