-- WorkBook 문제 풀이

-- Basic Select 4
-- 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다.
-- 그 대상자들의 학번이 다음과 같을 때 대상자들을 찾는 적절한 SQL 구문을 작성하시오.
-- A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME "대출 도서 장기 연체자" FROM TB_STUDENT 
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- Basic Select 5
-- 입학정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열을 출력하시오.
SELECT DEPARTMENT_NAME "학과 이름", CATEGORY "계열" FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- Basic Select 6
-- 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.
-- 그럼 춘 기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
SELECT PROFESSOR_NAME FROM TB_PROFESSOR WHERE DEPARTMENT_NO IS NULL;

-- Additional Select - 함수 1
-- 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL문장을 작성하시오.
-- (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
SELECT STUDENT_NO "학번", STUDENT_NAME "이름", ENTRANCE_DATE "입학년도" FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002';

-- Additional Select - 함수 2
-- 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다.
-- 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자.
-- (* 이때 올바르게 작성한 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
SELECT PROFESSOR_NAME "교수 이름", PROFESSOR_SSN "교수 주민번호" FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) > 3;

-- Additional Select - 함수 3
-- 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오.
-- 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오.
-- (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 '만' 으로 계산한다.)
SELECT PROFESSOR_NAME "교수이름", FLOOR((SYSDATE-TO_DATE('19'||SUBSTR(PROFESSOR_SSN,1,6)))/365) "나이" FROM TB_PROFESSOR
WHERE PROFESSOR_SSN LIKE '%-1%';

-- Additional Select - 함수 4
-- 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는 "이름" 이 찍히도록 한다.
-- (성이 2자인 경우는 교수는 없다고 가정하시오)
SELECT SUBSTR(PROFESSOR_NAME,2) "이름" FROM TB_PROFESSOR;





-- Additional SELECT - Option 16
-- 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_GRADE
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '환경조경학과'
GROUP BY CLASS_NO, CLASS_NAME;

-- Additional SELECT - Option 17
-- 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL문을 작성하시오.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_STUDENT WHERE STUDENT_NAME = '최경희');


-- Additional SELECT - Option 18
-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시오.

WITH STD_AVG_SCORE AS (
    SELECT STUDENT_NO, STUDENT_NAME, AVG_SCORE FROM TB_STUDENT
    JOIN (SELECT AVG(POINT) "AVG_SCORE", STUDENT_NO FROM TB_GRADE GROUP BY STUDENT_NO) USING(STUDENT_NO)
    WHERE DEPARTMENT_NO=(SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '국어국문학과%')
)
SELECT STUDENT_NO, STUDENT_NAME FROM STD_AVG_SCORE
WHERE AVG_SCORE = (SELECT MAX(AVG_SCORE) FROM STD_AVG_SCORE);


-- Additional SELECT - Option 19
-- 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL 문을 찾아내시오.
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.

SELECT DEPARTMENT_NAME, ROUND(AVG(POINT),1) 
FROM TB_GRADE
LEFT OUTER JOIN TB_STUDENT USING(STUDENT_NO)
LEFT OUTER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY=(SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '환경조경학과')
GROUP BY DEPARTMENT_NAME;


-- DDL 9
-- TB_DEPARTMENT의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모값으로 참조하도록 FOREIGN KEY를 지정하시오.
-- 이 때 KEY 이름은 FK_테이블이름_컬럼이름 으로 지정한다. (ex. FK_DEPARTMENT_CATEGORY)
DROP TABLE TB_CATEGORY;
CREATE TABLE TB_CATEGORY(
    CATEGORY_NAME VARCHAR2(20),
    USE_YN CHAR(1) DEFAULT 'Y'
);

INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;

ALTER TABLE TB_CATEGORY
ADD CONSTRAINT PK_NAME_CATEGORY
PRIMARY KEY (CATEGORY_NAME);

ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY
FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TB_DEPARTMENT';
DESC TB_CATEGORY;


-- DDL 10
-- 춘 기술대학교 학생들의 정보만이 포함되어 있는 학생일반정보 VIEW를 만들고자 한다.
-- 아래 내용을 참고하여 적절한 SQL 문을 작성하시오.
-- 뷰 이름(VW_학생일반정보), 컬럼(학번, 학생이름, 주소)

-- CHUN 계정에 VIEW 생성 권한 설정(SYSTEM계정으로 수행)
GRANT CREATE VIEW TO CHUN;

-- 뷰 생성(CHUN계정으로 수행)
CREATE VIEW VW_학생일반정보 (학번, 학생이름, 주소)
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS FROM TB_STUDENT;

SELECT * FROM VW_학생일반정보;


-- DDL 11
-- 춘 기술대학교는 1년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행한다.
-- 이를 위해 사용할 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW를 만드시오.
-- 이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오
-- (단, 이 VIEW 는 단순 SELECT만을 할 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)

CREATE VIEW COUNSLE_VIEW (학생이름, 학과이름, 담당교수이름)
AS SELECT STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME 
FROM TB_STUDENT
LEFT OUTER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT OUTER JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
ORDER BY DEPARTMENT_NAME ASC;

-- 학과별로 정렬되어있는지 확인
SELECT * FROM COUNSLE_VIEW;


-- DDL 12
-- 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW를 작성해 보자.
-- 뷰 이름(VW_학과별학생수), 컬럼(DEPARTMENT_NAME, STUDENT_COUNT)

CREATE VIEW VW_학과별학생수 (DEPARTMENT_NAME, STUDENT_COUNT)
AS SELECT DEPARTMENT_NAME, COUNT(*)
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME
ORDER BY 1 ASC;

SELECT * FROM VW_학과별학생수;


-- DML 3
-- 국어국문학과 학생들의 정보만이 포함되어 있는 학과정보 테이블을 만들고자 한다.
-- 아래 내용을 참고하여 적절한 SQL 문을 작성하시오.
-- (힌트 : 방법은 다양함, 소신껏 작성하시오)
-- 테이블이름(TB_국어국문학과), 컬럼(학번, 학생이름, 출생년도(4자리년도), 교수이름)

CREATE TABLE TB_국어국문학과 (학번, 학생이름, 출생년도, 교수이름)
AS SELECT STUDENT_NO, STUDENT_NAME, 
DECODE(SUBSTR(STUDENT_SSN,8,1), '1', '19', '2', '19', '3', '20', '4', '20')||SUBSTR(STUDENT_SSN,1,2),
PROFESSOR_NAME
FROM TB_STUDENT
LEFT OUTER JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO;

-- 작성된 테이블 확인
SELECT * FROM TB_국어국문학과;

-- DML 4
-- 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용할 SQL문을 작성하시오.
-- (단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다)

SELECT CAPACITY, DEPARTMENT_NAME FROM TB_DEPARTMENT ORDER BY DEPARTMENT_NAME ASC;
UPDATE TB_DEPARTMENT E SET CAPACITY = ROUND(CAPACITY*1.1);




