-- ���(emp) ���̺� �ۼ�
-- �����ȣ(eno)    ���� �ִ� 10�ڸ�
-- �����(ename)    �������� 20��
-- �μ��ڵ�(pno)  ���� �ִ� 2�ڸ�
-- ����(pos)        �������� 10��
-- �����ȣ(pcode)  �������� 7��
-- �ּ�(addr)      �������� 100��
-- �޿�(salery)    ���� 8�ڸ�
-- �󿩱�(bonus)    ���� 8�ڸ�
-- �Ի���(regdate)  ��¥
-- ����(gender)   ���� �ִ� 2�ڸ�


-- �÷� �߰�
-- �����(superior) ���� �ִ� 10�ڸ�
-- ��ȭ��ȣ(tel)    �������� 13�ڸ�





-- �����ȣ �����  �μ� ��å  �����ȣ �ּ�        ��ȭ��ȣ      �޿�    ���ʽ�     �Ի���     ����  ����
--                �ڵ�                                                                        �ڵ�
-- 2001     ����   10  ����  125-365 ���� ��걸  02-985-1254  3500000 1000000  1980-12-01  1   null
-- 2002     ����   10  �븮  354-865 ���� ������  02-865-1245  4000000          2000-01-25  1   2004
-- 2003     ���̻� 20  ���  587-456 �λ� �ؿ�뱸 051-256-9874 2500000 1000000  2002-05-24  2   2002
-- 2004     ����   30  ����  987-452 ���� ������  02-333-6589  5000000           1997-03-22 2    2001 
-- 2005     ��    10   �븮  123-322 ���� ������  02-888-9564  3000000 1000000  1999-07-15  2   2004
-- 2006     ����  20   ���  154-762 ���� ���ı�  02-3369-9874 2000000          2003-05-22  2    2005
-- 2007     ������ 30  �븮  367-985 ���� �������� 02-451-2563 3000000  1000000  2006-01-25  2   2004
-- 2008     ������ 40  ���  552-126 ���� �߱�    02-447-3256  2400000          2001-02-02  2   2007
-- 2009     ���÷� 10  ���  315-276 ���� ���α�  02-123-1278  2500000  1000000  2009-04-17  2   2002
-- 2010     ��ä�� 20  ���  485-172 ���� ���ϱ�  02-478-1235  2450000  800000   2009-12-15  2   2004  





create table emp(eno number(10) primary key, ename varchar2(20), pno number(2), 
pos varchar2(10), pcode varchar2(7), addr varchar2(100), salary number(8), 
bonus number(8), regdate date, gender number(2));

alter table emp add superior number(10);
alter table emp add tel varchar2(13);

select * from emp;

-- �÷� �����
alter table emp modify salary invisible;
alter table emp modify bonus invisible;
alter table emp modify regdate invisible;
alter table emp modify gender invisible;
alter table emp modify superior invisible;

-- �÷� ���̱�
alter table emp modify salary visible;
alter table emp modify bonus visible;
alter table emp modify regdate visible;
alter table emp modify gender visible;
alter table emp modify superior visible;

insert into emp values (2001,'����',10,'����','125-365','���� ��걸','02-985-1254',3500000,1000000,'1980-12-01',1,null);
insert into emp values (2002,'����',10,'�븮','354-865','���� ������','02-865-1245',4000000,null,'2000-01-25',1,2004);
insert into emp values (2003,'���̻�',20,'���','587-456','�λ� �ؿ�뱸','051-256-9874',2500000,1000000,'2002-05-24',2,2002);
insert into emp values (2004,'����',30,'����','987-452','���� ������','02-333-6589',5000000,null,'1997-03-22',2,2001);
insert into emp values (2005,'��',10,'�븮','123-322','���� ������','02-888-9564',3000000,1000000,'1999-07-15',2,2004);
insert into emp values (2006,'����',20,'���','154-762','���� ���ı�','02-3369-9874',2000000,null,'2003-05-22',2,2005);
insert into emp values (2007,'������',30,'�븮','367-985','���� ��������','02-451-2563',3000000,1000000,'2006-01-25',2,2004);
insert into emp values (2008,'������',40,'���','552-126','���� �߱�','02-447-3256',2400000,null,'2001-02-02',2,2007);
insert into emp values (2009,'���÷�',10,'���','315-276','���� ���α�','02-123-1278',2500000,1000000,'2009-04-17',2,2002);
insert into emp values (2010,'��ä��',20,'���','485-172','���� ���ϱ�','02-478-1235',2450000,800000,'2009-12-15',2,2004);

-- ������ ���(Procedural Language)�� SQL => PL/SQL
-- SQL ������ �ϳ��� ��� ������� �����Ͽ� �ʿ�� ȣ���Ͽ� ����ϸ�, IF, LOOP, FOR ���� Ȱ���Ͽ� �� ȿ�������� SQL�� Ȱ���� �� �ִ�.
-- ���ν���(Procedure), �Լ�(Function), Ʈ����(Trigger)

-- PL ���� ��� ��¹� Ȱ��ȭ
SET SERVEROUTPUT ON;

DECLARE
    TYPE firsttype IS RECORD(a emp.ename%TYPE, b emp.pos%TYPE, 
    c emp.salary%TYPE);
cus1 firsttype;
BEGIN
    SELECT ename, pos, salary INTO cus1 FROM emp where eno=2001;
    DBMS_OUTPUT.PUT_LINE('***********************************************');
    DBMS_OUTPUT.PUT_LINE(cus1.a || CHR(10) || cus1.b || CHR(10) || cus1.c);
    DBMS_OUTPUT.PUT_LINE('���� ���� : ' || USER);
    DBMS_OUTPUT.PUT_LINE('���� ���� �ð� : ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MM:SS'));
END;




-- �͸��� ���ν����� Ȱ���Ͽ� ���(emp) ���̺�� ���� �����ȣ 2002�� ������
-- �����ȣ, �����, ����, �ּ�, �Ի����� ����Ͻÿ�.
-- (��, �Ի����� ���� �� �ڸ�-�� �� �ڸ�-�� �� �ڸ� ���·� ��µ� �� �ֵ��� �� ��.)
DECLARE
    sawon emp%ROWTYPE;
BEGIN
    SELECT * INTO sawon FROM emp where eno=2002;
    DBMS_OUTPUT.PUT_LINE('***********************************************');
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || sawon.eno);
    DBMS_OUTPUT.PUT_LINE('����� : ' || sawon.ename);
    DBMS_OUTPUT.PUT_LINE('���� : ' || sawon.pos);
    DBMS_OUTPUT.PUT_LINE('�ּ� : ' || sawon.addr);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || TO_CHAR(sawon.regdate, 'YYYY-MM-DD'));
END;

-- �͸��� �ݺ� ���ν��� �ǽ�
-- ���(emp) ���̺�� ���� �����(ename), ����(pos) �÷��� ��� ����� ����Ͻÿ�.
DECLARE
    TYPE ename_type IS TABLE OF emp.ename%TYPE INDEX BY BINARY_INTEGER;
    TYPE pos_type IS TABLE OF emp.pos%TYPE INDEX BY BINARY_INTEGER;
    ename_col ename_type;
    pos_col pos_type;
    i BINARY_INTEGER := 0;
BEGIN
    FOR k IN(SELECT ename, pos FROM emp) LOOP
        i := i + 1;
        ename_col(i) := k.ename;
        pos_col(i) := k.pos;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('******************');
    DBMS_OUTPUT.PUT_LINE('�����      ����');
    DBMS_OUTPUT.PUT_LINE('******************');
    FOR j IN 1..i LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(ename_col(j), 12) || RPAD(pos_col(j), 10));
    END LOOP;    
END;

-- ���ν��� ����
--  CREATE OR REPLACE PROCEDURE ���ν��� �̸�( �Ű�������1[ IN | OUT | IN OUT ] ������Ÿ��[:= ����Ʈ��],
--      �Ű�������2[ IN | OUT | IN OUT ] ������Ÿ��[:= ����Ʈ��], ... )
--  IS[AS]
--      ����, ��� �� ����
--  BEGIN
--      ����
--  [EXCEPTION ����ó����]
--  END [���ν��� �̸�]


-- �����ȣ(eno)�� �޿�(salary)�� �Ű������� �Է¹޾� �ش� ����� �޿��� �����ϴ� ���ν���(update_pay)�� �ۼ��Ͽ���
CREATE OR REPLACE PROCEDURE update_pay(u_eno IN NUMBER, u_salary IN NUMBER)
IS
BEGIN
    UPDATE emp SET salary=u_salary WHERE eno = u_eno;
    COMMIT;
END update_pay;
/

EXEC update_pay(2001, 5000000);
EXEC update_pay(2006, 2800000);
select * from emp;

-- �����ȣ(eno)�� ����(pos), �ּ�(addr)�� �Է� �޾� �����ϴ� ���ν���(update_emp)�� �ۼ��ϰ�,
-- ������ �����ͷ� 3�� �̻� �����ϵ��� �Ͻÿ�.

CREATE OR REPLACE PROCEDURE update_emp(u_eno IN NUMBER, u_pos IN emp.pos%TYPE, u_addr IN emp.addr%TYPE)
IS
BEGIN
    UPDATE emp SET pos=u_pos,addr=u_addr WHERE eno = u_eno;
    COMMIT;
END update_emp;
/

EXEC update_emp(2004, '����', '���� ������');
EXEC update_emp(2002, '����', '���� ������');
EXEC update_emp(2003, '�븮', '�λ� �ؿ�뱸');

select * from emp;


-- �Լ� ����
--    CREATE OR REPLACE FUNCTION �Լ� �̸� (�Ű�����1, �Ű�����2....)
--    RETURN ������ Ÿ��;
--    IS[AS]
--        ����, ��� ����..
--    BEGIN
--        �����
--        RETURN ��ȯ��
--        [EXCEPTION ����ó����]
--    END [�Լ� �̸�];


-- �Լ�(Functions)
-- �����ȣ(eno)�� �Ű������� �Է¹޾� Ư�� ������ ����(3.3%)�� ����Ͽ� ����ϴ� �Լ�(tax_fnc)�� �ۼ��ϰ� �����Ͻÿ�.
-- ���Ƿ� 3���� ���๮�� �����ϰ�, �� ����� ����Ͻÿ�.
CREATE OR REPLACE FUNCTION tax(v_eno IN emp.eno%TYPE)
RETURN NUMBER
IS
    v_tax NUMBER;
BEGIN
    SELECT (salary+NVL(bonus, 0))*0.033 INTO v_tax FROM emp WHERE eno = v_eno;
    RETURN v_tax;
END tax;    
/

-- ���� ���1
DECLARE
    v_tax NUMBER;
BEGIN
    v_tax := tax(2003);
    DBMS_OUTPUT.PUT_LINE('���� : ' || v_tax);
END;
/

-- ���� ���2
select tax(2003) as "����" from dual;

-- ���� ���3
select distinct tax(2003) as "����" from emp;
select tax(2003) as "����" from emp where eno = 2003;


-- ����(pos)�� �Ű������� �Է� �޾� �ش� ���޺� �޿� �Ѿ�, ��� �޿�, �ο����� ����ϴ� 
-- ���ν���(tot_emp)�� �ۼ��Ͻÿ�.
CREATE OR REPLACE PROCEDURE tot_emp(v_pos IN VARCHAR2)
IS
    a NUMBER :=0;
    b NUMBER(12,2):=0;
    c NUMBER:=0;
BEGIN
    SELECT SUM(salary+NVL(bonus,0)), AVG(salary+NVL(bonus,0)), COUNT(*) INTO a,b,c
    FROM emp WHERE pos=v_pos;
    DBMS_OUTPUT.PUT_LINE(v_pos || '�� �޿� ����');
    DBMS_OUTPUT.PUT_LINE('�޿� �Ѿ� : ' || a || '��');
    DBMS_OUTPUT.PUT_LINE('��� �޿� : ' || b || '��');
    DBMS_OUTPUT.PUT_LINE('�ο��� : ' || c || '��');
END tot_emp;
/

EXEC tot_emp('���');
EXEC tot_emp('�븮');
EXEC tot_emp('����');
EXEC tot_emp('����');


ACCEPT k_pos PROMPT '������ ��å�� �Է��ϼ��� :';

select * from emp;

-- ����� �߰��ϴ� ���ν���(ins_emp)�� �ۼ��Ͻÿ�.
-- (��, �߰��ϴ� �����ʹ� ���Ƿ� �� ��.)
CREATE OR REPLACE PROCEDURE ins_emp(veno IN emp.eno%TYPE,
vename IN emp.ename%TYPE, vpno IN emp.pno%TYPE,
vpos IN emp.pos%TYPE, vpcode IN emp.pcode%TYPE,
vaddr IN emp.addr%TYPE, vtel IN emp.tel%TYPE,
vsalary IN emp.salary%TYPE, vbonus IN emp.bonus%TYPE,
vregdate IN emp.regdate%TYPE, vgender IN emp.gender%TYPE,
vsuperior IN emp.superior%TYPE)
IS
BEGIN
    INSERT INTO emp VALUES(veno,vename,vpno,vpos,vpcode,vaddr,vtel,vsalary,vbonus,
    vregdate,vgender,vsuperior);
    COMMIT;
END;

EXEC ins_emp(2011,'��ٿ�',30,'���','223-245','����õ��','031-457-1405',2350000,null,'2023-12-26',2,2005);
EXEC ins_emp(2012,'��ī��',40,'���','123-125','����� ���α�','02-2454-6903',2320000,null,'2024-01-10',1,2007);
EXEC ins_emp(2013,'������',40,'���','127-113','����� ��õ��','02-8654-2728',2320000,null,'2024-01-10',2,2006);

select * from emp;

-- �����ȣ(eno)�� �Ű������� �Է¹޾� �ش� ������ ���� ��� ó���� �ϴ� ���ν���(del_emp)�� �ۼ��Ͻÿ�.
-- (�ۼ��� del_emp ���ν������� ��, �Ű������� �����ȣ�� 2001�� ����� ������ ��.)
CREATE OR REPLACE PROCEDURE del_emp(veno IN emp.eno%TYPE)
IS
BEGIN
    DELETE FROM emp where eno=veno;
    COMMIT;
END;

EXEC del_emp(2001);










