SET SERVEROUTPUT ON;

-- Ŀ��(CURSOR) : SELECT �Ǵ� DML�� ���� SQL�� �� �÷��� �����(ResultSet)�� �����Ͽ� �ʿ��� ������ Ȱ���ϱ� ���� ��ü 
--      ����(DECLARATION) -> ����(OPEN) -> �ݺ��б�(FETCH) -> �ݱ�(CLOSE) : ����� Ŀ��
--      ����(DECLARATION) -> �ݺ� ����(FOR/LOOP/WHILE...) : ������ Ŀ��

-- ����� Ŀ��(EXPLICIT CURSOR) : ���� -> ���� -> �б� -> �ݱ� ���� ������ �̷������ Ŀ��

select * from emp;

CREATE OR REPLACE PROCEDURE emp_prt1(vpno IN emp.pno%TYPE)
IS
    CURSOR cur_pno IS SELECT pno, ename, pos, salary FROM emp WHERE pno=vpno;
vppo emp.pno%TYPE;
vename emp.ename%TYPE;
vpos emp.pos%TYPE;
psal emp.salary%TYPE;
BEGIN
    OPEN cur_pno;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ�  �����  ����  �޿�');
    DBMS_OUTPUT.PUT_LINE('**********************************');
    LOOP
        FETCH cur_pno INTO vppo, vename, vpos, psal;
        EXIT WHEN cur_pno%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(vppo || '  ' || vename || '  ' || vpos || '  ' || psal);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('��ü �Ǽ� : ' || cur_pno%ROWCOUNT);
    CLOSE cur_pno;
END;
/

EXEC emp_prt1(40);

-- ������ Ŀ��(IMPLICIT CURSOR) : ���⳪ �б�, �ݱ��� ���� �������� �ݺ����� Ȱ���ϴ� Ŀ��
CREATE OR REPLACE PROCEDURE emp_prt2(vpno IN emp.pno%TYPE)
IS
    CURSOR cur_pno IS SELECT pno, ename, pos, salary FROM emp WHERE pno=vpno;
vcnt NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ�  �����  ����  �޿�');
    DBMS_OUTPUT.PUT_LINE('**********************************');
    FOR cur IN cur_pno LOOP 
       DBMS_OUTPUT.PUT_LINE(cur.pno || '  ' || cur.ename || '  ' || cur.pos || '  ' || cur.salary);
       vcnt := cur_pno%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('��ü �Ǽ� : ' || vcnt);
END;
/
EXEC emp_prt2(10);

-- �����ڵ�(SUPERIOR)�� �Ű������� �Է¹޾� �Է��� �����ڵ忡 ���� ������ 
-- �����ȣ(eno), �����(ename), ����(pos), �޿�(salary) �� ����ϴ� cur_super
-- ������ Ŀ��(IMPLICIT CURSOR)�� �����Ͻÿ�.
CREATE OR REPLACE PROCEDURE cur_super(vsup IN emp.superior%TYPE)
IS
    CURSOR cur_data IS SELECT eno, ename, pos, salary FROM emp WHERE superior=vsup;
vcnt NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('�����ȣ  �����  ����  �޿�');
    DBMS_OUTPUT.PUT_LINE('**********************************');
    FOR cur IN cur_data LOOP 
       DBMS_OUTPUT.PUT_LINE(RPAD(cur.eno,9) || RPAD(cur.ename,8) || RPAD(cur.pos,7) || RPAD(cur.salary,10));
       vcnt := cur_data%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE(vsup || '�� ���ӻ���� ����� : ' || vcnt);
END;
/
EXEC cur_super(2004);


-- ��Ű��(PACKAGE) : ���� ���� ���ν��� �Ǵ� �Լ� ���� �ϳ��� �׷����� ���� ����.
-- ��Ű�� �����(PACKAGE DECLARATION)
CREATE OR REPLACE PACKAGE emp_pack
IS
    PROCEDURE eno_out;
    PROCEDURE ename_out;
    PROCEDURE pno_out;
    PROCEDURE pos_out;
END emp_pack;    
/

-- ��Ű�� ��� ���Ǻ�(PACKAGE DEFINE OF FUNCTION)
CREATE OR REPLACE PACKAGE BODY emp_pack 
IS
    CURSOR sw_cur IS SELECT * FROM emp;
    
    PROCEDURE eno_out
    IS
    BEGIN
       DBMS_OUTPUT.PUT_LINE('�����ȣ');
       DBMS_OUTPUT.PUT_LINE('--------');
       FOR k IN sw_cur LOOP 
          DBMS_OUTPUT.PUT_LINE(k.eno);
       END LOOP;
    END eno_out;
    PROCEDURE ename_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('�����');
        DBMS_OUTPUT.PUT_LINE('------');
        FOR k IN sw_cur LOOP 
            DBMS_OUTPUT.PUT_LINE(k.ename);
        END LOOP;
    END ename_out;
    PROCEDURE pno_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ');
        DBMS_OUTPUT.PUT_LINE('------');
        FOR k IN sw_cur LOOP
            DBMS_OUTPUT.PUT_LINE(k.pno);
        END LOOP;
    END pno_out;
    PROCEDURE pos_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('����');
        DBMS_OUTPUT.PUT_LINE('----');
        FOR k IN sw_cur LOOP 
            DBMS_OUTPUT.PUT_LINE(k.pos);
        END LOOP;
    END pos_out;
END;
/
EXEC emp_pack.eno_out;


-- Ʈ����(TRIGGER) : Ư�� ��Ȳ�̳� ���� ���� �̺�Ʈ��� �� ��, �̺�Ʈ�� �߻��ϸ�, 
-- ���� �������� �ش� ����� �ڵ����� ó�����ִ� ���� ���α׷��� ����.
-- BEFORE TRIGGER | AFTER TRIGGER(update, insert, delete)
-- CREATE [OR REPLACE] TRIGGER trigger_name
--   BEFORE | AFTER (INSERT,UPDATE,DELETE ON table_name)
--   BEGIN
--      Ʈ���� ó��
-- END;

-- ��ǰ(goods) ���̺� 
-- ��ǰ�ڵ�(pno)  ����
-- ��ǰ��(pname)  �������ڿ�, �ִ� 100 ����
-- �ܰ�(price)    ����

-- �԰�(store) ���̺�
-- ��ǰ�ڵ�(pno)    ����
-- ����(amount)    ����
-- ���Դܰ�(price)  ����

-- ���(release) ���̺�
-- ��ǰ�ڵ�(pno)    ����
-- ����(amount)    ����
-- ���ܰ�(price)  ����

-- ���(inventory) ���̺�
-- ��ǰ�ڵ�(pno)    ����
-- ����(amount)    ����
-- �ܰ�(price)  ����

-- ���̺� ����
CREATE TABLE goods(pno NUMBER, pname VARCHAR2(100), price NUMBER);  -- ��ǰ ���̺�
CREATE TABLE store(pno NUMBER, amount NUMBER, price NUMBER);    -- �԰� ���̺�
CREATE TABLE release(pno NUMBER, amount NUMBER, price NUMBER);  -- ��� ���̺�
CREATE TABLE inventory(pno NUMBER, amount NUMBER, price NUMBER);    -- ��� ���̺�

-- ������ �߰�
-- ��ǰ ���
INSERT INTO ��ǰ VALUES(100,'���±�',2500);
INSERT INTO ��ǰ VALUES(200,'����Ĩ',2000);
INSERT INTO ��ǰ VALUES(300,'¥�ĸ�',3000);
INSERT INTO ��ǰ VALUES(400,'�íS',2800);
INSERT INTO ��ǰ VALUES(500,'��Ƣ',2600);

-- �԰���� ��� ó�� : �԰�(store) ���̺� ���ο� ���ڵ尡 �߰��Ǹ�, ���� �����ȴ�.
-- ����, ���� �ش� ��ǰ�� ��� ������, ���ο� ��ǰ���� ��� ó���ϰ�,
-- �ش� ��ǰ�� ������ �����ϸ�, �� ��ǰ�� ������ �ܰ��� �����Ͽ� ��� ó���� �� �ֵ��� ������ ��.
-- Ʈ���� �̸� : store_trigger
-- ����� �ܰ� : �԰�� ���� ������ 40%�� ������
CREATE OR REPLACE TRIGGER store_trigger
AFTER INSERT ON store 
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN
        INSERT INTO inventory VALUES (:NEW.pno, :NEW.amount, :NEW.price*1.4);
    ELSE
        UPDATE inventory SET amount=amount+:NEW.amount, price=:NEW.price*1.4 
        WHERE pno=:NEW.pno;
    END IF;    
END;
/

select * from inventory;
-- �԰� ó��
INSERT INTO store VALUES(100,2,2500);
-- ��� ó�� : store_trigger�� ���� �ڵ� ó����
INSERT INTO inventory VALUES(100,2,3500);   
COMMIT;
INSERT INTO store VALUES(100,3,2500);
INSERT INTO store VALUES(200,4,2000);

-- ������ ��� ó�� : ���(release) ���̺� ���ο� ���ڵ尡 �߰��Ǹ�, ���� ���ҵȴ�.
-- ����, ���� �ش� ��ǰ�� ��� ��� �Ǹ�, �ش� ��ǰ�� ��� ������ �����ϰ�,
-- �ش� ��ǰ�� ���ǰ� �����ϸ�, �� ��ǰ�� ������ �����Ͽ� ��� ó���� �� �ֵ��� ������ ��.
-- Ʈ���� �̸� : release_trigger
CREATE OR REPLACE TRIGGER release_trigger
AFTER INSERT ON release 
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT amount-:NEW.amount INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN
        DELETE FROM inventory WHERE pno=:NEW.pno;
    ELSE
        UPDATE inventory SET amount=amount-:NEW.amount WHERE pno=:NEW.pno;
    END IF;    
END;
/

select * from inventory;
INSERT INTO release VALUES(100,3,(SELECT price FROM inventory WHERE pno=100));


-- ����(recall)���� ��� ó�� : �԰�(store) ���̺� ������ �����ϸ�, ��� ���ҵȴ�.
-- ����, ���� �ش� ��ǰ�� ��� ����(recall) �Ǹ�, �ش� ��ǰ�� ��� ������ �����ϰ�,
-- �ش� ��ǰ�� ����ǰ� �����ϸ�, �� ��ǰ�� ������ �����Ͽ� ��� ó���� �� �ֵ��� ������ ��.
-- Ʈ���� �̸� : recall_trigger
CREATE OR REPLACE TRIGGER recall_trigger
AFTER UPDATE ON store 
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT amount-:NEW.amount INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN
        DELETE FROM inventory WHERE pno=:NEW.pno;
    ELSE
        UPDATE inventory SET amount=amount-:NEW.amount WHERE pno=:NEW.pno;
    END IF;    
END;
/

select * from inventory;
UPDATE store SET amount=amount-2 WHERE pno=100;



-- ��ǰ(return)���� ��� ó�� : ���(release) ���̺� ������ �����ϸ�, ���� �����ȴ�.
-- ����, ���� �ش� ��ǰ�� ��� ������, ���ο� ��ǰ���� ��� ó���ϰ�,
-- �ش� ��ǰ�� ������ �����ϸ�, �� ��ǰ�� ������ �����Ͽ� ��� ó���� �� �ֵ��� ������ ��.
-- Ʈ���� �̸� : return_trigger
CREATE OR REPLACE TRIGGER return_trigger
AFTER UPDATE ON release
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN
        INSERT INTO inventory VALUES (:NEW.pno, :NEW.amount, :NEW.price);
    ELSE
        UPDATE inventory SET amount=amount+:NEW.amount, price=:NEW.price*1.4 
        WHERE pno=:NEW.pno;
    END IF;    
END;
/

select * from inventory;
UPDATE release SET amount=amount-2 WHERE pno=100;

