# Реализация через LOAD DATA

set sql_mode = 'ALLOW_INVALID_DATES';

load data infile '/var/lib/mysql-files/movie.csv'
    into table movie
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (id, title, 'text', group_code, url_file, category, user_id, created, 'active');

# Реализовать в виде хранимой процедуры

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

set sql_mode = 'ALLOW_INVALID_DATES';

load data infile '/var/lib/mysql-files/music.csv'
    into table ghost.temp
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    (id, name, url_name, genre, sorted, favorites, user_id, created, active);

create procedure ghost.copy_data_music()
begin
    insert into ghost.music
    select *
    from ghost.temp;
end;

call ghost.copy_data_music();