-- 1. Trigger for printing message after employee insertion

CREATE OR ALTER TRIGGER TR_EMPLOYEE_INSERT
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    PRINT 'Employee record inserted successfully.';
END;


-- 2. Trigger for printing message after employee update

CREATE OR ALTER TRIGGER TR_EMPLOYEE_UPDATE
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    PRINT 'Employee record updated successfully.';
END;


-- 3. Trigger for printing message after employee deletion

CREATE OR ALTER TRIGGER TR_EMPLOYEE_DELETE
ON EMPLOYEE
AFTER DELETE
AS
BEGIN
    PRINT 'Employee record deleted successfully.';
END;


-- 4. Trigger for printing message after employee salary increment

CREATE OR ALTER TRIGGER TR_SALARY_INCREMENT
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted I
        INNER JOIN deleted D
            ON I.EID = D.EID
        WHERE I.SALARY > D.SALARY
    )
    BEGIN
        PRINT 'Employee salary incremented successfully.';
    END
END;


-- 5. Trigger for automatically converting CITY into uppercase

CREATE OR ALTER TRIGGER TR_CITY_UPPERCASE
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET CITY = UPPER(E.CITY)
    FROM EMPLOYEE E
    INNER JOIN inserted I
        ON E.EID = I.EID;
END;



--  PART - B

-- 6. Trigger for updating employee city
--    and displaying old and new city

CREATE OR ALTER TRIGGER TR_CITY_UPDATE
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CITY)
    BEGIN
        SELECT
            D.EID,
            D.CITY AS OLD_CITY,
            I.CITY AS NEW_CITY
        FROM deleted D
        INNER JOIN inserted I
            ON D.EID = I.EID;
    END
END;


-- 7. Trigger for setting CITY as RAJKOT
--    if no city is entered

CREATE OR ALTER TRIGGER TR_DEFAULT_CITY
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET CITY = 'RAJKOT'
    FROM EMPLOYEE E
    INNER JOIN inserted I
        ON E.EID = I.EID
    WHERE I.CITY IS NULL;
END;


-- 8. Trigger for setting current year in JOININGYEAR
--    if no value is entered

CREATE OR ALTER TRIGGER TR_DEFAULT_JOININGYEAR
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET JOININGYEAR = YEAR(GETDATE())
    FROM EMPLOYEE E
    INNER JOIN inserted I
        ON E.EID = I.EID
    WHERE I.JOININGYEAR IS NULL;
END;


-- 9. Trigger for printing employee full name
--    after new employee insertion

CREATE OR ALTER TRIGGER TR_PRINT_FULLNAME
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    SELECT
        FIRSTNAME + ' ' + LASTNAME AS FULLNAME
    FROM inserted;
END;


-- 10. Trigger for assigning GENERAL department
--     if DEPARTMENT is NULL

CREATE OR ALTER TRIGGER TR_DEFAULT_DEPARTMENT
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET DEPARTMENT = 'GENERAL'
    FROM EMPLOYEE E
    INNER JOIN inserted I
        ON E.EID = I.EID
    WHERE I.DEPARTMENT IS NULL;
END;



--PART - C


-- 11. Create EMPLOYEE_UPDATE_LOG table

CREATE TABLE EMPLOYEE_UPDATE_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    OLD_SALARY DECIMAL(10,2),
    NEW_SALARY DECIMAL(10,2),
    OLD_DEPARTMENT VARCHAR(50),
    NEW_DEPARTMENT VARCHAR(50),
    UPDATE_DATE DATETIME
);



-- Trigger for storing updated employee details

CREATE OR ALTER TRIGGER TR_EMPLOYEE_UPDATE_LOG
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    INSERT INTO EMPLOYEE_UPDATE_LOG
    (
        EID,
        OLD_SALARY,
        NEW_SALARY,
        OLD_DEPARTMENT,
        NEW_DEPARTMENT,
        UPDATE_DATE
    )
    SELECT
        D.EID,
        D.SALARY,
        I.SALARY,
        D.DEPARTMENT,
        I.DEPARTMENT,
        GETDATE()
    FROM deleted D
    INNER JOIN inserted I
        ON D.EID = I.EID;
END;


-- 12. Create EMPLOYEE_INSERT_LOG table

CREATE TABLE EMPLOYEE_INSERT_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    FIRSTNAME VARCHAR(50),
    LASTNAME VARCHAR(50),
    CITY VARCHAR(50),
    SALARY DECIMAL(10,2),
    DEPARTMENT VARCHAR(50),
    JOININGYEAR INT,
    INSERT_DATE DATETIME
);



-- Trigger for storing newly inserted employee details

CREATE OR ALTER TRIGGER TR_EMPLOYEE_INSERT_LOG
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    INSERT INTO EMPLOYEE_INSERT_LOG
    (
        EID,
        FIRSTNAME,
        LASTNAME,
        CITY,
        SALARY,
        DEPARTMENT,
        JOININGYEAR,
        INSERT_DATE
    )
    SELECT
        EID,
        FIRSTNAME,
        LASTNAME,
        CITY,
        SALARY,
        DEPARTMENT,
        JOININGYEAR,
        GETDATE()
    FROM inserted;
END;


-- 13. Create NAME_CHANGE_LOG table

CREATE TABLE NAME_CHANGE_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    OLD_FIRSTNAME VARCHAR(50),
    NEW_FIRSTNAME VARCHAR(50),
    CHANGE_DATE DATETIME
);



-- Trigger for storing old and new FIRSTNAME

CREATE OR ALTER TRIGGER TR_NAME_CHANGE_LOG
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(FIRSTNAME)
    BEGIN
        INSERT INTO NAME_CHANGE_LOG
        (
            EID,
            OLD_FIRSTNAME,
            NEW_FIRSTNAME,
            CHANGE_DATE
        )
        SELECT
            D.EID,
            D.FIRSTNAME,
            I.FIRSTNAME,
            GETDATE()
        FROM deleted D
        INNER JOIN inserted I
            ON D.EID = I.EID
        WHERE ISNULL(D.FIRSTNAME, '') 
              <> ISNULL(I.FIRSTNAME, '');
    END
END;


-- 14. Create CITY_UPDATE_LOG table

CREATE TABLE CITY_UPDATE_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    OLD_CITY VARCHAR(50),
    NEW_CITY VARCHAR(50),
    UPDATE_DATE DATETIME
);


-- Trigger for storing old and new CITY

CREATE OR ALTER TRIGGER TR_CITY_UPDATE_LOG
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CITY)
    BEGIN
        INSERT INTO CITY_UPDATE_LOG
        (
            EID,
            OLD_CITY,
            NEW_CITY,
            UPDATE_DATE
        )
        SELECT
            D.EID,
            D.CITY,
            I.CITY,
            GETDATE()
        FROM deleted D
        INNER JOIN inserted I
            ON D.EID = I.EID
        WHERE ISNULL(D.CITY, '') 
              <> ISNULL(I.CITY, '');
    END
END;


-- 15. INSTEAD OF INSERT trigger
--     for removing extra spaces from FIRSTNAME and LASTNAME

CREATE OR ALTER TRIGGER TR_CLEAN_EMPLOYEE_NAME
ON EMPLOYEE
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO EMPLOYEE
    (
        EID,
        FIRSTNAME,
        LASTNAME,
        CITY,
        SALARY,
        DEPARTMENT,
        JOININGYEAR
    )
    SELECT
        EID,
        LTRIM(RTRIM(FIRSTNAME)),
        LTRIM(RTRIM(LASTNAME)),
        CITY,
        SALARY,
        DEPARTMENT,
        JOININGYEAR
    FROM inserted;
END;