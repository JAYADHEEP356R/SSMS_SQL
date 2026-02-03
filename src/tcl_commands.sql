use data_engineering
go

CREATE TABLE Accounts (
    AccountId INT PRIMARY KEY,
    Name VARCHAR(50),
    Balance INT
);

INSERT INTO Accounts VALUES
(1, 'Ravi', 5000),
(2, 'Anita', 3000);

BEGIN TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 1000
WHERE AccountId = 1;

UPDATE Accounts
SET Balance = Balance + 1000
WHERE AccountId = 2;

commit
--rollback



--using savepoint (save transaction name) as a partial rollback


select * from Accounts

BEGIN TRANSACTION;

UPDATE Accounts SET Balance = Balance - 500 WHERE AccountId = 1;

SAVE TRANSACTION after_debit;

UPDATE Accounts SET Balance = Balance + 500 WHERE AccountId = 2;

-- Something wrong
ROLLBACK TRANSACTION after_debit;


select @@TRANCOUNT; -- to check the transaction state
