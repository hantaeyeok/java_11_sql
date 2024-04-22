-- ���� �������� �Է¹޾� ������(3.1415) �� �ݿ��Ͽ� ���̸� ���ϴ� �Լ�(circle_fnc)�� �ۼ��Ͻÿ�.

CREATE OR REPLACE FUNCTION circle_fnc(radius IN NUMBER)
RETURN NUMBER
IS
    area NUMBER;
BEGIN
    area := radius*radius*3.1415;
    RETURN area;
END;
/

select circle_fnc(25) as "����" from dual;


-- �ʺ�(w),����(h),����(d)�� �Ű������� �Է¹޾� ������ü�� ���Ǹ� ���ϴ� �Լ�(box_vol)�� �ۼ��ϰ�, �����Ͻÿ�.
CREATE OR REPLACE FUNCTION box_vol(w IN NUMBER, h IN NUMBER, d IN NUMBER)
RETURN NUMBER
IS
    vol NUMBER;
BEGIN
    vol := w*h*d;
    RETURN vol;
END;
/

SELECT box_vol(20,5,8) AS "����" from dual;



-- ���(emp) ���̺�� ���� �ٹ��Ⱓ(y��x����)�� ����ϴ� �Լ�(workdays_fnc)�� �ۼ��Ͻÿ�.
-- (��, �Ի����� �Է¹޾� MONTH_BETWEEN�Լ��� ����Ͽ� ����� �������� ���� �� �ֵ��� �� ��.)
-- (���� �ÿ��� �����(ename)�� �ٹ��Ⱓ(y��x������ ��µǵ��� �� ��.)
-- MONTHS_BETWEEN(���߳�¥, ������¥) : �帥 ���� �� ��� (ex. 98����)
-- FLOOR(����) : �Ҽ��� ���� ����
-- ��� ���ϱ� : FLOOR(MONTHS_BETWEEN(SYSDATE, �Ի���)/12) (ex. 98/12=8.16667.. => 8��)
-- �ܿ� ������ ���ϱ� : FLOOR(MOD(MONTHS_BETWEEN(SYSDATE, �Ի���), 12)) (ex. 98 mod 12 => 2����)

CREATE OR REPLACE FUNCTION workdays_fnc(vdate IN DATE)
RETURN VARCHAR2
IS
    workdate VARCHAR2(40);
BEGIN
    workdate := FLOOR(MONTHS_BETWEEN(SYSDATE, vdate)/12) || '�� ' || 
    FLOOR(MOD(MONTHS_BETWEEN(SYSDATE, vdate), 12)) || '����';
RETURN workdate;
END;
/

SELECT ename AS "�����", TO_CHAR(REGDATE, 'YYYY-MM-DD') AS "�Ի���", 
workdays_fnc(REGDATE) AS "�ٹ��Ⱓ" FROM emp;

select * from emp;

-- ���(emp) ���̺��� �����ڵ�(gender)�� �̿��Ͽ� ������ ���ϴ� �Լ�(gender_fnc)�� �ۼ��ϰ�, �����Ͻÿ�.
-- (��,  �����ڵ�(gender)�� 1 �̰ų� 3 �̸�, '��' �̰�, �ƴϸ�, '��' �̴�.)
-- (�������� �����, ���� �÷��� ��µ� �� �ֵ��� �Ͻÿ�.)
CREATE OR REPLACE FUNCTION gender_fnc(vgender NUMBER)
RETURN VARCHAR2
IS
    sgender VARCHAR2(4);
BEGIN
    IF vgender IN (1,3) THEN
        sgender := '��';
    ELSE
        sgender := '��';
    END IF;
    RETURN sgender;
END;
/
-- IS gcode VARCHAR(4)
-- gcode := SUBSTR(jumin, 8, 1) �����ڵ尡 �ֹι�ȣ���� 8��° ���� 1������ ���
-- IF gcode IN ('1', '3') THEN
SELECT ename AS "�����", gender_fnc(gender) AS "����" FROM emp;

-- ���(emp) ���̺��� �޿�(salary)�� �̿��Ͽ� �޿������ ���ϴ� �Լ�(grade_emp)�� �ۼ��ϰ�, �����Ͻÿ�.
-- (��, �޿��� 4,500,000 �̻��̸�, 'A', 3,500,000 �̻��̸�, 'B', 3,000,000 �̻��̸�, 'C', �������� 'D'�� �� ��.)
-- (�������� ����ڵ�, �����, �޿����, �޿� ������ ��µ� �� �ֵ��� �Ͻÿ�.)(IF THEN~ELSIF THEN~ELSE)

CREATE OR REPLACE FUNCTION grade_emp(vsal NUMBER)
RETURN VARCHAR2
IS
    slev VARCHAR2(4);
BEGIN
    IF vsal >= 4500000 THEN
        slev := 'A';
    ELSIF vsal >= 3500000 THEN
        slev := 'B';
    ELSIF vsal >= 3000000 THEN
        slev := 'C';
    ELSE
        slev := 'D';
    END IF;
    RETURN slev;
END;
/

SELECT eno AS "����ڵ�", ename AS "�����", 
grade_emp(salary) AS "�޿����", salary AS "�޿�" FROM emp;


-- loop_test ���̺� ����
-- ��ȣ(no) ����
-- �̸�(name) �������ڿ� 20 ����, �⺻�� '�����'
CREATE TABLE loop_test(no NUMBER, name VARCHAR2(20) DEFAULT '�����');

-- LOOP ���� Ȱ���Ͽ� ��ȣ�� ���������� �ڵ� ä��鼭 20���� ���ڵ带 �߰��� �� �ֵ��� �ݺ��� ��.
-- ��ȣ�� 1~20
DECLARE 
    vcnt NUMBER(2) := 1;
BEGIN
    LOOP
        INSERT INTO loop_test(NO) VALUES (vcnt);
        vcnt := vcnt + 1;
        EXIT WHEN vcnt > 20;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE((vcnt-1) || '�� ������ �Է� �Ϸ�');
END;

commit;
select * from loop_test;

-- FOR IN LOOP ���� Ȱ���Ͽ� ��ȣ�� ������Ű�� �ڵ� ä��鼭 10���� ���ڵ带 �߰��� �� �ֵ��� �ݺ��� ��.
-- ��ȣ�� 21~30, ���ν��� �̸� : loop2
CREATE OR REPLACE PROCEDURE loop2
IS
BEGIN
    FOR i IN 21..30 LOOP
        INSERT INTO loop_test(NO) VALUES (i);
        COMMIT;
    END LOOP;
END;
/

EXEC loop2;

-- WHILE LOOP ���� Ȱ���Ͽ� ��ȣ�� ������Ű�� �ڵ� ä��鼭 10���� ���ڵ带 �߰��� �� �ֵ��� �ݺ��� ��.
-- ��ȣ�� 31~40, ���ν��� �̸� : loop3
CREATE OR REPLACE PROCEDURE loop3
IS
    vcnt NUMBER(2) := 31;
BEGIN
    WHILE vcnt <= 40 LOOP
        INSERT INTO loop_test(NO) VALUES (vcnt);
        COMMIT;
        vcnt := vcnt + 1;        
    END LOOP;
END;
/

EXEC loop3;

select * from loop_test;



-- ����ó�� ���ν��� exc_test
CREATE OR REPLACE PROCEDURE exc_test
IS
    sw emp%ROWTYPE;
BEGIN
    SELECT * INTO sw FROM emp;
    DBMS_OUTPUT.PUT_LINE('������ �˻� ����');
    COMMIT;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('�����Ͱ� �ʹ� �����ϴ�.');
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('�ش� �����Ͱ� �����ϴ�.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('��Ÿ ������ ���� ����ó�� ���� ���߽��ϴ�.');
END;
/

EXEC exc_test;






