--From the tables EMPLOYEE perform the following queries: 
--Part – A: 
--1. Display employees detail whose FIRSTNAME starts with ‘H’. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE 'H%'

--2. Display employees detail whose FIRSTNAME consists of exactly 5 characters. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '_____'

--3. Display employees detail whose CITY ends with ‘T’ and has 6 characters. 
SELECT *FROM EMPLOYEE
WHERE CITY LIKE '_____%T'

--4. Display employees detail whose LASTNAME ends with ‘EL’. 
SELECT *FROM EMPLOYEE
WHERE LASTNAME LIKE '%EL'

--5. Display employees detail whose FIRSTNAME starts with ‘R’ and ends with ‘A’. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE 'R%%A'

--6. Display employees detail whose FIRSTNAME starts with ‘V’ and third character is ‘S’. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE 'V%_S%'

--7. Display employees detail whose CITY is NULL and FIRSTNAME has 6 characters. 
SELECT *FROM EMPLOYEE
WHERE CITY IS NULL AND FIRSTNAME LIKE '______'

--8. Display employees detail whose FIRSTNAME contains ‘AR’. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '%AR%'

--9. Display employees detail whose CITY starts with ‘R’ or ‘B’. 
SELECT *FROM EMPLOYEE
WHERE CITY LIKE '[RB]%'

--10. Display employees detail whose DEPARTMENT is NOT NULL. 
SELECT *FROM EMPLOYEE
WHERE DEPARTMENT IS NOT NULL

--11. Display employees detail whose FIRSTNAME starts from alphabet A to H. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '[A-H]%'

--12. Display employees detail whose second character of FIRSTNAME is a vowel. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '_[AEIOU]%'

--13. Display employees detail whose FIRSTNAME length ≥ 5. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '_____%'

--14. Display employees detail whose LASTNAME starts with ‘PA’. 
SELECT *FROM EMPLOYEE
WHERE LASTNAME LIKE 'PA%'

--15. Display employees detail whose CITY does not start with ‘B’.
SELECT *FROM EMPLOYEE
WHERE CITY LIKE '[^B]%'

--16. Display employees whose second character of FIRSTNAME is a not vowel. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '_[^AEIOU]%'

--17. Display employees whose JOINING YEAR last digit is 4 or 6. 
SELECT *FROM EMPLOYEE
WHERE JOININGYEAR LIKE '%[46]'

--18. Display employees detail whose FIRSTNAME starts with ‘H’, ends with ‘I’, and CITY contains ‘RA’. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE 'H%%I' AND CITY LIKE '%RA%'

--19. Display employees detail whose FIRSTNAME contains ‘A’, CITY ends with ‘D’, and DEPARTMENT is NOT 
--NULL. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '%A%'AND CITY LIKE '%D' AND DEPARTMENT LIKE '%'

--20. Display employees whose second and third characters of FIRSTNAME are vowels and CITY starts with ‘R’. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '_[AEIOU][AEIOU]%' AND CITY LIKE 'R%'

--Part – B: 
--21. Display employees whose CITY contains ‘RA’ and salary less than 13000 and joining year last digit is 6. 
SELECT *FROM EMPLOYEE
WHERE CITY LIKE '%RA%' AND SALARY < 13000 AND JOININGYEAR LIKE '%6'

--22. Display employees whose SALARY between 10000 and 15000 and CITY name contains 'KO' and 
--FIRSTNAME start with H. 
SELECT *FROM EMPLOYEE
WHERE (SALARY BETWEEN 10000 AND 15000) AND CITY LIKE '%KO%' AND FIRSTNAME LIKE 'H%'

--23. Display employees whose FIRSTNAME starts with ‘A’ or ‘D’ and SALARY greater than 12000. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '[AD]%' AND SALARY >12000

--24. Display employees whose CITY contains ‘N’ and SALARY less than 15000. 
SELECT *FROM EMPLOYEE
WHERE CITY LIKE '%N%' AND SALARY <15000

--25. Display employees whose FIRSTNAME length = 6 and CITY ends with ‘AR’. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '______' AND CITY LIKE '%AR'
 
--Part – C: 
--26. Display employees whose FIRSTNAME ends with a vowel, department name start with vowel, and 
--SALARY is between 10000 and 15000. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '%[AEIOU]' AND DEPARTMENT LIKE '[AEIOU]%' AND (SALARY BETWEEN 10000 AND 15000)

--27. Display employees whose LASTNAME contains ‘A’ at least twice, gender is male, and SALARY is not equal 
--to 14000.
SELECT *FROM EMPLOYEE
WHERE LASTNAME LIKE '%A%A%' AND GENDER = 'MALE' AND (SALARY !=14000)

--28. Display employees whose FIRSTNAME second character is vowel and LASTNAME ends with ‘R’ and 
--SALARY less than 12000. 
SELECT *FROM EMPLOYEE
WHERE FIRSTNAME LIKE '_[AEIOU]%' AND LASTNAME LIKE '%R' AND (SALARY <12000)

--29. Display employees whose CITY is NOT NULL and FIRSTNAME does not start with vowel and DEPARTMENT 
--not in (‘HR’, ‘IT’). Z
SELECT *FROM EMPLOYEE
WHERE CITY LIKE '%' AND FIRSTNAME LIKE '[^AEIOU]%' AND DEPARTMENT NOT IN ('HR','IT')

--30. Display employees whose CITY is not NULL, FIRSTNAME ends with vowels, and DEPARTMENT is neither 
--‘HR’ nor ‘IT’.
SELECT *FROM EMPLOYEE
WHERE CITY LIKE '%' AND FIRSTNAME LIKE '%[AEIOU]' AND DEPARTMENT NOT IN ('HR','IT')