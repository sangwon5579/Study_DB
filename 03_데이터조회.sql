SELECT *
FROM employee
WHERE email LIKE '___$_%' ESCAPE '$'; 

#ORDER BY
#userbl 테이블에서 mDate으로 오름차순, 내림차순 정렬
SELECT `userid`,
			`name`,
			`mDate`
FROM usertbl
ORDER BY mDate DESC
LIMIT 3;

USE test_db
#usertbl 테이블에서 oddr로 오름차순 정렬
#단, addr 일치할 경우 mDate를 가지고 내림차순 정렬
SELECT `userID`, `addr`, `mDate`
FROM usertbl
ORDER BY addr ASC, mDate DESC; 

SELECT *
FROM usertbl
ORDER BY addr ASC, mDate DESC;

SELECT *
FROM usertbl;

#usertbl 테이블에서 아이디, 이름, 가입일 조회
#이름으로 내림차순 조회
SELECT `userid` AS '아이디',
			`name` AS '이름',
			`mDate` AS '가입일'
FROM usertbl
ORDER BY 이름 DESC
ORDER BY `name` DESC --열의 이름
ORDER BY 2 DESC --열의 순번
ORDER BY `이름` DESC --열의 별칭
#order by는 제일 마지막에 실행되니깐, 별칭도 사용 가능. 단, LIMIT은 order by보다 더 뒤에 실행됨

#####
#GROUP BY
#열이름 사용해야됨, 순번이랑 별칭 등 사용 불가
#SELECT문에 집계합수 사용가능
SELECT addr, COUNT(*)
FROM usertbl
GROUP BY addr; --중복되는것들이 하나로 묶임(그룹핑)

SELECT DISTINCT addr, COUNT(*) -- destinct는 중복을 제거하는 것. 그룹으로 묶지 않았으니, 테이블의 전체 개수를 단순히 카운트. 전체 행의 개수
FROM usertbl; --중복되는것들을 한번만 출력
# 중복 제거와 그룹으로 묶는 것은 다르다!

###
# 집계함수 - 모든행으로부터 하나의 결과값을 가지고 온다. (NOT 단일행함수, 윈도우 함수)
#emplotee table에서 전체 사원의 급여의 합계조회
SELECT SUM(salary) AS '급여의  합계'
FROM employee;

#emplooyee table에서 부서별 급여의 합계 조회 (부서별 오름차순으로 정렬)
SELECT dept_code AS '부서명', SUM(salary) AS '부서별 급여 합계'
FROM employee
GROUP BY dept_code
ORDER BY dept_code;

SELECT *
FROM buytbl;
#이 테이블에서 사용자별로 구매한 개수의  합계를 조합
SELECT `userid`, SUM(amount) AS '개수의 합계', SUM(price*amount) AS '총 가격'
FROM buytbl
GROUP BY userID

#위 테이블에서 전체 구매자가 구매한 물품 개수와 평균
SELECT AVG(amount), ROUND(AVG(amount))
FROM buytbl

#사용자별 평균 구매 개수
SELECT userid, AVG(amount)
FROM buytbl
GROUP BY userid;

#가장 작은 키와 가장 큰 키를 조회하기.
SELECT MAX(height) AS '가장 큰 키', MIN(height) AS '가장 작은 키'
FROM usertbl;

#조회된 행의 개수를 출력하는 COUNT()함수
#조회된 전체 행의 개수를 출력하기
SELECT COUNT(*) AS '전체 행의 개수'
FROM usertbl;

#휴대폰이 있는 회원의 수 출력하기
SELECT COUNT(*) AS '휴대폰 보유 인원'
FROM usertbl
WHERE mobile1 IS NOT NULL;

SELECT COUNT(mobile1)
FROM usertbl;
#위와 동일함. count를 할때 null값은 카운트를 안함. 값이 있는 데이터만 count

SELECT COUNT(DISTINCT mobile1) #중복되는건 한번만 카운트
FROM usertbl;

SELECT *
FROM employee;

-- Employee 테이블에서 부서 코드가 D5인 사원들의 총 연봉의 합계를 조회
SELECT SUM(salary*12)
FROM employee
WHERE dept_code = 'D5';

SELECT dept_code, SUM(salary*12)
FROM employee
WHERE dept_code = 'D5'
GROUP BY dept_code;

-- employee 테이블의 전체 사원의 급여 평균 조회
SELECT AVG(salary) AS '전체 사원 급여 평균 조회'
FROM employee;

SELECT round(AVG(ifnull(salary,0))) AS '전체 사원 급여 평균 조회'
FROM employee;

-- employee 테이블에서 퇴사한 직원의 수를 조회 (ENT_DATE가 NULL인 경우 개수를 세지않는다.)
SELECT COUNT(*) AS '퇴사한직원수'
FROM employee
WHERE ent_date IS NOT NULL;

SELECT COUNT(ent_date) #null은 카운트 안됨.
FROM employee;

-- employee 테이블에서 직급별 급여의 합계를 조회 (직급별 내림차순 정렬)
SELECT job_code, SUM(salary)
FROM employee
GROUP BY job_code
ORDER BY job_code DESC;

-- employee 테이블에서 부서별 사원의 수를 조회
SELECT dept_code, COUNT(*) AS '사원 수'
FROM employee
GROUP BY dept_code;

SELECT IFNULL(dept_code, '부서없음'), COUNT(*) AS '사원 수'
FROM employee
GROUP BY dept_code;

-- employee 테이블에서 부서별 사원의 수, 보너스를 받는 사원의 수, 급여의 합, 평균 급여, 최고 급여, 최저 급여를 조회 (부서별 내림차순)
SELECT dept_code, COUNT(emp_id), 
						COUNT(bonus IS NOT NULL), 
						COUNT(bonus),
						SUM(salary), 
						AVG(salary), 
						MAX(salary), 
						MIN(salary)
FROM employee
GROUP BY dept_code
ORDER BY dept_code DESC;

-- employee 테이블에서 부서 코드와 직급 코드가 같은 사원의 사원의 수, 급여의 합을 조회
SELECT dept_code, job_code, COUNT(*), SUM(salary)
FROM employee
GROUP BY dept_code, job_code; #지정한 열의 값이 서로 모두 같아야 그룹핑 

########
#HAVING
#집계함수에 대해서 조건을 제한하는 구문
#group by절 뒤에 작성
SELECT *
FROM buytbl;

#총구매금액이 1000이상인 회원의 아이디, 구매금액  조회하기
SELECT userid, 
		 sum(price*amount)
FROM buytbl
GROUP by userid 
HAVING sum(price*amount) >= 1000
ORDER BY sum(price*amount) ASC;
#집계함수의 결과를 ,where절에서 조건으로 서용하는건 불가능

# bytbl 테이블에서 사용자별 구매 평균 개수가 3개 이상인 회원의 id, 평균 구매 개수 조회
SELECT userid,
		 AVG(amount)
FROM buytbl
GROUP BY userid
HAVING AVG(amount) >=3;


SELECT *
FROM employee
-- employee table에서 부서별로 급여가 300만원 이상인 직원의 평균 급여를 조회
SELECT dept_code AS '부서', 
		 AVG(salary) AS '평균 급여'
FROM employee
WHERE salary >= 3000000
GROUP BY dept_code
ORDER BY 2 DESC;

-- employee 테이블에서 부서별 평균 급여가 300만원 이상인 부서의 부서 코드, 평균 급여를 조회
SELECT dept_code AS '부서', 
	    AVG(salary) AS '평균 급여'
FROM employee
GROUP BY dept_code
HAVING AVG(salary) >= 3000000
#ORDER BY 2 DESC;

-- employee 테이블에서 직급별 총 급여의 합이 10,000,000 이상인 직급만 조회
SELECT job_code
FROM employee
GROUP BY job_code
HAVING SUM(salary) >= 10000000;

-- employee 테이블에서 부서별 보너스를 받는 사원이 없는 부서만 조회
SELECT dept_code, COUNT(bonus), COUNT(*)
FROM employee
GROUP BY dept_code;

SELECT dept_code
FROM employee
GROUP BY dept_code
HAVING COUNT(bonus) = 0;

/*
SELECT 구문 실행 순서
5. SELECT
1. FROM
2. WHERE
3. GROU[P BY
4. HAVING
6. ORDER BY
7. LIMIT
*/


