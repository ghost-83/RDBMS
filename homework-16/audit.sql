# Создаем таблицу аудита
create table if not exists ghost.audit
(
    id        int primary key auto_increment,
    new_value json,
    created   timestamp not null default current_timestamp
);

# Создаем триггер для ведения аудита
delimiter $$
create trigger ghost.audit_reference_book
    after update
    on ghost.reference_book
    for each row
begin
    insert into ghost.audit(new_value)
    values (json_object(
            'id', new.id,
            'text', new.text,
            'title', new.title,
            'author', new.author,
            'user_id', new.user_id,
            'category', new.category,
            'active', new.active));
end;
$$
delimiter ;
