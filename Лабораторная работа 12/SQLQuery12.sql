-- Сначала включим Service broker - он необходим для создания очередей
-- писем, используемых DBMail
IF (SELECT is_broker_enabled FROM sys.databases WHERE [name] = 'msdb') = 0
	ALTER DATABASE msdb SET ENABLE_BROKER WITH ROLLBACK AFTER 10 SECONDS
GO
-- Включим непосредственно систему DBMail
sp_configure 'Database Mail XPs', 1
GO
RECONFIGURE
GO

EXECUTE msdb.dbo.sysmail_help_status_sp
GO

-- Создадим SMTP-аккаунт для отсылки писем
EXECUTE msdb.dbo.sysmail_add_account_sp
		@account_name = 'Mail sender account',
		@description = N'Почтовый аккаунт',
		@email_address = 'vadimgaraevtesting@rambler.ru',
		@display_name = N'Звонит доставка пиццы',
		@replyto_address = 'vadimgaraevtesting@rambler.ru',
	-- Домен или IP-адрес SMTP-сервера
		@mailserver_name = 'smtp.rambler.ru',
	-- Порт SMTP-сервера, обычно 25
		@port = 587,
	-- Имя пользователя. Некоторые почтовые системы требуют указания всего
	-- адреса почтового ящика вместо одного имени пользователя
		@username = 'vadimgaraevtesting@rambler.ru',
		@password = 'Dfybi123',
	-- Защита SSL при подключении, большинство SMTP-серверов сейчас требуют SSL
		@enable_ssl = 1;


-- Создадим профиль администратора почтовых рассылок
EXECUTE msdb.dbo.sysmail_add_profile_sp
		@profile_name = 'Mail sender';

-- Подключим SMTP-аккаунт к созданному профилю
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
		@profile_name = 'Mail sender',
		@account_name = 'Mail sender account',
	-- Указатель номера SMTP-аккаунта в профиле
		@sequence_number = 1;

-- Установим права доступа к профилю для роли DatabaseMailUserRole базы MSDB
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
		@profile_name = 'Mail sender',
		@principal_id = 0,
		@is_default = 1;



-- Проверка для отправки писем счастья
EXEC msdb.dbo.sp_send_dbmail
	-- Созданный нами профиль администратора почтовых рассылок
		@profile_name = 'Mail sender',
	-- Адрес получателя
		@recipients = 'vadimgaraevtesting@rambler.ru',
	-- Текст письма
		@body = N'Испытание системы SQL Server Database Mail',
	-- Тема
		@subject = N'Тестовое сообщение',
	-- Для примера добавим к письму результаты произвольного SQL-запроса
		@query = 'SELECT TOP 10 name FROM sys.objects';


-- Это уже для отладки, в случае поломок и прочего...

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