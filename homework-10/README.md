# Домашнее задание

Типы данных.

## Цель

+ Вдумчиво подбираем нужные типы данных.
+ Определяемся с типом ID.
+ Изучаем тип JSON.

## Описание задание

+ Проанализировать типы данных в своем проекте, изменить при необходимости. В README указать что на что поменялось и почему.
+ Добавить тип JSON в структуру. Проанализировать какие данные могли бы там хранится. привести примеры SQL для добавления записей и выборки.

## Реализация



+ Добавление таблици пользователей.

```SQL
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
```

+ Добавление таблици категории справочника.

```SQL
CREATE TABLE IF NOT EXISTS category
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(50) UNIQUE NOT NULL,
    created TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP
    );
```

+ Добавление таблици справочника.

```SQL
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
```

+ Добавление таблици постов.

```SQL
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
```

+ Добавление таблици файлов.

```SQL
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
```

+ Добавление таблици фильмов.

```SQL
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
```

+ Добавление таблици музыки.

```SQL
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
```
