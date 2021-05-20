
USE Polyclinic

create table doctor (
	doctor_code int primary key,
	first_name nvarchar(30) not null,
	last_name nvarchar(30) not null,
	medium_name nvarchar(30) null,
	specialty nvarchar(45) not null,
	category int not null
)

create table pacient (
	card_code int primary key,
	first_name nvarchar(30) not null,
	last_name nvarchar(30) not null,
	medium_name nvarchar(30) null,
	born_date date not null,
	gender bit not null,
	address nvarchar(120) null,
	discount int null
)

create table reception (
	ticket_number int primary key,
	doctor_code int not null,
	card_code int not null,
	visit_date date not null,
	goal nvarchar(50) not null,
	price int not null
)

alter table reception
add constraint rcp_doc_tick_FK
foreign key (doctor_code)
references doctor(doctor_code)
on update cascade
on delete cascade;

alter table reception
add constraint rcp_card_tick_FK
foreign key (card_code)
references pacient(card_code)
on update cascade
on delete cascade;

go

-- # # #

SELECT * FROM pacient
SELECT * FROM doctor

BEGIN TRANSACTION
INSERT INTO pacient(card_code, first_name, last_name, medium_name, born_date, gender, address, discount)
	VALUES (1,'Вадим','Гараев', null,'1.1.1', 1, null, null);
INSERT INTO doctor(doctor_code,first_name,last_name,medium_name,specialty,category)
	VALUES (1,'Вадим','Гараев',null,'Программист',1);
	
SELECT * FROM pacient
SELECT * FROM doctor

ROLLBACK

SELECT * FROM pacient
SELECT * FROM doctor

go
-- # # #

SELECT * FROM pacient
SELECT * FROM doctor

BEGIN TRANSACTION
INSERT INTO pacient(card_code, first_name, last_name, medium_name, born_date, gender, address, discount)
	VALUES (1,'Вадим','Гараев', null,'1.1.1', 1, null, null);
INSERT INTO doctor(doctor_code,first_name,last_name,medium_name,specialty,category)
	VALUES (1,'Вадим','Гараев',null,'Программист',1);
	
SELECT * FROM pacient
SELECT * FROM doctor

COMMIT

SELECT * FROM pacient
SELECT * FROM doctor
go
-- # # #

SELECT * FROM pacient WHERE first_name = 'Алексей'

BEGIN TRANSACTION
UPDATE pacient SET last_name = last_name + '1' WHERE first_name = 'Алексей'

	
SELECT * FROM pacient WHERE first_name = 'Алексей'

ROLLBACK

SELECT * FROM pacient WHERE first_name = 'Алексей'

go

-- # # #

SELECT * FROM pacient WHERE first_name = 'Алексей'

BEGIN TRANSACTION
UPDATE pacient SET last_name = last_name + '1' WHERE first_name = 'Алексей'

	
SELECT * FROM pacient WHERE first_name = 'Алексей'

COMMIT

SELECT * FROM pacient WHERE first_name = 'Алексей'

go

-- # # #

SELECT * FROM pacient WHERE first_name = 'Алексей'

BEGIN TRANSACTION
DELETE FROM pacient WHERE first_name = 'Алексей'

SELECT * FROM pacient WHERE first_name = 'Алексей'

ROLLBACK

SELECT * FROM pacient WHERE first_name = 'Алексей'

-- # # #

SELECT * FROM pacient WHERE first_name = 'Алексей'

BEGIN TRANSACTION
DELETE FROM pacient WHERE first_name = 'Алексей'

SELECT * FROM pacient WHERE first_name = 'Алексей'

COMMIT

SELECT * FROM pacient WHERE first_name = 'Алексей'