#window 함수
#순위함수

#키가 큰 순으로 순위매겨서 순위, 이름, 주소, 키를조회
SELECT ROW_NUMBER() OVER(ORDER BY height DESC), 
		 `name`, 
		 `height`
FROM usertbl;

#지역별로 순위를 매기기
SELECT ROW_NUMBER() OVER(PARTITION BY addr ORDER BY height DESC), 
		 `name`, 
		 `addr`,
		 `height`
FROM usertbl;

#동일 순위 이후의 등수를 동일한 인원수만큼 건너뛰고 증가
SELECT RANK() OVER(ORDER BY height DESC),
		`name`,
		addr
		height
FROM usertbl;

#동일한 순위 이후의등수를 1 증가, 인원수 반영X
SELECT DENSE_RANK() OVER(ORDER BY height DESC),
		`name`,
		addr
		height
FROM usertbl;

#급여가 높은 상위 10명의 순위, 직원명, 급여 조회
SELECT RANK() OVER(ORDER BY salary DESC) AS 'RANK',
		 emp_name,
		 salary
FROM employee
LIMIT 10;

SELECT emp.rank, emp.emp_name, emp.salary
FROM (
	SELECT RANK() OVER(ORDER BY salary DESC) AS 'rank',
		 emp_name,
		 salary
	FROM employee
) AS emp
WHERE emp.rank BETWEEN 1 AND 10;
#mariadb는 limit를 지원하지만 지원안해주는 DBMS도 있음. 그런경우 위와 같이 서브쿼리를 사용해서 처리하면 됨

#n개의 그룹/집합/등급으로 나누어서 상위부터 등급을 부여하는 형식
SELECT NTILE(3) OVER(ORDER BY height DESC) AS 'rank',
		 `name`,
		 `addr`,
		 `height`
FROM usertbl;

#키 순서대로 정렬 후 다음 사람과 키 차이를 조회
SELECT `name`,
		 `addr`,
		 `height`,
		 LEAD(height, 1) OVER(ORDER BY height DESC) AS 'height_2',
		 #현재 행의 키와 **다음**  n번째 행의 키의 차이를 구한다
		 height - LEAD(height, 1) OVER(ORDER BY height DESC) AS 'sub'
FROM usertbl;

#키 순서대로 정렬 후 이전 사람과 키 차이를 조회
SELECT `name`,
		 `addr`,
		 `height`,
		 LAG(height, 1) OVER(ORDER BY height DESC) AS 'height_2',
		 #현재 행의 키와 **이전**  n번째 행의 키의 차이를 구한다
		 height - LAG(height, 1) OVER(ORDER BY height DESC) AS 'sub'
FROM usertbl;
