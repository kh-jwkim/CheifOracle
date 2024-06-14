-- DDL
COMMIT;
-- Data Definition Language 데이터 정의어
-- 오라클의 객체를 생성, 수정, 삭제하는 명령어, 명령어의 종류로는
-- CREATE, ALTER, DROP, TRUNCATE, ...

-- COMMENT 작성은 여러번 해도 덮어씌워지는 동작을 하고 딱히 에러는 안남
COMMENT ON COLUMN EMPLOYEE.NAME IS '사원명';
COMMENT ON COLUMN EMPLOYEE.T_CODE IS '직급코드';
COMMENT ON COLUMN EMPLOYEE.D_CODE IS '부서코드';
COMMENT ON COLUMN EMPLOYEE.AGE IS '나이';

-- COMMENT 삭제는 그냥 NULL로는 안되고 비어있는 문자열('')로 해야하는듯
COMMENT ON COLUMN EMPLOYEE.NAME IS '';
COMMENT ON COLUMN EMPLOYEE.T_CODE IS '';
COMMENT ON COLUMN EMPLOYEE.D_CODE IS '';
COMMENT ON COLUMN EMPLOYEE.AGE IS '';


-- 테이블 기술서(표 형태)를 보고 그대로 DB 구성을 할 수 있느냐가 중요!!
DESC EMPLOYEE;

DESC USER_UNIQUE;

DESC USER_PRIMARY_KEY;




-- 계정을 만들어주세요
-- 접속정보(ID/PW) : KH / KH
-- 접속권한, 생성권한 부여

CREATE USER KH IDENTIFIED BY KH;
GRANT CONNECT, RESOURCE TO KH;


SHOW USER;



