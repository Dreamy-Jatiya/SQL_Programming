SELECT * FROM STUDENT

--1. Display the details of students whose SPI is greater than the average SPI.
SELECT * 
FROM STUDENT
WHERE SPI > (
	SELECT AVG(SPI) AS AVG_SPI
	FROM STUDENT
)


--2. Display the names of students whose SPI is less than the average SPI.
SELECT * 
FROM STUDENT
WHERE SPI < (
	SELECT AVG(SPI) AS AVG_SPI
	FROM STUDENT
)


--3. Display the student details who has the highest SPI.
SELECT * 
FROM STUDENT
WHERE SPI = (
	SELECT MAX(SPI)
	FROM STUDENT
)


--4. Display the student details who has the lowest SPI.
SELECT * 
FROM STUDENT
WHERE SPI = (
	SELECT MIN(SPI)
	FROM STUDENT
)


--5. Display the students whose SPI is greater than SPI of student DHARMIK.
SELECT * 
FROM STUDENT
WHERE SPI > (
	SELECT SPI
	FROM STUDENT
	WHERE SNAME = 'DHARMIK'
)


--6. Display the students whose SPI is less than SPI of student RIYA.
SELECT * 
FROM STUDENT
WHERE SPI < (
	SELECT SPI
	FROM STUDENT
	WHERE SNAME = 'RIYA'
)


--7. Display the students who belong to the same branch as KRUNAL.
SELECT * 
FROM STUDENT
WHERE BRANCH = (
	SELECT BRANCH
	FROM STUDENT
	WHERE SNAME = 'KRUNAL'
)


--8. Display the students whose branch is different from HETVI.
SELECT * 
FROM STUDENT
WHERE BRANCH != (
	SELECT BRANCH
	FROM STUDENT
	WHERE SNAME = 'HETVI'
)


--9. Display the second highest SPI from RESULT table.
SELECT MAX(SPI) AS SECOND_HIGHEST_SPI
FROM STUDENT
WHERE SPI != (
	SELECT MAX(SPI)
	FROM STUDENT
)


--10. Display the second lowest SPI from RESULT table.
SELECT MIN(SPI) AS SECOND_LOWEST_SPI
FROM STUDENT
WHERE SPI != (
	SELECT MIN(SPI)
	FROM STUDENT
)


--11. Display the names of students whose SPI is above branch-wise average SPI.
SELECT * 
FROM STUDENT S
WHERE SPI > (
	SELECT AVG(SPI)
	FROM STUDENT
	WHERE BRANCH = S.BRANCH
)


--12. Display the branch having maximum average SPI.
SELECT BRANCH , AVG(SPI) AS AVG_SPI
FROM STUDENT S
WHERE BRANCH IS NOT NULL
GROUP BY BRANCH
HAVING AVG(SPI) >= ALL(
	SELECT AVG(SPI)
	FROM STUDENT
	WHERE BRANCH IS NOT NULL
	GROUP BY BRANCH
)


--13. Display the branch having minimum average SPI.
SELECT BRANCH , AVG(SPI) AS AVG_SPI
FROM STUDENT S
WHERE BRANCH IS NOT NULL
GROUP BY BRANCH
HAVING AVG(SPI) <= ALL(
	SELECT AVG(SPI)
	FROM STUDENT
	WHERE BRANCH IS NOT NULL
	GROUP BY BRANCH
)



SELECT * FROM STUDENT_INFO
SELECT * FROM RESULT

--14. Display the students whose SPI is greater than all students of ME branch.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S. RNO
WHERE R.SPI > ALL(
	SELECT R.SPI
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S. RNO
	WHERE S.BRANCH = 'ME'
)


--15. Display the students whose SPI is less than any student of ME branch.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S. RNO
WHERE R.SPI < ANY(
	SELECT R.SPI
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S. RNO
	WHERE S.BRANCH = 'ME'
)


--16. Display the student details whose SPI is not equal to any SPI of EC branch students.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S. RNO
WHERE R.SPI <> ANY(
	SELECT R.SPI
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S. RNO
	WHERE S.BRANCH = 'EC'
)


--17. Display the names of students who scored higher SPI than student of RNO 103.
SELECT S.NAME
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S. RNO
WHERE R.SPI > ALL(
	SELECT SPI
	FROM RESULT
	WHERE RNO = 103
)


--18. Display the students whose SPI is greater than average SPI of their own branch.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S. RNO
WHERE R.SPI > ALL(
	SELECT AVG(R.SPI)
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S.RNO
	GROUP BY BRANCH
)


--19. Display the students whose SPI is greater than the average SPI of CE branch but greater than the maximum SPI of ME branch.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S. RNO
WHERE R.SPI > ALL(
	SELECT AVG(R.SPI)
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S.RNO
	WHERE S.BRANCH = 'CE'
) AND R.SPI > (
	SELECT MAX(R.SPI)
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S.RNO
	WHERE S.BRANCH = 'ME'
)


--20. Display the branch names whose average SPI is greater than the overall average SPI.
SELECT S.BRANCH
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S.RNO
GROUP BY S.BRANCH
HAVING AVG(R.SPI) > (
	SELECT AVG(SPI)
	FROM RESULT
)


--21. Display the students who have maximum SPI in their respective branch.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S.RNO
WHERE R.SPI IN (
	SELECT MAX(R.SPI)
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S.RNO
	GROUP BY BRANCH
)


--22. Display the students whose SPI is greater than their average SPI of their branch and greater than overall average SPI.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S.RNO
WHERE R.SPI > (
	SELECT AVG(R1.SPI)
	FROM STUDENT_INFO S1
	INNER JOIN RESULT R1
	ON R1.RNO = S1.RNO
	WHERE S.BRANCH = S1.BRANCH
) AND R.SPI > (
	SELECT AVG(SPI)
	FROM RESULT
)


--23. Display the students whose SPI is greater than at least one student of every branch.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S.RNO
WHERE R.SPI > ALL(
	SELECT MIN(R.SPI)
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S.RNO
	GROUP BY S.BRANCH
)


--24. Display the students whose SPI is less than all students of CE branch.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S. RNO
WHERE R.SPI < ALL(
	SELECT R.SPI
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S. RNO
	WHERE S.BRANCH = 'CE'
)


--25. Display the branch that contains the student with highest SPI.
SELECT S.BRANCH
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S. RNO
WHERE R.SPI = (
	SELECT MAX(SPI)
	FROM RESULT
)


--26. Display the students whose SPI is less than the SPI of every student in CE branch and greater than every student in ME branch.
SELECT S.* , R.SPI
FROM STUDENT_INFO S
INNER JOIN RESULT R
ON R.RNO = S. RNO
WHERE R.SPI < ALL(
	SELECT R.SPI
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S.RNO
	WHERE S.BRANCH = 'CE'
) AND R.SPI > ALL(
	SELECT R.SPI
	FROM STUDENT_INFO S
	INNER JOIN RESULT R
	ON R.RNO = S.RNO
	WHERE S.BRANCH = 'ME'
)
