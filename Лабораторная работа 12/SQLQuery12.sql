-- ������� ������� Service broker - �� ��������� ��� �������� ��������
-- �����, ������������ DBMail
IF (SELECT is_broker_enabled FROM sys.databases WHERE [name] = 'msdb') = 0
	ALTER DATABASE msdb SET ENABLE_BROKER WITH ROLLBACK AFTER 10 SECONDS
GO
-- ������� ��������������� ������� DBMail
sp_configure 'Database Mail XPs', 1
GO
RECONFIGURE
GO

EXECUTE msdb.dbo.sysmail_help_status_sp
GO

-- �������� SMTP-������� ��� ������� �����
EXECUTE msdb.dbo.sysmail_add_account_sp
		@account_name = 'Mail sender account',
		@description = N'�������� �������',
		@email_address = 'vadimgaraevtesting@rambler.ru',
		@display_name = N'������ �������� �����',
		@replyto_address = 'vadimgaraevtesting@rambler.ru',
	-- ����� ��� IP-����� SMTP-�������
		@mailserver_name = 'smtp.rambler.ru',
	-- ���� SMTP-�������, ������ 25
		@port = 587,
	-- ��� ������������. ��������� �������� ������� ������� �������� �����
	-- ������ ��������� ����� ������ ������ ����� ������������
		@username = 'vadimgaraevtesting@rambler.ru',
		@password = 'Dfybi123',
	-- ������ SSL ��� �����������, ����������� SMTP-�������� ������ ������� SSL
		@enable_ssl = 1;


-- �������� ������� �������������� �������� ��������
EXECUTE msdb.dbo.sysmail_add_profile_sp
		@profile_name = 'Mail sender';

-- ��������� SMTP-������� � ���������� �������
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
		@profile_name = 'Mail sender',
		@account_name = 'Mail sender account',
	-- ��������� ������ SMTP-�������� � �������
		@sequence_number = 1;

-- ��������� ����� ������� � ������� ��� ���� DatabaseMailUserRole ���� MSDB
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
		@profile_name = 'Mail sender',
		@principal_id = 0,
		@is_default = 1;



-- �������� ��� �������� ����� �������
EXEC msdb.dbo.sp_send_dbmail
	-- ��������� ���� ������� �������������� �������� ��������
		@profile_name = 'Mail sender',
	-- ����� ����������
		@recipients = 'vadimgaraevtesting@rambler.ru',
	-- ����� ������
		@body = N'��������� ������� SQL Server Database Mail',
	-- ����
		@subject = N'�������� ���������',
	-- ��� ������� ������� � ������ ���������� ������������� SQL-�������
		@query = 'SELECT TOP 10 name FROM sys.objects';


-- ��� ��� ��� �������, � ������ ������� � �������...

SELECT * FROM msdb.dbo.sysmail_allitems
SELECT sent_account_id, sent_date FROM msdb.dbo.sysmail_sentitems

EXEC sp_configure 'show advanced', 1;  
RECONFIGURE; 
EXEC sysmail_help_queue_sp @queue_type = 'Mail' ;


USE msdb ;  
GO  
  
-- Show the subject, the time that the mail item row was last  
-- modified, and the log information.  
-- Join sysmail_faileditems to sysmail_event_log   
-- on the mailitem_id column.  
-- In the WHERE clause list items where danw was in the recipients,  
-- copy_recipients, or blind_copy_recipients.  
-- These are the items that would have been sent  
-- to danw.  
  
SELECT items.subject,  
    items.last_mod_date  
    ,l.description FROM dbo.sysmail_faileditems as items  
INNER JOIN dbo.sysmail_event_log AS l  
    ON items.mailitem_id = l.mailitem_id  
WHERE items.recipients LIKE '%danw%'    
    OR items.copy_recipients LIKE '%danw%'   
    OR items.blind_copy_recipients LIKE '%danw%'  