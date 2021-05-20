create table doctor (
doctor_code int auto_increment primary key,
first_name nvarchar(30) not null,
last_name nvarchar(30) not null,
medium_name nvarchar(30) null,
specialty nvarchar(45) not null,
category int not null
) engine=innodb;

create table pacient (
card_code int auto_increment primary key,
first_name nvarchar(30) not null,
last_name nvarchar(30) not null,
medium_name nvarchar(30) null,
born_date date not null,
gender bit not null,
address nvarchar(120) null,
discount int null
) engine=innodb;

create table reception (
ticket_number int auto_increment primary key,
doctor_code int not null,
card_code int not null,
visit_date date not null,
goal nvarchar(50) not null,
price int not null
) engine=innodb;

alter table reception
add index rcp_doc_tick(doctor_code);

alter table reception
add constraint rcp_doc_tick_FK
foreign key (doctor_code)
references doctor(doctor_code)
on update cascade
on delete cascade;

alter table reception
add index sch_card_tick(card_code);

alter table reception
add constraint rcp_card_tick_FK
foreign key (card_code)
references patient(card_code)
on update cascade
on delete cascade;

create user client@localhost identified by '12345';
create user admin@localhost identified by '12345';
create user doctor@localhost identified by '12345';
grant select, insert on polyclinic.reception to client@localhost;
grant select, insert, delete, update on polyclinic.reception to admin@localhost;
grant select, insert, delete, update on polyclinic.pacient to admin@localhost;
grant select, update on polyclinic.pacient to doctor@localhost;

SELECT User, Host FROM mysql.user;

insert into polyclinic.doctor values ('1','Зубенко','Михаил','Петрович','Крутой','1');