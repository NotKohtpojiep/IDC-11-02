USE tax_park

-- ���� ���������� �������������� (��� ���? who?)

-- ���� �������� ���������(������ ���������)
CREATE ROLE head_manager
GRANT SELECT, INSERT, UPDATE TO head_manager

-- ���� �������(������������)
CREATE ROLE client_user
GRANT SELECT, INSERT ON ����� TO client_user;  
GRANT SELECT, INSERT ON ����������_������ TO client_user;
GRANT SELECT ON �������� TO client_user;
GRANT SELECT ON ����� TO client_user;
GRANT SELECT ON ������������_������ TO client_user;
GRANT SELECT ON ���� TO client_user;
GRANT SELECT ON ���������_������ TO client_user;
GRANT SELECT ON �����_������ TO client_user;
GRANT SELECT ON ������ TO client_user;
GRANT SELECT ON ������_������ TO client_user;
GRANT SELECT, INSERT, UPDATE ON ������������ TO client_user;
GRANT SELECT ON ����� TO client_user;
GRANT SELECT ON ��������_���� TO client_user;
GRANT SELECT ON ����� TO client_user;

-- ���� ���������(����������)
CREATE ROLE manager
GRANT SELECT TO manager;
GRANT INSERT, UPDATE ON ����� TO manager;  
GRANT INSERT, UPDATE ON ����������_������ TO manager;
GRANT INSERT, UPDATE ON �������� TO manager;  
GRANT INSERT, UPDATE ON ������ TO manager; 
GRANT INSERT, UPDATE ON ������ TO manager; 

	
CREATE LOGIN head_manager
WITH PASSWORD = '� ����� �������',
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
