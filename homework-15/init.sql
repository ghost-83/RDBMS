CREATE database ghost;
USE ghost;

# Добавление таблицы пользователей.

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

# Добавление таблицы категории справочника.

CREATE TABLE IF NOT EXISTS category
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(50) UNIQUE NOT NULL,
    created TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP
);

# Добавление таблицы справочника.

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

# Добавление таблицы постов.

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

# Добавление таблицы файлов.

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

# Добавление таблицы фильмов.

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

# Добавление таблицы оценки фильмов.

CREATE TABLE IF NOT EXISTS movie_grade
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT         NOT NULL REFERENCES movie (id) ON UPDATE CASCADE,
    grade    FLOAT(2, 1) NOT NULL,
    user_id  INT         NOT NULL REFERENCES user (id) ON UPDATE CASCADE,
    created  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

# Добавление таблицы комментариев к фильму.

CREATE TABLE IF NOT EXISTS movie_comment
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT       NOT NULL REFERENCES movie (id) ON UPDATE CASCADE,
    text     TEXT      NOT NULL,
    user_id  INT       NOT NULL REFERENCES user (id) ON UPDATE CASCADE,
    created  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active   BOOLEAN            DEFAULT TRUE
);

# Добавление таблицы музыки.

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


# Заполняем таблицы начальными данными

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