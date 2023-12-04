/*****************
파일명 : Or12SubQuery.sql
서브쿼리
설명 : 쿼리문 안에 도 다른 쿼리문이 들어가는 형태의 select문
    where구에 select문을 사용하면 서브쿼리라고 한다.
*******************/
-- HR 계정으로 하기

/*
단일행 서브쿼리
    단 하나의 행만 반환하는 서브쿼리로 비교연산자(=, <, <=, >, >=, <>)를 
    사용한다.
    형식] 
        select * from 테이블명 where 컬럼=(
            select 컬럼 from 테이블명 where 조건
        );
    * 괄호안의 서브쿼리는 반드시 하나의 결과를 인출해야 한다.
*/
/*
시나리오] 사원테이블에서 전체사원의 평균급여보다 낮은 급여를 받는 사월들을
    추출하여 출력하시오.
    출력항목 : 사원번호, 이름, 이메일, 연락처, 급여
*/
-- 1.평균 급여 구하기 : 6462
select avg(salary) from employees;
-- 2.해당 쿼리문은 문맥상 맞는 듯하지만 그룹함수를 단일행에 적용한 
-- 잘못된 쿼리문이다. 오류가 발생한다.
select * from employees where salary < avg(salary);
-- 3.앞에서 구한 평균 급여를 조건으로 select문을 작성하시오.
select * from employees where salary<6462;
-- 4.2개의 쿼리문을 하나의 서브쿼리문으로 합쳐서 결과를 확인한다.
select employee_id, first_name, email, phone_number, salary
 from employees where salary<(
    select avg(salary) from employees)
 order by salary;

/*
퀴즈] 전체 사원중 급여가 가장작은 사원의 이름과 급여를 출력하는 
    서브쿼리문을 작성하시오.
    출력항목 : 이름1, 이름2, 이메일, 급여
*/
-- 1단계 : 최소급여를 확인한다.
select min(salary) from employees;
-- 2단계 : 2100을 받는 직원의 정보를 인출하시오.
select * from employees where salary=2100;
-- 3단계 : 2개의 쿼릴 합쳐서 서브쿼리를 만든다.
select * from employees where salary=(
   select min(salary) from employees);
   
/*
시나리오] 평규급여가 많은 급여를 받는 사원들의 명단을 조회할 수 있는
    서브쿼리문을 작성하시오.
    출력내용 : 이름1, 이름2, 담당업무명, 급여
    * 담당업무명은 jobs 테이블에 있으므로 join 해야 한다.
*/
-- 1단계 : 평균급여 환산하기
select round(avg(salary)) from employees;
-- 2단계 : 테이블 조인
select
    first_name, last_name, job_title, salary
 from employees inner join jobs using(job_id)
 where salary>6462;
-- 3단계 : 서브쿼리문으로 병합
select
    first_name, last_name, job_title, salary
 from employees inner join jobs using(job_id)
 where salary>(select round(avg(salary)) from employees);

/*
복수형 서브쿼리 : 다중행 서브쿼리라고도 하고 여러개의 행을 반환
    하는 것으로 in, any, all, exists를 사용해야 한다.
    형식] select * from 테이블명 where 컬럼 in (
                select 컬럼 from 테이블명 where 조건
            );
    * 괄호안의 서브쿼리는 2개 이상의 결과를 인출해야 한다.
*/
/*
시나리오] 담당업무별로 가장 높은 급여를 받는 사원의 명단을 조회하시오.
    출력목록 : 사원아이디, 이름, 담당 업무 아이디, 급여
*/
-- 1단계 : 담당업무별 가장 높은 급여를 확인한다.
select job_id, max(salary) from employees group by job_id;
-- 2단계 : 위의 결과를 단순한 or 조건으로 묶어본다.
-- 19개의 결과가 인출되지만 4개정도만 기술해본다.
select * from employees where
    (job_id='SH_CLERK' and salary=4200) or
    (job_id='AD_ASST' and salary=4400) or
    (job_id='MK_MAN' and salary=13000) or
    (job_id='MK_REP' and salary=6000);
-- 3단계 : 복수형 연산자를 통해 서브쿼리로 병합한다.
select employee_id, first_name, job_id, salary
 from employees where (job_id, salary) in (
    select job_id, max(salary) from employees group by job_id)
 order by salary;

/*
복수행 연산자 : any(어떤것이라도_의 개념은 or와 비슷하다.
    메인쿼리의 비교조건이 서브쿼리의 검색결과와 하나이상
    일치하면 참이되는 연산자. 즉 둘 중 하나만 만족하면 해당 레코드를
    인출한다.
*/
/*
시나리오] 전체 사원중에서 부서번호가 20인 사원들의 급여보다 높은 급여를 
    받는 직원들을 인출하는 서브쿼리문을 작성하시오. 단 둘 중 하나만 
    만족하더라도 인출하시오.
*/
-- 1단계 : 20부서 부터 급여를 확인한다.
select first_name, salary from employees where department_id=20;
-- 2단계 : 1번의 결과를 단순한 or절로 작성해본다.
select first_name, salary from employees
    where salary>13000 or salary>6000;
-- 3단계 : 둘중 하나만 만족하면 되므로 복수행연산자 any를 이용해서 서브쿼리를
-- 만들면 된다. 즉 6000보다 크고 도는 13000보다 큰 조건으로 생성된다.
select first_name, salary from employees
    where salary>any(
        select salary from employees where department_id=20);
/*
    결과적으로 6000보다 크면 조건에 만족한다. 결과 : 55명
*/

/*
복수행 연산자3 : all은 and의 개념과 유사하다.
    메인쿼리는 비교조건이 서브쿼리의 검색결과와 모두 일치해야
    레코드를 인출한다.
*/
/*
시나리오] 전체 사원중에서 부서번호가 20인 사원들의 급여보다 높은 급여를 
    받는 직원들을 인출하는 서브쿼리문을 작성하시오. 단 둘다 만족하는 
    레코드만 인출하시오.
*/
select first_name, salary from employees
    where salary>all(
        select salary from employees where department_id=20);
/*
    6000이상이고 동시에 13000보다 커야하므로 결과적으로 13000이상인
    레코드만 인출하게 된다. 결과 : 5명
*/

/*
rownum : 테이블에서 레코드를 조회한 순서대로 순번이 부여되는 가상의
    컬럼을 말한다. 해당 컬럼은 모든 테이블에 논리적으로 존재한다.
*/
-- 모든 계정에 논리적으로 존재하는 테이블
select * from dual;
-- 레코드의 정렬없이 모든 레코드를 가져와서 rownum으로 부여한다.
-- 이경우 rownum은 순서대로 출력된다.
select employee_id, first_name, rownum from employees;
-- 이름의 오름차순으로 정렬하면 rownum이 섞여서 이상하게 나온다.
select employee_id, first_name, rownum from employees
    order by first_name asc;

/*
rownum을 우리가 정렬한 순서대로 재부여하기 위해 서브쿼리를 사용한다.
from절에는 테이블이 들어와야 하는데, 아래의 서브쿼리에서는 사눵테이블의
전체 레코드를 대상으로 하되 이름의 오름차순으로 정렬된 상태로 레코드를
가져와서 테이블처럼 사용한다.
*/
select first_name, rownum 
 from (select * from employees order by first_name asc);


--------------------------------------------------------
--------------- Sub Query 연 습 문 제 ------------------ 
--------------------------------------------------------

-- scott계정에서 진행합니다. 
/*
01.사원번호가 7782인 사원과 담당 업무가 같은 사원을 표시하시오.
출력 : 사원이름, 담당 업무
*/
select * from emp where empno=7782;--7782사원의 담당업무 확인
select * from emp where job='MANAGER';
select * from emp where job=(select job from emp where empno=7782);

/*
02.사원번호가 7499인 사원보다 급여가 많은 사원을 표시하시오.
출력 : 사원이름, 급여, 담당업무
*/
select * from emp where empno=7499;--7499의 급여 확인
select * from emp where sal>1600;
select * from emp where sal>(select sal from emp where empno=7499);

/*
03.최소 급여를 받는 사원번호, 이름, 담당 업무 및 급여를 표시하시오.
(그룹함수 사용)
*/
select min(sal) from emp;
select * from emp where sal=800;
select empno, ename, job, sal from emp 
    where sal=(select min(sal) from emp);

/*
04.평균 급여가 가장 적은 직급(job)과 평균 급여를 표시하시오.
*/
--직급별 평균급여 인출(job을 그룹으로 사용하므로 select절에 기술할수있다)
select job, avg(sal) AAA from emp group by job;
--에러발생. 그룹함수를 2개 겹쳤기 때문에 job컬럼을 제외해야한다.
--(평균급여 중 최소값을 찾아 인출하므로 job컬럼은 단일컬럼이 되므로 
--select절에서 제외해야 한다.)
select job, min(AAA) from emp group by job;
--정상실행. 직급중 평균급여가 최소인 레코드 인출
select min(avg(sal)) from emp group by job;
/*
평균급여는 물리적으로 존재하는 컬럼이 아니므로 where절에는 사용할수없고
having절에 사용해야 한다. 즉, 평균급여가 1017인 직급을 출력하는 방식으로
서브쿼리를 작성해야 한다. 
*/
select job, avg(sal) from emp
group by job
having avg(sal)=(select min(avg(sal)) from emp group by job);

/*
05.각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
*/
--단순 정렬을 통해 부서별 급여 확인
select deptno, sal from emp order by deptno, sal;
--그룹함수를 통해 부서별 최소급여 확인
select deptno, min(sal) from emp group by deptno;
--단순 or절을 통한 인출
select ename, sal, deptno from emp 
    where (deptno=20 and sal=800) or 
        (deptno=30 and sal=950) or 
        (deptno=10 and sal=1300) ;
--서브쿼리의 복수행 연산자를 통해 쿼리 작성    
select ename, sal, deptno from emp 
    where (deptno, sal) 
        in (select deptno, min(sal) from emp group by deptno);

/*
06.담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 
업무가 분석가(ANALYST)가 아닌 사원들을 표시(사원번호, 이름, 담당업무, 급여)
하시오.
*/
select * from emp where job='CLERK';--급여가 3000인것을 확인.
select * from emp where sal<3000 and job<>'ANALYST';
/*
ANALYST 업무를 통한 결과가 1개이므로 아래와 같이 단일행 연산자로 서브쿼리를
만들수 있지만, 만약 결과가 2개이상이라면 복수행 연산자 all 혹은 any를 
추가해야한다. 
*/
select * from emp where sal<(select sal from emp where job='ANALYST') 
    and job<>'ANALYST';
/*
Ex) 만약 담당업무가 CLERK로 주어졌다면 쿼리는 아래와 같이 해야한다. 
*/
select * from emp where job='CLERK';--3개의 결과가 인출된다.
select * from emp where job<>'CLERK' and (sal<800 or sal<950 or sal<1300);
--복수행이 되므로 any혹은 all을 사용해야 한다. 
select * from emp where job<>'CLERK' and 
    sal < any (select sal from emp where job='CLERK');


/*
07.이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 
사원번호와 이름, 부서번호를 표시하는 질의를 작성하시오
*/
--K가 포함된 사원은 10, 30번 부서에 속한것을 확인
select * from emp where ename like '%K%';
--10번 혹은 30번 부서에서 근무하는 사원을 출력(or로 기술해도 됨)
select * from emp where deptno in (30, 10);
/*
    or 조건을 in으로 표현할 수 있다. 따라서 서브쿼리에서 복수행 연산자인
    in을 사용한다. 2개 이상의 결과를 or로 연결하여 출력하는 기능을 
    가진다. 
*/
select * from emp where deptno 
    in (select deptno from emp where ename like '%K%');

/*
08.부서 위치가 DALLAS인 사원의 이름과 부서번호 및 담당 업무를 표시하시오.
*/
--20번 부서임을 확인
select * from dept where loc='DALLAS';
--20번 부서에서 근무하는 사원들
select * from emp where deptno=20;
--서브쿼리로 병합
select * from emp where deptno=(select deptno from dept where loc='DALLAS');

/*
09.평균급여 보다 많은 급여를 받고 이름에 K가 포함된 사원과 같은 
부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오.
*/
--평균급여
select avg(sal) from emp;--2077.xxx 
--K가 포함된 사원
select * from emp where ename like '%K%';
--단순 조건으로 쿼리작성
select * from emp
    where sal>2077 and deptno in (30, 10);
--서브쿼리로 작성. 단일행연산자와 복수행연산자가 동시에 들어가는 쿼리가된다.
select * from emp
    where sal>(select avg(sal) from emp) 
    and deptno in (select deptno from emp where ename like '%K%');

/*
10.담당 업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
*/
select * from emp where job='MANAGER';--10,20,30번 부서임을 확인
select * from emp where deptno 
    in (select deptno from emp where job='MANAGER');


/*
11.BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 
질의를 작성하시오. (단, BLAKE는 제외)
*/
select * from emp where ename='BLAKE';--30번부서
select * from emp where deptno=30 and ename<>'BLAKE';
select ename, hiredate from emp 
    where deptno=(select deptno from emp where ename='BLAKE') 
        and ename<>'BLAKE';

