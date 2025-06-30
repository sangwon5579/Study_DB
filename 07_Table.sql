#테이블 생성
#회원에 대한 데이터를 담을 수 있는 tb_memeber 테이블 생성
CREATE TABLE `tb_member`(
	`mem_no` INT,
	`mem_id` VARCHAR(20),
	`mem_pass` VARCHAR(20),
	`mem_name` varchar(10),
	`enroll_date` DATE DEFAULT CURDATE()
);

#테이블에 샘플데이터 추가
INSERT INTO tb_member VALUES (1, 'user1', '1234', '홍길동', '2025-06-30');
INSERT INTO tb_member VALUES (2, 'user2', '1234', '이몽룡', CURDATE());
INSERT INTO tb_member VALUES (3, 'user3', '1234', '성춘향', DEFAULT);
INSERT INTO tb_member(mem_no, mem_id) VALUES (4, 'user4');
INSERT INTO tb_member VALUES (NULL, NULL, NULL, NULL, NULL);

SELECT *
FROM tb_member;

DROP TABLE `tb_member`; #테이블 삭제

CREATE TABLE `tb_member`(
	`mem_no` INT NOT NULL,
	`mem_id` VARCHAR(20) NOT NULL,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE()
);
#NOT NULL 제약조건으로 NULL 데이터 삽입 불가능

UPDATE tb_member SET mem_id = NULL 
WHERE mem_name = '홍길동';

#제약조건
#primary key, unique 제약 조건
INSERT INTO tb_member VALUES(1, 'user4', '1234', '임꺽정', DEFAULT);

DROP TABLE `tb_member`; #테이블 삭제

CREATE TABLE `tb_member`(
	`mem_no` INT PRIMARY KEY,
	`mem_id` VARCHAR(20) unique NOT NULL,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE()
);


INSERT INTO tb_member VALUES (1, 'user1', '1234', '홍길동', '2025-06-30');
INSERT INTO tb_member VALUES (2, 'user2', '1234', '이몽룡', CURDATE());
INSERT INTO tb_member VALUES (1, 'user3', '1234', '성춘향', DEFAULT); #기본키 중복으로 에러 발생
INSERT INTO tb_member(mem_no, mem_id) VALUES (4, 'user4');
INSERT INTO tb_member VALUES (NULL, NULL, NULL, NULL, NULL);
INSERT INTO tb_member VALUES (1, 'user3', '1234', '성춘향', DEFAULT);

#마리아DB에서 자동으로 기본키를 생성할 수 있도록 수정
#AUTO_INCREMENT
DROP TABLE `tb_member`; #테이블 삭제

CREATE TABLE `tb_member`(
	`mem_no` INT AUTO_INCREMENT PRIMARY KEY,
	`mem_id` VARCHAR(20) unique NOT NULL,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE()
);

INSERT INTO tb_member (mem_id, mem_pass, mem_name) VALUES ('user1', '1234', '홍길동');
INSERT INTO tb_member (mem_id, mem_pass, mem_name) VALUES ('user2', '1234', '이몽룡');
INSERT INTO tb_member (mem_id, mem_pass, mem_name) VALUES ('user3', '1234', '성춘향');

#랜덤한 아이디 생성
SELECT UUID();
SELECT UUID_SHORT();

#열 정의 후 제약 조건을 뱔도로 지정하는 방법
DROP TABLE `tb_member`; #테이블 삭제

CREATE TABLE `tb_member`(
	`mem_no` INT AUTO_INCREMENT,
	`mem_id` VARCHAR(20) NOT NULL,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE(),
	CONSTRAINT PRIMARY KEY (`mem_no`)
);
#constraint는 생략 가능

CREATE TABLE `tb_member`(
	`mem_no` INT AUTO_INCREMENT,
	`mem_id` VARCHAR(20) NOT NULL,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE(),
	PRIMARY KEY (`mem_no`, `mem_id`)
);
#여러개의 기본키를 설정할 때 필요한 방식
#여러개의 열을 묶어서 하나의 기본키를 생성할 수 있다.

CREATE TABLE `tb_member`(
	`mem_no` INT AUTO_INCREMENT,
	`mem_id` VARCHAR(20) NOT NULL,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE(),
	PRIMARY KEY (`mem_no`),
	UNIQUE (`mem_id`)
);

CREATE TABLE `tb_member`(
	`mem_no` INT AUTO_INCREMENT,
	`mem_id` VARCHAR(20) NOT NULL,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE(),
	PRIMARY KEY (`mem_no`),
	CONSTRAINT uq_member_mem_id UNIQUE (`mem_id`)
);
#제약조건 이름 바꾸기
#unique  제약 조건도 여러개의 열을 묶어서 하나의 제약 조건으로 생성할 수 있다.


INSERT INTO tb_member (mem_id, mem_pass, mem_name) VALUES ('user1', '1234', '홍길동');
INSERT INTO tb_member (mem_id, mem_pass, mem_name) VALUES ('user2', '1234', '이몽룡');
INSERT INTO tb_member (mem_id, mem_pass, mem_name) VALUES ('user3', '1234', '성춘향');

#외래키 제약조건 - foreign key
#부모테이블 생성
CREATE TABLE tb_member_grade (
  grade_code VARCHAR(10) PRIMARY KEY,
  grade_name VARCHAR(10) NOT NULL
);

INSERT INTO tb_member_grade VALUES ('vip', 'vip 회원');
INSERT INTO tb_member_grade VALUES ('gold', 'gold 회원');
INSERT INTO tb_member_grade VALUES ('silver', 'silver 회원');

#자식테이블 생성
CREATE TABLE `tb_member`(
	`mem_no` INT AUTO_INCREMENT PRIMARY KEY,
	`mem_id` VARCHAR(20) NOT NULL UNIQUE,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`grade_code` VARCHAR(10) REFERENCES `tb_member_grade`,
	`enroll_date` DATE DEFAULT CURDATE()
);

CREATE TABLE `tb_member`(
	`mem_no` INT AUTO_INCREMENT PRIMARY KEY,
	`mem_id` VARCHAR(20) NOT NULL UNIQUE,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`grade_code` VARCHAR(10) REFERENCES `tb_member_grade`(`grade_code`),
	`enroll_date` DATE DEFAULT CURDATE()
);

INSERT INTO tb_member (mem_id, mem_pass, mem_name, grade_code) VALUES ('user2', '1234', '홍길동', 'vip');

#tb_member_grade 테이블의 grade_code 열에
#bronze라는 값이 없어서 외래 키 제약 조건에 위배되어 에러가 발생한다.
INSERT INTO tb_member (mem_id, mem_pass, mem_name, grade_code) VALUES ('user2', '1234', '이몽룡', 'bronze');

#grade_code 열에 null 삽입 가능
INSERT INTO tb_member (mem_id, mem_pass, mem_name, grade_code) VALUES ('user4', '1234', '성춘향', NULL);

#join해서 회원번호, 아이디, 이름, 게정 등급을 조회
SELECT m.mem_no,
		 m.mem_id,
		 m.mem_name,
		 mb.grade_name
FROM tb_member m LEFT OUTER JOIN tb_member_grade mb ON m.grade_code = mb.grade_code;

#SELECT *
DELETE
FROM tb_member_grade
WHERE grade_code = 'vip';
#delete 불가능

UPDATE tb_member_grade SET grade_code = 'vvip'
WHERE grade_code = 'vip';
#update 불가능

DELETE
FROM tb_member_grade
WHERE grade_code = 'gold';
#이건 삭제됨. 참조하고 있는 행이 없으면 제거/수정 가능하다.
UPDATE tb_member_grade SET grade_code = 'vvip'
WHERE grade_code = 'silver';

#cascade로 설정해놓으면 부모-자식 모두 종속적으로 삭제/수정 됨
#테이블 -> update/delete 될 때 ,  에서 수정가능
UPDATE tb_member_grade SET grade_code = 'vvip'
WHERE grade_code = 'vip';

#check 제약 조건
DROP TABLE tb_member;

CREATE TABLE `tb_member`(
	`mem_no` INT AUTO_INCREMENT PRIMARY KEY,
	`mem_id` VARCHAR(20) NOT NULL UNIQUE,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` varchar(10) NOT NULL,
	`gender` CHAR(2) CHECK(gender IN ('남자', '여자')),
	`age` TINYINT,
	`grade_code` VARCHAR(10) REFERENCES `tb_member_grade`,
	`enroll_date` DATE DEFAULT CURDATE(),
	#CHECK(`age` >= 0) -- or
	#CONSTRAINT ck_member_age CHECK(`age` >= 0 and `age` <=150) --or
	CONSTRAINT ck_member_age CHECK(`age` BETWEEN 0 AND 120) 
);

INSERT INTO tb_member (mem_id, mem_pass, mem_name, gender, age, grade_code) VALUES ('user1', '1234', '홍길동','남자', 24, 'vip');

#성별/나이에 유효하지 않은 값들은 저장이 불가능하다
INSERT INTO tb_member (mem_id, mem_pass, mem_name, gender, age, grade_code) VALUES ('user2', '1234', '이몽룡','몽룡', 25, NULL);

INSERT INTO tb_member (mem_id, mem_pass, mem_name, gender, age, grade_code) VALUES ('user3', '1234', '성춘향','여자', -3, 'silver');

UPDATE tb_member SET gender = '길동'
WHERE mem_name = '홍길동';

