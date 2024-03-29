-- 테이블 생성
create table member(no int not null, id varchar(20) primary key, pw varchar(300), 
		name varchar(100), birth timestamp, email varchar(300));
-- 시퀀스 생성        
create sequence c##test123.mem_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle;

-- 데이터 추가
insert into member values (mem_seq.nextval, 'kim', '1234', '김기태', '1981-12-25', 'kkt@gmail.com');
insert into member values (mem_seq.nextval, 'park', '1004', '박동수', '1998-03-25', 'park@naver.com');
insert into member values (mem_seq.nextval, 'lee', '1212', '이연정', '1979-08-15', 'lee@daum.net');
insert into member values (mem_seq.nextval, 'cho', '2848', '조대신', '1989-04-05', 'cho@gmail.com');
insert into member values (mem_seq.nextval, 'yu', '7979', '유정환', '1995-10-15', 'yu@naver.com');
insert into member values (mem_seq.nextval, 'bae', '0909', '배곤희', '1999-03-26', 'bae@gmail.com');

-- 데이터 검색
select * from member;
select id,name,birth from member;

-- 생일(birth)이 1980년생~1985년생인 회원의 id, name 컬럼 검색
select id,name from member 
where birth between '1980-01-01' and '1985-12-31';

-- id에 i나 e가 포함된 회원의 id,name 컬럼을 검색
select id,name from member 
where id like '%i%' or id like '%e%';
-- id like 'i%' : i로 시작하는
-- id like '%i' : i로 끝나는

-- id가 'kim','lee','cho','park' 인 회원(member) 정보를 검색
select * from member 
where id='kim' or id='lee' or id='cho' or id='park';

-- id가 'kim','lee','cho' 인 회원(member) 정보를 검색
select * from member 
where id in ('kim','lee','cho');

-- id가 'kim','lee','cho' 아닌 회원(member) 정보를 검색
select * from member 
where id not in ('kim','lee','cho');

-- 컬럼명이 너무 길거나 수식이나 함수를 적용하여 컬럼을 구성할 경우 
-- 컬럼에 대한 alias(별칭)를 붙일 수 있다.
-- 회원(member) 테이블로 부터 id, name, 이름 중에서 성씨를 검색
select id,name,substr(name,1,1) as surname from member;
-- java에서 rs.getString("surname"); 처럼 alias로 호출해야함

select * from member;

-- id가 'lee'인 회원의 이메일(email)을 'lee@naver.com'로 변경
update member set email='lee@naver.com' where id='lee';

-- id가 'kim'인 회원을 강제탈퇴하도록 한다.
delete from member where id='kim';

alter table member add regdate timestamp default sysdate;

alter table member add point int default 0;

alter table member rename column regdate to reg;

desc member;

select * from member;

alter table member modify pw varchar(200);

alter table member drop column point;

commit;

alter table member rename to temp1;

desc temp1;

create table temp2(no int, name varchar(200), point int);

insert into temp2 values (1, '김', 90);
insert into temp2 values (2, '박', 80);
insert into temp2 values (3, '최', 85);
insert into temp2(name, point) values ('이', 75);

select * from temp2;

delete from temp2 where no is null;

alter table temp2 add constraints key1 primary key (no);

create table emp(no int, name varchar(100), pcode int,
constraints key2 primary key (no));

insert into emp values (1, '김', 1);
insert into emp values (2, '이', 2);
insert into emp values (3, '이', 3);
insert into emp values (4, '이', 4);
insert into emp values (5, '이', 5);

update emp set name='박' where no=3;
update emp set name='최' where no=4;
update emp set name='조' where no=5;

create table pos(pcode int primary key, pname varchar(100));

insert into pos values (1, '이사');
insert into pos values (2, '부장');
insert into pos values (3, '과장');
insert into pos values (4, '사원');

insert into pos values (5, '인턴');

select * from emp;
select * from pos;

alter table emp add constraints fkey 
foreign key (pcode) references pos(pcode);

select * from ALL_CONSTRAINTS where OWNER='C##TEST123';
select * from ALL_CONSTRAINTS where TABLE_NAME='EMP';

alter table emp drop constraint key2;

drop table pos cascade constraints;

desc emp;

commit;

-- 뷰의 생성
create view view_emp as select * from emp;

select * from emp;
select * from view_emp;

-- 뷰 생성2
create view view_emp2 as select * from emp where no>=3;
select * from emp where no>=3;
select * from view_emp2;

-- 뷰 제거
drop view view_emp;
-- 뷰 수정 : create or replace view view_emp2 as select * from emp where no>=2 or name like '%이%';

-- 시퀀스(자동순번) 생성/수정/제거/적용/조회
-- 시퀀스 생성
create sequence emp_seq increment by 1
start with 6 minvalue 1 maxvalue 9999 nocycle;

select * from emp;

-- 시퀀스 수정
-- alter sequence emp_seq 수정할내용
alter sequence emp_seq increment by 1;

-- 시퀀스 제거
drop sequence emp_seq;

-- emp_seq 의 시퀀스 정보 조회
select * from all_sequences where sequence_name = 'EMP_SEQ';

select * from emp;

-- emp 테이블에 no의 값을 다음 순번(nextval)으로 적용하여 레코드 추가
insert into emp values (emp_seq.nextval, '고', 3); 

-- 현재 시퀀스값 조회
select emp_seq.currval from dual;

-- 테이블 복제(단, 제약조건은 복제가 되지 않음)
create table emp2 as select * from emp;

desc emp2;

select * from emp2;

-- no 컬럼을 기본키로 설정
alter table emp2 modify no int primary key;

-- 내부조인(inner join)
select a.no, a.name, b.pname 
from emp a inner join pos b on a.pcode=b.pcode; 

-- 외부조인1(left outer join)
select a.no, a.name, b.pname 
from emp a left outer join pos b on a.pcode=b.pcode; 

-- 외부조인2(right outer join)
select a.no, a.name, b.pname 
from emp a right outer join pos b on a.pcode=b.pcode; 

-- 연관쿼리
select a.no, a.name, b.pname
from emp a, pos b where a.pcode=b.pcode;

select emp.no, emp.name, pos.pname
from emp, pos where emp.pcode=pos.pcode;

select * from emp2;
delete from emp2 where no=3 or no=5;
insert into emp2 values(7, '오', 4);
insert into emp2 values(8, '정', 5);


-- 서브쿼리 = 이중쿼리
-- 서브쿼리(emp2 테이블에 존재하는 no만 emp 테이블 조회) => 일치쿼리(교집합)
select no, name from emp
where no in (select no from emp2);

-- 서브쿼리(emp2 테이블에 존재하지 않는 no만 emp 테이블 조회) => 불일치쿼리(차집합)
select no, name from emp
where name not in (select name from emp2);

select * from emp;
select * from emp2;

select * from emp, pos; -- 두 테이블 간의 product - emp:6, pos:5 => 6*5=30

update emp set pcode=4 where no=4 or no=6 or no=2;

select pcode, count(emp.no) as cnt 
from emp group by pcode;

-- 그룹화하는 항목과 출력되는 그룹 항목이 달라서(오류)
select pos.pname, count(emp.no) as cnt
from pos, emp where pos.pcode = emp.pcode
group by pos.pcode;


-- 직위별 인원수 join문 -> 그룹화하는 항목 : 직위명(pname)
select pos.pname, count(emp.no) as cnt
from pos inner join emp on pos.pcode = emp.pcode
group by pos.pname;

-- 직위별 인원수 연관쿼리 -> 그룹화하는 항목 : 직위명(pname)
select pos.pname, count(emp.no) as cnt
from pos, emp where pos.pcode = emp.pcode
group by pos.pname 
order by pos.pname; 

-- 집계함수 : count, sum, avg, max, min

-- 정렬하여 출력 : order by 컬럼명;
-- 반드시 order by 구절은 맨 끝에다 지정해야하며, 출력되는 항목이어야 함
select * from emp order by name desc;   -- desc:내림차순, 생략 또는 asc:오름차순

-- 집합연산시에는 연산하는 두 개의 테이블의 구조가 같거나
-- 연산하는 컬럼타입이 같아야 함.
-- 집합연산 UNION(합집합), INTERSECT(교집합), MINUS(차집합) 
create view uni_view as 
(select no, pcode from emp union select no, pcode from emp2);
select * from uni_view;
create view int_view as 
(select * from emp intersect select * from emp2);
select * from int_view;

create view min_view1 as 
(select * from emp minus select * from emp2);
create view min_view2 as 
(select * from emp2 minus select * from emp);
select * from min_view1;
select * from min_view2;