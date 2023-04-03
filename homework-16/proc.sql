# Создаем процедуру для пользователя
create user 'user'@'%' identified by '12345';

delimiter $$
create procedure ghost.pr_filter_movie(
    in _category varchar(50),
    in _title varchar(500),
    in _text text
)
begin
    select *
    from ghost.movie gm
    where (_category is null or gm.category = _category)
      and (_title is null or gm.title like concat('%', _title, '%'))
      and (_text is null or gm.text like concat('%', _text, '%'));
end;
$$
delimiter ;

grant execute on ghost.pr_filter_movie to 'user'@'%';

# Создаем процедуру для editor
create user 'editor'@'%' identified by '77777';

delimiter $$
create procedure ghost.pr_report_movie(
    in _category varchar(50),
    in _title varchar(500),
    in _grade_up decimal(2, 1),
    in _grade_down decimal(2, 1)
)
begin
    select gm.title,
           convert((sum(mg.grade) / count(*)), decimal(2, 1)) as grade,
           count(distinct mc.user_id)                         as count_user_comment,
           count(distinct mc.id)                              as count_comment,
           group_concat(distinct mc.user_id)                  as array_user_id
    from ghost.movie gm
             join ghost.movie_comment mc on gm.id = mc.movie_id
             join ghost.user u on u.id = mc.user_id
             join ghost.movie_grade mg on gm.id = mg.movie_id
    where (_category is null or gm.category = _category)
    and (_title is null or gm.title like concat('%', _title, '%'))
    and (_grade_up is null or mg.grade < _grade_up)
    and (_grade_down is null or mg.grade > _grade_down)
    group by gm.title;
end;
$$
delimiter ;

grant execute on ghost.pr_filter_movie to 'editor'@'%';