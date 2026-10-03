--Implement Exception Handling Using TRY...CATCH, Throw and Raise Error in SQL

--Part – A: 
--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.
BEGIN TRY
    DECLARE @A INT=10,@B INT=0;

    PRINT @A/@B;
END TRY

BEGIN CATCH
    PRINT 'Error occurs that is - Divide by zero error';
END CATCH;


--2. Try to convert string to integer and handle the error using try…catch block.
BEGIN TRY
    DECLARE @NUM INT;

    SET @NUM='ABC';

    PRINT @NUM;
END TRY

BEGIN CATCH
    PRINT 'INVALID CONVERSION';
END CATCH;

--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle 
--exception with all error functions if any one enters string value in numbers otherwise print result. 
CREATE PROCEDURE SP_SUM
    @A INT,
    @B INT
AS
BEGIN
    BEGIN TRY
        PRINT @A+@B;
    END TRY

    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        PRINT ERROR_NUMBER();
        PRINT ERROR_SEVERITY();
        PRINT ERROR_STATE();
        PRINT ERROR_LINE()
        PRINT ERROR_PROCEDURE()
    END CATCH
END;
EXEC SP_SUM 12,20

--4. Handle a Primary Key Violation while inserting data into STUDENT_INFO table and print the error 
--details such as the error message, error number, severity, and state. 
BEGIN TRY
    INSERT INTO STUDENT(STDID,SNAME,CITY,SPI,BRANCH)
    VALUES(101,'RAHUL','SURAT',7.8,'CE');
   
END TRY

BEGIN CATCH
        PRINT ERROR_MESSAGE();
        PRINT ERROR_NUMBER();
        PRINT ERROR_SEVERITY();
        PRINT ERROR_STATE();
        PRINT ERROR_LINE()
        PRINT ERROR_PROCEDURE()
END CATCH;

--5. Throw custom exception using stored procedure which accepts RNO as input & that throws Error like 
--no RNO is available in database. 
CREATE PROCEDURE SP_RNO
    @RNO INT
AS
BEGIN
    IF NOT EXISTS(SELECT *
        FROM STUDENT
        WHERE STDID=@RNO)
        THROW 50001,'NO RNO IS AVAILABLE IN DATABASE',1;
END;

 
--Part – B 
--6. Create a stored procedure to update employee SALARY and throw custom exception if salary is 
--negative or zero (Use EMPLOYEE Table). 
CREATE PROCEDURE SP_SALARY
    @EID INT,
    @SALARY DECIMAL(10,2)
AS
BEGIN
    IF @SALARY<=0
        THROW 50002,'SALARY CANNOT BE NEGATIVE OR ZERO',1;

    UPDATE EMPLOYEE
    SET SALARY=@SALARY
    WHERE EID=@EID;
END;
EXEC SP_SALARY 101,-1

--7. Handle a Foreign Key Violation while inserting data into RESULT table and print appropriate error 
--message (Use RESULT Table).
BEGIN TRY
    INSERT INTO STUDENT VALUES(20,8.5,999);
END TRY

BEGIN CATCH
    PRINT 'FOREIGN KEY VIOLATION';
END CATCH;

--8. Handle Invalid Date Format while inserting data into DEPOSIT table.
BEGIN TRY
    INSERT INTO DEPOSIT
    VALUES(120,'RAHUL','MAVDI',5000,'40-15-2025');
END TRY

BEGIN CATCH
    PRINT 'INVALID DATE FORMAT';
END CATCH;


--9. Create a stored procedure that validates gender column and throws error if value is other than male or 
--female (Use EMPLOYEE Table).
CREATE PROCEDURE SP_GENDER
    @EID INT,
    @GENDER VARCHAR(10)
AS
BEGIN
    IF @GENDER NOT IN ('MALE','FEMALE')
        THROW 50003,'INVALID GENDER',1;

    UPDATE EMPLOYEE
    SET GENDER=@GENDER
    WHERE EID=@EID;
END;
EXEC SP_GENDER 101,'OTHER'

--10. Create a stored procedure that accepts joiningyear and throws custom exception if entered year is 
--greater than current year (Use EMPLOYEE Table). 
CREATE PROCEDURE SP_JOINYEAR
    @YEAR INT
AS
BEGIN
    IF @YEAR>YEAR(GETDATE())
        THROW 50004,'INVALID JOINING YEAR',1;
END;
EXEC SP_JOINYEAR 2027

--Part – C 
--10. Create a stored procedure to delete employee record and handle exception if employee does not exist.
CREATE PROCEDURE SP_DELETE_EMP
    @EID INT
AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM EMPLOYEE
        WHERE EID=@EID)
        THROW 50005,'EMPLOYEE DOES NOT EXIST',1;

    DELETE FROM EMPLOYEE
    WHERE EID=@EID;
END;
EXEC SP_DELETE_EMP 100

--11. Create a stored procedure that throws custom exception if department name is NULL during insertion.
CREATE PROCEDURE SP_DEPARTMENT
@EID INT,
@FIRSTNAME VARCHAR(50),
@LASTNAME VARCHAR(50),
@DEPT VARCHAR(50),
@SALARY DECIMAL(10,2),
@CITY VARCHAR(50),
@GENDER VARCHAR(10),
@JOININGYEAR INT
AS
BEGIN
    IF @DEPT IS NULL
        THROW 50006,'DEPARTMENT CANNOT BE NULL',1;
    ELSE
        INSERT INTO EMPLOYEE(EID,FIRSTNAME,LASTNAME,DEPARTMENT,SALARY,CITY,GENDER,JOININGYEAR)
        VALUES(@EID,@FIRSTNAME,@LASTNAME,@DEPT,@SALARY,@CITY,@GENDER,@JOININGYEAR);
END;

EXEC SP_DEPARTMENT 100,'RAJ','PATEL',NULL,12000,'RAJKOT','MALE',2026



