# Домашнее задание

Транзакции.

## Цель

+ Заполнение своего проекта данными.

## Описание задание

+ Описать пример транзакции из своего проекта с изменением данных в нескольких таблицах. Реализовать в виде хранимой
  процедуры.
+ Загрузить данные из приложенных в материалах csv.

## Реализация

### Реализация через LOAD DATA:

+ Чтобы не возникла проблема с датами выполняем следующий запрос:

```SQL 
set sql_mode = 'ALLOW_INVALID_DATES'; 
```

+ Проверяем путь до файлов MySql: ![:](./png/10.png)
+ Выполняем загрузку:

```SQL
load data infile '/var/lib/mysql-files/movie.csv'
    into table movie
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    (id, title, text, group_code, url_file, category, user_id, created, active);
```

+ Результат операции: ![:](./png/11.png)
+ Результат загрузки: ![:](./png/12.png)
+ К сожалению через mysqlimport не удалось выполнить(((: ![:](./png/13.png)

### Реализация хранимой процедуры:

+ Запускаю docker-compose которай запустит контейнер, скрипт и помещает файл movie.csv в
  /var/lib/mysql-files/ ![:](./png/1.png)
+ Созданная база данных: ![:](./png/2.png)
+ Созтаем таблицу temp:

```SQL
CREATE TABLE IF NOT EXISTS ghost.temp
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

+ Копируем данные из файла music.csv в таблицу temp: ![:](./png/3.png)
+ Создаем хранимую процедуру:

```SQL
create procedure ghost.copy_data_music()
begin
    insert into ghost.music
    select *
    from ghost.temp;
end;
```

+ Выполняем ее: ![:](./png/4.png)
+ Результат: ![:](./png/5.png)
