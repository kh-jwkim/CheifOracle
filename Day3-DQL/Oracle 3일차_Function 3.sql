-- 3일차
-- 오라클 함수의 종류
-- 1. 단일행 함수 - 결과값 여러개
-- 2. 다중행 함수 - 결과값 1개(그룹함수)
SELECT SUM(SALARY) FROM EMPLOYEE;  -- 다중행 함수 예시



-- a. 숫자 처리 함수
-- - ABS(절대값), MOD(나머지), TRUNC(소숫점 지정 버림), FLOOR(버림), ROUND(반올림), CEIL(올림)
SELECT TRUNC(SYSDATE-HIRE_DATE,2) FROM EMPLOYEE;
SELECT MOD(35, 3) FROM DUAL; -- DUAL은 가상의 테이블이며 함수의 결과를 테스트 해볼 수 있게 해준다.
SELECT ABS(-1) FROM DUAL;
SELECT SYSDATE FROM DUAL;



-- b. 문자 처리 함수

DESC EMPLOYEE;

-- c. 날짜 처리 함수
-- ADD_MONTHS(), MONTHS_BETWEEN(), LAST_DAY(), EXTRACT, SYSDATE
SELECT ADD_MONTHS(SYSDATE, 2) FROM DUAL;    -- 2개월 뒤를 출력
SELECT ADD_MONTHS(SYSDATE, -4) FROM DUAL;   -- 4개월 전을 출력
SELECT MONTHS_BETWEEN(SYSDATE, '24/05/07') FROM DUAL;  -- '24/05/07' 부터 오늘까지 몇개월 지났는지


-- ex1) EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오.
SELECT EMP_NAME "이름",
HIRE_DATE "입사일",
HIRE_DATE+90,
ADD_MONTHS(HIRE_DATE, 3) "입사 후 3개월"
FROM EMPLOYEE;


-- ex2) EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오.
SELECT EMP_NAME "이름",
HIRE_DATE "입사일",
FLOOR((SYSDATE-HIRE_DATE)/30),
FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "근무 개월수"
FROM EMPLOYEE;


-- LAST_DAY() 입력받은 달의 마지막 날짜를 구해줌
SELECT LAST_DAY(SYSDATE)+1 FROM DUAL;
SELECT LAST_DAY('24/02/23')+1 FROM DUAL;


-- ex3) EMPLOYEE 테이블에서 사원이름, 입사일, 입사월의 마지막날을 조회하세요.
SELECT EMP_NAME "이름", HIRE_DATE "입사일", LAST_DAY(HIRE_DATE) "입사월의 말일" FROM EMPLOYEE;


-- EXTRACT DATE 값에서 년도, 월, 일 추출해줌
SELECT SYSDATE,
EXTRACT(YEAR FROM SYSDATE),
EXTRACT(MONTH FROM SYSDATE),
EXTRACT(DAY FROM SYSDATE)
FROM DUAL;


-- ex4) EMPLOYEE 테이블에서 사원이름, 입사 년도, 입사 월, 입사 일을 조회하시오.
SELECT EMP_NAME "이름",
EXTRACT(YEAR FROM HIRE_DATE)||'년' "입사 년도",  -- ||'String' 형태로 파이프라인 붙여서 결과값에 문자열 추가 가능
EXTRACT(MONTH FROM HIRE_DATE)||'월' "입사 월",
EXTRACT(DAY FROM HIRE_DATE)||'일' "입사 일"
FROM EMPLOYEE;

COMMIT;