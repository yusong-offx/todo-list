DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS TODOS;

CREATE TABLE USERS (
    id serial primary key,
    login_id char(20) unique,
    login_password varchar(60)
);

CREATE TABLE TODOS (
    id serial primary key,
    user_id integer references USERS(id),
    title varchar(50),
    contents varchar(1000),
    create_date timestamp with time zone Default now(),
    lastmodified_date timestamp with time zone Default now()
);