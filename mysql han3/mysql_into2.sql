use kh;

show tables;

select * from member;
select * from book;
select * from sales;

-- select를 활용한 update safe mode =>
-- 아래의 내용을 수정하고, MYSQL 서버를 재시작하게 되면  
-- c:\programData\MySQL Server 8.0\my.ini
-- [mysqld]
-- select를 활용한 update safe mode =>
-- set SQL_SAFE_UPDATES = 0; -- update시 검색하여 갱신하는 
-- set SQL_SAFE_UPDATES = 1; -- update시 검색하여 갱신하는 
-- SQL 실행시 자동 커밋 =>
-- set AUTOCOMMIT = FALSE;
-- set AUTOCOMMIT = TRUE;

-- WorkBench에서 해당 내용을 설정하고 싶다면, SEY 명령에 해당 옵션에 설정하면 된다.
-- SET SQL_SAFE_UPDATES = 0;
-- SET AUTOCOMMIT = FALSE;  : 트랜젝션 처리가 필요한 경우 반드시 OFF(FALSE) 이어야 함

-- 1) 회원 테이블에 다음과 같은 내용을 추가하시오.								
	insert into member values('kkt','a1004','김기태',	'가산동 123',	'010-1004-1004', '2023-09-12');						
-- 2) 도서 테이블에 다음 데이터를 추가하시오.							
	insert into book values(default, 'IT', '스프링프레임워크',	38000,	8,	'김기태',	'정복사',	'2022-09-10');							
	select count(*) as "인원수" from member;
    select * from book;
-- 3) 판매 테이블에 다음 튜플(레코드)을 추가하시오.
	insert into sales values(default, 1, 'kkt', 2, null, now());
    select * from sales;
    update sales set money=(select bookprice from book where bookid = sales.bno)*amount where sno =19;
-- 4) 회원 테이블에 기본값이 0인 숫자 데이터를 저장할 포인트(pt) 컬럼을 추가하시오.
	alter table member add pt int default 0;
    select * from member;
-- 5) 회원 테이블에 방문횟수(visited) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
	alter table member add visited int default 0;
-- 6) 회원 테이블에 이메일(email) 컬럼을 추가하시오(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
	alter table member add email varchar(200);
-- 7) 회원 테이블에 지역코드(areacode) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
    alter table member add areacode varchar(8);
-- 8) 회원 테이블에 있는 컬럼 중에서 방문횟수 컬럼을 제거하시오.
	alter table member drop column visited;
-- 9) 회원 테이블에 지역(areacode) 컬럼의 이름을 areadata 로 변경하시오.
	alter table member rename column areacode to areadata;
-- 10) 판매(sales) 테이블을 복제하여 판매2(sales2) 테이블을 만드시오.
	create table sales2 as select * from sales; 
-- 11) 도서 테이블을 복제하여 도서2(book2) 테이블을 만드시오.
	create table book2 as select * from book;
-- 12) 회원 테이블을 복제하여 회원2(member2) 테이블을 만드시오.
	create table member2 as select * from member;
-- 13) 판매2(sales2) 테이블을 제거하시오.
	drop table sales2;
-- 14) 복제된 회원2(member2) 테이블에서 아이디가 j가 포함된 회원을 삭제하시오.
	delete from member2 where id like '%j%';
    select count(*) from member2;
-- 15) 회원(member) 테이블에서 모든 회원에 대한 포인트를 100 이 지급될 수 있도록 변경하시오.
	update member set pt=pt+100;
-- 16) 회원(member) 테이블에서 회원의 아이디가 lsh인 회원의 주소를 '도화동 27'로 변경하시오.
	update member set address='도화동 27' where id='lsh';
-- 17) 회원2(member2) 테이블에서 연락처가 02인 회원에 대하여 가입일을 오늘날짜로 변경하시오.
-- curdate() : 날짜만 들어감
	update member2 set reg_date=curdate() where tel like '02%';
-- 18) 도서2(book2) 테이블에서 도서 분류가 HC인 레코드에 대하여 도서 수량을 5로 변경하시오.
	update book2 set bookcount=5 where bookkind='HC';
-- 19) 도서2(book2) 테이블에서 도서 분류가 TC인 튜플을 제거하시오.
	delete from book2 where bookkind='TC';
-- 20) 도서2(book2) 테이블에 도서상태(ckdata) 컬럼을 추가하시오.(컬럼타입 및 제약조건 등은 본인이 판단하여 할 것.)
	alter table book2 add column ckdata varchar(40); 
-- 21) 도서2(book2) 테이블에 도서 수량이 7이하인 튜플에 대하여 도서상태를 '재입고요망' 으로 내용을 추가하시오.
	update book2 set ckdata='재입고요망' where bookcount<=7;
-- 22) 회원2(member2) 테이블에 id를 기본키로 추가하시오. 
	alter table member2 add constraint mpkey1 primary key (id);
    desc member2;
-- 23) 도서2(boo2) 테이블에 도서코드(bookid)를 기본키로 도서분류(bookkind)를 외래키로 추가하시오.
	alter table book2 add constraint bpkey1 primary key (bookid);
    desc book2;
    -- 참조하는 테이블이 존재해야 하므로 임의의 테이블 bookkind(kindcode, kindname)
    drop table bookkind;
    create table bookkind(kindcode varchar(6) primary key, kindname varchar(50));
    insert into bookkind values('IT', '컴퓨터관련서적');
    insert into bookkind values('MV', '대중소설');
	insert into bookkind values('DV', '자기개발서적');
    insert into bookkind values('HC', '역사서적');
    insert into bookkind values('TC', '일반상식서적');
    select * from bookkind;
    -- 외래키 설정
    alter table book2 add constraint bfkey1 foreign key (bookkind) references bookkind(kindcode);
-- 24) 도서2(book2) 테이블에서 출판일(pubdate)가 2022년 8월 인 데이터의 수량을 5씩 더 증가시키시오.
	update book2 set bookcount=bookcount+5 where pubdate between '2022-08-01' and '2022-08-31'
-- 25) 회원(member) 테이블에서 모든 회원의 모든 정보를 조회하시오.
	select * from member;
-- 26) 판매(sales) 테이블에서 구매한 적이 있는 회원의 아이디를 중복을 제거하여 조회하시오.
	select distinct id, name, tel from member where id in(select id from sales);
-- 27) 도서(book) 테이블에서 도서종류(bookkind)가 IT인 튜플을 검색하시오.
	select * from book where bookkind='IT';
-- 28) 회원(member) 테이블에서 아이디가 k가 포함된 회원의 이름(name),  연락처(tel) 컬럼을 검색하시오.
	select name, tel from member where id like '%k%';
-- 29) 판매(sales) 테이블에서 수량(amount)이 2이상인 레코드를 검색하시오.
	select * from sales where anount >= 2;
-- 30) 도서(book) 테이블에서 단가(bookprice)가 19000이상 30000이하인 데이터의 도서명(booktitle), 
-- 도서가격(bookprice), 저자(author) 를 조회하시오.
	select booktitle,bookprice,author from book where bookprice between 19000 and 30000;
-- 31) 도서(book) 테이블에서 출판사(pubcom)이 한빛미디어 이거나 남가람북스인 튜플의 도서명(booktitle),
-- 저자(author), 수량(bookcount)를조회하시오.
	select booktitle, author, bookcount from book where pubcom='한빛미디어' or pubcom= '남가람북스';
    select booktitle, author, bookcount from book where pubcom in('한빛미디어', '남가람북스');
-- 32) 도서(book) 테이블에서 출판일(pubdate)이 2022년인 튜플을 검색하시오.
	select * from book where pubdate between '2022-01-01' and '2022-12-31';
-- 33) 회원(member) 테이블에서 비밀번호(password)가 5글자 이상인 회원의 아이디(id), 이름(name), 주소(tel)을 검색하시오.
	select id, name, tel from member where length(password) >=5 ; 
-- 34) 도서(book) 테이블에서 출판일(pubdate)을 기준으로 오름차순하여 검색하되 출판일(pubdate)이
-- 같은 경우 도서코드(bookid)의 내림차순으로 하시오.
	select * from book order by pubdate asc, bookid desc;
-- 35) 도서(book) 테이블에서 도서의 수량(bookcount)가 10권 미만인 튜플에 대하여 도서분류(bookkind),
-- 도서명(booktitle), 출판사(pubcom) 을 검색하되 그 결과가 저자(author)의 오름차순으로 정렬하여 표시되도록 하시오.
	select bookkind, booktitle, pubcom from book where bookcount<10 order by author asc limit 1;
-- 36) 도서(book) 테이블에서 도서분류(bookkind)가 IT, NV, TC가 아닌 레코드의 도서코드(bookid), 
-- 도서명(booktitle), 저자(author) 를 검색하되 그 결과가 출판일을 기준으로 내림차순되어 표시되도록 하시오.
	select bookid,booktitle,author from book where bookkind not in('IT', 'TC', 'NV') order by pubcom desc ;
-- 36) 판매(sales) 테이블의 전체 구매 건수를 출력하되 표시되는 컬럼명은 구매건수로 출력될 수 있도록 조회하시오.
	select count(*) as "구매건수" from sales; 
-- 37) 판매(sales) 테이블의 회원별 구매 건수를 출력하되 회원아이디(id)와 구매건수를 표시하되 컬럼명은 
-- cnt 하며, cmt가 2이상인 레코드만 검색되도록 회원아이디(id)의 오름차순 정렬되어 표시되도록 하시오.
	select id, count(*) as 'cnt' from sales group by id having cnt>=2 order by id;
-- 38) 판매(sales) 테이블의 도서별 판매금액의 합계를 구하여 표시하되, 도서코드(bno), 판매금액합계 로 출력되게 하시오.
	select bno, sum(money) as "판매금액합계" from sales group by bno;
    -- 도서이름을 알고자할때 (다른테이블 book에 있을때)
    select b.bno, a.booktitle, sum(b.money) as "판매금액합계" 
    from book a inner join sales b on a.bookid=b.bno group by b.bno, a.booktitle;
    -- 연관 커리alter
    select b.bno, a.booktitle, sum(b.money) as "판매금액합계" 
    from book a, sales b where a.bookid = b.bno group by b.bno, a.booktitle;
    
    select * from member, book; --  member 11, book :10 =>product(*) 110건 (cardinality)
    
-- 39) 판매(sales) 테이블에서 가장 큰 판매금액을 출력하되, 회원아이디(id), 도서코드(bno), 판매금액이 표시되도록 하시오.
	select id, bno, max(money) as "최대판매금액" from sales group by id, bno;
-- 40) 회원(member) 테이블에서 가입일별 인원수를 구하여 출력하되, 가입일 오름차순으로 출력되도록 하시오.
	select reg_date, count(*) as "인원수" from member group by reg_date order by reg_date asc;
-- 41) 도서(book) 테이블에서 도서수량(bookcount)가 남은 수량이 적은 것을 기준으로 5위권까지 모든 도서 정보가 출력되도록 하시오.
	select * from book order by bookcount asc limit 5;
-- 42) 판매(sales) 테이블에서 판매금액(money)가 큰 순으로 3위 까지인 튜플의 판매코드(sno), 도서코드(bno), 회원아이디(id)가 출력될 수 있도록 하시오.
	select sno, bno, id from sales order by money desc limit 3;
-- 43) 회원 뷰(mem_view)를 생성하되 회원2(member2) 테이블을 활용하고, 회원 데이터 중에서 가입일을 기준으로 2022년 09월 이후에 가입한 회원을 대상으로 하시오.
	create view mem_view as select * from member2 where reg_date>='2022-09-01';
-- 44) 판매 뷰(sales_view)를 생성하되 판매2(sales2) 테이블을 활용하고, 판매코드(sno), 도서코드(bno), 아이디(id), 판매금액(money) 컬럼만 추출되어 생성되게 하시오.
	create view sales_view as select sno, bno, id, money from sales2;
-- 45) 도서 뷰(book_view)를 생성하되 도서2(book2) 테이블을 활용하고, 도서 데이터 중에서 
-- 도서분류(bookkind)가 'IT', 'TC', 'HC' 인 데이터를 대상으로 하며, 컬럼은 
-- 도서분류(bookkind), 도서명(booktitle), 도서가격(bookprice), 출판사(pubcom) 만으로 구성되게 하시오.
	create view book_view as select bookkind,booktitle,bookprice,pubcom from book2
    where bookkind in('IT', 'TC', 'HC');
-- 46) 도서 뷰(book_view)에서 도서가격(bookprice)가 현재 가격에서 10% 인상이 될 수 있도록 데이터를 갱신하시오.
	update book_view set bookprice = bookprice*1.1; -- book2 의'IT', 'TC', 'HC' 10프로증가한다.
    select * from book2;
-- 47) 판매 뷰(sales_view)를 편집하되 기존 select 구문에서 수량(amount) 가 2이상인 조건을 추가되게 하시오.
	-- 뷰의 문장을 수정하는 것이기 때문에 create or replace 사용해야함
    select * from sales_view;
    create or replace view sales_view as select * from sales2 where amount>=2;
-- 48) 회원 뷰(mem_view)에서 아이디(id)가 y로 끝나는 회원의 데이터를 삭제하시오.
	delete from mem_view where id like '%y';
    select * from member2;
-- 49) 판매 뷰(sales_view) 를 제거하시오.
	drop view sales_view;
-- 50) 판매 뷰(sales_view) 를 제거하시오.
	drop view sales_view;
-- mariaDB MySQL은 시퀀스 개념이 사용되지 않는다. 또한 사용하려면 별도로 설치가 필요함
-- 51) 상반기 판매순번 시퀀스(sd_seq)를 만들되 1부터 1씩 증가하도록 생성하시오.
	-- create sequence sd_seq start with 1 increment
-- 52) 상반기 판매순번 시퀀스(sd_seq)를 시작값이 6부터 될수 있도록 수정하시오.
-- 53) 상반기 판매순번 시퀀스(sd_seq)의 현재값이 조회될 수 있도록 하시오.
-- 54) 상반기 판매순번 시퀀스(sd_seq)를 제거하시오.

-- 55) 서브쿼리를 이용하여 구매한 적이 있는 (판매 테이블에 있는) 회원의 이름(name)을 중복성을 제거하여 조회하시오.
	select distinct name from member where id in(select distinct id from sales);
-- 56) 서브쿼리를 이용하여 판매되지 않은 (판매 테이블에 있는) 도서의 정보를 조회하시오.
	select * from book where bookid not in (select bno from sales);
-- 57) 서브쿼리를 활용하여 판매 테이블에서 판매금액의 평균이상인 모든 컬럼을 조회하시오.
	select * from sales where money>=(select avg(money) from sales);
-- 58) 내부조인을 활용하여 구매한 회원의 id, name, tel을 조회
	select a.id, a.name, a.tel from member a inner join sales b on a.id = b.id;
-- 59) 내부조인을 활용하여 구매한 e도서의 bookid, bookname, amout, money 를 조회
	select a.bookid, a.booktitle, sum(b.amount) as "총판매수수량합계", sum(b.money) as "총판매금액"
    from book a inner join sales b on a.bookid=b.bno 
    group by a.bookid, a.booktitle order by a.bookid asc;
-- 60) 외부조인을 활용하여 판매되지 않은 도서의 도서명(booktitle), 도서가격(bookprice), 저자(author) 을 조회하시오.
	-- 판매되지 않은 항목
	select distinct booktitle, author, booktitle from book where bookid not in(select bno from sales);
    -- 판매된 항목 : 교집합
    select distinct a.booktitle, a.bookprice, a.author from book a, sales b
    where a.bookid= b.bno;
    
    -- 팔리지 않은 항목 차집합
    select distinct a.booktitle, a.author, a.booktitle from book a left outer join sales b on
    a.bookid= b.bno where b.bno is null;
    
    -- 연관쿼리
	select distinct a.booktitle, a.author, a.booktitle 
    from book a, sales b where a.bookid = b.bno ;
    
    -- 연관쿼리 
	select distinct a.booktitle, a.author, a.booktitle 
    from book a where not exists(
    select 1 from sales b where a.bookid=b.bno
    );
    
    
    -- 판매되지 않은 항목
    -- except : 차집합
    select distinct a.booktitle, a.author, a.booktitle from book a left outer join sales b on
    a.bookid= b.bno
    except
    select distinct a.booktitle, a.author, a.booktitle from book a right outer join sales b on
    a.bookid= b.bno;
    -- union : 합집합
	select distinct a.booktitle, a.author, a.booktitle from book a left outer join sales b on
    a.bookid= b.bno
	union
    select distinct a.booktitle, a.author, a.booktitle from book a right outer join sales b on
    a.bookid= b.bno;
	
-- 60) 외부조인을 활용하여 구매한 적이 없는 회원의 회원아이디(id), 회원명(name) 을 조회하시오.
	select distinct id, name from member where id not in(select distinct id from sales);
    
    -- join
    select distinct a.id, a.name from member a left join sales b on a.id=b.id where b.id is null;
    
    -- 연관쿼리
    select a.id, a.name from member a where not exists (select 1 from sales b where a.id=b.id);
    select * from sales;
    select * from member;
    
    
-- 61) 판매(sales)와 판매2(sales2) 테이블을 합집합하여 종합 판매 뷰(tot_sales_view)를 생성하시오. 
create view tot_sales_view as select * from sales union select * from sales2;
-- 62) 회원(member)와 회원2(member2) 테이블을 교집합하여 중복회원 뷰(cross_mem_view)를 생성하시오. 
create view cross_mem_view as select a.id, a.password, a.name, a.address from member a, member b where a.id=b.id;
-- 63) 도서(book)와 도서2(book2) 테이블을 차집합하여 도서(book)에만 있는 도서 뷰(minus_book_view)를 생성하시오. 
  -- 안나옴 create view minus_book_view as select * from book except select * from book2;
  
  create view minus_book_view as select bookid, bookkind, booktitle, bookcount 
  from book where bookid not in(select distinct bookid from book2);
  select * from minus_book_view;
  drop view minus_book_view;
  create view minus_book_view as select a.bookid, a.bookkind, a.booktitle, a.bookcount 
  from book a left join book2 b on a. bookid = b.bookid where b.bookid is null;
  
  
  
  select * from member limit 5,3;
    select * from book2;
    select * from member2;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    