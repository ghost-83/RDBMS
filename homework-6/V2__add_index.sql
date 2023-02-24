-- Для увеличения скорости поика
CREATE INDEX IF NOT EXISTS core_user_login_idx ON core."user" (login);
-- Для увеличения скорости поика
CREATE INDEX IF NOT EXISTS core_user_email_idx ON core."user" (email);
--частичные индексы для получения не активных пользователей для дальнейшей активации
CREATE INDEX IF NOT EXISTS core_user_active_idx ON core."user" (active) WHERE active = false;
-- Для увеличения скорости поика
CREATE INDEX IF NOT EXISTS reference_book_title_idx ON data.reference_book USING GIN (title);
-- Для увеличения скорости фильтрации
CREATE INDEX IF NOT EXISTS reference_book_category_idx ON data.reference_book (category);
-- Для увеличения скорости поика
CREATE INDEX IF NOT EXISTS post_title_idx ON data.post USING GIN (title);
-- Для увеличения скорости фильтрации
CREATE INDEX IF NOT EXISTS post_category_idx ON data.post (category);
-- Для увеличения скорости поика
CREATE INDEX IF NOT EXISTS g_file_name_idx ON g_file.g_file (name, category);
-- Для увеличения скорости поика
CREATE INDEX IF NOT EXISTS movie_title_idx ON media.movie USING GIN (title);
-- Для увеличения скорости фильтрации
CREATE INDEX IF NOT EXISTS movie_category_idx ON media.movie (category);
-- Для увеличения скорости поика
CREATE INDEX IF NOT EXISTS music_name_idx ON media.music (name);
-- Для увеличения скорости фильтрации
CREATE INDEX IF NOT EXISTS music_genre_idx ON media.music USING GIN  (genre);