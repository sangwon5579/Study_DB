#table 수정
#1. 열의 추가, 수정, 삭제
#1) 열의 추가
#usertbl에 homepage 열을 추가
ALTER TABLE usertbl ADD homepage VARCHAR(30);

SELECT *
FROM usertbl;

ALTER TABLE usertbl ADD gender CHAR(2) DEFAULT '남자' NOT NULL;

ALTER TABLE usertbl ADD age TINYINT DEFAULT 0 AFTER birthyear;






















