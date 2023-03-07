CREATE database ghost;
USE ghost;

# Добавление таблици пользователей.

CREATE TABLE IF NOT EXISTS user
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    login    VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100)        NOT NULL,
    name     VARCHAR(100) UNIQUE NOT NULL,
    email    VARCHAR(100) UNIQUE NOT NULL,
    role     VARCHAR(50),
    created  TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated  TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active   BOOLEAN                      DEFAULT TRUE
);

# Добавление таблици категории справочника.

CREATE TABLE IF NOT EXISTS category
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(50) UNIQUE NOT NULL,
    created TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP
);

# Добавление таблици справочника.

CREATE TABLE IF NOT EXISTS reference_book
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    title    VARCHAR(500) NOT NULL,
    text     TEXT         NOT NULL,
    author   VARCHAR(100) NOT NULL,
    user_id  INT          NOT NULL REFERENCES user (id) ON UPDATE CASCADE,
    category VARCHAR(50)  NOT NULL REFERENCES category (name) ON UPDATE CASCADE,
    created  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active   BOOLEAN               DEFAULT TRUE
);

# Добавление таблици постов.

CREATE TABLE IF NOT EXISTS post
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    title    VARCHAR(500) NOT NULL,
    text     TEXT         NOT NULL,
    author   VARCHAR(100) NOT NULL REFERENCES user (name) ON UPDATE CASCADE,
    user_id  INT          NOT NULL REFERENCES user (id) ON UPDATE CASCADE,
    category VARCHAR(50)  NOT NULL REFERENCES category (name) ON UPDATE CASCADE,
    image    VARCHAR(500) NOT NULL,
    created  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active   BOOLEAN               DEFAULT TRUE
);

# Добавление таблици файлов.

CREATE TABLE IF NOT EXISTS g_file
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    name      VARCHAR(500) NOT NULL,
    url_name  VARCHAR(500) NOT NULL,
    size      INT          NOT NULL,
    user_name VARCHAR(100) NOT NULL REFERENCES user (name) ON UPDATE CASCADE,
    category  VARCHAR(100) NOT NULL,
    created   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active    BOOLEAN               DEFAULT TRUE
);

# Добавление таблици фильмов.

CREATE TABLE IF NOT EXISTS movie
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    title      VARCHAR(500) NOT NULL,
    text       TEXT         NOT NULL,
    group_code INT          NOT NULL,
    url_file   JSON         NOT NULL,
    category   VARCHAR(50),
    user_id    INT          NOT NULL REFERENCES user (id) ON UPDATE CASCADE,
    created    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active     BOOLEAN               DEFAULT TRUE
);

# Добавление таблици музыки.

CREATE TABLE IF NOT EXISTS music
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    name      VARCHAR(500) NOT NULL,
    url_name  VARCHAR(500) NOT NULL,
    genre     VARCHAR(50),
    sorted    INT,
    favorites BOOLEAN               DEFAULT FALSE,
    user_id   INT          NOT NULL REFERENCES user (id) ON UPDATE CASCADE,
    created   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active    BOOLEAN               DEFAULT TRUE
);


# Заполняем таблици начальными данными

INSERT INTO category(name, created)
VALUES ('python', '2021-11-09'),
       ('linux', '2021-11-09'),
       ('java', '2021-11-09'),
       ('kotlin', '2021-11-09'),
       ('react', '2021-11-09'),
       ('arduino', '2021-11-09'),
       ('postgres', '2021-11-09'),
       ('spring', '2021-11-09'),
       ('raspberry', '2021-11-09'),
       ('vs_code', '2021-11-09'),
       ('nginx', '2021-11-09'),
       ('docker', '2021-11-09'),
       ('android', '2021-11-09'),
       ('c', '2021-11-09'),
       ('cpp', '2021-11-09'),
       ('ssh', '2021-11-09'),
       ('js', '2021-11-09'),
       ('css', '2021-11-09'),
       ('json', '2021-11-09'),
       ('typescript', '2021-11-09');

# Создаем админа

INSERT INTO user(login, password, name, email, role, created, updated, active)
VALUES ('ghost_83', '8766EDA20B0991F76FEAD173B0E41296', 'admin', 'ghost_83@mail.ru',
        'ADMIN', '2021-11-09', '2021-11-09', true),
       ('ghost', '8766EDA20B0991F76FEAD173B0E41296', 'ghost', 'ghost1783@gmail.com',
        'USER', '2021-11-09', '2021-11-09', true);

# Добавление записи с обьектом JSON

INSERT INTO movie(title, text, group_code, url_file, category, user_id, created, active)
VALUES ('Человек-муравей и Оса',
        '<p class="gp">Скотт Лэнг, известный также как Человек-муравей, уже заслужил право оказаться в команде Мстителей. Но желание быть ближе к дочери удерживает его в родном Сан-Франциско – до тех пор, пока доктор Хэнк Пим, создавший когда-то изменяющий размеры своего владельца чудо-костюм, не призывает Скотта присоединиться к новой опасной миссии. А помогать в противостоянии с коварным врагом Человеку-муравью будет новая напарница – Оса.</p>',
        10002,
        '{"image": "Ant-man_and_Wasp.webp", "movie": "Ant-man_and_Wasp.mp4", "poster": "Ant-man_and_Wasp_poster.jpg", "movieEng": null}',
        'fantastic',
        1,
        '2021-11-09',
        true),
       ('Пираты Карибского моря: Проклятие Черной жемчужины',
        '<p class="gp">Жизнь харизматичного авантюриста, капитана Джека Воробья, полная увлекательных приключений, резко меняется, когда его заклятый враг капитан Барбосса похищает корабль Джека Черную Жемчужину, а затем нападает на Порт Ройал и крадет прекрасную дочь губернатора Элизабет Свонн.</p><p class="gp">Друг детства Элизабет Уилл Тернер вместе с Джеком возглавляет спасательную экспедицию на самом быстром корабле Британии, чтобы вызволить девушку и заодно отобрать у злодея Черную Жемчужину. Вслед за этой парочкой отправляется амбициозный коммодор Норрингтон, который к тому же числится женихом Элизабет.</p><p class="gp">Однако Уилл не знает, что над Барбоссой висит вечное проклятие, при лунном свете превращающее его с командой в живых скелетов. Проклятье будет снято лишь тогда, когда украденное золото Ацтеков будет возвращено пиратами на старое место.</p>',
        20001,
        '{"image": "Pirates_of_the_Caribbean_The_Curse_of_the_Black_Pearl_1080p.webp", "movie": "Pirates_of_the_Caribbean_The_Curse_of_the_Black_Pearl_1080p.mp4", "poster": "Pirates_of_the_Caribbean_The_Curse_of_the_Black_Pearl_1080p_poster.jpg", "movieEng": "Pirates_of_the_Caribbean_The_Curse_of_the_Black_Pearl_1080p_ENG.mp4"}',
        'adventures',
        1,
        '2021-11-09',
        true);

SELECT JSON_EXTRACT(url_file, '$.movieEng') AS extract,
       url_file ->'$.movieEng' IS NOT NULL AS test_1,
      url_file ->>'$.movieEng' IS NOT NULL AS test_2
FROM movie
WHERE JSON_VALID(url_file)
AND url_file ->'$.movieEng' IS NOT NULL
AND JSON_EXTRACT(url_file, '$.movieEng') IS NOT NULL;