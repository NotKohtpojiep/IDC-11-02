USE [master]
GO
CREATE SERVER AUDIT Thiking_Audit  
    TO FILE ( FILEPATH ='C:\AuditThings\' );  

CREATE SERVER AUDIT SPECIFICATION Thiking_Audit_Specification  
FOR SERVER AUDIT Thiking_Audit  
    ADD (FAILED_LOGIN_GROUP),
	ADD (BACKUP_RESTORE_GROUP),
	ADD (LOGIN_CHANGE_PASSWORD_GROUP)
WITH (STATE = ON);
GO  

ALTER SERVER AUDIT Thiking_Audit  
WITH (STATE = ON);  
GO  


USE AdventureWorks2012 ;   
GO  
-- Create the database audit specification.   
CREATE DATABASE AUDIT SPECIFICATION Audit_Pay_Tables  
FOR SERVER AUDIT Thiking_Audit  
ADD (INSERT, DELETE, UPDATE  
     ON Production.Product BY dbo )   
WITH (STATE = ON) ;   
GO   

/*
select [statement], 
     CONVERT(datetime, 
        SWITCHOFFSET(CONVERT(datetimeoffset, event_time), 
            DATENAME(TzOffset, SYSDATETIMEOFFSET()))) 
       AS
      event_time from (
SELECT event_time,[statement] FROM sys.fn_get_audit_file 
('C:\AuditThings\Thiking_Audit_E10D9A80-FF58-41A3-824B-52476DC4C774_0_132632949650670000.sqlaudit'
,default,default)
) x 

SELECT GETDATE()
SELECT SYSDATETIMEOFFSET()

SELECT DATEADD(mi, DATEPART(TZ, SYSDATETIMEOFFSET()), GETDATE())
*/