# Получения списка файлов активных пользователей(для дальнейшей чистки и освобождения свободного места)

SELECT gg.*
FROM ghost.g_file gg
         INNER JOIN user u ON gg.user_name = u.name AND u.active = false;

# Получени все заметок созданных определенной группой

SELECT grb.*
FROM ghost.reference_book grb
         LEFT JOIN ghost.user gu on grb.user_id = gu.id
WHERE gu.role = 'ADMIN';

# Получени все заметок созданных определенным пользователем

SELECT grb.*
FROM ghost.reference_book grb
         LEFT JOIN ghost.user gu on grb.user_id = gu.id
WHERE gu.name = 'ghost';

# Получени отсортированных песен определенной категории

SELECT *
FROM ghost.music gm
WHERE gm.genre = 'rook'
ORDER BY gm.sorted;

# Получени количества фильмов по категории

SELECT category, count(*) AS quantity
FROM ghost.movie gm
GROUP BY gm.category;

# Получени фильмов по названию

SELECT *
FROM ghost.movie gm
WHERE gm.title LIKE '%test%';

# Получени постов только активных пользователей

SELECT gp.*
FROM ghost.post gp
WHERE gp.user_id IN (SELECT id FROM ghost.user gu WHERE gu.active = true);