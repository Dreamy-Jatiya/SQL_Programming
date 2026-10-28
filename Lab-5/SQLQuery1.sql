--From the table DEPOSIT perform the following queries:  
--Part – A: 
--1. Add column state varchar(20). 
ALTER TABLE DEPOSIT
ADD STATE VARCHAR(20)
SELECT *FROM DEPOSIT

--2. Add two more columns city varchar(20) and pincode int. 
ALTER TABLE DEPOSIT
ADD CITY VARCHAR(20),PINCODE INT
SELECT *FROM DEPOSIT

--3. Change the size of cname column from varchar(50) to varchar(35).  
ALTER TABLE DEPOSIT
ALTER COLUMN CNAME VARCHAR(35)
SELECT *FROM DEPOSIT

--4. Change the data type of amount from decimal to int. 
ALTER TABLE DEPOSIT
ALTER COLUMN AMOUNT INT
SELECT *FROM DEPOSIT

--5. Delete column city from the DEPOSIT table.
ALTER TABLE DEPOSIT_DETAIL
DROP COLUMN CITY
SELECT *FROM DEPOSIT_DETAIL

--6. Rename column actno to ano.
EXEC SP_RENAME 'DEPOSIT.ACTNO','ANO';
SELECT *FROM DEPOSIT

--7. Rename column bname to branch_name.  
EXEC SP_RENAME 'DEPOSIT.BNAME','BRANCH_NAME';
SELECT *FROM DEPOSIT

--8. Rename table DEPOSIT to DEPOSIT_DETAIL. 
EXEC SP_RENAME 'DEPOSIT','DEPOSIT_DETAIL';
SELECT *FROM DEPOSIT

--9. Add column ifsc_code varchar(15). 
ALTER TABLE DEPOSIT_DETAIL
ADD IFSC_CODE VARCHAR(15)
SELECT *FROM DEPOSIT_DETAIL

--10. Change the size of bname column from varchar(50) to varchar(30). 
ALTER TABLE DEPOSIT_DETAIL
ALTER COLUMN BRANCH_NAME VARCHAR(30)
SELECT *FROM DEPOSIT_DETAIL

--Part – B: 
--11. Rename column adate to aopendate.
EXEC SP_RENAME 'DEPOSIT_DETAIL.ADATE','AOPENDATE';
SELECT *FROM DEPOSIT_DETAIL

--12. Delete column aopendate from DEPOSIT_DETAIL table.  
ALTER TABLE DEPOSIT_DETAIL
DROP COLUMN AOPENDATE
SELECT *FROM DEPOSIT_DETAIL

--13. Rename column cname to customer_name.  
EXEC SP_RENAME 'DEPOSIT_DETAIL.CNAME','CUSTOMER_NAME';
SELECT *FROM DEPOSIT_DETAIL

--14. Add column country varchar(20). 
ALTER TABLE DEPOSIT_DETAIL
ADD COUNTRY VARCHAR(20)
SELECT *FROM DEPOSIT_DETAIL

--15. Add column account_type varchar(15). 
ALTER TABLE DEPOSIT_DETAIL
ADD ACCOUNT_TYPE VARCHAR(20)
SELECT *FROM DEPOSIT_DETAIL

--Part – C: 
--16. Change data type of pincode from int to bigint. 
ALTER TABLE DEPOSIT_DETAIL
ALTER COLUMN PINCODE BIGINT
SELECT *FROM DEPOSIT_DETAIL

--17. Delete column account_type. 
ALTER TABLE DEPOSIT_DETAIL
DROP COLUMN ACCOUNT_TYPE
SELECT *FROM DEPOSIT_DETAIL

--18. Rename column amount to balance. 
EXEC SP_RENAME 'DEPOSIT_DETAIL.AMOUNT','BALANCE';
SELECT *FROM DEPOSIT_DETAIL

--19. Add column status varchar(10). 
ALTER TABLE DEPOSIT_DETAIL
ADD STATUS VARCHAR(10)
SELECT *FROM DEPOSIT_DETAIL

--20. Change table name deposit_detail to bank_deposit. 
EXEC SP_RENAME 'DEPOSIT_DETAIL','BANK_DEPOSIT'

--From the table DEPOSIT perform the following queries:  
--Part – A: 
--1. Delete all the records having amount less than or equal to 3000.
DELETE FROM BANK_DEPOSIT
WHERE BALANCE<=3000
SELECT *FROM BANK_DEPOSIT

--2. Delete all the accounts of ‘BEDI’ branch customer. 
DELETE FROM BANK_DEPOSIT
WHERE BRANCH_NAME='BEDI'
SELECT *FROM BANK_DEPOSIT

--3. Delete all the accounts having account number greater than 102 and less than 109.  
DELETE FROM BANK_DEPOSIT
WHERE ANO>102 AND ANO<109
SELECT *FROM BANK_DEPOSIT

--4. Delete all the accounts whose branch is ‘BEDI’ or ‘MADHAPAR’. 
DELETE FROM BANK_DEPOSIT
WHERE BRANCH_NAME='BEDI'OR BRANCH_NAME='MADHAPAR'
SELECT *FROM BANK_DEPOSIT

--5. Delete all the accounts details where amount is 8000 and account open after 1-1-2025; 
DELETE FROM BANK_DEPOSIT
WHERE BALANCE = 8000
AND AOPENDATE > '2025-01-01';

--6. Delete all the accounts whose account branch is NULL.
DELETE FROM BANK_DEPOSIT
WHERE BRANCH_NAME IS NULL
SELECT *FROM BANK_DEPOSIT

--7. Delete all the accounts details where amount is 7000 and name is CHARMI and branch is SHITAL PARK. 
DELETE FROM BANK_DEPOSIT
WHERE BALANCE=7000 AND CUSTOMER_NAME='CHARMI' AND BRANCH_NAME='SHITAL PARK'
SELECT *FROM BANK_DEPOSIT

--8. Delete all the remaining records using DELETE command.
DELETE FROM BANK_DEPOSIT;
SELECT * FROM BANK_DEPOSIT;

--9. Delete all the records of DEPOSIT table. (Use TRUNCATE)  
TRUNCATE TABLE DEPOSIT;

--10. Remove DEPOSIT table. (Use DROP) 
DROP TABLE DEPOSIT;
 
--From the table STUDENT perform the following queries:  
--Part – B: 
-- 11. Delete all students whose STDID is greater than 105.
DELETE FROM STUDENT
WHERE STDID > 105;

SELECT * FROM STUDENT;

-- 12. Delete records whose BRANCH is NULL and SNAME is not NULL.
DELETE FROM STUDENT
WHERE BRANCH IS NULL
AND SNAME IS NOT NULL;

SELECT * FROM STUDENT;

-- 13. Delete records whose SPI is less than 9 and CITY is RAJKOT.
DELETE FROM STUDENT
WHERE SPI < 9
AND CITY = 'RAJKOT';

SELECT * FROM STUDENT;

-- 14. Delete records whose branch name is not empty.
DELETE FROM STUDENT
WHERE BRANCH IS NOT NULL
AND BRANCH <> '';

SELECT * FROM STUDENT;

-- 15. Delete all records using TRUNCATE.
TRUNCATE TABLE STUDENT;
SELECT * FROM STUDENT;