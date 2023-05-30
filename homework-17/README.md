# Домашнее задание

Восстановить таблицу из бэкап.

## Цель

+ В этом ДЗ осваиваем инструмент для резервного копирования и восстановления - xtrabackup. Задача восстановить конкретную таблицу из сжатого и шифрованного бэкапа.

## Описание задание

+ В материалах приложен файл бэкап backup_des.xbstream.gz.des3 и дамп структуры базы world-db.sql.
+ Бэкап выполнен с помощью команды:
  sudo xtrabackup --backup --stream=xbstream
  --target-dir=/tmp/backups/xtrabackup/stream
  | gzip - | openssl des3 -salt -k "password" \
  stream/backup_des.xbstream.gz.des3
+ Требуется восстановить таблицу world.city из бэкапа и выполнить оператор:
  select count(*) from city where countrycode = 'RUS';.
+ Результат оператора написать в чат с преподавателем.

## Реализация

+ Создали БД и таблицу: 

![:](./png/1.png) 

![:](./png/2.png)

+ Создаем директории: 

![:](./png/3.png)

+ Расшифровываем и распаковываем файл бэкап: 

![:](./png/4.png)

+ Извлекаем бэкап: 

![:](./png/5.png)

+ Извлекаем бэкап отдельной таблицы: 

![:](./png/6.png)

+ Отключаем таблицу: 

![:](./png/7.png)

+ Восстанавливаем бэкап: 

![:](./png/8.png)

+ Восстанавливаем tablespace: 

![:](./png/9.png)

+ Результат: 

![:](./png/10.png)