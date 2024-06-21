-- 7일차 PL/SQL
-- Oracle's Procedural Language Extension to SQL의 약자
-- 1. 개요
-- - 오라클 자체에 내장되어 있는 절차적 언어로써, SQL의 단점을 보완하여 SQL 문장
-- 내에서 변수의 정의, 조건처리, 반복처리 등을 지원함.

-- 2. 구조(익명블록) -     블록문법
-- 2.1 선언부(선택)      : DECLARE
-- 2.2 실행부(필수)      : BEGIN
-- 2.3 예외처리부(선택)  : EXCEPTION
-- 2.4 END;(필수)        : END;
-- 2.5 /(필수)           : /

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL');
END;
/

-- PL/SQL에서 변수쓰는 방법
DECLARE
    VID NUMBER;
BEGIN
    --VID := 1;
    --SELECT 결과값을 변수에 저장
    SELECT SALARY
    INTO VID
    FROM EMPLOYEE
    WHERE EMP_NAME = '선동일이삼';
    DBMS_OUTPUT.PUT_LINE('ID : ' || VID);
EXCEPTION
    -- NO_DATA_FOUND에 대한 오류제어 부분
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No DATA~');
END;
/

DESC EMPLOYEE;
-- 2. PL/SQL 변수
DECLARE
    VEMPNO EMPLOYEE.EMP_NO%TYPE;    --CHAR(14);
    VENAME EMPLOYEE.EMP_NAME%TYPE;  --VARCHAR2(20);
    VSAL   EMPLOYEE.SALARY%TYPE;    --NUMBER;
    VHDATE EMPLOYEE.HIRE_DATE%TYPE; --DATE;
BEGIN
    SELECT EMP_NO, EMP_NAME, SALARY, HIRE_DATE
    INTO VEMPNO, VENAME, VSAL, VHDATE
    FROM EMPLOYEE
    WHERE EMP_ID = '200';
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' : ' || VENAME || ' : ' || VSAL || ' : ' || VHDATE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No DATA~');
END;
/

DESC JOB;

-- @실습문제1
-- 사번, 사원명, 직급명을 담을 수 있는 참조변수(%TYPE)를 통해서
-- 송종기 사원의 사번, 사원명, 직급명을 익명블럭을 통해 출력하세요.
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VJNAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_NAME
    INTO VEMPID, VENAME, VJNAME
    FROM EMPLOYEE
    LEFT OUTER JOIN JOB USING(JOB_CODE)
    WHERE EMP_NAME LIKE '송종기';
    DBMS_OUTPUT.PUT_LINE('사번 : '|| VEMPID || ' 사원명 : ' || VENAME || ' 직급명 : ' || VJNAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No DATA~');
END;
/

-- PL/SQL 입력 받기
DECLARE
    VEMP EMPLOYEE%ROWTYPE; -- EMPLOYEE 테이블 항목과 거기에 해당하는 타입(%ROWTYPE) 을 받아오겠다.
BEGIN
    SELECT *
    INTO VEMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || VEMP.EMP_ID || ', 이름 : ' || VEMP.EMP_NAME);
END;
/





-- @실습문제2
-- 사원번호를 입력받아서 해당 사원의 사원번호, 이름, 부서코드, 부서명을 출력하세요.
DECLARE
    --VEMP EMPLOYEE%ROWTYPE;
    --VDPT DEPARTMENT%ROWTYPE;
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VDCODE EMPLOYEE.DEPT_CODE%TYPE;
    VDTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    -- 쿼리문 작성
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
    -- 변수에 쿼리문 결과값 매핑
    INTO VEMPID, VENAME, VDCODE, VDTITLE
    FROM EMPLOYEE
    LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE(VEMPID || ';' || VENAME || ';' || VDCODE || ';' || VDTITLE);
END;
/



DESC EMPLOYEE;
-- @실습문제3
-- EMPLOYEE 테이블에서 사번의 마지막 번호를 구한뒤 +1한 사번에 사용자로부터
-- 입력받은 이름, 주민번호, 전화번호, 직급코드, 급여등급을 등록하는 PL/SQL을 작성하시오.
DECLARE
    VMNUM EMPLOYEE.EMP_ID%TYPE;
BEGIN
    -- MAX() 함수를 이용해서 마지막 번호를 구한다
    SELECT MAX(EMP_ID)
    INTO VMNUM
    FROM EMPLOYEE;
    INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, PHONE, JOB_CODE, SAL_LEVEL)
    VALUES(VMNUM+1, '&NAME', '&EMPNO', '&PHONE', '&JOBCODE', '&SALLEVEL');  -- INSERT INTO 의 VALUES 부분에 '&INPUT' 형식으로 데이터를 입력받으면 된다!
    --COMMIT;
END;
/

SELECT * FROM EMPLOYEE;
ROLLBACK;


-- == PL/SQL의 조건문
-- 1. IF (조건식) THEN (실행문) END IF;
-- 2. IF (조건식) THEN (실행문) ELSE (실행문) END IF;
-- 3. IF (조건식) THEN (실행문) ELSIF (조건식) THEN (실행문) ... (ELSIF-THEN 반복)
--    ELSE (실행문)
--    END IF;



-- @실습문제1
-- 사원번호를 입력받아서 사원의 사번, 이름, 급여, 보너스율을 출력하시오
-- 단, 직급코드가 J1인 경우 '저희 회사 대표님입니다.'를 출력하시오.
-- 사번 : 222
-- 이름 : 이태림
-- 급여 : 2460000
-- 보너스율 : 0.35
-- 저희 회사 대표님입니다.
DECLARE
    EMP_INFO EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO EMP_INFO
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_INFO.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_INFO.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || EMP_INFO.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || NVL(EMP_INFO.BONUS,0)*100 || '%');
    
    --조건
    IF (EMP_INFO.JOB_CODE = 'J1')
    --실행
    THEN DBMS_OUTPUT.PUT_LINE('저희 회사 대표님입니다.');
    --종료
    END IF;
END;
/


-- @실습문제2
-- 사원번호를 입력받아서 사원의 사번, 이름, 부서명, 직급명을 출력하시오.
-- 단, 직급코드가 J1인 경우 '대표', 그 외에는 '일반직원'으로 출력하시오.
-- 사번 : 201
-- 이름 : 송종기
-- 부서명 : 총무부
-- 직급명 : 부사장
-- 소속 : 일반직원
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VDTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VJCODE EMPLOYEE.JOB_CODE%TYPE;
    VJNAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_CODE, JOB_NAME
    INTO VEMPID, VENAME, VDTITLE, VJCODE, VJNAME
    FROM EMPLOYEE
    LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    LEFT OUTER JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || VEMPID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || VENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || VDTITLE);
    DBMS_OUTPUT.PUT_LINE('직급명 : ' || VJNAME);
    
    --조건
    IF (VJCODE = 'J1')
    --실행
    THEN DBMS_OUTPUT.PUT_LINE('소속 : 대표');
    ELSE DBMS_OUTPUT.PUT_LINE('소속 : 일반직원');
    --종료
    END IF;
END;
/



-- @실습문제3
-- 사번을 입력 받은 후 급여에 따라 등급을 나누어 출력하도록 하시오.
-- 그때 출력 값은 사번, 이름, 급여, 급여등급을 출력하시오.
-- 500만원 이상(그외) : A
-- 400만원 ~ 499만원 : B
-- 300만원 ~ 399만원 : C
-- 200만원 ~ 299만원 : D
-- 100만원 ~ 199만원 : E
-- 0만원 ~ 99만원 : F
DECLARE
    EMP_INFO EMPLOYEE%ROWTYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    VSLEVEL VARCHAR2(3);
BEGIN
    SELECT *
    INTO EMP_INFO
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';

    SAL := EMP_INFO.SALARY/10000;
    IF(SAL >= 500)
        THEN VSLEVEL := 'A';
    ELSIF(SAL BETWEEN 400 AND 499)
        THEN VSLEVEL := 'B';
    ELSIF(SAL BETWEEN 300 AND 399)
        THEN VSLEVEL := 'C';
    ELSIF(SAL BETWEEN 200 AND 299)
        THEN VSLEVEL := 'D';
    ELSIF(SAL BETWEEN 100 AND 199)
        THEN VSLEVEL := 'E';
    ELSE VSLEVEL := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_INFO.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_INFO.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || EMP_INFO.SALARY);
    DBMS_OUTPUT.PUT_LINE('급여등급 : ' || VSLEVEL);

END;
/

-- ELSIF와 대응되는 CASE문
-- CASE 변수
--      WHEN 값1 THEN 실행문1
--      WHEN 값2 THEN 실행문2
--      WHEN 값3 THEN 실행문3
--      WHEN 값4 THEN 실행문4
--      ELSE 실행문5
-- END CASE;
DECLARE
    EMP_INFO EMPLOYEE%ROWTYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    VSLEVEL VARCHAR2(3);
BEGIN
    SELECT *
    INTO EMP_INFO
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';

    SAL := FLOOR(EMP_INFO.SALARY/1000000);
    CASE SAL
        WHEN 0 THEN VSLEVEL := 'F';
        WHEN 1 THEN VSLEVEL := 'E';
        WHEN 2 THEN VSLEVEL := 'D';
        WHEN 3 THEN VSLEVEL := 'C';
        WHEN 4 THEN VSLEVEL := 'B';
        ELSE VSLEVEL := 'A';
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_INFO.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_INFO.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || EMP_INFO.SALARY);
    DBMS_OUTPUT.PUT_LINE('급여등급 : ' || VSLEVEL);

END;
/



-- == PL/SQL의 반복문







