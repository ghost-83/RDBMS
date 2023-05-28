CREATE database ghost;

USE ghost;

# Обращения
CREATE TABLE `titles` (
                          `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                          `created_at` timestamp,
                          `title` varchar(15) NOT NULL
);

# Язык
CREATE TABLE `languages` (
                             `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                             `created_at` timestamp,
                             `language` varchar(2) NOT NULL
);

# Пользователи
CREATE TABLE `users` (
                         `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                         `created_at` timestamp,
                         `first_name` varchar(100),
                         `last_name` varchar(100),
                         `middle_name` varchar(100),
                         `birth_date` date,
                         `gender` enum('Female', 'Male', 'Unknown'),
                         `marital_status` enum('Married', 'Free', 'Divorced'),
                         `title_fk` int,
                         `corr_language_fk` int
);

# Страны
CREATE TABLE `countries` (
                             `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                             `created_at` timestamp,
                             `country_code` varchar(2) NOT NULL,
                             `country` varchar(70)
);

# Регионы
CREATE TABLE `regions` (
                           `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                           `created_at` timestamp,
                           `country_fk` int NOT NULL,
                           `region` varchar(170) NOT NULL
);

# Почтовые индексы
CREATE TABLE `postal_codes` (
                                `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                                `created_at` timestamp,
                                `postal_code` varchar(12) UNIQUE NOT NULL,
                                `country_fk` int
);

# Города
CREATE TABLE `cities` (
                          `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                          `created_at` timestamp,
                          `country_fk` int,
                          `region_fk` int,
                          `city` varchar(180) NOT NULL
);

# Улицы
CREATE TABLE `streets` (
                           `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                           `created_at` timestamp,
                           `city_fk` int,
                           `street` varchar(200) UNIQUE NOT NULL
);

# Дома
CREATE TABLE `houses` (
                          `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                          `created_at` timestamp,
                          `street_fk` int NOT NULL,
                          `house` varchar(12)
);

# Адреса
CREATE TABLE `user_adresses` (
                                 `id` int UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
                                 `created_at` timestamp,
                                 `user_fk` int,
                                 `address` json,
                                 `country_fk` int,
                                 `postal_code_fk` int,
                                 `region_fk` int,
                                 `city_fk` int,
                                 `street_fk` int,
                                 `house_fk` int,
                                 `building` varchar(30),
                                 `flat` varchar(10)
);

ALTER TABLE `users` ADD FOREIGN KEY (`title_fk`) REFERENCES `titles` (`id`);

ALTER TABLE `users` ADD FOREIGN KEY (`corr_language_fk`) REFERENCES `languages` (`id`);

ALTER TABLE `regions` ADD FOREIGN KEY (`country_fk`) REFERENCES `countries` (`id`);

ALTER TABLE `postal_codes` ADD FOREIGN KEY (`country_fk`) REFERENCES `countries` (`id`);

ALTER TABLE `cities` ADD FOREIGN KEY (`country_fk`) REFERENCES `countries` (`id`);

ALTER TABLE `cities` ADD FOREIGN KEY (`region_fk`) REFERENCES `regions` (`id`);

ALTER TABLE `streets` ADD FOREIGN KEY (`city_fk`) REFERENCES `cities` (`id`);

ALTER TABLE `houses` ADD FOREIGN KEY (`street_fk`) REFERENCES `streets` (`id`);

ALTER TABLE `user_adresses` ADD FOREIGN KEY (`user_fk`) REFERENCES `users` (`id`);

ALTER TABLE `user_adresses` ADD FOREIGN KEY (`country_fk`) REFERENCES `countries` (`id`);

ALTER TABLE `user_adresses` ADD FOREIGN KEY (`postal_code_fk`) REFERENCES `postal_codes` (`id`);

ALTER TABLE `user_adresses` ADD FOREIGN KEY (`region_fk`) REFERENCES `regions` (`id`);

ALTER TABLE `user_adresses` ADD FOREIGN KEY (`city_fk`) REFERENCES `cities` (`id`);

ALTER TABLE `user_adresses` ADD FOREIGN KEY (`street_fk`) REFERENCES `streets` (`id`);

ALTER TABLE `user_adresses` ADD FOREIGN KEY (`house_fk`) REFERENCES `houses` (`id`);