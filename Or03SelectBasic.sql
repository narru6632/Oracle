+/*
파일명 : Or03SelectBasic.sql
처음으로 실행해보는 질의어(SQL문 혹은 Query문)
개발자들 사이에서는 '시퀄'이라고 표현하기도 한다
설명 : select, where 등 가장 기본적인 DQL문 사용해보기
*/
--HR 계정으로 하기
/*
SQL Developer 에서 주석 사용하기
    블럭 단위 주석 : 자바와 동일함
    라인 단위 주석 : -- 실행문 (하이푼 두개)
*/

--select문 : 테이블에 저장된 레코드를 조회하는 SQL문으로 DQL문에 해당한다
/*
형식]
    select 컬럼1, 컬럼2, .... 혹은 *
    from 테이블명
    where 조건1 and 조건2 or 조건3
    order by 정렬할 컬럼 asc(오름차순), desc(내림차순);
*/

-- 사원테이블에 저장된 모든 레코드를 대상으로 모든 컬럼을 조회하기
-- (쿼리문은 대소문자를 구분하지 않는다.)
select * from employees;
SELECT * from employees;

/*
컬럼명을 지정해서 조회하고 싶은 컬럼만 조회하기
=> 사원번호, 이름, 이메일, 부서번호만 조회하시오
*/
select employee_id, first_name, last_name, email, department_id
    from employees;  -- 하나의 쿼리문이 끝날 때 ;을 반드시 기술해야한다
    
-- 테이블의 구조와 컬럼별 자료형 및 크기를 출력 
-- 즉 테이블의 스키마를 알 수 있다
desc employees;

-- as는 생략할 수 있다
select employee_id "사원아이디", first_name as "이름", last_name "성"
    from employees where first_name = 'William';

--오라클은 기본적으로 대소문자를 구분하지 않으므로
--예약어의 경우 대소문자 구분없이 사용할 수 있다.
seLecT employee_id "사원아이디", fiRSt_name as "이름", last_name "성"
    FROM EmPLOyees WHERE first_name = 'William';
    
--단, 레코드(데이터값)인 경우 대소문자를 구분한다    
-- 따라서 아래 SQL문을 실행하면 아무런 결과도 나오지 않는다
select employee_id "사원아이디", first_name as "이름", last_name "성"
    from employees where first_name = 'WILLIAM';

/*
where절을 이용해서 조건에 맞는 웹코드 추출하기
-> last_name이 Smith인 레코드를 추출하시오
*/
select * from employees where last_name = 'Smith';

/* and/or 연산자 w: where절에서 둘 이상의 조건이 필요할 때 사용할 수 있다
-> last_name이 Smith이면서 급여가 8,000불인 사원을 추출하시오
*/
--컬럼이 문자형인 경우 싱클쿼테이션(')으로 감싼다, 숫자인경우 생략한다
select * from employees where last_name = 'Smith' and salary = 8000;

--컬럼이 문자형인경우 싱글쿼테이션(')이 없으면 에러발생
--select * from employees where last_name = Smith and salary = 8000;
--컬럼이 숫자형인경우 싱글쿼테이션(')으로 감싸도 에러ㅜ발생 x
select * from employees where last_name = 'Smith' and salary = '8000';

/*
비교연산자를 통한 쿼리문 작성
    :이상, 이하와 같은 조건에 >, <= 와 같은 비교연산자를 사용할 수 있다.
    날짜인경우 이전(미만), 이후(초과)와 같은 조건도 가능하다
*/
-- 급여가 5000미만인 사원의 정보를 추출하시오.
select * from employees where salary < 5000;
-- 입사일이 04년 01월 01일 이후(포함) 사원정보를 추출하시오
select * from employees where Hire_Date >= '04/01/01'; --날짜는 싱글쿼테이션 필요

/*
in 연산자
    : or 연산자와 같이 하나의 컬럼에 여러개의 값으로 조건을 걸고싶을 때
    사용한다. => 급여가 4200, 6400, 8000인 사원의 정보를 추출하시오
*/
--방법1 : or사용, 이떄 컬럼명을 반복적으로 기술해야 하므로 불편하다
select * from employees where salary = 4200 or salary = 6400 or salary = 8000;
--방법2 : in 사용, 컬럼명을 한번만 기술하면 되므로 편리하다
select * from employees where salary in(4200, 6400, 8000);

/*
not 연산자
    : 해당 조건이 아닌 레코드를 추출한다
    -> 부서번호가 50이 아닌 사원정보를 조회하는 SQL문을 작성하시오.
*/
select * from employees where department_id<> 50;
select * from employees where not (department_id = 50);
-- <> = not

/*
between and 연산자
    : 컬럼의 구간을 정해 검색할 때 사용한다.
    => 급여가 4000~8000사이의 사원을 인출하시오.
*/
-- 방법1 and연산자
select * from employees where salary >= 4000 and salary <=8000; -- 검색 2번
-- 방법2 between and 연산자
select * from employees where salary between 4000 and 8000; -- 검색 1번

/*
distinct 연산자
    : 컬럼에서 중복되는 레코드를 제거할 때 사용한다
    특정 조거능로 select 했을 때 하나의 컬럼에서 중복되는 값이 있는 경우
    중복값을 제거한 후 결과를 출력할 수 있다
    -- 담당업무 아이디를 중복을 제거한 후 출력하시오
*/
-- 전체 사원에 대한 담당업무명이 인출
select job_id from employees;
-- 중복된거 빼기
select distinct job_id from employees;

/*
like 연산자
    : 특정 키워드를 통한 문자열을 검색할 때 사용한다
    형식] 컬럼명 like '%검색어%'
    와일드카드 사용법
        % : 모든 문자 / 문자열을 대체함
        EX) D로 시작하는 단어 : D% -> Da, Dea, Daewoo
            Z로 끝나는 단어 : %Z -> aZ, adxZ
            C가 포함된 단어 : %C% => ACd, abCde, Vitamin-C
            
        _ : 하나의 문자를 대체함
        Ex) D로 시작하는 세글자 단어 : D__ -> Dad, Ddd, Dxy
            A가 중간에 들어가는 3글자 단어 : _A_ -> aAa, xAy
*/
-- first_name이 'D'로 시작하는 직원을 검색하시오
select * from employees where first_name like 'D%';
-- first_name이 세번째 문자가 A인 직원을 추출하시오
select * from employees where first_name like '__a%';
-- last_name이 'Y'로 끝나는 직원을 추출하시오
select * from employees where last_name like '%y';
-- 전화번호에 1344가 포함된 직원전체를 추출하시오
select * from employees where phone_number like '%1344%';

/*
레코드 정렬하기(sorting)
    오름차순 정렬 : order by 컬럼명 asc(혹은 생략가능)
    내림차순 정렬 : order by 컬럼명 desc
    
    2개이상의 컬럼으로 정렬해야 할 경우 콤마(,)로 구분해 정렬한다
    단, 이때 먼저 입력한 컬럼으로 정렬된 상태에서 두번째 컬럼이 정렬된다
*/

-- 사원정보테이블에서 급여가 낮은 순서에서 높은 순서로 인출되도록
-- 정렬하여 조회하시오 / 출력할 컬럼 : first_name, salary, emanil, phone_number
select first_name, salary, email, phone_number 
    from employees order by salary asc;
    select first_name, salary, email, phone_number 
    from employees order by salary ;
    
/*
부서번호를 내림차순으로 정렬한 후 해당부서에서 낮은 급여를 
받는 직원이 먼저 출력되도록 하는 sql문을 작성하시오
출력항목 : 사원번호, 이름, 성, 급여, 부서번호
*/
select EMPLOYEE_ID , FIRST_NAME, LAST_NAME, SALARY , DEPARTMENT_ID from employees order by department_id desc, salary;

/*
is null과 is not null
    : 값이 null이거나 null이 아닌 레코드 가져오기.
    컬럼중 null값을 허용하는 경우 값을 입력하지 않으면 
    null값이 되는데 이를 대상으로 select할 때 사용한다.
*/
--보너스율이 없는 사원을 조회하시오
select * from employees where commission_pct is null;
--영업사원이면서 급여가 8000이상인 사원을 조회하시오
select * from employees where commission_pct is not null and salary >=8000;




/***********************
연습문제(scott계정에서 진행합니다.)
************************/
/*
1. 덧셈 연산자를 이용하여 모든 사원에 대해서 $300의 급여인상을 계산한후 
이름, 급여, 인상된 급여를 출력하시오.
*/
select * from emp; -- 전체 사원 확인
select ename "이름",sal "급여",sal+300 "인상된급여" from emp; 

/*
2. 사원의 이름, 급여, 연봉을 수입이 많은것부터 작은순으로 출력하시오. 
연봉은 월급에 12를 곱한후 $100을 더해서 계산하시오.
*/
select ename, sal, (sal*12+100) "연봉" from emp;
--정렬시 물리적으로 존재하는 컬럼명을 사용하는게 기본
select ename, sal, (sal*12+100) "연봉" from emp order by sal desc;
--물리적으로 존재하지 않은 컬럼이라면 계산식 그대로를
--orderby 절에 기술한다
select ename, sal, (sal*12+100) "연봉" from emp order by "연봉" desc;


/*
3. 급여가  2000을 넘는 사원의 이름과 급여를 내림차순으로 정렬하여 출력하시오
*/
select ename, sal from emp where sal>2000 order by sal desc;

/*
4. 사원번호가  7782인 사원의 이름과 부서번호를 출력하시오.
*/
select ename, deptno from emp where mgr = 7782;


/*
5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력하시오.
*/
select ename, sal from emp where sal not between 2000 and 3000;


/*
6. 입사일이 81년2월20일 부터 81년5월1일 사이인 사원의 이름, 
담당업무, 입사일을 출력하시오.
*/
select ename, job, hiredate from emp where hiredate between '81/2/20' and '81/5/1';


/*
7. 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 
기준(내림차순)으로 출력하시오
*/
select ename, deptno from emp where deptno in(20,30) order by ename desc;

/*
8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 
사원의 이름, 급여와 부서번호를 출력하되 이름순(오름차순)으로 출력하시오
*/
select * from emp;
select ename, sal, empno from emp where sal between 2000 and 3000 order by ename;
    
/*
9. 1981년도에 입사한 사원의 이름과 입사일을 출력하시오. (like 연산자와 와일드카드 사용)
*/  
select * from emp;
select ename, hiredate from emp where hiredate like'81%';

/*
10. 관리자가 없는 사원의 이름과 담당업무를 출력하시오. 
*/
select * from emp;
select ename, job from emp where comm is null order by job;


/*
11. 커미션을 받을수 있는 자격이 되는 사원의 이름, 급여, 커미션을 
출력하되 급여 및 커미션을 기준으로 내림차순으로 정렬하여 출력하시오.
*/
select ename, sal, comm from emp order by sal desc, comm desc;

/*
12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.
*/
select ename from emp where ename like'__R%';

/*
13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.
*/
select ename from emp where 
(ename like'%A%' and ename like'%E%');


/*
14. 담당업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이면서 급여가 
$1600, $950, $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오. 
*/
select ename, job, sal from emp where 
    job in('CLERK', 'SALESMAN') and
    sal not in (1600, 950, 1300);
    


/*
15. 커미션이 $500 이상인 사원의 이름과 급여 및 커미션을 출력하시오. 
*/
select * from emp;
select ename, sal, comm from emp where comm>=500;