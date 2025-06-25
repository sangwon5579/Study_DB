INSERT INTO employees(name, gender, age) VALUES('홍길동', '남자', 20);
#모든 열 삽입할꺼면 (name, gender, age) 생략 가능하다

SELECT *
FROM usertbl;
#user table에 한 행을 삽입
INSERT usertbl(`userid`, `name`, `birthyear`, `addr`) 
VALUES('HGD', '홍길동', 2015, '서울');
#primary키에 따라서 정렬 후 저장함. 즉 무조건 제일 아래에 저장되는게 아님. 위와 같은 경우도 중간에 삽입됨

INSERT usertbl(`userid`, `name`, `birthyear`, `addr`) 
VALUES('LEE', 2015, '이몽룡', '강원');
#열의 순서와 데이터 타입이 맞지 않아서 에러가 발생
#이거는 데이터 타입이 안맞아서 에러가 발생
#BUT 2015의 경우 int에서 문자형으로 묵시적 형변환이 가능하다.
#그러나 문자형에서 숫자형으로의 묵시적 형변환은 불가능하므로 에러가 발생한다.

INSERT usertbl (`name`, `birthyear`, `addr`) 
VALUES('이몽룡', 2015, '강원');
#이것도 에러발생. 기본키(primary key)에 대한 값이 없기 때문에 --(nameid) 테이블 정보를 보면 null값을 허용하지 않으므로 에러가 발생한다.
#기본키는 행들을 식별하는 식별자. 반드시 있어야되는 값이다.

INSERT usertbl(`userid`, `birthyear`, `addr`) 
VALUES('LEE', 2015, '강원');
#에러발생
#기본키는 아니지만. 테이블 정보를 보면 name은 null을 허용하지 않음
#not null 제약조건이다
#null을 허용하지 않는 애들은 반드시 값이 있어야 된다. 기본키가 아니더라도

INSERT usertbl
VALUES('LEE', '이몽룡', 2015, '강원');
#에러발생
#insert 테이블명 옆에 생략을 하면 모든 값을 전달해줘야됨
#모든 열에 값을 담을 것이라는 뜻
#기본키, NOT NULL 상관없이 값이 모두 있어야됨. 
#위는 4개의 value만 주고있기 때문에 에러발생

INSERT usertbl
VALUES('LEE', '이몽룡', 2015, '강원', '010', '4567899', NULL, CURDATE());
#값을 주기 싫으면 NULL 입력 단, null을 허용하는 곳이어야함
#날짜는 직접 입력해도 좋지만(ex 2025-12-12) 날짜 관련 함수 사용가능. 함수 호출. ex) curdate()
#모든 열의 데이터 삽입

SELECT CURDATE();
#현재 날짜 불러오는 함수

#한번에 usertbl 테이블에 여러개의 행 삽입
INSERT INTO usertbl(`userid`, `name`, `birthyear`, `addr`) 
VALUES('LIM', '임꺽정', 1980, '경기'),
		('CHO', '조상원', 2002, '서울');

#다른 테이블에서 데이터 가져오기
#테이블 복사(일단 구조만 복사)
CREATE TABLE usertbl_copy(
	SELECT *		
	FROM usertbl
	WHERE 1=0 
);
#where절에서 무조건 거짓으로 하여 원본 테이블의 구조만 남게 되고 그것만 가져오는 것
#KEY는 복사안됨!
#제약조건을 모두 제외(하지만 null 허용 여부는 복사)하고 테이블의 데이터/구조만 복사한다usertblusertbl


SELECT *
FROM usertbl_copy; 
#Select 결과를 usertbl_copy 테이블에 삽입하기
INSERT INTO usertbl_copy
	SELECT *
	FROM usertbl
	WHERE addr = '서울';                 

INSERT INTO usertbl_copy(
	SELECT `userid`, `name`
	FROM usertbl
	WHERE addr = '강원'
);
#에러 발생.
#서브쿼리로 조회한 열의 개수가 테이블의 열의 개수보다 적기 때문에
#insert into 테이블명 뒤에 아무것도 명시하지 않았기 때문에 모든 데이터를 넣어야 한다

INSERT INTO usertbl_copy(`userid`, `name`, `birthyear`, `addr`)
	SELECT `userid`, 
			 `name`, 
			 `birthyear`, 
			 `addr`
	FROM usertbl
	WHERE addr = '강원';
#null 허용을 지키면서 데이터 삽입

DROP TABLE usertbl_copy;
#테이블 삭제하기.
#insert, create 후에 F5 새로 고침해야지 변경사항 보임

#####
#####
UPDATE employees
SET name = '임꺽정',
    age = 35
WHERE emp_no = 30000;
#'='는 대입연산자 아님
#db에서는 '='는 같다 라는 뜻
#대입의 개념이 아니라 같게 만든다 라는 개념
#where 안쓰면 전체 데이터가 변경되어버림
SELECT *
FROM usertbl;

UPDATE usertbl
SET `name` = '고길동'
WHERE `userid` = 'HGD';
#where절에서는 특정열을 찾을때 primarykey의 개념을 잘 생각하고 해야됨
#단순 이름을 바꾼다고 이름을 where절에 사용하면 안됨
#이름은 기본키가 아니니깐. 동명이인등의 문제가 생길 수 있음
#행을 식별할 수 있는 primary key를 통해 구분해야됨 

#test table 생성
CREATE TABLE emp_salary (
	SELECT emp_id,
			 emp_name,
			 salary,
			 bonus
	FROM employee
);

SELECT *
FROM emp_salary;

UPDATE emp_salary
SET emp_name = '홍길동';
#where절 생략했음
#특정행이 아닌 전체에 적용됨

UPDATE emp_salary
SET salary = salary * 1.1;
#모든 사원의 급여를 10퍼센트 인상한 금액으로 변경

#####
#####
#mariaDB는 오토커밋 되어있음
-- 조건을 만족하는 3개의 행 삭제
DELETE FROM employees WHERE address LIKE '서울%' LIMIT 3;

-- 테이블 삭제, 행단위로 지우는것, 롤백 가능함. 페이지의 데이터만 지우고 페이지는 유지, 공간은 남아있음.
DROP TABLE employees;

-- 테이블의 모든 데이터 삭제, 한번에 지우는 것. 롤백 불가능함. 데이터 자체를 날려버리는 것이기 때문에. 페이지 자체를 지워버림. 공간이 없어짐.
TRUNCATE TABLE employees;

SELECT *
FROM usertbl;

SELECT *
FROM usertbl
WHERE userid = 'HGD';
#DELETE하기 전에는 select로 한번 더 확인하고 지우는 습관

#SELECT * -> 주석 처리후 select를 delete로
DELETE
FROM usertbl
WHERE userid = 'HGD';

SELECT *
FROM usertbl
WHERE mobile1 IS NULL
LIMIT 2;

#SELECT *
DELETE
FROM usertbl
WHERE mobile1 IS NULL
LIMIT 2;
#mobile1이 null인 회원 중 상위 2명을 삭제

SELECT *
FROM emp_salary;


DELETE FROM emp_salaremp_salaryy;
#모든 데이터 삭제
#where절 작성 안했으니 모든 행 삭제

DROP TABLE emp_salary;

#####
#####
#조건부 데이터 입력/변경
INSERT IGNORE INTO employees VALUES(30000, '홍길동', 30);
# 오류 무시

INSERT INTO employees VALUES(30000, '임꺽정', 35)
  ON DUPLICATE KEY UPDATE name = '임꺽정', age = 35;
#기본키에 해당하는 내용을 업데이트 수행 기본키가 중복되는 경우

SELECT *
FROM usertbl;

INSERT INTO usertbl(`userid`, `name`, `birthyear`, `addr`)
VALUES ('BBK', '바보킴', 1999, '인천');
#기본키 중복으로 에러발생
#이미 존재하는 기본키임

INSERT IGNORE INTO usertbl(`userid`, `name`, `birthyear`, `addr`)
VALUES ('BBK', '바보킴', 1999, '인천');
#에러를 발생시키지는 않지만, 실제 적용되지는 않는다
#기본키 중복으로 인한 에러기 발생하지 않고 경고만 출력한다
#실제로 사용할 일은 거의 없다

#usertbl 테이블에 userid가 HONG인 회원이 없으면 insert 수행하고, 
#userid가 HONG인 회원이 있으면 update를 수행한다
INSERT INTO usertbl(`userid`, `name`, `birthyear`, `addr`)
VALUES ('HONG', '홍길동', 1999, '서울')
ON DUPLICATE KEY UPDATE `name`='고길동', `birthyear`=1970, `addr` = '강원';



########
########
#TCL (transection control language) --트랜잭션 : 하나의 논리적인 작업 단위
#commit, rollback
SELECT @@AUTOCOMMIT;
#mariadb는 자동적으로 오토커밋. 롤백이 불가능.

#SELECT *
DELETE 
FROM usertbl
WHERE userid = 'HONG';

SELECT *
FROM usertbl;

ROLLBACK;
#autocommit 활성화 되어있어서 적용안됨

SET autocommit = 1; #오토커밋 활성화
SET autocommit = 0; #비활성화
#오토커밋이 활성화 된 경우 롤백으로 실행이 취소되지 않는다.

#SELECT *
UPDATE usertbl
SET `name` = '바보킴'
WHERE `userid` = 'BBK';

COMMIT;
#커밋 시 롤백 불가능
#오토커밋 비활성화 된 경우 변경사항 반영하려면 커밋 실행해야됨
#DML

ROLLBACK;
#오토커밋 비활성화 된 경우 롤백 가능함.
#롤백으로 실행취소 가능
#DML

SHOW VARIABLES LIKE 'AUTOCOMMIT@';
