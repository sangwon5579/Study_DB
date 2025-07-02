#index
SELECT *
FROM employees;

#실행계획 확인. EXPLAIN
EXPLAIN SELECT *
FROM employees;

SELECT *
FROM employees
WHERE emp_no = 457485;

EXPLAIN SELECT *
FROM employees
WHERE emp_no = 457485;

SELECT *
FROM employees
WHERE first_name = 'Gianluca' AND last_name = 'Sinicrope';

EXPLAIN SELECT *
FROM employees
WHERE first_name = 'Gianluca' AND last_name = 'Sinicrope';

SELECT *
FROM employees
WHERE first_name = 'moon';

EXPLAIN SELECT *
FROM employees
WHERE first_name = 'moon';

###
##index 생성
CREATE INDEX udx_employees_first_name ON employees(first_name); #보조 인덱스

SELECT *
FROM employees
WHERE first_name = 'moon';
#시간이 더 적게 걸림

EXPLAIN SELECT *
FROM employees
WHERE first_name = 'moon';
# type이 ref로 바뀜. 보조 인덱스 사용중
#search한 row 수도 줄어들었음

ANALYZE TABLE employees;

#여러개의 열을 묶어서 인덱스 생성
CREATE INDEX idx_employees_first_name_last_name ON employees(first_name, last_name);

SELECT *
FROM employees
WHERE first_name = 'moon' AND last_name = 'Yetto';

EXPLAIN SELECT *
FROM employees
WHERE first_name = 'moon' AND last_name = 'Yetto';

###
#인덱스 삭제
DROP INDEX udx_employees_first_name ON employees;
DROP INDEX idx_employees_first_name_last_name ON employees;

#인덱스를 사용하지 않는 경우
SELECT *
FROM employees;
#1. 전체를 다 조회하는 경우
EXPLAIN SELECT *
FROM employees;

SELECT *
FROM employees
WHERE emp_no < 400000;
# 2. 거의 대부분의 범위를 조회하는 경우
EXPLAIN SELECT *
FROM employees
WHERE emp_no < 400000;

EXPLAIN SELECT *
FROM employees
WHERE emp_no < 100000;


SELECT * 
FROM employees
WHERE emp_no = 100000;

EXPLAIN SELECT * 
FROM employees
WHERE emp_no = 100000;
#3. 산술연산
EXPLAIN SELECT * 
FROM employees
WHERE emp_no*1 = 100000;
#산술연산이 있으면 인덱스를 태우지 않는다.

ALTER TABLE employees ADD INDEX idx_employees_gender(gender);
ANALYZE TABLE employees;

#4. 중복이 너무 많은 경우
SELECT * 
FROM employees
WHERE gender = 'M';

EXPLAIN SELECT * 
FROM employees
WHERE gender = 'M';

ALTER TABLE employees DROP INDEX idx_employees_gender;




