-- 4일차 오라클 조인
-- 1. JOIN
--  - 두 개 이상의 테이블에서 연관성을 가지고 있는 데이터들을
--      따로 분류하여 새로운 가상의 테이블을 만듦
--  -> 여러 테이블의 레코드를 조합하여 하나의 레코드로 만듦
-- ANSI 표준 구문

-- DEPT_CODE/DEPT_ID를 가지고 조인을 하려고 함
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;

-- DEPT_CODE = DEPT_ID 를 조건으로 조인한 쿼리 (ANSI표준 구문)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE   -- 베이스가 될 테이블을 FROM 구문에
JOIN DEPARTMENT -- JOIN으로 끼워넣을 테이블을 JOIN 구문에
ON DEPT_CODE = DEPT_ID;  -- 어떤 컬럼이 동일해야하는지를 ON 구문에 적는다

-- DEPT_CODE = DEPT_ID 를 조건으로 조인한 쿼리 (Oracle전용 구문)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT   -- 베이스가 될 테이블을 FROM구문 첫번째에, JOIN으로 끼워넣을 테이블을 ',' 다음에
WHERE DEPT_CODE = DEPT_ID;  -- 어떤 컬럼이 동일해야하는지를 WHERE 구문에 적는다




-- 두 테이블의 JOB_CODE를 가지고 조인을 하려고 함
SELECT JOB_CODE, JOB_NAME FROM JOB;
SELECT EMP_ID, EMP_NAME, JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE.JOB_CODE = JOB.JOB_CODE 를 조건으로 조인한 쿼리
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE 
JOIN JOB
ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 테이블 별칭을 써서 타이핑을 줄인 쿼리
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E -- EMPLOYEE에 별칭으로 E 부여
JOIN JOB J      -- JOB에 별칭으로 J 부여
ON E.JOB_CODE = J.JOB_CODE;

-- COLUMN명이 중복일 때 더 간단하게 표현하는 쿼리
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB
USING (JOB_CODE);   -- COLUMN명 중복이라서 그냥 한번에 적음




SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;
-- @실습문제1
-- 부서명과 지역명을 출력하세요.
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION
ON LOCATION_ID = LOCAL_CODE;

-- 다중 조인 테스트해봄 (부서명, 지역명, 국가명 표시)
SELECT DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);



-- @실습문제2
-- 사원명과 직급명을 출력하세요!
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB
USING(JOB_CODE);


-- @실습문제3
-- 지역명과 국가명을 출력하세요
SELECT LOCAL_NAME, NATIONAL_NAME
FROM LOCATION
JOIN NATIONAL
USING(NATIONAL_CODE);

DESC DEPARTMENT;
DESC JOB;
DESC EMPLOYEE;

-- @JOIN 종합실습
--1. 주민번호가 1970년대 생이면서 성별이 여자이고, 
-- 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT EMP_NAME "사원명",
EMP_NO "주민번호",
DEPT_TITLE "부서명",
JOB_NAME "직급명"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '전%' AND EMP_NO LIKE '7_____-2%';


--2. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
SELECT EMP_ID "사번", EMP_NAME "사원명", DEPT_TITLE "부서명"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%형%';

DESC JOB;
DESC DEPARTMENT;
DESC EMPLOYEE;
DESC LOCATION;

--3. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT EMP_NAME "사원명", 
JOB_NAME "직급명", 
DEPT_CODE "부서코드", 
DEPT_TITLE "부서명"
FROM EMPLOYEE
JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE LIKE '해외영업%';

--4. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME "사원명", BONUS "보너스포인트", DEPT_TITLE "부서명", LOCAL_NAME "근무지역명"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;

--5. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME "사원명", JOB_NAME "직급명", DEPT_TITLE "부서명", LOCAL_NAME "근무지역명"
FROM EMPLOYEE
JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE DEPT_CODE LIKE 'D2';

--6. 급여등급테이블의 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
-- (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 조인할 것)
-- 데이터 없음!
SELECT EMP_NAME "사원명", JOB_NAME "직급명", SALARY "급여", SALARY*12 "연봉", MAX_SAL "최대급여"
FROM EMPLOYEE
JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE
JOIN SAL_GRADE USING(SAL_LEVEL)
WHERE SALARY > MAX_SAL;

--7. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명", LOCAL_NAME "지역명", NATIONAL_NAME "국가명"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_CODE IN ('KO','JP');

--8. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오. 
--단, join과 IN 사용할 것
SELECT EMP_NAME "사원명", JOB_NAME "직급명", SALARY "급여"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME IN ('차장','사원') AND BONUS IS NULL;

--9. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
SELECT ENT_YN "퇴사여부", COUNT(*)
FROM EMPLOYEE
GROUP BY ENT_YN;



