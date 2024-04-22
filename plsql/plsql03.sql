SET SERVEROUTPUT ON;

-- Ä¿¼­(CURSOR) : SELECT ¶Ç´Â DML°ú °°Àº SQLÀÇ ÇÑ ÄÃ·³ÀÇ °á°ú¼Â(ResultSet)À» ÀúÀåÇÏ¿© ÇÊ¿äÇÑ °÷¿¡¼­ È°¿ëÇÏ±â À§ÇÑ °´Ã¼ 
--      ¼±¾ð(DECLARATION) -> ¿­±â(OPEN) -> ¹Ýº¹ÀÐ±â(FETCH) -> ´Ý±â(CLOSE) : ¸í½ÃÀû Ä¿¼­
--      ¼±¾ð(DECLARATION) -> ¹Ýº¹ ·çÇÁ(FOR/LOOP/WHILE...) : ¹¬½ÃÀû Ä¿¼­

-- ¸í½ÃÀû Ä¿¼­(EXPLICIT CURSOR) : ¼±¾ð -> ¿­±â -> ÀÐ±â -> ´Ý±â µîÀÇ ¼ø¼­·Î ÀÌ·ç¾îÁö´Â Ä¿¼­

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
    DBMS_OUTPUT.PUT_LINE('ºÎ¼­ÄÚµå  »ç¿ø¸í  Á÷±Þ  ±Þ¿©');
    DBMS_OUTPUT.PUT_LINE('**********************************');
    LOOP
        FETCH cur_pno INTO vppo, vename, vpos, psal;
        EXIT WHEN cur_pno%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(vppo || '  ' || vename || '  ' || vpos || '  ' || psal);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('ÀüÃ¼ °Ç¼ö : ' || cur_pno%ROWCOUNT);
    CLOSE cur_pno;
END;
/

EXEC emp_prt1(40);

-- ¹¬½ÃÀû Ä¿¼­(IMPLICIT CURSOR) : ¿­±â³ª ÀÐ±â, ´Ý±âÀÇ º°µµ ±¸¹®¾øÀÌ ¹Ýº¹¹®¸¸ È°¿ëÇÏ´Â Ä¿¼­
CREATE OR REPLACE PROCEDURE emp_prt2(vpno IN emp.pno%TYPE)
IS
    CURSOR cur_pno IS SELECT pno, ename, pos, salary FROM emp WHERE pno=vpno;
vcnt NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('ºÎ¼­ÄÚµå  »ç¿ø¸í  Á÷±Þ  ±Þ¿©');
    DBMS_OUTPUT.PUT_LINE('**********************************');
    FOR cur IN cur_pno LOOP 
       DBMS_OUTPUT.PUT_LINE(cur.pno || '  ' || cur.ename || '  ' || cur.pos || '  ' || cur.salary);
       vcnt := cur_pno%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('ÀüÃ¼ °Ç¼ö : ' || vcnt);
END;
/
EXEC emp_prt2(10);

-- Á÷¼ÓÄÚµå(SUPERIOR)¸¦ ¸Å°³º¯¼ö·Î ÀÔ·Â¹Þ¾Æ ÀÔ·ÂÇÑ Á÷¼ÓÄÚµå¿¡ ¼ÓÇÑ Á÷¿øÀÇ 
-- »ç¿ø¹øÈ£(eno), »ç¿ø¸í(ename), Á÷±Þ(pos), ±Þ¿©(salary) ¸¦ Ãâ·ÂÇÏ´Â cur_super
-- ¹¬½ÃÀû Ä¿¼­(IMPLICIT CURSOR)¸¦ »ý¼ºÇÏ½Ã¿À.
CREATE OR REPLACE PROCEDURE cur_super(vsup IN emp.superior%TYPE)
IS
    CURSOR cur_data IS SELECT eno, ename, pos, salary FROM emp WHERE superior=vsup;
vcnt NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('»ç¿ø¹øÈ£  »ç¿ø¸í  Á÷±Þ  ±Þ¿©');
    DBMS_OUTPUT.PUT_LINE('**********************************');
    FOR cur IN cur_data LOOP 
       DBMS_OUTPUT.PUT_LINE(RPAD(cur.eno,9) || RPAD(cur.ename,8) || RPAD(cur.pos,7) || RPAD(cur.salary,10));
       vcnt := cur_data%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE(vsup || '°¡ Á÷¼Ó»ó°üÀÎ »ç¿ø¼ö : ' || vcnt);
END;
/
EXEC cur_super(2004);


-- ÆÐÅ°Áö(PACKAGE) : ¿©·¯ °³ÀÇ ÇÁ·Î½ÃÀú ¶Ç´Â ÇÔ¼ö µîÀ» ÇÏ³ªÀÇ ±×·ìÀ¸·Î ¹­Àº ¹­À½.
-- ÆÐÅ°Áö ¼±¾ðºÎ(PACKAGE DECLARATION)
CREATE OR REPLACE PACKAGE emp_pack
IS
    PROCEDURE eno_out;
    PROCEDURE ename_out;
    PROCEDURE pno_out;
    PROCEDURE pos_out;
END emp_pack;    
/

-- ÆÐÅ°Áö ±â´É Á¤ÀÇºÎ(PACKAGE DEFINE OF FUNCTION)
CREATE OR REPLACE PACKAGE BODY emp_pack 
IS
    CURSOR sw_cur IS SELECT * FROM emp;
    
    PROCEDURE eno_out
    IS
    BEGIN
       DBMS_OUTPUT.PUT_LINE('»ç¿ø¹øÈ£');
       DBMS_OUTPUT.PUT_LINE('--------');
       FOR k IN sw_cur LOOP 
          DBMS_OUTPUT.PUT_LINE(k.eno);
       END LOOP;
    END eno_out;
    PROCEDURE ename_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('»ç¿ø¸í');
        DBMS_OUTPUT.PUT_LINE('------');
        FOR k IN sw_cur LOOP 
            DBMS_OUTPUT.PUT_LINE(k.ename);
        END LOOP;
    END ename_out;
    PROCEDURE pno_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ºÎ¼­¹øÈ£');
        DBMS_OUTPUT.PUT_LINE('------');
        FOR k IN sw_cur LOOP
            DBMS_OUTPUT.PUT_LINE(k.pno);
        END LOOP;
    END pno_out;
    PROCEDURE pos_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Á÷±Þ');
        DBMS_OUTPUT.PUT_LINE('----');
        FOR k IN sw_cur LOOP 
            DBMS_OUTPUT.PUT_LINE(k.pos);
        END LOOP;
    END pos_out;
END;
/
EXEC emp_pack.eno_out;


-- Æ®¸®°Å(TRIGGER) : Æ¯Á¤ »óÈ²ÀÌ³ª µ¿ÀÛ µîÀ» ÀÌº¥Æ®¶ó°í ÇÒ ¶§, ÀÌº¥Æ®°¡ ¹ß»ýÇÏ¸é, 
-- ¿¬¼â µ¿ÀÛÀ¸·Î ÇØ´ç ±â´ÉÀ» ÀÚµ¿À¸·Î Ã³¸®ÇØÁÖ´Â ¼­ºê ÇÁ·Î±×·¥ÀÇ ÀÏÁ¾.
-- BEFORE TRIGGER | AFTER TRIGGER(update, insert, delete)
-- CREATE [OR REPLACE] TRIGGER trigger_name
--   BEFORE | AFTER (INSERT,UPDATE,DELETE ON table_name)
--   BEGIN
--      Æ®¸®°Å Ã³¸®
-- END;

-- »óÇ°(goods) Å×ÀÌºí 
-- »óÇ°ÄÚµå(pno)  ¼ýÀÚ
-- »óÇ°¸í(pname)  °¡º¯¹®ÀÚ¿­, ÃÖ´ë 100 ±ÛÀÚ
-- ´Ü°¡(price)    ¼ýÀÚ

-- ÀÔ°í(store) Å×ÀÌºí
-- »óÇ°ÄÚµå(pno)    ¼ýÀÚ
-- ¼ö·®(amount)    ¼ýÀÚ
-- ¸ÅÀÔ´Ü°¡(price)  ¼ýÀÚ

-- Ãâ°í(release) Å×ÀÌºí
-- »óÇ°ÄÚµå(pno)    ¼ýÀÚ
-- ¼ö·®(amount)    ¼ýÀÚ
-- Ãâ°í´Ü°¡(price)  ¼ýÀÚ

-- Àç°í(inventory) Å×ÀÌºí
-- »óÇ°ÄÚµå(pno)    ¼ýÀÚ
-- ¼ö·®(amount)    ¼ýÀÚ
-- ´Ü°¡(price)  ¼ýÀÚ

-- Å×ÀÌºí »ý¼º
CREATE TABLE goods(pno NUMBER, pname VARCHAR2(100), price NUMBER);  -- »óÇ° Å×ÀÌºí
CREATE TABLE store(pno NUMBER, amount NUMBER, price NUMBER);    -- ÀÔ°í Å×ÀÌºí
CREATE TABLE release(pno NUMBER, amount NUMBER, price NUMBER);  -- Ãâ°í Å×ÀÌºí
CREATE TABLE inventory(pno NUMBER, amount NUMBER, price NUMBER);    -- Àç°í Å×ÀÌºí

-- µ¥ÀÌÅÍ Ãß°¡
-- »óÇ° µî·Ï
INSERT INTO »óÇ° VALUES(100,'¸ÔÅÂ±ø',2500);
INSERT INTO »óÇ° VALUES(200,'²¿ºÏÄ¨',2000);
INSERT INTO »óÇ° VALUES(300,'Â¥ÆÄ¸µ',3000);
INSERT INTO »óÇ° VALUES(400,'ÆÃ­S',2800);
INSERT INTO »óÇ° VALUES(500,'°¨Æ¢',2600);

-- ÀÔ°í½ÃÀÇ Àç°í Ã³¸® : ÀÔ°í(store) Å×ÀÌºí¿¡ »õ·Î¿î ·¹ÄÚµå°¡ Ãß°¡µÇ¸é, Àç°í´Â Áõ°¡µÈ´Ù.
-- ¸¸¾à, ÇöÀç ÇØ´ç »óÇ°ÀÇ Àç°í°¡ ¾øÀ¸¸é, »õ·Î¿î »óÇ°À¸·Î Àç°í¸¦ Ã³¸®ÇÏ°í,
-- ÇØ´ç »óÇ°¿¡ ±âÁ¸¿¡ Á¸ÀçÇÏ¸é, ±× Á¦Ç°ÀÇ ¼ö·®°ú ´Ü°¡¸¦ Àû¿ëÇÏ¿© Àç°í¸¦ Ã³¸®ÇÒ ¼ö ÀÖµµ·Ï ±¸ÇöÇÒ °Í.
-- Æ®¸®°Å ÀÌ¸§ : store_trigger
-- Àç°íÀÇ ´Ü°¡ : ÀÔ°í½Ã ¿ø·¡ °¡°ÝÀÇ 40%ÀÇ ¸¶ÁøÀ²
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
-- ÀÔ°í Ã³¸®
INSERT INTO store VALUES(100,2,2500);
-- Àç°í Ã³¸® : store_trigger¿¡ ÀÇÇØ ÀÚµ¿ Ã³¸®µÊ
INSERT INTO inventory VALUES(100,2,3500);   
COMMIT;
INSERT INTO store VALUES(100,3,2500);
INSERT INTO store VALUES(200,4,2000);

-- Ãâ°í½ÃÀÇ Àç°í Ã³¸® : Ãâ°í(release) Å×ÀÌºí¿¡ »õ·Î¿î ·¹ÄÚµå°¡ Ãß°¡µÇ¸é, Àç°í´Â °¨¼ÒµÈ´Ù.
-- ¸¸¾à, ÇöÀç ÇØ´ç »óÇ°ÀÌ ¸ðµÎ Ãâ°í µÇ¸é, ÇØ´ç »óÇ°ÀÇ Àç°í Á¤º¸¸¦ »èÁ¦ÇÏ°í,
-- ÇØ´ç »óÇ°ÀÌ Ãâ°íµÇ°íµµ ÀÜÁ¸ÇÏ¸é, ±× Á¦Ç°ÀÇ ¼ö·®À» Àû¿ëÇÏ¿© Àç°í¸¦ Ã³¸®ÇÒ ¼ö ÀÖµµ·Ï ±¸ÇöÇÒ °Í.
-- Æ®¸®°Å ÀÌ¸§ : release_trigger
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


-- ¹ÝÃâ(recall)½ÃÀÇ Àç°í Ã³¸® : ÀÔ°í(store) Å×ÀÌºí¿¡ ¼ö·®ÀÌ °¨¼ÒÇÏ¸é, Àç°íµµ °¨¼ÒµÈ´Ù.
-- ¸¸¾à, ÇöÀç ÇØ´ç »óÇ°ÀÌ ¸ðµÎ ¹ÝÃâ(recall) µÇ¸é, ÇØ´ç »óÇ°ÀÇ Àç°í Á¤º¸¸¦ »èÁ¦ÇÏ°í,
-- ÇØ´ç »óÇ°ÀÌ ¹ÝÃâµÇ°íµµ ÀÜÁ¸ÇÏ¸é, ±× Á¦Ç°ÀÇ ¼ö·®À» Àû¿ëÇÏ¿© Àç°í¸¦ Ã³¸®ÇÒ ¼ö ÀÖµµ·Ï ±¸ÇöÇÒ °Í.
-- Æ®¸®°Å ÀÌ¸§ : recall_trigger
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



-- ¹ÝÇ°(return)½ÃÀÇ Àç°í Ã³¸® : Ãâ°í(release) Å×ÀÌºí¿¡ ¼ö·®ÀÌ °¨¼ÒÇÏ¸é, Àç°í´Â Áõ°¡µÈ´Ù.
-- ¸¸¾à, ÇöÀç ÇØ´ç »óÇ°ÀÇ Àç°í°¡ ¾øÀ¸¸é, »õ·Î¿î »óÇ°À¸·Î Àç°í¸¦ Ã³¸®ÇÏ°í,
-- ÇØ´ç »óÇ°ÀÌ ±âÁ¸¿¡ Á¸ÀçÇÏ¸é, ±× Á¦Ç°ÀÇ ¼ö·®À» Àû¿ëÇÏ¿© Àç°í¸¦ Ã³¸®ÇÒ ¼ö ÀÖµµ·Ï ±¸ÇöÇÒ °Í.
-- Æ®¸®°Å ÀÌ¸§ : return_trigger
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

