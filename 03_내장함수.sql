#형변환 함수
#숫자데이터를 문자 데이터로 형변환
SELECT 123456789; #숫자형은 파랑색으로 출력됨
SELECT '123456789';

SELECT  CAST(123456789 AS CHAR);
#123456789가 문자형으로 출력됨

SELECT CONVERT(123456789,  CHAR);
#문자형으로 출력됨. ,로 구분하여 두개의 매개값으로 전달

SELECT *
FROM usertbl;
#usertbl에 birtyear을 문자데이터로 변경하여 출력
SELECT `name`,
		 CONVERT(`birthYear`, CHAR)
FROM usertbl;

#실수데이터를 정수데이터로 형 변환
#buytbl 테이블에서 평균 구매 개수 출력. 정수형으로  변환해서 조회
SELECT CONVERT(avg(amount), INT)
FROM buytbl;

#문자데이터를 숫자데이터로 형변환
SELECT '1111111111';
SELECT CONVERT('111111111111111', INT);
SELECT CAST('111111111111' AS INT);
SELECT '111,111,111,111';
SELECT CONVERT('111,111,111,111', INT);
# -> 111출력됨
SELECT REPLACE('111,111,111,,111', ',',''); #문자열에서 ,를 제거 Rplace(대상, 바꾸고 싶은 대상, 바꿀 대상)
SELECT CONVERT(REPLACE('111,111,111,,111', ',',''), INT);

SELECT '1,000,000' - '500,000'; #묵시적 형변환. ,는 인지 못하고 1-500이 실행됨. 그래서 499 출력
SELECT CONVERT(REPLACE('1,000,000',',',''), INT) - CONVERT(REPLACE('500,000',',',''), INT); #명시적 형변환
SELECT REPLACE('1,000,000',',','') - REPLACE('500,000',',','');

SELECT *
FROM usertbl;

SELECT `name`,
		  CONVERT(mobile1, INT)
FROM usertbl;
#제일 앞의 0은 사라짐. 정수형은 0ㅇ으로 시작하지 않음

#문자, 숫자 데이터를 날짜,시간  데이터로 형변환
SELECT CURDATE();
SELECT NOW();
SELECT SYSDATE();

SELECT CONVERT('2025-06-25', DATE);
SELECT CONVERT('2025/06/25', DATE);
SELECT CONVERT('2025%06%25', DATE);
# -, /, % 다 가능

SELECT '11:10:30';
SELECT CONVERT('11:10:30', TIME);
SELECT CONVERT('111030', TIME);

SELECT CONVERT('2025-06-25 11:10:30', DATETIME);

SELECT 20250625;
SELECT CONVERT(20250625, DATE);
SELECT CONVERT(250625,  DATE);
SELECT CONVERT(990625, DATE);
SELECT CONVERT(222222,DATE); #NULL

SELECT CONVERT(111111,TIME);
SELECT CONVERT(20250625111111, DATETIME);

SELECT CONVERT(2025, YEAR); #에러발생. mariadb에서는 지원안함
SELECT CONVERT(125, TINYINT); #에러발생
SELECT CONVERT(12345, SMALLINT); #에러 발생
#모든 데이터 타입에 대해서 변환이 가능한 것은 아님

#묵시적 형변환
SELECT '100' + '200'; #자바처럼 100200아님. 300나옴
SELECT CONCAT('100'+'200');
SELECT CONCAT('100'+200);
select 1> '2mega'; #거짓 2로 변환되어서 비교
SELECT 3> '2mege'; #참, 2로 변환되어서 비교
SELECT 0 = 'mega'; #참, 0으로 변환되어서 비교. 문자는 0으로 변환된다.

#제어 흐름 함수
#if
SELECT IF(100<200, 'T', 'F');

#buytbl 테이블에서 고객별 구매 개수의; 합게 죄회. 단, 구매개수가 10개 이상이면, 'vip 고객'ㅡ 
SELECT userid,
		SUM(amount),		 
		IF(sum(amount)>=10, 'VIP 고객', '일반 고객')
FROM buytbl
GROUP BY userid;

#IFNULL 함수
SELECT IFNULL(NULL, '값이없음'),
		 IFNULL(100, '값이 없음');

SELECT NVL(NULL, '값이없음'),
		 NVL(100, '값이 없음');
#mariadb  10.3버전부터 지원


#buytbl 테이블에서 모든 데이터를 출력. groupName 열의 값이 NUll인 경우 없음으로 출력하기
SELECT num, userID, prodName, IFNULL(groupName, '없음'), price, amount
FROM buytbl;

#NVL2함수
SELECT NVL2(NULL, 'null 일떄 앞', 'null 일 때 뒤'), NVL2(300, 'null 아닌 경우 앞', 'null 아닌 경우 뒤');

#employee table에서 bonus를 0.1로 동결하여 직원명, 보너스, 동결된 보너스, 보너스가 포함된 연봉 조회
SELECT emp_name, bonus, NVL2(bonus, round(bonus*0.1, 2), 0)
FROM employee;

SELECT emp_name, bonus, NVL2(bonus, 0.1, 0), (salary*bonus+salary)*12 #이건 안됨. 뒤에 salary가 이전의 값으로 적용됨
FROM employee;

SELECT emp_name, bonus, NVL2(bonus, 0.1, 0), (salary*NVL2(bonus, 0.1, 0)+salary)*12
FROM employee;

##### case 연산자
SELECT CASE 8
			WHEN 1 THEN '일'
			WHEN 5 THEN '오'
			WHEN 10 THEN '십'
			ELSE '모름'
  		 END AS '결과';
#자바의 SWITCH문과 같은 원리

SELECT CASE
			WHEN 10 > 20 THEN '10>20'
			WHEN 10=20 THEN '10=20'
			WHEN 10=10 THEN '10=10'
			WHEN 20=20 THEN '20=20'
			ELSE '모름'
  		 END AS '결과';
#참인 결과 나오면 그 아래는 동작하지 않음. LIKE 자바의 다중 IF문

#employee 테이블에서 직원명, 급여, 급여등급(1~4) 조회
#급여가 500만원 초과일 경우 1등급
#급여가 500만원 이하, 350만원 초과일 경우 2등급
#급여가 350만원 이하, 200만원 초과일 경우 3등급
#급여가 200만원 이하일 경우 4등급
SELECT emp_name
FROM employee;

SELECT emp_name AS '이름',
		 salary AS '급여',
		 CASE
			WHEN salary > 5000000 THEN '1등급'
			WHEN salary > 3500000 THEN '2등급'
			WHEN salary > 2000000 THEN '3등급'
			ELSE '4등급'
		 END AS '급여등급'
FROM employee;

#문자열 함수
#ASCII, CHAR 함수
SELECT ASCII('A');
SELECT CHAR(65);
#result set
SELECT ASCII('가');

SELECT * FROM employee; #테이블의 조회 결과
SELECT emp_id, emp_name FROM employee; #result set

#Bit_length, char_length, length
SELECT BIT_LENGTH('ABC'), CHAR_LENGTH('ABC'), length('ABC');
#3byte*8, 문자열의 개수, byte 수
SELECT BIT_LENGTH('홍길동'), CHAR_LENGTH('홍길동'), length('홍길동');
#한글은 한글자를 3바이트로 계산 9byte*8, 문자열의 개수, byte 수 = 3*3
#mariadb는 기본적으로 UTF-8 코드를 사용함
#그래서 영문은 1바이트, 한글은 3바이트를 할당해서 사용한다.

#concat, concat_ws
SELECT CONCAT('2025','06','25');
SELECT CONCAT_WS('/', '2025','06','25');   #제일 앞에는 구분자

#usertbl 테이블에서 아이디, 이름, 전화번호 조회
SELECT `userid`,
		`name`,
		CONCAT_WS('-',`mobile1`,`mobile2`) AS mobile
FROM usertbl;

#ELT, field, find_in_set, instr, locate
SELECT ELT(2, '일', '이', '삼', '사');	# '둘'반환
SELECT FIELD('이', '일', '이', '삼', '사'); #2 반환
SELECT FIND_IN_SET('둘', '하나,둘,셋,');	#, 기준으로반환.'2' 반환
SELECT INSTR('하나 둘 셋', '둘');	#4 반환. '둘'의 위치는 공백을 포함한 4이기 때문
SELECT LOCATE('둘','하나 둘 셋'); #4반환. 위와 같은 원리

#employee 테이블에서 email 주소에서 @의 위치값을 출력하기
SELECT email, LOCATE('@', email) AS '@ 위치값'
FROM employee;

#format
SELECT CONVERT(1234567, CHAR);
SELECT FORMAT(1234567.789, 2);	#숫자를 문자열로. 3자리 콤마를 표시해준다. 1234567.79 반올림
#FORMAT(숫자, 소수점 자릿수)

#INSERT(기준 문자열, 위치, 길이, 삽입할 문자열)
SELECT INSERT('abcdefghi', 3, 4, '@@@@@@@@@');	#위치로부터 길이만큼을 잘라냄. 그 자리에 삽입할 문자열을 삽입
SELECT INSERT('020410-1234567', 9, 6, '******');

#employee 테이블에서 사원명, 주민등록번호(뒷자리 마스킹처리)
SELECT emp_name, 
		 INSERT(emp_no, 8, 7, '*******') AS '주민등록 번호'
FROM employee;

#upper, lower
SELECT UPPER('asdfgHJKL'), LOWER('asdfGHJKL');

#left, right
SELECT LEFT('abcdefghi',  3), RIGHT('abcdefghi',3);

#employee 테이블에서 사원명, 이메일, 아이디출력(아이디는 이메일의 @ 앞까지)
SELECT emp_name, email, LEFT(email, LOCATE('@', email)-1) AS ID
FROM employee;

SELECT emp_name, email, LEFT(email, INSTR(email, '@')-1) AS ID
FROM employee;

#lqad, rpad
SELECT LPAD('hello',10); #공백으로 채우기 총 10자리
select LPAD('hello', 3, 'q');
SELECT RPAD(UPPER('hello'), 15, '@');
SELECT RPAD('hello', 16, '1234567');

SELECT emp_name '이름', 
		 RPAD(LPAD(emp_no, 8), 14, '*') '주민등록번호'
FROM employee;

#공백제거
SELECT LTRIM('     he  llo     '),
		 RTRIM('     he  llo     '),
		 TRIM('     he  llo     ');
		 
SELECT TRIM(BOTH ' ' FROM '     he  llo      ');	#양쪽 공백제거
SELECT TRIM(BOTH 'z' FROM 'zzzzzzzzzz e  llzzzzzzzzzzzzazzzzzzz');
SELECT TRIM(LEADING ' ' FROM '     he  llo      '); 	#왼쪽만 공백제거
SELECT TRIM(LEADING ' ' FROM 'aaaaasaaahell    oaaaaaaaa');
SELECT TRIM(TRAILING ' ' FROM '     he  llo      '); 	#오른쪽만 공백 제거

#repeat, reversw, space
SELECT REPEAT('HELLO', 3);
SELECT REVERSE('HELLO');
SELECT SPACE('5');
SELECT CONCAT('MARIA', SPACE(5), 'DB');

#replace
SELECT REPLACE('asdfghj@gmail.com', 'gmail', 'naver');
SELECT REPLACE('asdfghj@gmail.com', '@gmail.com', '');

#employee테이블에서 이메일의 kh.or.kr을 beyond.com으로 변경해서 조회
SELECT emp_id, REPLACE(email, 'kh.or.kr', 'beyond.com'),
					REPLACE(email, '@kh.or.kr', '')
FROM employee;

#substring SUBSTRING(문자열, 시작 위치, 길이)
SELECT SUBSTRING('대한민국만세', 3);
SELECT SUBSTRING('가나다라마바사아', 3, 2); #3번쨰부터 문자열 2개만 잘라서 출력한다
SELECT SUBSTRING('일이삼사오육칠팔구십', -3, 2);

#employee 테이블에서 사원명, 아이디(substring으로 출력), 성별(from 주민번호, 1이면 남자, 2이면 여자)
SELECT emp_name,
		 SUBSTRING(email, 1, LOCATE('@', email)-1),
		 case 
		 	when substring(emp_no, 8, 1) then '남자'
		 	when SUBSTRING(emp_no, 8, 2) then '여자'
		 	ELSE '에러'
		 END AS '성별'
FROM employee;

#substring_index
SELECT SUBSTRING_INDEX('cafe.naver.com', '.', 2);
# (문자열, 구분자, 횟수)
#왼쪽으로부터 횟수번째나오는 구분자까지 찾는다. 그 구분자부터 끝까지 잘라버린다.
SELECT SUBSTRING_INDEX('cafe.naver.com', '.', -2);
#음수이면, 오른쪽부터 횟수 세기

#employee 테이블에서 사원명, 아이디, 이메일 조회
SELECT emp_name,
		 SUBSTRING_INDEX(email, '@', 1),
		 email
FROM employee;

#ceiling, froor
SELECT CEILING(4.3), FLOOR(4.7); #올림, 버림

#round 
SELECT ROUND(4.355); #반올림
SELECT ROUND(4.355, 0);
SELECT ROUND(4.355, 2);
SELECT ROUND(444.355, -1);

#truncate
#소수점기준으로 정수 위치까지만 구하고 나머지는 버린다. 잘라버리는 느낌
SELECT TRUNCATE(123.456, 0);
#두번째 매개체 생략 불가!
SELECT TRUNCATE(123.456, 1);
SELECT TRUNCATE(123.456, -1);

#mod
SELECT MOD(157, 10),
		 157%10,
		 157 MOD 10;

#rand
#1~100  사이 랜덤 값 출력
SELECT RAND(),
		 RAND(),
		 RAND(),
		 RAND();
#0.0000000~0.99999999999.. 사이 숫자 출력
SELECT FLOOR((RAND()*100)+1);
#1.000~100.000

#날짜, 시간 함수
#adddate, subdate
SELECT ADDDATE('2025-01-01', INTERVAL 10 DAY),
		 SUBDATE('2025-01-01', INTERVAL 1 MONTH),
		 ADDDATE(CURDATE(), INTERVAL 2 YEAR);

#직원명,  입사일, 입사 후 3개월이 된 날짜를 조회
SELECT emp_name,
		 hire_date,
		 ADDDATE(hire_date, INTERVAL 3 MONTH)
FROM employee;

#addtime, subtime
SELECT ADDTIME('2025-01-01 23:59:59', '1:1:1'),
	 	 SUBTIME('15:00:00', '2:10:30');
SELECT NOW(), CURTIME(); #날짜, 시간/ 시간

SELECT CURDATE(), #2025-06-26
		 CURTIME(), #09:40:10
		 NOW(), #2025-06-26 09:40:10
		 SYSDATE(); #2025-06-26 09:40:10
		 
SELECT DAYOFMONTH(CURDATE());

SELECT DATEDIFF(CURDATE(), '2024-08-20'); #일수 차이
SELECT TIMEDIFF(CURTIME(), '09:00:00');

SELECT emp_name,
		 hire_date,
		 DATEDIFF(CURDATE(), hire_date)
FROM employee;

SELECT DAYOFWEEK(CURDATE()),
		 MONTHNAME(CURDATE()),
		 DAYOFMONTH(CURDATE()),
		 LAST_DAY(CURDATE());
SELECT MAKEDATE(2025, 10),
		 MAKETIME(2,2,3);
		 
SELECT MAKEDATE(2025, 400);
SELECT PERIOD_ADD(202506, 11);
SELECT PERIOD_DIFF(202506, 202507);

SELECT QUARTER(NOW());
select TIME_TO_SEC(CURtimE());

SELECT USER();
SELECT DATABASE();
SELECT FOUND_ROWS();
SELECT ROW_COUNT();
SELECT VERSION();




