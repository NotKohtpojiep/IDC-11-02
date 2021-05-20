USE delivery
CREATE TABLE ���������� (
	���_���������� int PRIMARY KEY,
	����� text NOT NULL,
	���������� text)

CREATE TABLE ����������_���� (
	���_���������� int PRIMARY KEY,
	������� varchar(20) NOT NULL,
	��� varchar(20) NOT NULL,
	�������� varchar(20) NOT NULL,
	�����_������������� varchar(10)
	FOREIGN KEY (���_����������) REFERENCES ����������(���_����������))

CREATE TABLE �����������_���� (
	���_���������� int PRIMARY KEY,
	�������� varchar(20) NOT NULL,
	���������_����� varchar(20),
	�����_������������� varchar(10)
	FOREIGN KEY (���_����������) REFERENCES ����������(���_����������))

CREATE TABLE �������� (
	�����_�������� int IDENTITY (1,1) PRIMARY KEY,
	����_�������� datetime,
	���_���������� int NOT NULL,
	����������� text
	FOREIGN KEY (���_����������) REFERENCES ����������(���_����������))

CREATE TABLE ���������� (
	�����_�������� int,
	����� varchar(20),
	���������� decimal(4,0) NOT NULL CHECK (����������>0),
	���� decimal(8,2) NOT NULL CHECK (����>0)
	FOREIGN KEY (�����_��������) REFERENCES ��������(�����_��������)
	PRIMARY KEY (�����_��������, �����))

go

-- #4

USE delivery

SELECT ����������.����������, ����������.�����, ����������.����,
����������.����������, ����������.*, ��������.����_��������
FROM ����������, ��������, ����������
WHERE ��������.�����_�������� = ����������.�����_��������
and ����������.���_���������� = ��������.���_����������
and ��������.�����_�������� = 1

BEGIN TRANSACTION
INSERT INTO ���������� VALUES (1, '�������', 22, 389.75);

SELECT ����������.����������, ����������.�����, ����������.����,
����������.����������, ����������.*, ��������.����_��������
FROM ����������, ��������, ����������
WHERE ��������.�����_�������� = ����������.�����_��������
and ����������.���_���������� = ��������.���_����������
and ��������.�����_�������� = 1

ROLLBACK

SELECT ����������.����������, ����������.�����, ����������.����,
����������.����������, ����������.*, ��������.����_��������
FROM ����������, ��������, ����������
WHERE ��������.�����_�������� = ����������.�����_��������
and ����������.���_���������� = ��������.���_����������
and ��������.�����_�������� = 1


-- #5

USE delivery

SELECT ����������.����������, ����������.�����, ����������.����,
����������.����������, ����������.*, ��������.����_��������
FROM ����������, ��������, ����������
WHERE ��������.�����_�������� = ����������.�����_��������
and ����������.���_���������� = ��������.���_����������
and ��������.�����_�������� = 1

BEGIN TRANSACTION
INSERT INTO ���������� VALUES (1, '�������', 22, 389.75);

SELECT ����������.����������, ����������.�����, ����������.����,
����������.����������, ����������.*, ��������.����_��������
FROM ����������, ��������, ����������
WHERE ��������.�����_�������� = ����������.�����_��������
and ����������.���_���������� = ��������.���_����������
and ��������.�����_�������� = 1

COMMIT

SELECT ����������.����������, ����������.�����, ����������.����,
����������.����������, ����������.*, ��������.����_��������
FROM ����������, ��������, ����������
WHERE ��������.�����_�������� = ����������.�����_��������
and ����������.���_���������� = ��������.���_����������
and ��������.�����_�������� = 1


-- #6

USE delivery

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

BEGIN TRANSACTION
INSERT INTO ���������� (���_����������, �����, ����������)
	VALUES (6, '�.�����66,�� 66,66', '');
INSERT INTO ��������(����_��������, ���_����������, �����������)
	VALUES ('20181212', 6, '');

INSERT INTO ����������
	VALUES 
	(8, '�������', 22, 3890),
	(8, '���������', 33, 750);

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

ROLLBACK

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������


-- #7

USE delivery

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

BEGIN TRANSACTION
INSERT INTO ���������� (���_����������, �����, ����������)
	VALUES (6, '�.�����66,�� 66,66', '');
INSERT INTO ��������(����_��������, ���_����������, �����������)
	VALUES ('20181212', 6, '');

INSERT INTO ����������
	VALUES 
	(8, '�������', 22, 3890),
	(8, '���������', 33, 750);

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

COMMIT

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

-- #9

USE delivery

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ���������� WHERE �����_�������� = 8

BEGIN TRAN
UPDATE ���������� SET ���_���������� = 22 WHERE ���_���������� = 6
UPDATE ���������� SET ���� = ���� * 1.1 WHERE �����_�������� = 8

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ���������� WHERE �����_�������� = 8

ROLLBACK

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ���������� WHERE �����_�������� = 8

-- #10

USE delivery

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ���������� WHERE �����_�������� = 8

BEGIN TRAN
UPDATE ���������� SET ���_���������� = 22 WHERE ���_���������� = 6
UPDATE ���������� SET ���� = ���� * 1.1 WHERE �����_�������� = 8

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ���������� WHERE �����_�������� = 8

COMMIT

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ���������� WHERE �����_�������� = 8

-- #11

USE delivery

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

BEGIN TRAN
DELETE FROM ���������� Where ���_���������� = 6

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

ROLLBACK

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

-- #12

USE delivery

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

BEGIN TRAN
DELETE FROM ���������� Where ���_���������� = 6

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������

COMMIT

SELECT * FROM ����������
SELECT * FROM ��������
SELECT * FROM ����������