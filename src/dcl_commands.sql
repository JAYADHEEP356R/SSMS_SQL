-- Server level
CREATE LOGIN test_login 
WITH PASSWORD = '1234',
CHECK_POLICY = OFF;

-- Database level
USE data_engineering;
GO

CREATE USER jai FOR LOGIN test_login;

-- Permission
GRANT SELECT ON dbo.Employees TO jai;


select * from Employees;
