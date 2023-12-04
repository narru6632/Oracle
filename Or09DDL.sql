/*
파일명 : Or09DDL.sql
DDL : Data Definition Language(데이터 정의어)
설명 : 테이블 뷰와 같은 객체를 생성 및 변경하는 쿼리문을 말한다

*/

--@@@@system계정으로 시작@@@
--새로운 계정을 생성한 후  접속 권한과 테이블생성 권한등을 부여한다

--Oracle 21c 이상부터는 계정 생성전 해당 명령을 실행해야한다.
alter session set "_ORACLE_SCRIPT" = true; --Seesion이 변경되었습니다

--study 계정을 생성하고, 패스워드를 1234로 부여한다
create user study identified by 1234; --User STUDY가 생성되었습니다

--생성한 계정에 몇가지 권한을 부여한다.
grant connect, resource to study; -- Grant를 성공했습니다(study에 연결할 권리)

--화면 11시 녹색 십자가 눌러서 계정생성

----------------------------------------------------------------------------

--@@@@Study계정에 연결한 후 진행@@@@

-- 모든 계정에 존재하는 논리적 테이블(dual)
select * from dual;

-- 해당 계정에 생성된 테이블의 목록을 저장한 시스템 테이블
-- 이와 같은 테이블을 "데이터 사전"이라고 한다
select * from tab; -- 아직 dual제외 다른 테이블이 없으므로 보이는게 없음


/*
테이블 생성하기
형식] create table 테이블명 {
        컬럼명1 자료형,
        컬럼명2 자료형,
        ........
        primary key(컬럼명)등의 제약조건 추가
     );
*/
create table tb_number(
    idx number(10), -- 10자리의 정수를 표현
    userid varchar2(30), -- 문자형으로 30byte 저장가능
    passwd varchar2(50), -- 암호화 하므로 넉넉히
    username varchar2(30),
    mileage number(7,2) -- 실수표현 전체7자리 소수점 2자리
 );
-- 현재 접속한 계정에 생성된 테이블 목록을 확인한다
select * from tab;

-- 테이블의 구조(스키마) 확인. 컬럼명, 자료형, 크기 등을 확인한다.
desc tb_number;

/*
기존 생성된 테이블에 새로운 컬럼 추가하기
    -> tb_member 테이블에 email 컬럼을 추가하시오.
    형식]
    alter table 테이블명 add 추가할컬럼 자료형(크기) 제약조건;
*/
alter table tb_number add email varchar2(100);
desc tb_number;

/*테이블 컬럼 삭제하기
alter table 테이블명 drop column 컬럼명;
*/
alter table tb_number draop column mileage;
desc tb_number;

/*
기존 생성된 테이블의 컬럼 수정하기
    -> tb_number 테이블의 email 컬럼의 사이즈를 200으로 축소하시오
    또한 이름이 저장되는 user_name 컬럼도 60으로 확장하시오
    형식[alter table 테이블명 motify 수정할 컬럼명 자료형(크기)
*/
alter table tb_number modify email varchar2(200);
alter table userid modify email varchar2(60);

/*
테이블 복붙생성
*/
create table employees(
employee_id	number(6,0),
first_name	varchar2(20 byte),
last_name	varchar2(25 byte),
email	varchar2(25 byte),
phone_number	varchar2(20 byte),
hire_date	date,
job_id	varchar2(10 byte),
salary	number(8,2),
commission_pct	number(2,2),
manager_id	number(6,0),
department_id	number(4,0)
);
desc employees;

/*
테이블 삭제하기
    -> employees 테이블은 더이상 사용하지 않으므로 삭제하시오.
    형식] drop table 삭제할 테이블명 
*/
select * from tab; -- 테이블 확인
--테이블 삭제
drop table employees;
drop table empolyees;
select * from tab; 
-- 삭제 후 테이블 목록에서는 보이지 않습니다.(휴지통에 들어간 상태)
-- 다른명령 실행해해도 '객체가 존재하지 않습니다' < 에러발생

/*
tb_number 테이블에 새로운 레코드를 삽입한다.(DML부분에서 학습할 예정)
하지만 테이블 스페이스라는 권한이 없어서 삽입할 수 없는 상태이다
*/

insert into tb_number values
    (1, 'hong', '1234', '홍길동', 'hong@naver.com'); 
    -- 테이블스페이스 users 권한 없어 에러

/*
오라클11g에서는 새로운 계정을 생성한 후 connect, resource를 
(Role)만 부여하면 테이블 생성 및 삽입까지 가능하나,
그 이후 버전에서는 테이블 스페이스 관련 오류가 발생한다.
따라서 아래와 같이 테이블 스페이스에 대한 권한도 부여해야 한다.
해당 명령은 system계정으로 접속한 후 실행해야 한다
*/
--system계정으로 전환 후
grant unlimited tablespace to study;
--study계정으로 전환하여 권한 확인
insert into tb_number values
    (1, 'hong', '1234', '홍길동', 'hong@naver.com'); --성공
insert into tb_number values
    (2, 'yu', '9876', '유비', 'yu@hanmail.com');
--삽입된 레코드 확인
select * from tb_number;

/*
테이블 복사 1 - 속성과 레코드까지 모두 복사하기
select문을 기술할때 where 절이 없으면 모든 레코드를 출력하라는 명령
아래에서는 모든 레코드를 가져와서 복사본 테이블을 생성 - 즉, 레코드까지 복사한다
*/
create table tb_number_copy
    as
    select * from tb_number;
desc tb_number_copy; -- 확인
select * from tb_number_copy;

/*
테이블 복사 2 - 레코드를 제외한 테이블 구조(속성)만 복사
*/

create table tb_number_empty
    as
    select * from tb_number where 1=0;
desc tb_number_empty; -- 확인
select * from tb_number_empty;
/*
DDL 문 : 테이블을 생성 및 조작하는 쿼리문
(Date Definition Language : 데이터 정의어)
    테이블생성 : create table 테이블명
    테이블수정
        - 컬럼추가 : alter table 테이블명 add 컬럼명
        - 컬럼수정 : alter table 테이블명 modify 컬럼명
        - 컬럼삭제 : alter table 테이블명 drop column 컬럼명
    테이블삭제 : drop table 테이블명
*/






--연습문제 
-- study 계정으로 하시오.
/*
1. 다음 조건에 맞는 “pr_dept” 테이블을 생성하시오.
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
*/
create table pr_dept(
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
);

select * from pr_dept;


/*
2. 다음 조건에 맞는 “pr_emp” 테이블을 생성하시오.
    eno number(4),
    ename varchar2(10),
    job varchar2(30),
    regist_date date
*/
create table pr_emp(
    eno number(4),
    ename varchar2(10),
    job varchar2(30),
    regist_date date
    );
select * from pr_emp;
desc pr_emp;

/*
3. pr_emp 테이블의 ename 컬럼을 varchar2(50) 로 수정하시오.
*/
alter table pr_emp modify ename varchar2(50);
desc pr_emp;

/*
4. 1번에서 생성한 pr_dept 테이블에서 dname 칼럼을 삭제하시오.
*/
alter table pr_dept drop column dname;
desc pr_dept;



/*
5. “pr_emp” 테이블의 job 컬럼을 varchar2(50) 으로 수정하시오.
*/

alter table pr_emp modify job varchar2(50);
desc pr_emp;

