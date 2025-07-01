#table 수정
#1. 열의 추가, 수정, 삭제
#1) 열의 추가
#usertbl에 homepage 열을 추가
ALTER TABLE usertbl ADD homepage VARCHAR(30);

SELECT *
FROM usertbl;

ALTER TABLE usertbl ADD gender CHAR(2) DEFAULT '남자' NOT NULL;

ALTER TABLE usertbl ADD age TINYINT DEFAULT 0 AFTER birthyear;

# 2) 열의 수정
#usertbl 테이블에서 name열의 데이터 유형을 char(15)로 수정
ALTER TABLE usertbl MODIFY `name` CHAR(15) NULL;

ALTER TABLE usertbl MODIFY `name` CHAR(1);
#이미name이라는  열에는 char(1)보다 큰 데이터들이 들어 있음 그래서 에러 발생

ALTER TABLE usertbl MODIFY `name` INT NULL;
#이미 문자형 데이터들이 들어있음.  에러 발생

ALTER TABLE usertbl MODIFY homepage INT;
#값이 안들어있으면 타입변경 가능

ALTER TABLE usertbl RENAME COLUMN `name` TO `uname`;

ALTER TABLE usertbl CHANGE COLUMN `uname` `name` VARCHAR(20) DEFAULT '업음' NOT NULL;
#한번에 변경

#3) 열의 삭제
ALTER TABLE usertbl DROP COLUMN age;
ALTER TABLE usertbl DROP COLUMN homepage;
ALTER TABLE usertbl DROP COLUMN gender;

ALTER TABLE usertbl DROP COLUMN userid;
#기본키라 삭제 안되는게 아님
#외래키 제약  조건 때문에 삭제 안되는 것
#참조되고 있는 열이 있다면 삭제가 불가능
#제약조건을 삭제하거나 참조하는 열이 없도록 조치 후 삭제가 가능


CREATE TABLE dept_copy(
	SELECT *
	FROM department
);

ALTER TABLE dept_copy DROP COLUMN dept_id; 
ALTER TABLE dept_copy DROP COLUMN dept_title;
ALTER TABLE dept_copy DROP COLUMN location_id; #error
#테이블에는 최소 한개의 열이 존재해야하기 때문에 삭제안됨

#2. 열의 제약조건 추가/삭제
#제약조건의 수정은 불가능
#삭제 후 조건을 추가해야한다.
#1) 열의 제약 조건 추가
CREATE TABLE tb_member_grade(
	grade_code VARCHAR(10),
	grade_name VARCHAR(1test_db0) NOT NULL	
	
);

CREATE TABLE tb_member(
	mem_no INT,
	mem_id VARCHAR(20) NOT NULL,
	mem_pass VARCHAR(20) NOT NULL,
	mem_name VARCHAR(15) NOT NULL,
	enroll_date DATE DEFAULT CURDATE()	
);

ALTER TABLE tb_member_grade ADD CONSTRAINT PRIMARY KEY(grade_code);

ALTER TABLE tb_member ADD CONSTRAINT PRIMARY KEY(mem_no);

ALTER TABLE tb_member MODIFY mem_no INT AUTO_INCREMENT;

ALTER TABLE tb_member ADD CONSTRAINT uq_tb_member_mem_id UNIQUE(mem_id);

#외래키 제약조건
ALTER TABLE tb_member ADD grade_code VARCHAR(10) AFTER mem_name;
ALTER TABLE tb_member ADD CONSTRAINT fk_tb_member_grade_code FOREIGN KEY(grade_code) REFERENCES tb_member_grade(grade_code);

#check 제약 조건
ALTER TABLE tb_member ADD gender CHAR(2) AFTER mem_name;
ALTER TABLE tb_member ADD CONSTRAINT CHECK(gender = '남자' OR gender = '여자');

ALTER TABLE tb_member ADD age TINYINT AFTER gender;
ALTER TABLE tb_member ADD CONSTRAINT ck_tb_member_age CHECK(age BETWEEN 0 AND 120);

#employee 테이블에서 emp_id 열에 pk 제약조건 추가
ALTER TABLE employee ADD CONSTRAINT PRIMARY KEY(emp_id);

#employee 테이블에서 emp_no 열에 unique 제약조건  추가
ALTER TABLE employee ADD CONSTRAINT uq_employee_emp_no UNIQUE(emp_no);

#employee 테이블에서 dept_code열에 fk 제약 조건 추가
ALTER TABLE employee ADD CONSTRAINT fk_employee_dept_code FOREIGN KEY(dept_code) REFERENCES department(dept_id);

#employee 테이블에서 job_code 열에 외래키 제약 조건 추가
ALTER TABLE employee ADD CONSTRAINT fk_employee_job_code FOREIGN KEY(job_code) REFERENCES job(job_code);

#department 테이블에서 location_id 열에 fk 제약 조건 추가
ALTER TABLE department ADD CONSTRAINT fk_department_location_id FOREIGN KEY(location_id) REFERENCES location(local_code);

#location 테이블에서 national_code 열에 fk 제약 조건 추가
ALTER TABLE location ADD CONSTRAINT fk_location_national_code FOREIGN KEY(national_code) REFERENCES national(national_code);

#2) 제약 조건 삭제
#pk 말고는 제약 조건 이름 확인 후 제약 조건 이름으로 삭제!!!
#pk 제약 조건 삭제
ALTER TABLE tb_member DROP CONSTRAINT PRIMARY KEY;
#default auto_increment 먼저 삭제. 숫자가 증가하니깐
ALTER TABLE tb_member MODIFY mem_no INT;

#unique 제약 조건 삭제
ALTER TABLE tb_member DROP CONSTRAINT uq_tb_member_mem_id;
#제약조건 이름으로 삭제

#fk 제약 조건 삭제
ALTER TABLE tb_member DROP CONSTRAINT fk_tb_member_grade_code;

#check 제약 조건 삭제
ALTER TABLE tb_member DROP CONSTRAINT CONSTRAINT_1;
ALTER TABLE tb_member DROP CONSTRAINT ck_tb_member_age;

#3. 테이블 이름 변경
RENAME TABLE usertbl TO usertbl_rename;

#4. 테이블 삭제
DROP TABLE tb_member_grade; #fk 제약 조건 때문에 삭제 불가능
#참조되고 있는 테이블은 삭제 불가능
#자식 테이블부터 삭제는 가능
#외래키 제약 조건을 삭제하고 나서 삭제해도 가능

#자식 테이블 먼저 삭제 후 부모 테이블 삭제
DROP TABLE tb_member, tb_member_grade;
