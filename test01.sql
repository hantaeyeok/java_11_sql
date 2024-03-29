create table member1 (id varchar(12) primary key, password varchar(12) not null, name varchar(20) not null, address varchar(100), tel varchar(20) not null, reg_date timestamp default sysdate);
insert into member1 values ('bgh', 'a1234', '배곤희', '신사동 912', '010-1111-2222', '2023-09-13');
insert into member1 values ('yjh', 'a3421', '유정환', '강일동 128', '02-2222-3333', '2023-09-13');
insert into member1 values ('lmk', 'b1111', '이민규', '수유동 1004', '010-3333-4444', '2023-09-14');
insert into member1 values ('lsh', 'c456', '이성하', '화곡1동 37', '010-4444-5555', '2023-09-15');
insert into member1 values ('lyj', 'z675', '이연정', '난곡동 67', '02-4444-2222', '2023-09-11');
insert into member1 values ('lyl', 'q789', '이예린', '능동 13', '010-5555-6666', '2023-09-15');
insert into member1 values ('lws', 'g478', '이원석', '고척1동 178', '010-6666-7777', '2023-09-13');
insert into member1 values ('ljh', 'd666', '이정희', '독산1동 75', '010-7777-8888', '2023-09-14');
insert into member1 values ('ljw', 'e964', '이종우', '상계동 777', '02-5555-2222', '2023-09-05');
insert into member1 values ('jib', 'h369', '장인범', '쌍문3동 888', '010-8888-9999', '2023-09-16');

select *from member1;

create sequence bookid_sequence increment by 1 start with 1 minvalue 1 maxvalue 10 nocycle;
create table book (bookid int primary key, bookkind varchar(3) not null, booktitle varchar(50) not null, bookprice int not null, bookcount int not null, author varchar(40), pubcom varchar(40), pubdate timestamp);
insert into book values (bookid_sequence.nextval, 'IT', '이것이 자바다', 30000, 10,'신용권', '한빛미디어',	'2021-08-20');
insert into book values (bookid_sequence.nextval, 'IT',	'자바웹개발워크북', 31500,	19,	'구멍가게코딩단',	'남가람북스', '2022-08-04');
insert into book values (bookid_sequence.nextval, 'NV',	'하얼빈', 14400,	15, '김훈',	'문학동네', '2022-08-03');
insert into book values (bookid_sequence.nextval, 'NV',	'불편한편의점', 12600, 10, '김호연', '나무옆의자', '2022-08-10');
insert into book values (bookid_sequence.nextval, 'DV',	'역행자', 15750,	8,	'자청',	'웅진출판', '2022-05-30');
insert into book values (bookid_sequence.nextval, 'DV',	'자소서바이블', 18000, 15, '이형',	'엔알디', '2022-08-25');
insert into book values (bookid_sequence.nextval, 'HC',	'벌거벗은한국사',	17500, 10, 'tvn', '프런트페이지', '2022-08-22');
insert into book values (bookid_sequence.nextval, 'HC',	'난중일기', 14000, 30, '이순신', '스타북스', '2022-07-27');
insert into book values (bookid_sequence.nextval, 'TC',	'진짜쓰는실무엑셀', 20000,	10,	'전진권', '제이펍', '2022-02-15');
insert into book values (bookid_sequence.nextval, 'TC',	'빅데이터인공지능', 25000,	15,	'박해선', '한빛미디어', '2020-12-21');

select * from book;


create table sales (sno int primary key, bno int not null, id varchar(12) not null, amount int default 1 not null, money int, salesday timestamp default sysdate);
create sequence sno_sequence increment by 1 start with 1 minvalue 1 maxvalue 100 nocycle;
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	1,	'lhy',	1);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	2,	'ykh',	1);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	1,	'jjs',	2);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	9,	'lhy',	1);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	2,	'cmj',	5);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	2,	'jjs',	3);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	3,	'yjh',	2);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	5,	'hsy',	4);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	4,	'nsy',	8);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	1,	'jbj',	3);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	2,	'kyj',	4);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	7,	'lhn',	1);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	8,	'hth',	2);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	10,	'cmj',	5);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	1,	'lhy',	3);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	2,	'cmj',	2);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	2,	'lhy',	1);
insert into sales (sno, bno, id, amount) values (sno_sequence.nextval,	1,	'ykh',	3);

select * from sales;
update sales set money= book.bookprice * book.bookcount;
select bookprice, bookcount from book where bookprice*bookcount;



--1) 회원 테이블에 다음과 같은 내용을 추가하시오.
insert into member1 ('kkt', 'a1004', '김기태', '가산동 123', ' 010-1004-1004', '2023-09-12');
--2) 도서 테이블에 다음 데이터를 추가하시오.
insert into book (bookid_sequence.nextval, 'IT', '스프링프레임워크', 38000, 8, '김기태', '정복사', '2022/9/10');
--3) 판매 테이블에 다음 튜플(레코드)을 추가하시오.


