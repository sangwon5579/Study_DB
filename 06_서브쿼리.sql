#하나의 sql 구문안에 포함된 또 다른 sql 구문

#ex
#노옹철 사원과 같은 부서에 있는 사원들 조회
# 1) 노옹철 사원의 부서 코드를 조회
SELECT emp_name, 
		 dept_code
FROM employee
WHERE emp_name = '노옹철';

# 2) 부서코드가 노옹철 사원의 부서 코드와 동일한 사원들을 조회
SELECT emp_name,
		 dept_code
FROM employee
WHERE dept_code = 'D9';

# 3) 위의  두 단계를 서브쿼리를 사용하여 하나의 쿼리문으로 작성
SELECT emp_name,
		 dept_code
FROM employee
WHERE dept_code = (SELECT dept_code
						 FROM employee
						 WHERE emp_name = '노옹철');
						 
					
#서브쿼리 구분
#서브쿼리는 서브쿼리를 수행한 결과값의 행과 열의 개수에 따라서 분류할 수 있다.
#1) 단일행 서브 쿼리
-- 서브쿼리의 조회 결과값의 개수가 1개일 때
-- 직원의 평균 급여보다 더 많은 급여를 받고 있는 직원들의 사번, 직원명, 직급 코드, 급여를 조회
SELECT emp_no,
		 emp_name,
		 dept_code,
		 salary
FROM employee
WHERE salary >= (SELECT AVG(salary)
					 FROM employee);
#2) 노옹철 사원의 급여보다 더 많이 받는 사원의 사번, 직원명, 부서명, 급여 조회
SELECT e.emp_id,
		 e.emp_name,
		 d.dept_title,
		 e.salary
FROM employee e INNER JOIN department d ON e.dept_code = d.dept_id
WHERE e.salary > (SELECT salary
						 FROM employee
						 WHERE emp_name = '노옹철');
					 
#2) 다중행 서브쿼리
#서브쿼리의 조회 결과값의 개수가 여러 행일때
#각 부서별 최고 급여를 받는 직원의 이름, 직급 코드, 부서 코드, 급여 조회
SELECT emp_name,
		 job_code,
		 dept_code,
		 salary 
FROM employee
WHERE salary IN (SELECT MAX(salary)
					  FROM employee
					  GROUP BY dept_code
					  HAVING dept_code IS NOT NULL)
ORDER BY dept_code;

#직원들의 사번, 직원명, 부서코드, 구분값(일반사원/사수) 조회
SELECT emp_id AS '사번',
		 emp_name AS '직원명',
		 dept_code AS '부서코드',
		 CASE
		 	WHEN emp_id IN (SELECT DISTINCT manager_id
								 FROM employee
								 WHERE manager_id IS NOT NULL) THEN '사수'
			ELSE '부사수'
		 END AS '구분'
FROM employee;

#대리(job_name) 직급인데 과장 직급들의 최소급여보다 급여가 높은 대리들을 찾기. 사번, 이름, 직급, 급여 조회
SELECT e.emp_id,
		 e.emp_name,
		 j.job_name,
		 j.job_code,
		 e.salary
FROM employee e INNER JOIN job j ON e.job_code = j.job_code
WHERE j.job_name = '대리'
		AND e.salary > (SELECT MIN(salary)
							FROM employee e INNER JOIN job j ON e.job_code = j.job_code
							WHERE j.job_name = '과장');
							
#AND salary > ANY(서브쿼리) 
#ANY 연산자는 하나라도 참이라면 참이됨.
#값을그대로 쓰는 것을 허용하지 않는다. 안에 서브쿼리를 넣는 방법 가능
#서브쿼리의 결과 중 하나라도 조건을 만족하면 참을 반환한다
SELECT e.emp_id,
		 e.emp_name,
		 j.job_name,
		 j.job_code,
		 e.salary
FROM employee e INNER JOIN job j ON e.job_code = j.job_code
WHERE j.job_name = '대리'
		AND e.salary > ANY (SELECT salary
							FROM employee e INNER JOIN job j ON e.job_code = j.job_code
							WHERE j.job_name = '과장');

#과장직급임에도 차장직급의 최대 급여보다 더 많이 받는 
#직원의 사번, 이름, 직급코드, 급여조회
SELECT emp_id,
		 emp_name,
		 job_code,
		 salary
FROM employee
WHERE job_code ='J5'
		AND salary > (SELECT max(salary)
						  FROM employee
						  WHERE job_code = 'J4');

#AND salary > AlL(...)
#모든 조건을 만족시켜야함
#서브쿼리의 결과 모두가 조건을 만족하면 참이된다.	
SELECT emp_id,
		 emp_name,
		 job_code,
		 salary
FROM employee
WHERE job_code ='J5'
		AND salary > ALL(SELECT salary
						  FROM employee
						  WHERE job_code = 'J4');		
						  
#testtbl 내부의 테이블을 이용하여 한번이라도 구매한 적이 있는 회원의 아이디, 이름, 주소 조회
SELECT u.userID,
		 u.`name`,
		 u.addr
FROM usertbl u
WHERE u.userID IN (SELECT b.userID
						 FROM buytbl u INNER JOIN buytbl b ON u.userID = b.userID 
						 WHERE b.prodName IS NOT NULL);

SELECT u.userID,
		 u.`name`,
		 u.addr
FROM usertbl u
WHERE EXISTS(SELECT *
				 FROM buytbl b
				 WHERE b.userid = u.userid);
#exist() 연산자는 서브쿼리의 결과가 한 건이라도 존재하면 참이된다.				 

SELECT DISTINCT u.userID,
		 u.`name`,
		 u.addr
FROM usertbl u INNER JOIN buytbl b ON u.userID = b.userID;		 

#3) 다중열 서브쿼리
#서브쿼리의 조회 결과 값은 한 행이지만 열의 수가 여러개일떄

#하이유 사원과 같은 부서 코드, 같은 직급 코드에 해당하는 사원들을 조회
SELECT emp_name,
		dept_code,
		job_code
FROM employee
WHERE (dept_code, job_code) IN (SELECT dept_code,
		 											job_code 
									      FROM employee
											WHERE emp_name = '하이유'); #다중행, 다중열 서브쿼리

#박나라 사원과 직급 코드가 일치하면서 같은 사수를 가지고 있는 
#사원들의 사번, 직원명, 직급코드, 사수 사번 조회
SELECT emp_id,
		 emp_name,
		 dept_code,
		 manager_id
FROM employee
WHERE (dept_code, manager_id) IN (SELECT dept_code,
													 manager_id
											FROM employee
											WHERE emp_name = '박나라')
		AND emp_name != '박나라';					 
						 
						 
#4)다중행, 다중열 서브쿼리
#서브쿼리의 조회 결과값이 여러 행, 여러 열일 경우

#각 부서별 최고 급여를 받는 직원의 사번, 직원명, 부서코드, 급여 조회
SELECT dept_code,
		 max(salary)
FROM employee
GROUP BY dept_code;

SELECT emp_id,
		 emp_name,
		 IFNULL(dept_code, '부서없음'),
		 salary	
FROM employee
WHERE (IFNULL(dept_code, '부서없음'), salary) IN (SELECT IFNULL(dept_code, '부서없음'),
																			 max(salary)
																	FROM employee
																	GROUP BY dept_code)
ORDER BY dept_code;		
#null을 포함하기위한 IFNULL 처리. 3군데에 사용.

#각 부서별 최소 급여를 받는 사원들의 사번, 이름, 부서코드, 급여조회
SELECT emp_id,
		 emp_name,
		 IFNULL(dept_code, '부서없음'),
		 salary
FROM employee
WHERE (IFNULL(dept_code, '부서없음'), salary) IN (SELECT IFNULL(dept_code, '부서없음'), 
																			MIN(salary)
																  FROM employee
																  GROUP BY dept_code)
ORDER BY dept_code;



#각 직급별 최소 급여를 받는 사원들의 사번, 이름 , 직급 코드, 급여 조회
SELECT emp_id,
		 emp_name,
		 job_code,
		 salary
FROM employee
WHERE (job_code, saraly) IN (SELECT job_code, 
												MIN(salary)
									  FROM employee
									  GROUP BY job_code)
ORDER BY job_code;










			 