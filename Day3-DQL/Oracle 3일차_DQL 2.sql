DESC EMPLOYEE;

-- 데이터를 조회한 결과를 Result Set 이라고 함 
-- ResultSet : SELECT 구문에 의해 반환된 행들의 집합
-- ResultSet은 0개 이상의 행이 포함될 수 있음.
-- ResultSet은 특정한 기준에 의해 정렬될 수 있음
-- 특정 컬럼이나 특정 행을 조회할 수 있음


-- SELECT 뒤에 컬럼명을 적어서 어떤 컬럼을 출력할지 선택
SELECT EMP_ID FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, EMP_NO FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- WHERE 조건을 이용하여 어떤 행을 출력할지 선택
SELECT * FROM EMPLOYEE
WHERE EMP_ID = '200';

-- EMP_ID 기준 오름차순 정렬 (ASC 대신 DESC 키워드가 들어가면 내림차순)
SELECT * FROM EMPLOYEE
ORDER BY EMP_ID ASC;


-- 1. EMPLOYEE 테이블에서 이름, 연봉, 총수령액(보너스 포함),
-- 실수령액(총 수령액-(월급*세금 3%)) 가 출력되도록 하시오.
-- NVL(컬럼명,숫자) 은 컬럼명에 해당하는 필드의 값이 NULL인 경우 숫자로 치환시켜준다.
SELECT EMP_NAME AS 이름,
SALARY*12 AS 연봉, 
SALARY*12+SALARY*NVL(BONUS,0) AS 총수령액, 
SALARY*12+SALARY*NVL(BONUS,0)-SALARY*0.03 AS 실수령액 FROM EMPLOYEE;


-- 2. EMPLOYEE 테이블에서 이름, 근무 일 수를 출력해보시오.
-- (SYSDATE를 사용하면 현재 시간 출력)
SELECT EMP_NAME AS 이름,
ROUND(SYSDATE-HIRE_DATE) AS 근무일수  --ROUND는 반올림 하여 소수점 제거하는데 사용
FROM EMPLOYEE;


-- 3. EMPLOYEE 테이블에서 20년 이상 근속자의 이름, 월급, 보너스율 출력하시오
SELECT EMP_NAME AS 이름,
SALARY AS 월급,
NVL(BONUS,0) AS 보너스율 --,
--ROUND((SYSDATE-HIRE_DATE)/365) AS 근무년수
FROM EMPLOYEE
WHERE (SYSDATE-HIRE_DATE)/365 > 20;










-- 1.EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2.EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 출력하시오
SELECT EMP_NAME AS 이름,
PHONE AS 전화번호
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3.EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고 고용일이
--   90/01/01 ~ 00/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오
SELECT * FROM EMPLOYEE
WHERE (EMAIL LIKE '%s%') AND (DEPT_CODE IN ('D9','D6')) AND (HIRE_DATE BETWEEN '90/01/01' AND '01/12/01') AND (SALARY>2700000);






-- 최종 실습 문제
-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라
SELECT EMP_NAME AS 이름,
EMP_NO AS 주민번호,
SALARY AS 급여,
HIRE_DATE AS 입사일
FROM EMPLOYEE
WHERE (SYSDATE-HIRE_DATE)/365 BETWEEN 5 AND 10;




-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라 
--(퇴사 여부 : ENT_YN)
SELECT EMP_NAME AS 이름,
DEPT_CODE AS 부서코드,
HIRE_DATE AS 고용일,
ROUND(ENT_DATE-HIRE_DATE) AS 근무기간,
ENT_DATE AS 퇴직일
FROM EMPLOYEE
WHERE ENT_YN LIKE 'Y';




-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.
SELECT EMP_NAME AS 이름,
SALARY*1.5 AS 급여,
CEIL((SYSDATE-HIRE_DATE)/365) AS 근속년수   --소숫점 올림, FLOOR는 소수점 아래 버림
FROM EMPLOYEE
WHERE ((SYSDATE-HIRE_DATE)/365 > 10) AND ENT_YN LIKE 'N'
--ORDER BY SYSDATE-HIRE_DATE ASC;
ORDER BY 3 ASC;  --여기서 3은 RESULT SET의 3번째 COLUMN을 뜻한다!






-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
SELECT EMP_NAME AS 이름,
EMP_NO AS 주민번호,
EMAIL AS 이메일,
PHONE AS 폰번호,
SALARY AS 급여
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '99/01/01' AND '10/01/01'
AND SALARY<=2000000;


-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.
SELECT EMP_NAME AS 이름,
EMP_NO AS 주민번호,
SALARY AS 급여,
NVL(DEPT_CODE, '없음') AS 부서코드
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000
AND EMP_NO LIKE '%-2%'
AND EMP_NO LIKE '__04%'
--AND EMP_NO LIKE '__04__-2%' 위의 2 조건을 한번에 만족시키는 형태의 와일드카드
ORDER BY EMP_NO DESC;


-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
SELECT EMP_NAME AS 이름,
TRUNC((SYSDATE-HIRE_DATE)/1000)*(SALARY/10) AS "특별 보너스"
FROM EMPLOYEE
WHERE EMP_NO LIKE '%-1%'
AND BONUS IS NULL
ORDER BY EMP_NAME ASC;




-- extra1
-- EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';



-- extra2
-- EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\';




-- 실습1
-- 관리자(MANAGER_ID)도 없고 부서 배치(DEPT_CODE)도 받지 않은  
-- 직원의 이름 조회하시오
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 실습2
-- 부서배치를 받지 않았지만 보너스를 지급하는 직원 전체 정보 조회
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;













