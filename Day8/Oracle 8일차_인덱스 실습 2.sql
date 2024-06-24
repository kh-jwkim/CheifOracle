-- 오라클 인덱스 실습
-- 1. 100만 개의 데이터를 넣을 테이블 생성
-- 2. 100만개 데이터 삽입(PL/SQL 반복문)
-- 3. 인덱스 설정 전 테스트
-- 4. 인덱스 설정
-- 5. 인덱스 설정 후 테스트

-- #1
-- 아이디, 비번, 이름, 전번, 주소, 등록일, 수정일
-- KH_CUSTOMER_TBL
CREATE TABLE KH_CUSTOMER_TBL
(
    USER_ID VARCHAR2(20),
    USER_PW VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    USER_PHONE VARCHAR2(30),
    USER_ADDR VARCHAR2(40),
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    FIX_DATE TIMESTAMP DEFAULT SYSTIMESTAMP
);
CREATE SEQUENCE SEQ_CUSTOMER_USERID
MINVALUE 1
MAXVALUE 999999999
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;
DROP TABLE KH_CUSTOMER_TBL;
DROP SEQUENCE SEQ_CUSTOMER_USERID;
-- #2
DECLARE
    V_USERID VARCHAR2(200);
BEGIN
    FOR N IN 1..1000000
    LOOP
        V_USERID := '1'||LPAD(SEQ_CUSTOMER_USERID.NEXTVAL, 9, 0);
        INSERT INTO KH_CUSTOMER_TBL
        VALUES(V_USERID, '0000', N||'용자', '010-0000-0000',
        '서울시 중구 남대문로'||N, DEFAULT, DEFAULT);
    END LOOP;
END;
/

--EXPLAIN PLAN FOR
SET TIMING ON;
SELECT COUNT(*) FROM KH_CUSTOMER_TBL WHERE USER_NAME LIKE '%123%';
SET TIMING OFF;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SELECT * FROM USER_INDEXES;

-- #3
-- 인덱스 걸기 전 실행시간 체크
--SELECT * FROM KH_CUSTOMER_TBL;
--SELECT * FROM KH_CUSTOMER_TBL ORDER BY 5 DESC;
EXPLAIN PLAN FOR
SELECT COUNT(*) FROM KH_CUSTOMER_TBL WHERE USER_NAME LIKE '22%용자';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/*
Plan hash value: 371451537
 
--------------------------------------------------------------------------------------
| Id  | Operation          | Name            | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |                 |     1 |    17 |  4047   (1)| 00:00:49 |
|   1 |  SORT AGGREGATE    |                 |     1 |    17 |            |          |
|*  2 |   TABLE ACCESS FULL| KH_CUSTOMER_TBL | 31929 |   530K|  4047   (1)| 00:00:49 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - filter("USER_NAME" LIKE '22%용자')
 
Note
-----
   - dynamic sampling used for this statement (level=2)*/

-- #4
-- 인덱스 생성하기
CREATE INDEX IDX_CUSTOMER_USERNAME ON KH_CUSTOMER_TBL(USER_NAME);
DROP INDEX IDX_CUSTOMER_USERNAME;

-- #5
-- 인덱스 건 후 실행시간 체크
EXPLAIN PLAN FOR
SELECT COUNT(*) FROM KH_CUSTOMER_TBL WHERE USER_NAME LIKE '22%용자';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/*
Plan hash value: 1356290034
 
-------------------------------------------------------------------------------------------
| Id  | Operation         | Name                  | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |                       |     1 |    17 |    33   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE   |                       |     1 |    17 |            |          |
|*  2 |   INDEX RANGE SCAN| IDX_CUSTOMER_USERNAME | 31929 |   530K|    33   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("USER_NAME" LIKE '22%용자')
       filter("USER_NAME" LIKE '22%용자')
 
Note
-----
   - dynamic sampling used for this statement (level=2)*/