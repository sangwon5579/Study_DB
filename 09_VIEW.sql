#VIEW
# 1. 뷰 생성
# 사원들의 사번, 직원명, 부서명, 직급명, 입사일을 조회하는 뷰 생성
CREATE VIEW v_employee
AS SELECT e.emp_id,
			 e.emp_name,
			 d.dept_title,
			 j.job_name,
			 e.hire_date
	FROM employee e LEFT OUTER JOIN department d ON e.dept_code = d.dept_id
					    LEFT OUTER JOIN job j ON e.job_code = j.job_code;

#가상의 테이블로 실제 데이터가 담겨있는 것은 아니다.
SELECT *
FROM v_employee;

SELECT *
FROM v_employee
where dept_title IS NULL; 

#사원의 사번, 직원명, 성별, 급여를 조회할 수 있는 뷰 생성
CREATE OR REPLACE VIEW v_employee
AS SELECT emp_id,
			 emp_name,
			 IF(SUBSTRING(emp_no, 8, 1)  = '1', '남자', '여자') AS gender,
			 salary
	FROM employee;

SELECT emp_name, gender
FROM v_employee;

# 2. 뷰 수정
#회원의 아이디, 이름, 구매제품, 주소, 연락처를 조회하는 뷰를 생성
CREATE VIEW v_usertbl
AS SELECT u.userID,
		  	 u.`name`,
		  	 b.prodName,
		  	 u.addr,
		  	 CONCAT(u.mobile1, '-', u.mobile2) AS mobile
	FROM buytbl b INNER JOIN usertbl_rename u ON b.userID = u.userID;
	
# 뷰의 수정
SELECT *
FROM v_usertbl;

ALTER VIEW v_usertbl 
AS SELECT u.userID,
		  	 u.`name`,
		  	 b.prodName,
		  	 u.addr,
		  	 CONCAT(u.mobile1, '-', u.mobile2) AS mobile
	FROM buytbl b INNER JOIN usertbl_rename u ON b.userID = u.userID;

# 3. 뷰를 이용한 DML(insert, update, delete) 작업
CREATE VIEW v_job 
AS SELECT *
	FROM job;

SELECT *
FROM v_job;

#view, table 모두 영향 받는다.
INSERT INTO v_job VALUES('J8', '알바');

#view, table 모두 영향 받는다.
UPDATE v_job
SET job_name = '인턴'
WHERE job_code = 'J8';

#view, table 모두 영향 받는다.
DELETE
FROM v_job
WHERE job_code = 'J8';


# 4. DML 조작이 불가능한 경우
#1) 뷰의 정의에 포함되지 않은 열을 조작하는 경우
CREATE OR REPLACE VIEW v_job
AS SELECT job_code
	FROM job;

SELECT *
FROM v_job;

INSERT INTO v_job VALUES('J8', '알바'); #error

UPDATE v_job
SET job_name = '인턴'
WHERE job_caode = 'J7'; # error

DELETE 
FROM v_job
WHERE job_name = '사원'; #error

#2) 산술 연산으로 정의된 열을 조작하는 경우
#직원들의 사번, 이름, 주민등록번호, 연봉을 조회하는 뷰를 생성
CREATE VIEW v_emp
AS SELECT  emp_id,
			  emp_name,
			  emp_no,
			  salary*12 AS 'salary'
FROM employee;

SELECT * FROM v_emp;

INSERT INTO v_emp VALUES('300'. '홍길동', '250701-111111', 30000);

UPDATE v_emp
SET salary = 3000000
WHERE emp_id = '200';

# 5. with check option
#서브쿼리에 기술된 조건에 부합하지 않는 값으로 수정하는 경우 오류를 발생시킨다
CREATE OR REPLACE VIEW v_employee
AS SELECT *
	FROM employee
	WHERE salary >= 3000000
WITH CHECK OPTION;

SELECT *
FROM v_employee;

#선동일 사원의 급여를 200만원/400만원으로 변경 -->조건에 부합하는 것만 변경 가능
UPDATE v_employee
SET salary = 2000000
WHERE emp_id = '200'; #error

UPDATE v_employee
SET salary = 4000000
WHERE emp_id = '200'; #OK

# 6. 뷰 삭제
DROP VIEW v_usertbl;

DROP VIEW  v_emp, v_employee, v_job;


