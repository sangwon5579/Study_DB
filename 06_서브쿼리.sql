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
#2) 다중행 서브쿼리
#3) 다중열 서브쿼리
#4) 다중행, 다중열 서브쿼리

						 
						 
						 
						 
						 
						 
						 
						 
						 
						 