SHOW USER;

CREATE TABLE EMPLOYEE(
    NAME VARCHAR2(20),
    T_CODE VARCHAR2(10),
    D_CODE VARCHAR2(10),
    AGE NUMBER
);
-- 1. �÷��� ������ Ÿ�Ծ��� ���̺� �����Ͽ� ������
-- -> ������Ÿ�� �ۼ�
-- 2. ���ѵ� ���� ���̺��� �����Ͽ� ������
-- -> System_���� ���� RESOURCE ���� �ο�
-- 3. �������� �� ����, ���ο� ��ũ��Ʈ ���� ���� ��ũ��Ʈ ���� ��ܿ��� KHUSER01_���� �����Ͽ�
-- ��ɾ� �����

-- ���̺� ������ ����
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('�Ͽ���', 'T1', 'D1', 33);
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('�̿���', 'T2', 'D1', 44);
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('�����', 'T1', 'D2', 32);
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('�Ͽ���', 'T2', 'D1', 43);

-- ���̺��� ������ ����
DROP TABLE EMPLOYEE;    --���̺� ��ü�� ����

DELETE FROM EMPLOYEE;   --���̺��� ������ ��ü ����

DELETE FROM EMPLOYEE WHERE NAME = '�Ͽ���';    --COLUMN NAME�� ���� '�Ͽ���'�� ROW ����

DELETE FROM EMPLOYEE WHERE NAME = '�Ͽ���' AND T_CODE = 'T2';  --COLUMN NAME�� ���� '�Ͽ���' �̸鼭 COLUMN T_CODE�� ���� 'T2'�� ROW ����

UPDATE EMPLOYEE SET T_CODE = 'T3' WHERE NAME = '�Ͽ���';   --COLUMN NAME�� ���� '�Ͽ���' �� ROW�� COLUMN T_CODE�� ���� 'T3'���� ����

SELECT NAME, T_CODE, D_CODE, AGE FROM EMPLOYEE  -- NAME, T_CODE, D_CODE, AGE �÷��� ���� EMPLOYEE ���̺��� ��ȸ
WHERE NAME = '�Ͽ���';                           -- NAME �÷��� ���� '�Ͽ���'�� ���

SELECT * FROM EMPLOYEE; --EMPLOYEE ���̺� ��ü ROW(WHERE�� ���� ����), ��ü COLUMN(SELECT * ����)�� ��ȸ



-- �̸��� STUDENT_TBL�� ���̺��� ���弼��
-- �̸�, ����, �г�, �ּҸ� ������ �� �ֵ��� �ϸ�
-- �Ͽ���, 21, 1, ����� �߱� �� �������ּ���
-- �Ͽ��ڸ� ����ڷ� �ٲ��ּ���
-- �����͸� �����ϴ� �������� �ۼ��ϰ� ������ Ȯ���Ͻð�
-- ���̺��� �����ϴ� �������� �ۼ��Ͽ� ���̺��� ����� ���� Ȯ���ϼ���.

-- �̸��� STUDENT_TBL�̸鼭 �̸�, ����, �г�, �ּҸ� ������ �� �ִ� ���̺� �ۼ�
CREATE TABLE STUDENT_TBL(
    NAME VARCHAR2(10),
    AGE NUMBER,
    GRADE NUMBER,
    ADDR VARCHAR2(20)
);

-- �Ͽ���, 21, 1, ����� �߱� �� ����
INSERT INTO STUDENT_TBL(NAME, AGE, GRADE, ADDR)
VALUES('�Ͽ���', 21, 1, '����� �߱�');

-- ������� �ѹ�/Ȯ��
ROLLBACK;   -- ���� COMMIT �������� �ǵ�����
COMMIT;     -- ���� ���¸� ROLLBACK �������� ����

-- �Ͽ��ڸ� ����ڷ� ����
UPDATE STUDENT_TBL SET NAME = '�����' WHERE NAME = '�Ͽ���';

-- �����͸� �����ϴ� �������� �ۼ��ϰ� ����
DELETE STUDENT_TBL WHERE NAME = '�����';

-- ������ ������ Ȯ��
SELECT * FROM STUDENT_TBL;

-- ���̺��� �����ϴ� �������� �ۼ�
DROP TABLE STUDENT_TBL;

-- ���̺��� ����� ���� Ȯ��
SELECT * FROM STUDENT_TBL;



-- ���̵� KHUSER02 ��й�ȣ�� KHUSER02�� ������ �����ϰ�
-- ������ �ǵ��� �ϰ� ���̺� ���� �� �ֵ��� �ϼ���

-- ���� ���� ������ ������ DCL(Data Control Language) ������ �ִ� system �������� ����
-- system (RED) -> SQL Developer ȭ�� ���� ����� ���� ����

-- ���̵� KHUSER02 ��й�ȣ�� KHUSER02�� ������ ����
--�̰� �� �ȿܿ����ϱ� �ɽ��Ҷ����� ����/���� �ϸ鼭 �����ؾ� �� ��?
CREATE USER KHUSER02 IDENTIFIED BY KHUSER02;

-- ������ �ǵ��� ����
GRANT CONNECT TO KHUSER02;

-- ���̺� ���� �� �ֵ��� ����
GRANT RESOURCE TO KHUSER02;

SHOW USER;

--�ٸ� ���� �������� Ŀ�ǵ� �Է��� �Ǵ��� ����;��µ� �ȵǴµ�...
--CONN KHUSER02
--SHOW USER;



SELECT * FROM user_users;
