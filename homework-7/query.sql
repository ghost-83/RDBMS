-- Создайте таблицу
CREATE TABLE statistic(
                          player_name VARCHAR(100) NOT NULL,
                          player_id INT NOT NULL,
                          year_game SMALLINT NOT NULL CHECK (year_game > 0),
                          points DECIMAL(12,2) CHECK (points >= 0),
                          PRIMARY KEY (player_name,year_game)
);

-- Заполнить данными
INSERT INTO
    statistic(player_name, player_id, year_game, points)
VALUES
    ('Mike',1,2018,18),
    ('Jack',2,2018,14),
    ('Jackie',3,2018,30),
    ('Jet',4,2018,30),
    ('Luke',1,2019,16),
    ('Mike',2,2019,14),
    ('Jack',3,2019,15),
    ('Jackie',4,2019,28),
    ('Jet',5,2019,25),
    ('Luke',1,2020,19),
    ('Mike',2,2020,17),
    ('Jack',3,2020,18),
    ('Jackie',4,2020,29),
    ('Jet',5,2020,27);

-- Запрос суммы очков с группировкой и сортировкой по годам
SELECT year_game, sum(points)
FROM statistic
GROUP BY year_game
ORDER BY year_game;

-- CTE суммы очков с группировкой и сортировкой по годам
WITH statistic AS (SELECT year_game AS years, sum(points) AS points
                   FROM statistic
                   GROUP BY year_game
                   ORDER BY year_game)
SELECT years, points
FROM statistic;

-- LAG вывести кол-во очков по всем игрокам за текущий код и за предыдущий
WITH statistic AS (SELECT
                player_id,
                player_name,
                year_game,
                LAG(points) OVER win AS prev_year_points,
                points
            FROM statistic
                WINDOW win AS (
                    PARTITION BY player_name
                    ORDER BY year_game
                    ))
SELECT player_name, year_game, points::int, prev_year_points
FROM statistic
WHERE year_game > 2018;