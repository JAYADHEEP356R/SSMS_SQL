USE data_engineering;
GO

/* =====================================================
   DROP PROCEDURES IF THEY EXIST
   ===================================================== */
DROP PROCEDURE IF EXISTS sp_GetAllEmployees;
DROP PROCEDURE IF EXISTS sp_GetEmployeeByDept;
DROP PROCEDURE IF EXISTS sp_GetEmployeeByDeptAndStatus;
DROP PROCEDURE IF EXISTS sp_AddEmployee;
DROP PROCEDURE IF EXISTS sp_UpdateSalary;
DROP PROCEDURE IF EXISTS sp_DeleteEmployee;
DROP PROCEDURE IF EXISTS sp_GetEmployeeCountByDept;
DROP PROCEDURE IF EXISTS sp_CheckSalaryLevel;
DROP PROCEDURE IF EXISTS sp_SafeEmployeeInsert;
DROP PROCEDURE IF EXISTS sp_IncrementSalary;
GO


/* =====================================================
   1. BASIC PROCEDURE – NO INPUT PARAMETERS
   ===================================================== */
CREATE PROCEDURE sp_GetAllEmployees
AS
BEGIN
    SELECT * FROM Employees;
END;
GO


/* =====================================================
   2. PROCEDURE WITH SINGLE INPUT PARAMETER
   ===================================================== */
CREATE PROCEDURE sp_GetEmployeeByDept
    @DeptId INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DeptId = @DeptId;
END;
GO


/* =====================================================
   3. PROCEDURE WITH MULTIPLE INPUT PARAMETERS
   ===================================================== */
CREATE PROCEDURE sp_GetEmployeeByDeptAndStatus
    @DeptId INT,
    @Status VARCHAR(20)
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DeptId = @DeptId
      AND Status = @Status;
END;
GO


/* =====================================================
   4. INSERT USING STORED PROCEDURE
   ===================================================== */
CREATE PROCEDURE sp_AddEmployee
    @EmpId INT,
    @EmployeeName VARCHAR(100),
    @Email VARCHAR(100),
    @Salary INT,
    @DeptId INT,
    @Status VARCHAR(20),
    @JoiningDate DATE
AS
BEGIN
    INSERT INTO Employees
    VALUES (@EmpId, @EmployeeName, @Email, @Salary, @DeptId, @Status, @JoiningDate);
END;
GO


/* =====================================================
   5. UPDATE USING STORED PROCEDURE
   ===================================================== */
CREATE PROCEDURE sp_UpdateSalary
    @EmpId INT,
    @NewSalary INT
AS
BEGIN
    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmpId = @EmpId;
END;
GO


/* =====================================================
   6. DELETE USING STORED PROCEDURE
   ===================================================== */
CREATE PROCEDURE sp_DeleteEmployee
    @EmpId INT
AS
BEGIN
    DELETE FROM Employees
    WHERE EmpId = @EmpId;
END;
GO


/* =====================================================
   7. OUTPUT PARAMETER
   ===================================================== */
CREATE PROCEDURE sp_GetEmployeeCountByDept
    @DeptId INT,
    @EmpCount INT OUTPUT
AS
BEGIN
    SELECT @EmpCount = COUNT(*)
    FROM Employees
    WHERE DeptId = @DeptId;
END;
GO


/* =====================================================
   8. IF ELSE LOGIC
   ===================================================== */
CREATE PROCEDURE sp_CheckSalaryLevel
    @EmpId INT
AS
BEGIN
    DECLARE @Salary INT;

    SELECT @Salary = Salary
    FROM Employees
    WHERE EmpId = @EmpId;

    IF @Salary >= 45000
        PRINT 'High Salary Employee';
    ELSE
        PRINT 'Average Salary Employee';
END;
GO


/* =====================================================
   9. TRY CATCH (ERROR HANDLING)
   ===================================================== */
CREATE PROCEDURE sp_SafeEmployeeInsert
    @EmpId INT,
    @EmployeeName VARCHAR(100),
    @Email VARCHAR(100),
    @Salary INT,
    @DeptId INT,
    @Status VARCHAR(20),
    @JoiningDate DATE
AS
BEGIN
    BEGIN TRY
        INSERT INTO Employees
        VALUES (@EmpId, @EmployeeName, @Email, @Salary, @DeptId, @Status, @JoiningDate);
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


/* =====================================================
   10. TRANSACTION CONTROL (TCL)
   ===================================================== */
CREATE PROCEDURE sp_IncrementSalary
    @EmpId INT,
    @IncrementAmount INT
AS
BEGIN
    BEGIN TRANSACTION;

    UPDATE Employees
    SET Salary = Salary + @IncrementAmount
    WHERE EmpId = @EmpId;

    IF @@ERROR <> 0
        ROLLBACK;
    ELSE
        COMMIT;
END;
GO


/* =====================================================
   EXECUTION EXAMPLES (OPTIONAL)
   ===================================================== */
EXEC sp_GetAllEmployees;
EXEC sp_GetEmployeeByDept 101;
EXEC sp_GetEmployeeByDeptAndStatus 101, 'Active';

EXEC sp_AddEmployee 
    3001, 'Rahul', 'rahul@gmail.com', 48000, 102, 'Active', '2024-02-01';

EXEC sp_UpdateSalary 1, 47000;

DECLARE @Total INT;
EXEC sp_GetEmployeeCountByDept 101, @Total OUTPUT;
SELECT @Total AS EmployeeCount;

EXEC sp_CheckSalaryLevel 2;
EXEC sp_IncrementSalary 2, 3000;
