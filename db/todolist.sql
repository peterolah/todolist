-- adatbázis létrehozása

-- felhasználó létrehozása
CREATE USER 'petero'@'%'
IDENTIFIED BY '***';

GRANT USAGE ON *.* TO 'petero'@'%' IDENTIFIED BY '***'
WITH MAX_QUERIES_PER_HOUR 0 
MAX_CONNECTIONS_PER_HOUR 0 
MAX_UPDATES_PER_HOUR 0 
MAX_USER_CONNECTIONS 0;

GRANT ALL PRIVILEGES ON `todolist`.* TO 'petero'@'%';


-- authentikációhoz szzükséges táblák létrehozása
create table users(
username varchar(128) not null primary key,
password varchar(512) not null,
enabled boolean not null);

create table authorities (
username varchar(128) not null,
authority varchar(128) not null);

create unique index idx_auth_username on authorities (username,authority);

create table groups (
id bigint not null,
group_name varchar(128) not null);

alter table groups add constraint pk_groups primary key(id);

create table group_authorities (
group_id bigint not null,
authority varchar(128) not null,
constraint fk_group_authorities_group foreign key(group_id) references groups(id));

create table group_members (
id bigint not null,
username varchar(128) not null,
group_id bigint not null,
constraint fk_group_members_group foreign key(group_id) references groups(id));     

alter table group_members add constraint pk_group_members primary key(id);

insert into users(username,password,enabled) values ('user1','secret',true);
insert into users(username,password,enabled) values ('user2','secret',true);

insert into authorities(username,authority) values ('user1','ROLE_USER');
insert into authorities(username,authority) values ('user2','ROLE_USER');  
insert into authorities(username,authority) values ('user2','ROLE_EDITOR');