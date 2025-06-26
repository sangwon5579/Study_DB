#inner join
#각 사원들의 사번, 직원명, 부서코드,부서명 조회
SELECT emp_id, emp_name, dept_id, dept_title
FROM employee e INNER JOIN department d ON dept_code = dept_id;