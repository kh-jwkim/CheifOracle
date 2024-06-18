-- 4일차
-- 오라클 함수
-- 1. 단일행 함수 : 결과값 여러개
-- 2. 다중행 함수 : 결과값 1개(그룹함수)
SELECT LENGTH(EMAIL) FROM EMPLOYEE;


SELECT FLOOR(SYSDATE-HIRE_DATE) FROM EMPLOYEE;

-- 1.1 단일행 함수의 종류
-- 1.1.1 숫자 처리 함수
--      - ABS, MOD, TRUNC, FLOOR, ROUND, CEIL
-- 1.1.2 문자 처리 함수
/*      a. LENGTH, LENGTHB  : 길이 구함
        b. INSTR, INSTRB    : 위치 구함
        c. LPAD, RPAD       : 빈 곳을 채워줌
        d. LTRIN/RTRIM      : 특정문자 제거(공백제거)
        e. TRIM             : 특정문자 제거(공백제거)
        f. SUBSTR           : 문자열 잘라줌
        g. CONCAT           : 문자열 합쳐줌
        h. REPLACE          : 문자열 바꿔줌
        FUNCTION USAGE      : 함수명(값1, 값2, ...), 값에는 리터럴이나 컬럼명을 넣어주면 됨
*/
-- 1.1.3 날짜 처리 함수
--      - ADD_MONTHS, MONTHS_BETWEEN, LAST_DAY, EXTRACT, SYSDATE

-- @실습문제
/*
    오늘부로 일용자씨가 군대에 끌려갑니다.
    군복무 기간이 1년 6개월을 한다라고 가정하면
    첫번째, 제대일자는 언제인지 구하고
    두번째, 제대일짜까지 먹어야 할 짬밤의 그릇수를 구해주세요!!
    (단, 1일 3끼를 먹는다고 한다.)
*/

SELECT SYSDATE "입대일자", ADD_MONTHS(SYSDATE, 18) "제대일자", FLOOR(ADD_MONTHS(SYSDATE, 18)-SYSDATE)*3 "짬밥수" FROM DUAL;






DESC EMPLOYEE;
-- @함수 최종실습문제
--1. 직원명과 이메일 , 이메일 길이를 출력하시오
--		  이름	    이메일		이메일길이
--	ex)  홍길동 , hong@kh.or.kr   	  13
SELECT EMP_NAME "이름",
EMAIL "이메일",
LENGTH(EMAIL) "이메일 길이" FROM EMPLOYEE;


--2. 직원의 이름과 이메일 주소중 아이디 부분만 출력하시오
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh
SELECT EMP_NAME "이름",
SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) "이메일" FROM EMPLOYEE;


--3. 60년대에 태어난 직원명과 년생, 보너스 값을 출력하시오. 그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
--	    직원명    년생      보너스
--	ex) 선동일	    1962	    0.3
--	ex) 송은희	    1963  	    0
SELECT EMP_NAME "직원명",
'19'||SUBSTR(EMP_NO,1,2) "년생",
NVL(BONUS, 0) "보너스" FROM EMPLOYEE
WHERE EMP_NO LIKE '6%';


--4. '010' 핸드폰 번호를 쓰지 않는 사람의 전체 정보를 출력하시오.
SELECT * FROM EMPLOYEE WHERE PHONE NOT LIKE '010%';


--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년 12월
--	ex) 전지연		1997년 3월
SELECT EMP_NAME "직원명", EXTRACT(YEAR FROM HIRE_DATE)||'년 '||EXTRACT(MONTH FROM HIRE_DATE)||'월' "입사년월" FROM EMPLOYEE;


--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서 출력 하시오
--	ex) 홍길동 771120-1******
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') FROM EMPLOYEE;


--7. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원중에 조회함.
--   사번 사원명 부서코드 입사일
SELECT EMP_ID "사번", EMP_NAME "사원명", DEPT_CODE "부서코드", HIRE_DATE "입사일" FROM EMPLOYEE WHERE DEPT_CODE IN ('D5','D9') AND EXTRACT(YEAR FROM HIRE_DATE) = '2004';


--8. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
SELECT EMP_NAME "사원명", HIRE_DATE "입사일", FLOOR(SYSDATE-HIRE_DATE) FROM EMPLOYEE;


--9. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
SELECT EMP_NAME "사원명", DEPT_CODE "부서코드", 
'19'||SUBSTR(EMP_NO,1,2)||'년 '||SUBSTR(EMP_NO,3,2)||'월 '||SUBSTR(EMP_NO,5,2)||'일' "생년월일", 
HIRE_DATE "입사일", 
FLOOR((SYSDATE-TO_DATE('19'||SUBSTR(EMP_NO,1,2)||SUBSTR(EMP_NO,3,2)||SUBSTR(EMP_NO,5,2), 'YYYYMMDD'))/365) "나이" 
FROM EMPLOYEE;


DESC EMPLOYEE;
--10. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME "직원명",
JOB_CODE "직급코드",
TO_CHAR((SALARY*12)+(SALARY*12*NVL(BONUS,0)), 'L999,999,999') "연봉"
FROM EMPLOYEE;


--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.
SELECT EMP_NAME "사원명", 
CASE WHEN DEPT_CODE='D5' THEN '총무부'
    WHEN DEPT_CODE='D6' THEN '기획부'
    WHEN DEPT_CODE='D9' THEN '영업부'
END "부서명"
FROM EMPLOYEE WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY DEPT_CODE ASC;



-- 1.1.4 형변환 함수
--      a. TO_CHAR()
--      b. TO_DATE()
--      c. TO_NUMBER()

-- EMPLOYEE테이블에서 입사일이 00/01/01 ~ 10/01/01 사이인 직원의 정보를 출력하시오.
SELECT * FROM EMPLOYEE
--WHERE HIRE_DATE BETWEEN '00/01/01' AND '10/01/01';    --자동형변환으로 실제로는 아래의 내용으로 동작함
WHERE HIRE_DATE BETWEEN TO_DATE('00/01/01') AND TO_DATE('10/01/01');

SELECT 500 + 300 FROM DUAL;
SELECT TO_NUMBER('500') + 300 FROM DUAL;

--자동 형변환 안되는 경우
SELECT '1,000,000' - '500,000' FROM DUAL;   -- ORA-01722: invalid number
SELECT TO_NUMBER('1,000,000', '9,999,999') - TO_NUMBER('500,000', '999,999') "계산결과" FROM DUAL;

SELECT HIRE_DATE, 
EXTRACT(YEAR FROM HIRE_DATE)||'년 '
||EXTRACT(MONTH FROM HIRE_DATE)||'월 ' 
||EXTRACT(DAY FROM HIRE_DATE)||'일' "입사일자",
TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') "입사일자2" FROM EMPLOYEE;


/* =================== TO_CHAR 형식 문자(숫자) ========================
Format		 예시			설명
,(comma)    9,999		콤마 형식으로 변환
.(period)	99.99		소수점 형식으로 변환
9           99999       해당자리의 숫자를 의미함. 값이 없을 경우 소수점이상은 공백, 소수점이하는 0으로 표시.
0		    09999		해당자리의 숫자를 의미함. 값이 없을 경우 0으로 표시. 숫자의 길이를 고정적으로 표시할 경우.
$		    $9999		$ 통화로 표시
L		    L9999		Local 통화로 표시(한국의 경우 \)
XXXX		XXXX		16진수로 표시
FM         FM1234.56    포맷9로부터 치환된 공백(앞) 및 소수점이하0을 제거
*/
/*  =================== TO_DATE 형식 문자(날짜) =======================
YYYY	    년도표현(4자리)
YY	        년도 표현 (2자리)
* RR        년도 표현 (2자리), 50이상 1900, 50미만 2000
MONTH       월을 LOCALE설정에 맞게 출력(FULL)
MM	        월을숫자로표현  
MON	        월을 알파벳으로 표현(월요일아님)
DDD         365일 형태로 표현
DD	        31일 형태로 표현	
D           요일을 숫자로 표현(1:일요일...) 
DAY	        요일 표현	  
DY	        요일을 약어로 표현	

HH HH12     시각
HH          시각(24시간)
MI
SS
AM PM A.M. P.M. 오전오후표기
FM          월, 일, 시,분, 초앞의 0을 제거함.
*/



-- 1.1.5 기타함수
/*          a. NVL함수 : 널처리 하는 함수
            b. DECODE(IF문)
            c. CASE(SWITCH문)
*/
--NVL 함수
SELECT NVL(BONUS*SALARY, 0) FROM EMPLOYEE;

-- DECODE 함수
-- 사용법 : DECODE(변하는 값, 조건값, 참일때 값, 조건값, 참일때 값, 모두 아닐때 값)
-- 예시 : DECODE(변하는 값, 1, '빨강', 2, '노랑', '파랑')
-- CASE 함수
-- 사용법 : CASE WHEN 변하는값 = 조건값 THEN 참일때 값 WHEN 변하는값 = 조건값 THEN 참일때 값 ELSE 모두 아닐때 값 END
-- 예시 : CASE 조두 QUSGKSMS RKQT = 1 THEN '빨강' WHEN 변하는 값 = 2 THEN '노랑' ELSE '파랑' END
SELECT 
    EMP_NAME "이름",
    DECODE((SUBSTR(EMP_NO, 8, 1)), '1', '남', '2', '여', '3', '남', '4', '여', '무') "성별",
    CASE
        WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '남'
        WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '여'
        ELSE '무'
    END "성별"
FROM EMPLOYEE;


-- 2.1 다중행 함수(그룹함수)
-- 2.1.1 SUM : 합
SELECT SUM(SALARY) FROM EMPLOYEE;
-- 2.1.2 AVG : 평균
SELECT AVG(SALARY) FROM EMPLOYEE;
-- 2.1.3 COUNT : 갯수
SELECT COUNT(*) FROM EMPLOYEE;
-- 2.1.4 MAX/MIN
SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEE;


-- 3. GROUP BY & HAVING
-- 그룹함수 사용시 기준이 되는 값에 따라 각각의 결과값을 출력하도록 해주는 키워드

-- 부서별 급여 합계를 구하려고 하는데 아래와 같은 에러메시지가 발생한다.
-- ORA-00937:not a single-group group function
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE;

-- GROUP BY 를 사용하면 전체 값을 부분으로 나눠서 그룹함수 사용 가능
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1 ASC;


--실습1
-- EMPLOYEE 테이블에서 부서코드, 그룹별 급여의 합계, 그룹별 급여의 평균(정수처리),
-- 인원수를 조회하고, 부서코드 순으로 정렬하세요
SELECT DEPT_CODE, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(SALARY) FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1 ASC;


--실습2
-- EMPLOYEE 테이블에서 부서코드, 보너스를 지급받는 사원 수를 조회하고 부서코드 순으로 정렬하세요
SELECT DEPT_CODE, COUNT(BONUS) FROM EMPLOYEE WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1 ASC;

DESC EMPLOYEE;
-- 실습3
-- EMPLOYEE 테이블에서 직급이 J1인 사람들을 제외하고 직급별 사원수 및 평균급여를 출력하세요.
SELECT JOB_CODE, COUNT(*), AVG(SALARY) FROM EMPLOYEE
WHERE JOB_CODE NOT LIKE 'J3' GROUP BY JOB_CODE;


-- 실습4
-- EMPLOYEE 테이블에서 직급이 J1인 사람들을 제외하고 입사년도별 인원수를 조회해서,
-- 입사년도 기준으로 오름차순으로 정렬하세요.
SELECT EXTRACT(YEAR FROM HIRE_DATE) "입사년도", COUNT(HIRE_DATE) "입사인원" FROM EMPLOYEE
WHERE JOB_CODE <> 'J1' GROUP BY EXTRACT(YEAR FROM HIRE_DATE) ORDER BY 1 ASC;


-- 실습5
-- EMPLOYEE 테이블에서 EMP_NO의 8번째 자리가 1, 3이면 '남', 2, 4이면 '여'로 결과를 조회하고,
-- 성별별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬하시오.
SELECT DECODE((SUBSTR(EMP_NO, 8, 1)), '1', '남', '2', '여', '3', '남', '4', '여', '무') "성별",
TRUNC(AVG((SYSDATE-HIRE_DATE)/365),2) "평균연차",
FLOOR(AVG(SALARY)) "급여의 평균", 
SUM(SALARY) "급여의 합계", 
MAX(SALARY) "최대 급여",
MIN(SALARY) "최소 급여",
COUNT(*) "인원수" FROM EMPLOYEE
GROUP BY DECODE((SUBSTR(EMP_NO, 8, 1)), '1', '남', '2', '여', '3', '남', '4', '여', '무')
ORDER BY 4 DESC;


-- 지금까지 한 것
-- 숫자 처리 함수, 문자 처리 함수, 날짜 처리 함수
-- 그룹함수 결과이지만 GROUP BY를 쓰면 기준별로 결과가 나옴
SELECT DEPT_CODE, AVG(SALARY) FROM EMPLOYEE
GROUP BY DEPT_CODE;



-- 실습6
-- 부서내 직급별 급여의 합계를 구하시오.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
--GROUP BY JOB_CODE, DEPT_CODE
ORDER BY 1 ASC;


-- 실습7
-- 부서내 성별 인원수를 구하시오
SELECT DEPT_CODE "부서코드", 
DECODE((SUBSTR(EMP_NO, 8, 1)), '1', '남', '2', '여', '3', '남', '4', '여', '무') "성별", 
COUNT(*) "인원" FROM EMPLOYEE
GROUP BY DEPT_CODE, DECODE((SUBSTR(EMP_NO, 8, 1)), '1', '남', '2', '여', '3', '남', '4', '여', '무')
HAVING SUM(SALARY) >= 5000000
ORDER BY 1 ASC;


-- SELECT문에서 조건을 달때는 WHERE을 쓰지만
SELECT * FROM EMPLOYEE
WHERE SALARY >= 5000000;

-- GROUP BY한 결과값에 조건을 걸때에는 HAVING을 쓴다

-- 부서별 인원수가 5명 미만/초과인 레코드를 출력하세요.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) < 5;

-- HAVING 실습문제
-- 실습문제1
-- 부서별 인원이 5명보다 많은 부서와 인원수를 출력하세요
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;

-- 실습문제2
--부서내 직급별 인원수가 3명이상인 직급의 부서코드, 직급코드, 인원수를 출력하세요.
SELECT DEPT_CODE "부서코드", JOB_CODE "직급코드", COUNT(*) "인원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >= 3;


-- 실습문제3
-- 매니저가 관리하는 사원이 2명 이상인 매니저 아이디와 관리하는 사원수를 출력하세요
SELECT MANAGER_ID "매니저 아이디", COUNT(*) "관리하는 사원 수"
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2;


-- ROLLUP과 CUBE
-- 시험보는거 아니면 잘 안보인다고 함
-- 그얘기를 굳이 하는건 시험에 나온다는 이야기..?

-- 부서별 합계가 출력
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1 ASC;

-- 부서별/직급별 합계 출력
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1 ASC;



