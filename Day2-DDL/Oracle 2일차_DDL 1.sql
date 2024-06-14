-- DDL
COMMIT;
-- Data Definition Language ������ ���Ǿ�
-- ����Ŭ�� ��ü�� ����, ����, �����ϴ� ��ɾ�, ��ɾ��� �����δ�
-- CREATE, ALTER, DROP, TRUNCATE, ...

-- COMMENT �ۼ��� ������ �ص� ��������� ������ �ϰ� ���� ������ �ȳ�
COMMENT ON COLUMN EMPLOYEE.NAME IS '�����';
COMMENT ON COLUMN EMPLOYEE.T_CODE IS '�����ڵ�';
COMMENT ON COLUMN EMPLOYEE.D_CODE IS '�μ��ڵ�';
COMMENT ON COLUMN EMPLOYEE.AGE IS '����';

-- COMMENT ������ �׳� NULL�δ� �ȵǰ� ����ִ� ���ڿ�('')�� �ؾ��ϴµ�
COMMENT ON COLUMN EMPLOYEE.NAME IS '';
COMMENT ON COLUMN EMPLOYEE.T_CODE IS '';
COMMENT ON COLUMN EMPLOYEE.D_CODE IS '';
COMMENT ON COLUMN EMPLOYEE.AGE IS '';


-- ���̺� �����(ǥ ����)�� ���� �״�� DB ������ �� �� �ִ��İ� �߿�!!
DESC EMPLOYEE;

DESC USER_UNIQUE;

DESC USER_PRIMARY_KEY;




-- ������ ������ּ���
-- ��������(ID/PW) : KH / KH
-- ���ӱ���, �������� �ο�

CREATE USER KH IDENTIFIED BY KH;
GRANT CONNECT, RESOURCE TO KH;


SHOW USER;



