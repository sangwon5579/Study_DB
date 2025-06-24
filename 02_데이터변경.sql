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
usertbl
#wher절에서 무조건 거짓으로 하여 원본 테이블의 구조만 남게 되고 그것만 가져오는 것
#KEY는 복사안됨!
#제약조건을 모두 제외(하지만 null 허용 여부는 복사)하고 테이블의 데이터/구조만 복사한다usertblusertblusertbl


























