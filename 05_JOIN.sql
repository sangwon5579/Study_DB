#inner join
#각 사원들의 사번, 직원명, 부서코드,부서명 조회
SELECT emp_id, emp_name, dept_id, dept_title
FROM employee e INNER JOIN department d ON dept_code = dept_id;

#각 사원들의 사번, 직원명, 직급코드, 직급명 조회(employee), (job)
#테이블명 앞에 표기해서 중복되는 열 처리
SELECT emp_no, emp_name, job.job_code, job_name
FROM employee INNER JOIN job ON employee.job_code = job.job_code;

#테이블 별칭 이용
SELECT e.emp_no, e.emp_name, j.job_code, j.job_name
FROM employee e INNER JOIN job j ON e.job_code = j.job_code;

#natural join사용
SELECT emp_no, emp_name, job_code, job_name
FROM employee NATURAL JOIN job;

-- usertbl 테이블과 buytbl 테이블을 조인하여
-- JYP라는 아이디를 가진 회원의 이름, 주소, 연락처, 주문 상품 이름을 조회
SELECT u.name AS '이름',
		 u.addr AS '주소',
		 CONCAT(u.mobile1, '-', u.mobile2) AS '연락처',
		 b.prodName AS '주문 상품 이름'
FROM usertbl u INNER JOIN buytbl b ON u.userID = b.userID
WHERE u.userid = 'JYP';


-- employee 테이블과 department 테이블을 조인하여 보너스를 받는 사원들의 사번, 직원명, 보너스, 부서명을 조회
SELECT e.emp_no AS '사번', 
		 e.emp_name AS '직원명', 
		 e.bonus AS '보너스', 
		 d.dept_title AS '부서명'
FROM employee e  INNER JOIN department d ON e.dept_code = d.dept_id
WHERE e.bonus IS NOT NULL;

-- employee 테이블과 department 테이블을 조인하여 인사관리부가 아닌 사원들의 직원명, 부서명, 급여를 조회
SELECT e.emp_name AS '직원명', 
		 d.dept_title AS '부서명',
		 e.salary AS '급여'
FROM employee e INNER JOIN department d ON e.dept_code = d.dept_id
WHERE d.dept_title != '인사관리부';

-- employee 테이블과 department 테이블, job 테이블을 조인하여 사번, 직원명, 부서명, 직급명 조회
SELECT e.emp_no AS '사번', 
		 e.emp_name AS '직원명', 
		 d.dept_title AS '부서명',
		 j.job_name AS '직급명'
FROM employee e  
	  INNER JOIN department d ON d.dept_id = e.dept_code 
	  INNER JOIN job j ON e.job_code = j.job_code;
#3개의 join인 경우 join의 순서도 중요함

#outerjoin
SELECT e.emp_name,
		 d.dept_id,
		 d.dept_title,
		 e.salary
FROM employee e INNER JOIN department d ON e.dept_code = d.dept_id
ORDER BY d.dept_id;

SELECT e.emp_name,
		 d.dept_id,
		 d.dept_title,
		 e.salary
FROM employee e LEFT OUTER JOIN department d ON e.dept_code = d.dept_id
ORDER BY d.dept_id;

SELECT e.emp_name,
		 d.dept_id,
		 d.dept_title,
		 e.salary
FROM employee e LEFT JOIN department d ON e.dept_code = d.dept_id
ORDER BY d.dept_id;

SELECT e.emp_name,
		 d.dept_id,
		 d.dept_title,
		 e.salary
FROM employee e RIGHT OUTER JOIN department d ON e.dept_code = d.dept_id
ORDER BY d.dept_id;

SELECT *
FROM employee CROSS JOIN department;
#단순 행의 곱 만큼의 개수를 출력

SELECT *
FROM employee;

SELECT *
FROM department;

#self join
SELECT e.emp_id,
		 e.emp_name,
		 e.dept_code,
		 e.manager_id,
		 m.emp_id,
		 m.emp_name
FROM employee e INNER JOIN employee m ON e.manager_id = m.emp_id;

SELECT e.emp_id,
		 e.emp_name,
		 e.dept_code,
		 e.manager_id,
		 m.emp_name
FROM employee e LEFT JOIN employee m ON e.manager_id = m.emp_id;

#join 조건에 등호(=)를 사용하지 않는 조건문. 비등가 조인
#nonequal join
#employee 테이블과 sal_grade 테이블을 비등가 조인하여 직원명, 급여, 급여등급 조회
SELECT e.emp_name,
		 e.salary,
		 s.sal_level
FROM employee e INNER JOIN sal_grade s ON e.salary >= s.min_sal AND e.salary < s.max_sal;

SELECT e.emp_name,
		 e.salary,
		 s.sal_level
FROM employee e INNER JOIN sal_grade s ON e.salary BETWEEN s.min_sal AND s.max_sal;

SELECT e.emp_name,
		 e.salary,
		 s.sal_level
FROM employee e LEFT JOIN sal_grade s ON e.salary BETWEEN s.min_sal AND s.max_sal;

-- 이름에 '형'자가 들어있는 직원들의 사번, 직원명, 직급명을 조회
SELECT e.emp_no, e.emp_name, j.job_name 
FROM employee e INNER JOIN job j ON e.job_code = j.job_code
WHERE e.emp_name LIKE '%형%';

-- 70년대생 이면서 여자이고, 성이 전 씨인 직원들의 직원명, 주민번호, 부서명, 직급명을 조회하세요.
SELECT e.emp_name,
		 e.emp_no,
		 d.dept_title,
		 j.job_name
FROM employee e
	  INNER JOIN job j ON e.job_code = j.job_code
	  INNER JOIN department d ON e.dept_code=d.dept_id
WHERE e.emp_no LIKE '7%' AND SUBSTRING(e.emp_no, 8, 1) IN ('2', '4') AND e.emp_name LIKE '전%';


-- 각 부서별 평균 급여를 조회하여 부서명, 평균 급여를 조회
-- 단, 부서 배치가 안된 사원들의 평균도 같이 나오게끔 조회해 주세요.
SELECT IFNULL(d.dept_title, '부서 없음'),
		 FLOOR(AVG(e.salary))
FROM employee e LEFT OUTER JOIN department d ON e.dept_code = d.dept_id
GROUP BY d.dept_title;

-- 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합을 조회
SELECT d.dept_title,
		 SUM(e.salary)
FROM employee e RIGHT OUTER JOIN department d ON e.dept_code = d.dept_id
GROUP BY d.dept_title
HAVING SUM(e.salary) >= 10000000
ORDER BY SUM(e.salary) DESC;

-- 해외영업팀에 근무하는 직원들의 직원명, 직급명, 부서 코드, 부서명을 조회
SELECT e.emp_name,
		 j.job_name,
		 d.dept_id,
		 d.dept_title
FROM employee e
	  INNER JOIN job j ON e.job_code = j.job_code
	  INNER JOIN department d ON e.dept_code=d.dept_id
WHERE d.dept_title LIKE '해외영업%';
	  
-- 테이블을 다중 JOIN 하여 사번, 직원명, 부서명, 지역명, 국가명 조회
SELECT e.emp_id,
		 e.emp_name,
		 d.dept_title,
		 l.local_name,
		 n.national_name
FROM employee e 
	  INNER JOIN department d ON e.dept_code = d.dept_id
	  INNER JOIN location l ON d.location_id = l.local_code
	  INNER JOIN national n ON l.national_code = n.national_code;
	  
-- 테이블을 다중 JOIN 하여 사번, 직원명, 부서명, 지역명, 국가명, 급여 등급 조회
SELECT e.emp_id,
		 e.emp_name,
		 d.dept_title,
		 l.local_name,
		 n.national_name,
		 s.sal_level
FROM employee e 
	  LEFT OUTER JOIN department d ON e.dept_code = d.dept_id
	  LEFT OUTER JOIN location l ON d.location_id = l.local_code
	  LEFT OUTER JOIN national n ON l.national_code = n.national_code
	  LEFT OUTER JOIN sal_grade s ON e.salary BETWEEN s.min_sal AND s.max_sal;
#부서가 없는 인원들도 같이 출력하여 등급을 확인하기 위해 left outer join 을 사용
#부서가 없으면 지역명, 국가명도 없기에 제일 위만 left outer join을 하는 것이 아니라 아래것들도 모두 left outer join 한다

-- 부서가 있는 직원들의 직원명, 직급명, 부서명, 지역명을 조회하시오.
SELECT e.emp_name,
		 j.job_name,
		 d.dept_title,
		 l.local_name
FROM employee e 
	  INNER JOIN job j ON e.job_code = j.job_code
	  INNER JOIN department d ON e.dept_code = d.dept_id
	  INNER JOIN location l ON d.location_id = l.local_code;

-- 한국과 일본에서 근무하는 직원들의 직원명, 부서명, 지역명, 근무 국가를 조회하세요.
SELECT e.emp_name,
		 d.dept_title,
		 l.local_name,
		 n.national_name
FROM employee e 
	  INNER JOIN department d ON e.dept_code = d.dept_id
	  INNER JOIN location l ON d.location_id = l.local_code
	  INNER JOIN national n ON l.national_code = n.national_code
WHERE n.national_name IN ('한국', '일본');

#union
SELECT emp_id,
		 emp_name,
		 dept_code,
		 salary
FROM employee
WHERE dept_code = 'D5'; 
#6개의 행

SELECT emp_id,
		 emp_name,
		 dept_code,
		 salary
FROM employee
WHERE salary > 3000000;
#8개의 행

SELECT emp_id,
		 emp_name,
		 dept_code,
		 salary
FROM employee
WHERE dept_code = 'D5'

UNION 

SELECT emp_id,
		 emp_name,
		 dept_code,
		 salary
FROM employee
WHERE salary > 3000000;
#12개의 행. 중복 제거
#UNION은 잘 사용하지 않는다. where절의 or을 사용해서 더욱 간편하게 대체 가능하다.

SELECT emp_id,
		 emp_name,
		 dept_code,
		 salary
FROM employee
WHERE dept_code = 'D5'

UNION ALL 

SELECT emp_id,
		 emp_name,
		 dept_code,
		 salary
FROM employee
WHERE salary > 3000000;
#14개의 행. 중복 포함
#UNION ALL은 UNION과 달리 대체할 수 있는 방법이 없다. 