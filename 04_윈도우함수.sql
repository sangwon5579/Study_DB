#window 함수
#순위함수
SELECT ROW_NUMBER() OVER(ORDER BY height DESC), 
		 `name`, 
		 `height`
FROM usertbl;