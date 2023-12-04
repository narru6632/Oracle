/*
파일명 : Or12SubQuery.sql
서브쿼리
설명 : 쿼리문 안에 또 다른 쿼리문이 들어가는 형태의 select문
    (where구에 select문을 사용하면 서브쿼리라고 한다)
HR계정으로 하기
*/

/*
단일행 서브쿼리
    단 하나의 행만 반환하는 서브쿼리로 비교연산자(=,<,<=,>, >=, <>)를 사용한다
    형식] select * from 테이블명 where 컬럼 =(
            select 컬럼 from 테이블명 where 조건
            );
            @@괄호 안의 서브쿼리는 반드시 하나의 결과를 인출해야한다.
*/
/*
시나리오] 사원테이블에서 전체사원의 평균급여보다 낮은 급여를 받는 사원들을
    추출하여 출력하시오.
    출력항목 : 사우너번호, 이름, 이메일, 연락처, 급여
*/
-- 1.평균급여 구하기 : 6462(반올림) 
select avg(salary) from employees;

-- 2.해당쿼리문은 문맥상 맞는 듯 하지만 그룹함수(avg)를 단일행에 적용한
-- 잘못된 쿼리문 << 오류발생
select * from employees where salary < avg(salary); -- 그룹함수라 에러

-- 3.앞에서 구한 평균급여를 조건으로 select문을 작성
select * from employees where salary < 6462; --avg와 같은값이지만 그룹하수아니라 실행

-- 4. 2개의 쿼리문을 하나의 서브쿼리문으로 합쳐서 결과 확인
select employee_id, first_name, email, phone_number, salary
    from employees where salary < (select avg(salary) from employees)
    order by salary;
    
/*
퀴즈] 전체사원 중 급여가 가장 적은 사원의 이름과 급여를 출력하는 서브쿼리문을
    작성하시오.
    출력항목 : 이름1, 이름2, 이메일, 급여
*/
-- 1단계 : 최소급여를 확인한다.
select min(salary) from employees;

-- 2단계 : 2100$를 받는 직원의 정보를 인출하시오
select * from employees where salary=2100;

-- 3단계 : 두개의 쿼리를 합쳐서 서브쿼리를 만드시오
select * from employees where salary=(
    select min(salary) from employees);
    
/*
시나리오] 평균급여가 많은 급여를 받는 사원들의 명단을 조회할 수 있는 
    서브쿼리문을 작성하시오
    출력내용 : 이름1, 이름2, 담당업무명, 급여
    @담당업무명은 jobs 테이블에 있으므로 join 해야한다
*/

--1단계 : 평균급여환산
select avg(salary) from employees; -- 반올림시 6462

--2단계 : 테이블 join / 담당업무명
select first_name, last_name, job_title, salary
    from employees inner join jobs using(job_id)
    where salary > 6462;
    
--3단계 : 서브쿼리문으로 병합
select first_name, last_name, job_title, salary
    from employees inner join jobs using(job_id)
    where salary > (select avg(salary) from employees);
    
/*
복수형 서브쿼리 : 다중행 서브쿼리라고도 함, 여러개의 행을 반환하는 것으로
    in, any, all, exists를 사용해야 한다
형식] select * from 테이블명 where 컬럼 in (
        selct 컬럼 from 테이블명 where 조건
        );
        @괄호안의 서브쿼리는 두개 이상의 결과를 인출해야 한다
*/
/*
시나리오] 담당업무별로 가장 높은 급여를 받는 사원의 명단을 조회하시오.
    출력목록 : 사원아이디, 이름, 담당 업무 아이디, 급여
*/
--1단계 : 담당업무별 가장 높은 급여를 확인한다
select job_id, max(salary) from employees group by job_id; 

--2단계 : 위의 결과를 단순한 or 조건으로 묶어보기
--19개의 결과가 인출되지만 3개정도만 기술해본다
select * from employees where 
    (job_id ='SH_CLERK'and salary=4200) or
    (job_id ='AD_ASST'and salary=4400) or
    (job_id = 'MK_MAN' and salary=13000); -- 쌩노가다 + 코드길어져서 비추천
    
--3단계 : 복수형 연산자를 통해 서브쿼리로 병합하기
select employee_id, first_name, job_id, salary from employees
    where (job_id, salary) 
    in (select job_id, max(salary) from employees group by job_id)
    order by salary; 
    
/*
복수형 연산자 : any(어느것이라도, 개념은 or와 비슷)
        메인쿼리의 비교조건이 거브쿼리의 검색결과와 하나이상
        일치하면 참이 되는 연산자
        = 조건 중 하나만 일치해도 레코드를 인출
*/
/*
시나리오] 전체 사원중에서 부서번호가 20인 사원들의 급여보다 높은 급여를
    받는 직원들을 인출하는 서브쿼리문을 작성하시오.
    단 둘 중 하나만 만족하더라도 인출하시오.
*/
--1단계 : 20부서의 급여를 확인한다
select first_name, salary from employees where department_id = 20;
--2단계 : 1번의 결과를 단순한 or절로 작성해본다
select first_name, salary from employees
    where salary > 1300 or salary >6000;
--3단계 : 둘 중 하나만 만족하면 되므로 복수행연산자 any를 이용해서
--    서브쿼리를 만들면 된다.
select first_name, salary from employees
    where salary>any(
    select salary from employees where department_id = 20); 
/*
    결과적으로 6000보다 크면 조건에 만족한다 > 결과 55명
*/



/*
복수행 연산자2 : all은 and의 개념과 유사
    메인쿼리는 비교조건이 서브쿼리의 검색결과와 모두 일치해야 
    레코드를 인출함(교집합)
*/
/*
시나리오] 전체 사우너중에서 부서번호가 20인 사원들의 급여보다 높은 급여를 받는 
        직원들을 인출하는 서브쿼리문을 작성하시오, 단 둘다 만족하는
        레코드만 인출하시오
*/
select first_name, salary from employees
    where salary>all(
       select salary from employees where department_id = 20
       );
       
       
/*
rownum : 테이블에서 레코드를 조회한 순서대로 순번이 부여되는 가상의 컬럼을
    말한다. 해당 컬럼은 모든 테이블에 논리적으로 존재함(인덱스 느낌)
*/
 -- 모든 계정에 논리적으로 존재하는 테이블
 select * from dual;
 -- 레코드의 정렬없이 모든 레코드를 가져와서 rownum으로 부여함
 -- 이 경우 rownum은 순서대로 출력됨
 select employee_id, first_name, rownum from employees;        
 -- 이름의 오름차순으로 정렬하면 rownum이 섞여서 이상하게 나온다
 select employee_id, first_name, rownum from employees order by first_name;
 
 /*
 rownum을 우리가 정렬한 순서대로 재 부여하기위해 서브쿼리를 사용한다
 from절에는 테이블이 들어와야 하는데 아래의 서브쿼리에서는 사원테이블의 
 전체 레코드를 대상으로 하되 이름의 오름차순으로 정렬된 상태로 레코드를
 가져와서 테이블처럼 사용한다.
 */
 select first_name, rownum from (select * from employees order by first_name);
 -- oderby를 서브쿼리를 통해  적용해주면 rownum이 섞이지 않음
 
 
 
 --------------------------------------------------------
--------------- Sub Query 연 습 문 제 ------------------ 
--------------------------------------------------------

-- scott계정에서 진행합니다. 
/*
01.사원번호가 7782인 사원과 담당 업무가 같은 사원을 표시하시오.
출력 : 사원이름, 담당 업무
*/


/*
02.사원번호가 7499인 사원보다 급여가 많은 사원을 표시하시오.
출력 : 사원이름, 급여, 담당업무
*/


/*
03.최소 급여를 받는 사원번호, 이름, 담당 업무 및 급여를 표시하시오.
(그룹함수 사용)
*/


/*
04.평균 급여가 가장 적은 직급(job)과 평균 급여를 표시하시오.
*/

/*
평균급여는 물리적으로 존재하는 컬럼이 아니므로 where절에는 사용할수없고
having절에 사용해야 한다. 즉, 평균급여가 1017인 직급을 출력하는 방식으로
서브쿼리를 작성해야 한다. 
*/



/*
05.각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
*/


/*
06.담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 
업무가 분석가(ANALYST)가 아닌 사원들을 표시(사원번호, 이름, 담당업무, 급여)
하시오.
*/

/*
ANALYST 업무를 통한 결과가 1개이므로 아래와 같이 단일행 연산자로 서브쿼리를
만들수 있지만, 만약 결과가 2개이상이라면 복수행 연산자 all 혹은 any를 
추가해야한다. 
*/


/*
Ex) 만약 담당업무가 CLERK로 주어졌다면 쿼리는 아래와 같이 해야한다. 
*/



/*
07.이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 
사원번호와 이름, 부서번호를 표시하는 질의를 작성하시오
*/


/*
    or 조건을 in으로 표현할 수 있다. 따라서 서브쿼리에서 복수행 연산자인
    in을 사용한다. 2개 이상의 결과를 or로 연결하여 출력하는 기능을 
    가진다. 
*/


/*
08.부서 위치가 DALLAS인 사원의 이름과 부서번호 및 담당 업무를 표시하시오.
*/


/*
09.평균급여 보다 많은 급여를 받고 이름에 K가 포함된 사원과 같은 
부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오.
*/


/*
10.담당 업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
*/



/*
11.BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 
질의를 작성하시오. (단, BLAKE는 제외)
*/

