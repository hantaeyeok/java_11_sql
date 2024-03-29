--테이블 생성
create table member(no int not null, id varchar(20) primary key, pw varchar(300), name varchar(100), birth timestamp, email varchar(300));
-- 시퀀스 생성
create sequence c##test123.mem_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;
--데이터 추가
insert into member values (mem_seq.nextval, 'kim', '1234', '김기태', '1981-12-25', 'kkt@gmail.com');
insert into member values (mem_seq.nextval, 'han', '2346', '한태역', '1998-03-05', 'gksxodur1@gmail.com');
insert into member values (mem_seq.nextval, 'lee', '5678', '이이이', '1998-02-05', 'gksxodur1@gmail.com');
insert into member values (mem_seq.nextval, 'hty', '7894', 'hhttyy', '1998-01-05', 'gksxodur123@gmail.com');
insert into member values (mem_seq.nextval, 'lee1', '1597', 'hhttyy', '1998-01-05', 'dlwjdgml@gmail.com');
insert into member values (mem_seq.nextval, 'kim1', '8794', 'kimkim', '1998-08-05', 'rlavlfrb@gmail.com');
INSERT into member values (mem_seq.nextval, 'bae', '0909' '배곤희', '1999-03-26', 'bea@naver.com');

--데이터 검색
SELECT * from member;


