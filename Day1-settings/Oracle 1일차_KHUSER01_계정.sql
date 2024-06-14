SHOW USER;

CREATE TABLE EMPLOYEE(
    NAME VARCHAR2(20),
    T_CODE VARCHAR2(10),
    D_CODE VARCHAR2(10),
    AGE NUMBER
);
-- 1. 컬럼의 데이터 타입없이 테이블 생성하여 오류남
-- -> 데이터타입 작성
-- 2. 권한도 없이 테이블을 생성하여 오류남
-- -> System_계정 에서 RESOURCE 권한 부여
-- 3. 접속해제 후 접속, 새로운 워크시트 말고 기존 워크시트 우측 상단에서 KHUSER01_계정 선택하여
-- 명령어 재실행

-- 테이블에 데이터 삽입
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('일용자', 'T1', 'D1', 33);
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('이용자', 'T2', 'D1', 44);
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('삼용자', 'T1', 'D2', 32);
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('일용자', 'T2', 'D1', 43);

-- 테이블의 데이터 삭제
DROP TABLE EMPLOYEE;    --테이블 자체를 삭제

DELETE FROM EMPLOYEE;   --테이블의 데이터 전체 삭제

DELETE FROM EMPLOYEE WHERE NAME = '일용자';    --COLUMN NAME의 값이 '일용자'인 ROW 삭제

DELETE FROM EMPLOYEE WHERE NAME = '일용자' AND T_CODE = 'T2';  --COLUMN NAME의 값이 '일용자' 이면서 COLUMN T_CODE의 값이 'T2'인 ROW 삭제

UPDATE EMPLOYEE SET T_CODE = 'T3' WHERE NAME = '일용자';   --COLUMN NAME의 값이 '일용자' 인 ROW의 COLUMN T_CODE의 값을 'T3'으로 변경

SELECT NAME, T_CODE, D_CODE, AGE FROM EMPLOYEE  -- NAME, T_CODE, D_CODE, AGE 컬럼의 값을 EMPLOYEE 테이블에서 조회
WHERE NAME = '일용자';                           -- NAME 컬럼의 값이 '일용자'인 경우

SELECT * FROM EMPLOYEE; --EMPLOYEE 테이블 전체 ROW(WHERE가 없기 때문), 전체 COLUMN(SELECT * 때문)를 조회



-- 이름이 STUDENT_TBL인 테이블을 만드세요
-- 이름, 나이, 학년, 주소를 저장할 수 있도록 하며
-- 일용자, 21, 1, 서울시 중구 를 저장해주세요
-- 일용자를 사용자로 바꿔주세요
-- 데이터를 삭제하는 쿼리문을 작성하고 삭제를 확인하시고
-- 테이블을 삭제하는 쿼리문을 작성하여 테이블이 사라진 것을 확인하세요.

-- 이름이 STUDENT_TBL이면서 이름, 나이, 학년, 주소를 저장할 수 있는 테이블 작성
CREATE TABLE STUDENT_TBL(
    NAME VARCHAR2(10),
    AGE NUMBER,
    GRADE NUMBER,
    ADDR VARCHAR2(20)
);

-- 일용자, 21, 1, 서울시 중구 를 저장
INSERT INTO STUDENT_TBL(NAME, AGE, GRADE, ADDR)
VALUES('일용자', 21, 1, '서울시 중구');

-- 변경사항 롤백/확정
ROLLBACK;   -- 기존 COMMIT 지점으로 되돌린다
COMMIT;     -- 현재 상태를 ROLLBACK 지점으로 설정

-- 일용자를 사용자로 변경
UPDATE STUDENT_TBL SET NAME = '사용자' WHERE NAME = '일용자';

-- 데이터를 삭제하는 쿼리문을 작성하고 삭제
DELETE STUDENT_TBL WHERE NAME = '사용자';

-- 데이터 삭제를 확인
SELECT * FROM STUDENT_TBL;

-- 테이블을 삭제하는 쿼리문을 작성
DROP TABLE STUDENT_TBL;

-- 테이블이 사라진 것을 확인
SELECT * FROM STUDENT_TBL;



-- 아이디가 KHUSER02 비밀번호가 KHUSER02인 계정을 생성하고
-- 접속이 되도록 하고 테이블도 만들 수 있도록 하세요

-- 계정 정보 설정이 가능한 DCL(Data Control Language) 권한이 있는 system 계정으로 변경
-- system (RED) -> SQL Developer 화면 우측 상단의 계정 설정

-- 아이디가 KHUSER02 비밀번호가 KHUSER02인 계정을 생성
--이거 잘 안외워지니까 심심할때마다 생성/삭제 하면서 연습해야 할 듯?
CREATE USER KHUSER02 IDENTIFIED BY KHUSER02;

-- 접속이 되도록 설정
GRANT CONNECT TO KHUSER02;

-- 테이블도 만들 수 있도록 설정
GRANT RESOURCE TO KHUSER02;

SHOW USER;

--다른 유저 권한으로 커맨드 입력이 되는지 보고싶었는데 안되는듯...
--CONN KHUSER02
--SHOW USER;



SELECT * FROM user_users;
