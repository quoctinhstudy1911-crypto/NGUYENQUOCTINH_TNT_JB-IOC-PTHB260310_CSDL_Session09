-- Dữ liệu 
create database session7_8;
create table users (
    user_id serial primary key,
    email varchar(100),
    username varchar(100)
);

insert into users (email, username)
select 
    'user' || g || '@gmail.com',
    'user' || g
from generate_series(1, 100000) g;

insert into users (email, username)
values
('kimtoa@gmail.com', 'kt')

create index idx_users_email_hash
on users using hash(email);

explain
select * from users
where email = 'kimtoa@gmail.com';
-- Sau khi dùng lệnh thực thi 10 ngàn dòng ta thêm 1 dòng dữ liệu mới ở cuối để test hash map
-- Vì hash theo cơ chế con trỏ nên trỏ đúng vào email kimtoa@gmail.com không cần phải duyệt qua 10 ngàn dòng như duyệt tuần tự