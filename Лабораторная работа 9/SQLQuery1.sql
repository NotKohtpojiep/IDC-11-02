USE tax_park

-- Роль системного администратора (это кто? who?)

-- Роль главного менеджера(важный сотрудник)
CREATE ROLE head_manager
GRANT SELECT, INSERT, UPDATE TO head_manager

-- Роль клиента(пользователя)
CREATE ROLE client_user
GRANT SELECT, INSERT ON Заказ TO client_user;  
GRANT SELECT, INSERT ON Информация_заказа TO client_user;
GRANT SELECT ON Водитель TO client_user;
GRANT SELECT ON Город TO client_user;
GRANT SELECT ON Закрепленная_машина TO client_user;
GRANT SELECT ON Зона TO client_user;
GRANT SELECT ON Категория_тарифа TO client_user;
GRANT SELECT ON Класс_машины TO client_user;
GRANT SELECT ON Машина TO client_user;
GRANT SELECT ON Модель_машины TO client_user;
GRANT SELECT, INSERT, UPDATE ON Пользователь TO client_user;
GRANT SELECT ON Тариф TO client_user;
GRANT SELECT ON Тарифная_зона TO client_user;
GRANT SELECT ON Улица TO client_user;

-- Роль менеджера(сотрудника)
CREATE ROLE manager
GRANT SELECT TO manager;
GRANT INSERT, UPDATE ON Заказ TO manager;  
GRANT INSERT, UPDATE ON Информация_заказа TO manager;
GRANT INSERT, UPDATE ON Водитель TO manager;  
GRANT INSERT, UPDATE ON Машина TO manager; 
GRANT INSERT, UPDATE ON Машина TO manager; 

	
CREATE LOGIN head_manager
WITH PASSWORD = 'я здесь главный',
	 DEFAULT_DATABASE = tax_park;

CREATE LOGIN [manager]
WITH PASSWORD = 'manager',
	 DEFAULT_DATABASE = tax_park;

CREATE LOGIN [manager2]
WITH PASSWORD = 'manager2',
	 DEFAULT_DATABASE = tax_park;


CREATE LOGIN [client]
WITH PASSWORD = 'client',
	 DEFAULT_DATABASE = tax_park;

CREATE USER [head_manager1] FOR LOGIN head_manager WITH DEFAULT_SCHEMA = [dbo]  
ALTER ROLE head_manager ADD MEMBER [head_manager1]

CREATE USER [manager1] FOR LOGIN manager WITH DEFAULT_SCHEMA = [dbo]  
ALTER ROLE manager ADD MEMBER [manager1]

CREATE USER [manager2] FOR LOGIN manager2 WITH DEFAULT_SCHEMA = [dbo]  
ALTER ROLE manager ADD MEMBER [manager2]

CREATE USER [client] FOR LOGIN client WITH DEFAULT_SCHEMA = [dbo]  
ALTER ROLE client_user ADD MEMBER [client]
