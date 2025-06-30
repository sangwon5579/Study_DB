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