USE delivery
CREATE TABLE Поставщики (
	Код_Поставщика int PRIMARY KEY,
	Адрес text NOT NULL,
	Примечание text)

CREATE TABLE Физические_Лица (
	Код_Поставщика int PRIMARY KEY,
	Фамилия varchar(20) NOT NULL,
	Имя varchar(20) NOT NULL,
	Отчество varchar(20) NOT NULL,
	Номер_Свидетельства varchar(10)
	FOREIGN KEY (Код_Поставщика) REFERENCES Поставщики(Код_Поставщика))

CREATE TABLE Юридические_Лица (
	Код_Поставщика int PRIMARY KEY,
	Название varchar(20) NOT NULL,
	Налоговый_Номер varchar(20),
	Номер_Свидетельства varchar(10)
	FOREIGN KEY (Код_Поставщика) REFERENCES Поставщики(Код_Поставщика))

CREATE TABLE Договоры (
	Номер_Договора int IDENTITY (1,1) PRIMARY KEY,
	Дата_Договора datetime,
	Код_Поставщика int NOT NULL,
	Комментарий text
	FOREIGN KEY (Код_Поставщика) REFERENCES Поставщики(Код_Поставщика))

CREATE TABLE Поставлено (
	Номер_Договора int,
	Товар varchar(20),
	Количество decimal(4,0) NOT NULL CHECK (Количество>0),
	Цена decimal(8,2) NOT NULL CHECK (Цена>0)
	FOREIGN KEY (Номер_Договора) REFERENCES Договоры(Номер_Договора)
	PRIMARY KEY (Номер_Договора, Товар))

go

-- #4

USE delivery

SELECT Поставлено.Количество, Поставлено.Товар, Поставлено.Цена,
Поставлено.Количество, Поставщики.*, Договоры.Дата_Договора
FROM Поставлено, Договоры, Поставщики
WHERE Договоры.Номер_Договора = Поставлено.Номер_Договора
and Поставщики.Код_Поставщика = Договоры.Код_Поставщика
and Договоры.Номер_Договора = 1

BEGIN TRANSACTION
INSERT INTO Поставлено VALUES (1, 'Пылесос', 22, 389.75);

SELECT Поставлено.Количество, Поставлено.Товар, Поставлено.Цена,
Поставлено.Количество, Поставщики.*, Договоры.Дата_Договора
FROM Поставлено, Договоры, Поставщики
WHERE Договоры.Номер_Договора = Поставлено.Номер_Договора
and Поставщики.Код_Поставщика = Договоры.Код_Поставщика
and Договоры.Номер_Договора = 1

ROLLBACK

SELECT Поставлено.Количество, Поставлено.Товар, Поставлено.Цена,
Поставлено.Количество, Поставщики.*, Договоры.Дата_Договора
FROM Поставлено, Договоры, Поставщики
WHERE Договоры.Номер_Договора = Поставлено.Номер_Договора
and Поставщики.Код_Поставщика = Договоры.Код_Поставщика
and Договоры.Номер_Договора = 1


-- #5

USE delivery

SELECT Поставлено.Количество, Поставлено.Товар, Поставлено.Цена,
Поставлено.Количество, Поставщики.*, Договоры.Дата_Договора
FROM Поставлено, Договоры, Поставщики
WHERE Договоры.Номер_Договора = Поставлено.Номер_Договора
and Поставщики.Код_Поставщика = Договоры.Код_Поставщика
and Договоры.Номер_Договора = 1

BEGIN TRANSACTION
INSERT INTO Поставлено VALUES (1, 'Пылесос', 22, 389.75);

SELECT Поставлено.Количество, Поставлено.Товар, Поставлено.Цена,
Поставлено.Количество, Поставщики.*, Договоры.Дата_Договора
FROM Поставлено, Договоры, Поставщики
WHERE Договоры.Номер_Договора = Поставлено.Номер_Договора
and Поставщики.Код_Поставщика = Договоры.Код_Поставщика
and Договоры.Номер_Договора = 1

COMMIT

SELECT Поставлено.Количество, Поставлено.Товар, Поставлено.Цена,
Поставлено.Количество, Поставщики.*, Договоры.Дата_Договора
FROM Поставлено, Договоры, Поставщики
WHERE Договоры.Номер_Договора = Поставлено.Номер_Договора
and Поставщики.Код_Поставщика = Договоры.Код_Поставщика
and Договоры.Номер_Договора = 1


-- #6

USE delivery

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

BEGIN TRANSACTION
INSERT INTO Поставщики (Код_Поставщика, Адрес, Примечание)
	VALUES (6, 'г.Город66,ул 66,66', '');
INSERT INTO Договоры(Дата_Договора, Код_Поставщика, Комментарий)
	VALUES ('20181212', 6, '');

INSERT INTO Поставлено
	VALUES 
	(8, 'Пылесос', 22, 3890),
	(8, 'Кофемолка', 33, 750);

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

ROLLBACK

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено


-- #7

USE delivery

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

BEGIN TRANSACTION
INSERT INTO Поставщики (Код_Поставщика, Адрес, Примечание)
	VALUES (6, 'г.Город66,ул 66,66', '');
INSERT INTO Договоры(Дата_Договора, Код_Поставщика, Комментарий)
	VALUES ('20181212', 6, '');

INSERT INTO Поставлено
	VALUES 
	(8, 'Пылесос', 22, 3890),
	(8, 'Кофемолка', 33, 750);

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

COMMIT

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

-- #9

USE delivery

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено WHERE Номер_Договора = 8

BEGIN TRAN
UPDATE Поставщики SET Код_Поставщика = 22 WHERE Код_Поставщика = 6
UPDATE Поставлено SET Цена = Цена * 1.1 WHERE Номер_Договора = 8

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено WHERE Номер_Договора = 8

ROLLBACK

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено WHERE Номер_Договора = 8

-- #10

USE delivery

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено WHERE Номер_Договора = 8

BEGIN TRAN
UPDATE Поставщики SET Код_Поставщика = 22 WHERE Код_Поставщика = 6
UPDATE Поставлено SET Цена = Цена * 1.1 WHERE Номер_Договора = 8

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено WHERE Номер_Договора = 8

COMMIT

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено WHERE Номер_Договора = 8

-- #11

USE delivery

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

BEGIN TRAN
DELETE FROM Поставщики Where Код_Поставщика = 6

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

ROLLBACK

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

-- #12

USE delivery

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

BEGIN TRAN
DELETE FROM Поставщики Where Код_Поставщика = 6

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено

COMMIT

SELECT * FROM Поставщики
SELECT * FROM Договоры
SELECT * FROM Поставлено