-- Создание БД:

CREATE DATABASE ghost;

-- Добавление пользователя и роли:

CREATE USER test WITH PASSWORD 'Test-1234';

GRANT ALL PRIVILEGES ON DATABASE ghost TO test;

-- Добавление схем:

CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS data;
CREATE SCHEMA IF NOT EXISTS media;
CREATE SCHEMA IF NOT EXISTS g_file;

--Добавление таблици пользователей.

CREATE TABLE IF NOT EXISTS core.user
(
    id       BIGSERIAL PRIMARY KEY,
    login    VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100)        NOT NULL,
    name     VARCHAR(100) UNIQUE NOT NULL,
    email    VARCHAR(100) UNIQUE NOT NULL,
    role     VARCHAR(50),
    created  TIMESTAMP WITH TIME ZONE,
    updated  TIMESTAMP WITH TIME ZONE,
    active   BOOLEAN DEFAULT TRUE
);

--Добавление таблици категории справочника.

CREATE TABLE IF NOT EXISTS data.category
(
    id      BIGSERIAL PRIMARY KEY,
    name    VARCHAR(50) UNIQUE NOT NULL,
    created TIMESTAMP WITH TIME ZONE
);

--Добавление таблици справочника.

CREATE TABLE IF NOT EXISTS data.reference_book
(
    id       BIGSERIAL PRIMARY KEY,
    title    VARCHAR(254) NOT NULL,
    text     TEXT         NOT NULL,
    author   VARCHAR(100) NOT NULL
        CONSTRAINT reference_book_user_id_fk REFERENCES core.user (name) ON UPDATE CASCADE,
    user_id  BIGINT       NOT NULL REFERENCES core.user (id) ON UPDATE CASCADE,
    category VARCHAR(50)  NOT NULL REFERENCES data.category (name) ON UPDATE CASCADE,
    created  TIMESTAMP WITH TIME ZONE,
    updated  TIMESTAMP WITH TIME ZONE,
    active   BOOLEAN DEFAULT TRUE
);

--Добавление таблици постов.

CREATE TABLE IF NOT EXISTS data.post
(
    id       BIGSERIAL PRIMARY KEY,
    title    VARCHAR(254) NOT NULL,
    text     TEXT         NOT NULL,
    author   VARCHAR(100) NOT NULL REFERENCES core.user (name) ON UPDATE CASCADE,
    user_id  BIGINT       NOT NULL REFERENCES core.user (id) ON UPDATE CASCADE,
    category VARCHAR(50)  NOT NULL REFERENCES data.category (name) ON UPDATE CASCADE,
    image    VARCHAR(254) NOT NULL,
    created  TIMESTAMP WITH TIME ZONE,
    update   TIMESTAMP WITH TIME ZONE,
    active   BOOLEAN DEFAULT TRUE
);

--Добавление таблици файлов.

CREATE TABLE IF NOT EXISTS g_file.g_file
(
    id        BIGSERIAL PRIMARY KEY,
    name      VARCHAR(254) NOT NULL,
    url_name  VARCHAR(254) NOT NULL,
    size      BIGINT       NOT NULL,
    user_name VARCHAR(100) NOT NULL REFERENCES core.user (name) ON UPDATE CASCADE,
    category  VARCHAR(100) NOT NULL,
    created   TIMESTAMP WITH TIME ZONE,
    active    BOOLEAN DEFAULT TRUE
);

--Добавление таблици фильмов.

CREATE TABLE IF NOT EXISTS media.movie
(
    id         BIGSERIAL PRIMARY KEY,
    title      VARCHAR(254) NOT NULL,
    text       TEXT         NOT NULL,
    group_code BIGINT       NOT NULL,
    url_file   JSONB        NOT NULL,
    category   VARCHAR(50),
    user_id    BIGINT       NOT NULL REFERENCES core.user (id) ON UPDATE CASCADE,
    created    TIMESTAMP WITH TIME ZONE,
    active     BOOLEAN DEFAULT TRUE
);

--Добавление таблици музыки.

CREATE TABLE IF NOT EXISTS media.music
(
    id        BIGSERIAL PRIMARY KEY,
    name      VARCHAR(254) NOT NULL,
    url_name  VARCHAR(254) NOT NULL,
    genre     VARCHAR(50),
    sorted    BIGINT,
    favorites BOOLEAN DEFAULT FALSE,
    user_id   BIGINT       NOT NULL REFERENCES core.user (id) ON UPDATE CASCADE,
    created   TIMESTAMP WITH TIME ZONE,
    active    BOOLEAN DEFAULT TRUE
);


--Заполняем таблици начальными данными

INSERT INTO data.category(name, created)
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

--Создаем админа

INSERT INTO core.user(login, password, name, email, role, created, updated, active)
VALUES ('ghost_83', '8766EDA20B0991F76FEAD173B0E41296', 'admin', 'ghost_83@mail.ru',
        'ADMIN', '2021-11-09', '2021-11-09', true),
       ('ghost', '8766EDA20B0991F76FEAD173B0E41296', 'ghost', 'ghost1783@gmail.com',
        'USER', '2021-11-09', '2021-11-09', true);

COMMENT ON TABLE core.user IS 'Таблица пользователей.';
COMMENT ON COLUMN core.user.id IS 'ID';
COMMENT ON COLUMN core.user.login IS 'Логин пользователя';
COMMENT ON COLUMN core.user.password IS 'Пароль пользователя';
COMMENT ON COLUMN core.user.name IS 'Имя пользователя';
COMMENT ON COLUMN core.user.email IS 'Email пользователя';
COMMENT ON COLUMN core.user.role IS 'Роль пользователя';
COMMENT ON COLUMN core.user.created IS 'Дата создания';
COMMENT ON COLUMN core.user.updated IS 'Дата обновления';
COMMENT ON COLUMN core.user.active IS 'Активность';

COMMENT ON TABLE data.post IS 'Таблица постов.';
COMMENT ON COLUMN data.post.id IS 'ID';
COMMENT ON COLUMN data.post.title IS 'Заголовок';
COMMENT ON COLUMN data.post.text IS 'Текст';
COMMENT ON COLUMN data.post.author IS 'Имя пользователя добавившего';
COMMENT ON COLUMN data.post.user_id IS 'ID пользователя добавившего';
COMMENT ON COLUMN data.post.category IS 'Категория';
COMMENT ON COLUMN data.post.image IS 'Ссылка картинки на заставку';
COMMENT ON COLUMN data.post.created IS 'Дата создания';
COMMENT ON COLUMN data.post.update IS 'Дата обновления';
COMMENT ON COLUMN data.post.active IS 'Активность';

COMMENT ON TABLE data.reference_book IS 'Таблица справочник.';
COMMENT ON COLUMN data.reference_book.id IS 'ID';
COMMENT ON COLUMN data.reference_book.title IS 'Заголовок';
COMMENT ON COLUMN data.reference_book.text IS 'Текст';
COMMENT ON COLUMN data.reference_book.author IS 'Имя пользователя добавившего';
COMMENT ON COLUMN data.reference_book.user_id IS 'ID пользователя добавившего';
COMMENT ON COLUMN data.reference_book.category IS 'Категория';
COMMENT ON COLUMN data.reference_book.created IS 'Дата создания';
COMMENT ON COLUMN data.reference_book.updated IS 'Дата обновления';
COMMENT ON COLUMN data.reference_book.active IS 'Активность';

COMMENT ON TABLE data.category IS 'Таблица категорий для постов и справочника.';
COMMENT ON COLUMN data.category.id IS 'ID';
COMMENT ON COLUMN data.category.name IS 'Название';
COMMENT ON COLUMN data.category.created IS 'Дата создания';

COMMENT ON TABLE g_file.g_file IS 'Таблица файлов для хранения и скачивания.';
COMMENT ON COLUMN g_file.g_file.id IS 'ID';
COMMENT ON COLUMN g_file.g_file.name IS 'Название файла';
COMMENT ON COLUMN g_file.g_file.url_name IS 'Ссылка на файл';
COMMENT ON COLUMN g_file.g_file.size IS 'Размер';
COMMENT ON COLUMN g_file.g_file.user_name IS 'Имя пользователя загрузившего';
COMMENT ON COLUMN g_file.g_file.category IS 'Категория';
COMMENT ON COLUMN g_file.g_file.created IS 'Дата создания';
COMMENT ON COLUMN g_file.g_file.active IS 'Активность';

COMMENT ON TABLE media.movie IS 'Таблица фильмов.';
COMMENT ON COLUMN media.movie.id IS 'ID';
COMMENT ON COLUMN media.movie.title IS 'Название фильма';
COMMENT ON COLUMN media.movie.text IS 'Описание фильма';
COMMENT ON COLUMN media.movie.url_file IS 'JSON с сылками на постер, заставку и файл с фильмом';
COMMENT ON COLUMN media.movie.group_code IS 'Имя пользователя';
COMMENT ON COLUMN media.movie.user_id IS 'ID пользователя добавившего';
COMMENT ON COLUMN media.movie.category IS 'Категория';
COMMENT ON COLUMN media.movie.created IS 'Дата создания';
COMMENT ON COLUMN media.movie.active IS 'Активность';

COMMENT ON TABLE media.music IS 'Таблица музыки.';
COMMENT ON COLUMN media.music.id IS 'ID';
COMMENT ON COLUMN media.music.name IS 'Название файла';
COMMENT ON COLUMN media.music.url_name IS 'Ссылка на файл';
COMMENT ON COLUMN media.music.user_id IS 'ID пользователя добавившего';
COMMENT ON COLUMN media.music.favorites IS 'Добавлено в избранное';
COMMENT ON COLUMN media.music.genre IS 'Жанр';
COMMENT ON COLUMN media.music.created IS 'Дата создания';
COMMENT ON COLUMN media.music.sorted IS 'Поле для сортировки';
COMMENT ON COLUMN media.music.active IS 'Активность';