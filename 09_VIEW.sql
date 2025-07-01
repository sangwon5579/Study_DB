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
