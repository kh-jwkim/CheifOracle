CREATE TABLE USER_NO_CONSTRAINT (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

DROP TABLE USER_NO_CONSTRAINT;

SELECT * FROM USER_NO_CONSTRAINT;

-- INSERT INTO ${TABLE_NAME}(COLUMN1, COLUMN2, ...) VALUES(FIELD1,FIELD2,...); �� �ȿܿ����� �̰͵� ���� �ʿ�
-- 1, khuser01, pass01, �Ͽ���, ��, 01012345678, khuser01@test.com
INSERT INTO USER_NO_CONSTRAINT(USER_NO, USER_ID, USER_PWD, USER_NAME, USER_GENDER, USER_PHONE, USER_EMAIL)
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', '��', '01012345678', 'khuser01@test.com');
INSERT INTO USER_NO_CONSTRAINT(USER_NO, USER_ID, USER_PWD, USER_NAME, USER_GENDER, USER_PHONE, USER_EMAIL)
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', '��', '01012345678', 'khuser01@test.com');
INSERT INTO USER_NO_CONSTRAINT(USER_NO, USER_ID, USER_PWD, USER_NAME, USER_GENDER, USER_PHONE, USER_EMAIL)
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', '��', '01012345678', 'khuser01@test.com');

ROLLBACK;

COMMIT;

--�������� ��� �״�� �Է� ����
INSERT INTO USER_NO_CONSTRAINT(USER_NO, USER_ID, USER_PWD, USER_NAME, USER_GENDER, USER_PHONE, USER_EMAIL)
VALUES(null, null, null, null, null, null, null);

--���⼱ ����ص� ���� (null)�� �������� �׳� null�� ''�� �ٸ���!!
INSERT INTO USER_NO_CONSTRAINT(USER_NO, USER_ID, USER_PWD, USER_NAME, USER_GENDER, USER_PHONE, USER_EMAIL)
VALUES(null, null, '', null, null, null, null);

INSERT INTO USER_NO_CONSTRAINT(USER_NO, USER_ID, USER_PWD, USER_NAME, USER_GENDER, USER_PHONE, USER_EMAIL)
VALUES(2, 'khuser02', null, null, null, null, null);






CREATE TABLE USER_NOTNULL (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL,      -- �ʵ尪 ���� �����ʿ� NOT NULL �������� COLUMN LEVEL ���
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

SELECT * FROM USER_NOTNULL;

-- NOT NULL �Ӽ��� �ִ� �ʵ忡 NULL�� ���� �༭ ROW�� �ۼ��� ��
INSERT INTO USER_NOTNULL(USER_NO, USER_ID, USER_PWD, USER_NAME, USER_GENDER, USER_PHONE, USER_EMAIL)
VALUES(1, 'khuser01', null, null, null, null, null);

-- NOT NULL �ʵ带 ä������ ��
INSERT INTO USER_NOTNULL(USER_NO, USER_ID, USER_PWD, USER_NAME, USER_GENDER, USER_PHONE, USER_EMAIL)
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', null, null, null);




CREATE TABLE USER_UNIQUE (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE,      -- �ʵ尪 ���� �����ʿ� NOT NULL �������� COLUMN LEVEL ���
    USER_PWD VARCHAR2(30) UNIQUE,
    USER_NAME VARCHAR2(30) UNIQUE,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

--UNIQUE ���� �������� �ߺ��� �������� NULL�� ���� ���� ����
SELECT * FROM USER_UNIQUE;

-- ������ 2�� �ߺ� �Է� ��
INSERT INTO USER_UNIQUE
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', null, null, null);
INSERT INTO USER_UNIQUE
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', null, null, null);



CREATE TABLE USER_PRIMARY_KEY (
    USER_NO NUMBER UNIQUE NOT NULL,
    USER_ID VARCHAR2(20) PRIMARY KEY,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

DROP TABLE USER_PRIMARY_KEY;

SELECT * FROM USER_PRIMARY_KEY;

-- UNIQUE NOT NULL �Ӽ��� �ʵ尪���� NULL�� ���� ��
INSERT INTO USER_PRIMARY_KEY
VALUES(1, null, 'pass01', '�Ͽ���', null, null, null);

INSERT INTO USER_PRIMARY_KEY
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', null, null, null);
INSERT INTO USER_PRIMARY_KEY
VALUES(2, 'khuser02', 'pass02', '�̿���', null, null, null);
INSERT INTO USER_PRIMARY_KEY
VALUES(3, 'khuser01', 'pass03', '�����', null, null, null);   -- �ߺ����϶��� �����޽��� üũ!
INSERT INTO USER_PRIMARY_KEY
VALUES(3, null, 'pass03', '�����', null, null, null);         -- NULL�϶��� �����޽��� üũ!





CREATE TABLE USER_CHECK (
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(20) PRIMARY KEY,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')),   --CHECK �������� ����
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

DROP TABLE USER_CHECK;

INSERT INTO USER_CHECK
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', 'M', null, null);
INSERT INTO USER_CHECK
VALUES(2, 'khuser02', 'pass02', '�̿���', 'm', null, null);    --��ҹ��ڵ� ���еȴ�!!
INSERT INTO USER_CHECK
VALUES(3, 'khuser03', 'pass03', '�����', 'Male', null, null);

SELECT * FROM USER_CHECK;






CREATE TABLE USER_DEFAULT (
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(20) PRIMARY KEY,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')), 
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50),
    USER_DATE DATE DEFAULT SYSDATE  --������ �Է� �� DEFAULT�� �Է��ϸ� ������ SYSDATE ����� ����
);
DROP TABLE USER_DEFAULT;

INSERT INTO USER_DEFAULT
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', 'M', '01012345678', 'khuser01@test.com', '24/06/14');
INSERT INTO USER_DEFAULT
VALUES(2, 'khuser02', 'pass02', '�̿���', 'M', '01012345678', 'khuser02@test.com', SYSDATE+7);
INSERT INTO USER_DEFAULT
VALUES(3, 'khuser03', 'pass03', '�����', 'M', '01012345678', 'khuser03@test.com', DEFAULT);

SELECT * FROM USER_DEFAULT;

--��������
-- 1. NOT NULL : NULL�� ���� �ʰ���
-- 2. UNIQUE : �ߺ��� ���� �ʰ���
-- 3. PRIMARY KEY : �ߺ��� �ȵǰ� NULL�� ���� �ʵ��� ��
-- 4. CHECK : ������ ���� ����ǵ��� ��
-- 5. DEFAULT : ������ �Լ��� ǥ�������� ����ǵ��� ��
-- 6. FOREIGN KEY(�ܷ�Ű) : 


CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
SELECT * FROM USER_GRADE;
--DELETE FROM USER_GRADE;
INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');
INSERT INTO USER_GRADE VALUES(40, 'VIP ȸ��');

DELETE FROM USER_GRADE WHERE GRADE_CODE = 30;

CREATE TABLE USER_FOREIGN_KEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')), 
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50),
    USER_DATE DATE DEFAULT SYSDATE,
    --USER_GRADE ���̺��� GRADE_CODE �����θ� �����ϰڴ�
    --ON DELETE SET NULL �� ������ ���� �� NULL�� �ٲٰڴ�
    --GRADE_CODE NUMBER REFERENCES USER_GRADE(GRADE_CODE) ON DELETE SET NULL
    GRADE_CODE NUMBER REFERENCES USER_GRADE(GRADE_CODE) ON DELETE CASCADE
);

DROP TABLE USER_FOREIGN_KEY;

SELECT * FROM USER_FOREIGN_KEY;

-- USER_FOREIGN_KEY�� �ִ� GRADE_CODE�� USER_GRADE�� GRADE_CODE�� �������ִ� 10, 20, 30�� �־�� �Ѵ�
-- 10, 20, 30 ���� ���� 40�� �Է� �Ұ���!
INSERT INTO USER_FOREIGN_KEY
VALUES(1, 'khuser01', 'pw01', '�Ͽ���', 'M', '01012345678', 'khuser01@test.com', DEFAULT, 10);
INSERT INTO USER_FOREIGN_KEY
VALUES(2, 'khuser02', 'pw02', '�̿���', 'M', '01012345678', 'khuser02@test.com', DEFAULT, 20);
INSERT INTO USER_FOREIGN_KEY
VALUES(3, 'khuser03', 'pw03', '�����', 'M', '01012345678', 'khuser03@test.com', DEFAULT, 30);
INSERT INTO USER_FOREIGN_KEY
VALUES(4, 'khuser04', 'pw04', '�����', 'M', '01012345678', 'khuser04@test.com', DEFAULT, 40);

DELETE FROM USER_GRADE WHERE GRADE_CODE = 40;

INSERT INTO USER_GRADE VALUES(40, 'VIP ȸ��');




CREATE TABLE GRADE_POINT(
    GRADE_POINT NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_POINT VALUES(10, '�Ϲݵ��');



---------------------------------------------------------------------------------------------


-- ���̺�� : SHOP_MEMBER
-- �����ؾ��� ������ : 1, khuser01, pass01, �Ͽ���, M, 01012345678, khuser01@test.com

CREATE TABLE SHOP_MEMBER(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')), 
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

INSERT INTO SHOP_MEMBER
VALUES(1, 'khuser01', 'pass01', '�Ͽ���', 'M', '01012345678', 'khuser01@test.com');
INSERT INTO SHOP_MEMBER
VALUES(2, 'khuser02', 'pass02', '�̿���', 'M', '01012345678', 'khuser02@test.com');

SELECT * FROM SHOP_MEMBER;
COMMIT;



-- ���̺�� : SHOP_BUY
-- �����ؾ��� ������ : 1, khuser01, ��ȭ, 24/06/14

CREATE TABLE SHOP_BUY(
    BUY_NO NUMBER PRIMARY KEY,
    --USER_ID VARCHAR2(20) REFERENCES SHOP_MEMBER(USER_ID) ON DELETE CASCADE NOT NULL, -- USER_ID �ʵ忡 NULL�� ���� �� ���� ������ ���� �� �ش� Ʃ�� ����
    USER_ID VARCHAR2(20) REFERENCES SHOP_MEMBER(USER_ID) ON DELETE SET NULL, -- ������ ���� �� USER_ID �ʵ带 NULL�� ����
    PRODUCT_NAME VARCHAR2(30) NOT NULL,
    REG_DATE DATE DEFAULT SYSDATE
);
-- SHOP_BUY�� USER_ID�� SHOT_MEMBER�� USER_ID�� ������ �ִ�
-- khuser01, khuser02 ��... �� ���� �� �ִ�
DROP TABLE SHOP_BUY;

SELECT * FROM SHOP_BUY;

INSERT INTO SHOP_BUY
VALUES(1, 'khuser01', '��ȭ', DEFAULT);
INSERT INTO SHOP_BUY
VALUES(2, 'khuser02', '��ȭ', DEFAULT);

COMMIT;



-- �ܷ�Ű FOREIGN KEY
-- �ڽ����̺��� �θ� ���̺��� ������ �ִ� �÷��� �ʵ尪���θ� INSERT�ϵ��� �ϴ� ��
-- ���� ���Ἲ�� �����ϴ� ����������
-- �÷� ���� : REFERENCES ${�θ����̺�}(${�÷���}) ���� �ɼ�(ON DELETE SET NULL, ON DELETE CASECADE)

-- �ܷ�Ű �����ɼ� (�θ����̺��� ������ ���� �õ��� �ڽ� ���̺��� �����͸� ó���ϴ� ���)
-- 1. �⺻ �ɼ� ON DELETE RESTRICTED
-- 2. ������ ��� �� ���� �ɼ� : ON DELETE CASCADE
-- 3. NULL�� ����� ���� �ɼ� : ON DELETE SET NULL