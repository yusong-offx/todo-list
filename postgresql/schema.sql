DROP TABLE IF EXISTS USERS;

CREATE TABLE USERS (
    user_id serial primary key,
    login_id char(60) unique,
    login_password char(60),
    first_name varchar(20),
    last_name varchar(20),
);