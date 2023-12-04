/*
파일명 : Or08GruopBy.sql
그룹함수(select문 2번째)
설명 : 전체 레코드(row)에서 통계적인 결과를 구하기 위해
    한 개 이상의 레코드를 그룹으로 묶어서 연산 후 결과를 반환하는 함수/쿼리문
HR계정으로 하기
*/

--사원테이블에서 담당업무 인출 : 총 107개가 인출됨
select job_id from employees;

/*
distinct
    -동일한 값이 있는 경우 중복된 레코드를 제거후 하나만 가져와서 보여준다
    -하나의 순수한 레코드이므로 통계적인 값을 계산 할 수 있다
*/
select distinct(job_id) from employees;



/*
group by
    - 동일한 값이 있는 레코드를 하나의 값으로 묶어서 가져온다
    - 보여지는건 하나의 레코드지만 다수의 레코드가 하나의 그룹으로 
    묶여진 결과이므로 통계적인값을 계산할 수 있다
    - 최대 최소 평균 합산등의 연산이 가능하다
*/
--각 담당업무별 직원수가 몇명인지 카운트한다.
select job_id, count(*) from employees group by job_id; 

--검증을 위해 해당업무를 통해 select해서 인출되는 행의 개수와 비교해본다
select first_name, job_id from employees where job_id='FI_ACCOUNT';
select first_name, job_id from employees where job_id='ST_CLERK';


/*
group절이 포함된 select문의 형식

select
	컬럼1, 컬럼2,.......컬럼N 혹은 *(전체)
from
	테이블명
[where 
	조건1 and 조건2 or 조건N....]
[group by
	데이터 그룹화를 위한 컬럼명]
[having
	그룹에서 찾을 조건]
[order by
	데이터 정렬을 위한 컬럼과 정렬방식]
	
※쿼리의 실행순서
	from(테이블) -> where(조건) -> group by(그룹화) -> 
    having(그룹조건) -> select(컬럼지정) -> order by(정렬방식)

*/
/*
sum() : 합계를 구할 때 사용하는 함수
    - numbrt 타입의 컬럼에서만 사용할 수 있다.
    - 필드명이 필요한 경우 as를 이용해서 별칭을 부여할 수 있다.
*/
--전체 직원의 급여의 합계를 출력하시오
select
    sum(salary) as sumSalary1,
    to_char(sum(salary), '999,000') sumsalary2,
    ltrim(to_char(sum(salary), '$999,000')) sumsalary3,
    ltrim(to_char(sum(salary), 'L999,000')) sumsalary4
    from employees;
    
--10번 부서에 근무하는 사원들의 급여합계는 얼마인지 출력하시오.
select
    sum(salary) "급여합계",
    ltrim(to_char(sum(salary), '$999,000')) "좌측공백제거, 세자리 콤마, 달러표시"
 from employees where department_id = 10;
 
--sum과 같은 그룹함수는 number타입인 컬럼에서만 사용할 수 있다.
select sum(first_name) from employees; -- 에러발생

/*
count() : 그룹화된 레코드의 개수를 카운트할 때 사용하는 함수
*/
select count(*) from employees;
select count(employee_id) from employees;
--count함수를 사용할 때는 위 2가지 방법 모두 가능하나 *를 사용할것을 권장함
--컬럼(_)의 특성혹은 데이터에 따른 방해를 받지 않아 실행속도가 빠르다.
/*
count()함수의 
    사용법 1 : count(all 컬럼명)
        => 디폴트 사용법으로 컬럼 전체의 레코드를 기준으로 카운트 한다.
    사용법 2 : count(distinct 컬럼명)
        => 중복을 제거한 상태에서 카운트한다
*/
select
    count(job_id) "담당업무전체갯수",
    count(all job_id) "담당업무 전체 갯수2",
    count(distinct job_id) "담당업무 중복제거"
 from employees;
 
/*
avg() : 평균값을 구할 떄 사용하는 함수
*/
-- 전체 사원의 평균 급여는 얼마인지 출력하는 쿼리문을 작성하시오.
select
    count(*) "전체직원수",
    sum(salary) "사원 급여의 합",
    sum(salary)/count(*) "평균급여->직접계산",
    avg(salary) "평균급여->avg함수",
    trim(to_char(avg(salary),'$999,000')) "서식 및 공백제거"
 from employees;
 
 -- 영업팀(SALES)의 평균 급여는 얼마인가요
 -- 1. 부서테이블의 영업팀 부서번호부터 확인한다
 -- 2. 정보검색시 대소문자/공백이 포함된 경우 모든 레코드에 대해 
 --     문자열을 확인하는 것은 불가능 하므로 일괄적인 규칙의
 --     적용을 위해 upper()과 같은 변환함수를 활용하여 검색하는 것이 좋다
 
 select * from departments where department_name = initcap('sales');//initcap << 첫글자 대문자
 select * from departments where lower(department_name) = 'sales';
 select * from departments where upper(department_name) = upper('sales');
 
 -- 부서 번호가 80인 것을 확인 후 다음 쿼리문을 작성한다
 select ltrim(to_char(avg(salary), '$999,000')) "영업팀 평균급여"
    from employees where department_id = 80;

/*
min(), max() 함수 : 최대값,최소값을 찾을 때 사용하는 함수
*/
-- 전체 사원중 가장 낮은 급여는 얼마인가?
select min(salary) from employees; -- 2100
-- 가장 낮은 급여를 받는 직원은 누구인가
select first_name, salary from employees where salary=min(salary);
      --이 쿼리문은 원래 에러가 발생함, 그룹함수는 일반컬럼에 사용 불가능하다
-- 사원테이블에서 가장 낮은 급여인 2100을 받는 사원을 인출한다
select first_name, salary from employees where salary=2100;
/*
사원중 가장 낮은 급여는 min()으로 구할 수 있으나, 가장 낮은 급여를 받는 사람은
아래와 같이 서브쿼리를 통해 구할 수 있다. 따라서 문제에 따라 서브쿼리를 사용할지
여부를 결정해야한다.
*/
select first_name, salary
    from employees where salary=(select min(salary) from employees); --서브쿼리미리보기

/*
group by 절 : 여러개의 레코드를 하나의 그룹으로 그룹화하여 
        묶여진 결과를 반환하는 쿼리문
        ※distinct << 단순한 중복값을 제거
*/
-- 사원테이블에서 각 부서별 급여의 합계는 얼마인가?
-- IT 부서의 급여 합계
select sum(salary) from employees where department_id =60;--28800
-- Finance부서의 급여 합계
select sum(salary) from employees where department_id =100; --51608

-- stage 1 : 부서가 많은경우 일일이 부서별로 확인할 수 없으므로 부서를
--      그룹화 한다. 중복이 제거된 결과로 보이지만 동일한 레코드가
--      하나의 그룹으로 합쳐진 결과가 인출된다
select department_id, sum(salary) from employees group by department_id;

-- stage 2 : 각 부서별로 급여의 합계를 구할 수 있다. 4자리가 넘어가는 경우
--      가독성이 떨어지므로 서식을 이용해서 세자리마다 콤마를 표시한다.
select department_id, sum(salary), trim(to_char(sum(salary), '999,000'))
    from employees 
    group by department_id 
    order by sum(salary) desc;

/*
퀴즈] 사원테이블에서 각 부서별 사원수와 평균 급여는 얼마인지 출력하는
        쿼리문을 작성하시오
        출력결과 : 부서번호, 급여총합, 사원총합, 평균급여
        출력시 부서번호를 기준으로 오름차순 정렬하시오
*/
select department_id "부서번호", 
        rtrim(to_char(sum(salary), '999,000')) "급여총합",
        count(*) "사원총합",
        rtrim(to_char(avg(salary), '999,000')) "평균급여" 
        from employees
        group by department_id
        order by department_id;
        
/*
앞에서 사용했던 쿼리문을 아래와 같이 수정하면 에러가 발생한다
*/
select
    department_id, sum(salary), count(*), avg(salary), first_name -- firstname에 에러발생
    from employees
    group by department_id;
/*     ㄴㄱ
group by 절에서 사용한 컬럼은 select절에서 사용할 수 있으나
그 외의 단일컬럼은 select절에서 사용할 수 없다.
그룹화된 상태에서 특정 레코드 하나만 선택하는 것은 애매하기 때문이다.
*/




/*
시나리오] 부서아이디가 50인 사원들의 직원 총합, 평균 급여, 급여총합이 얼마인지
        출력하는 쿼리문을 작성하시오
*/
 select 
    '50번 부서', count(*), round(avg(salary)), sum(salary)
 from employees where department_id = 50
 group by department_id;
 
 /*
 having 절 : 물리적으로 존재하는 컬럼이 아닌 그룹함수를 통해 논리적으로
        생성된 컬럼의 조건을 추가할 때 사용한다.
        해당 조건을 where절에 추가하면 에러가 발생한다.
 */
 /*
 시나리오] 사원테이블에서 각 부서별로 근무하고 있는 직원의 담당업무별
        사원수와 평균급여가 얼마인지 출력하는 쿼리문을 작성하시오
        단, 사원수가 10을 초과하는 레코드만 인출하시오
 */
 --같은 부서에 근무하더라도 담당업누느 다를 수 있으므로 이 문제에서는 
 --group by를 절에 2개의 컬럼을 명시해야 한다. 즉 부서로 그룹화 한 후
 -- 다시 담당업무별로 그룹화 하여야 한다
 
select 
    department_id, job_id, count(*), avg(salary)
 from employees
 where count(*)>10  <<여기서 에러발생
 group by department_id, job_id;
 
/* 
 담당 업무별 사원수는 물리적으로 존재하는 컬럼이 아니므로
 where절에 쓰면 에러가 발생함, 이런경우에는 having절에 조건을 추가해야한다.
 ex) 급여가 3000인 사원 -> 물리적으로 존재하므로 where절에 사용
     평균 급여가 3000인 사원 -> 논리적으로 존재하므로 having 절 사용
                                즉, group함수를 통해 구할 수 있는 데이터다.
*/
select 
    department_id, job_id, count(*), avg(salary)
 from employees
 group by department_id, job_id
having count(*)>10;

/*******************************************
연습문제
*******************************************/

--#해당 문제는 hr계정의 employees 테이블을 사용합니다.

/*
1. 전체 사원의 급여최고액, 최저액, 평균급여를 출력하시오. 컬럼의 별칭은 
아래와 같이 하고, 평균에 대해서는 정수형태로 반올림 하시오.
별칭) 급여최고액 -> MaxPay
급여최저액 -> MinPay
급여평균 -> AvgPay
*/
--round(), to_char() : 반올림 처리 되어 출력됨
--trunc() : 소수 이하를 잘라서 출력됨. 반올림되지 않음.

select max(salary) MaxPay, min(salary) MinPay, 
    to_char(avg(salary),'999,000') Avgpay
    from employees;
    
/*
2. 각 담당업무 유형별로 급여최고액, 최저액, 총액 및 평균액을 출력하시오. 
컬럼의 별칭은 아래와 같이하고 모든 숫자는 to_char를 이용하여 세자리마다 
컴마를 찍고 정수형태로 출력하시오.
별칭) 급여최고액 -> MaxPay
급여최저액 -> MinPay
급여평균 -> AvgPay
급여총액 -> SumPay
참고) employees 테이블의 job_id컬럼을 기준으로 한다.
*/
select 
    job_id,
    to_char(max(salary),'999,000') MaxPay, 
    to_char(min(salary),'999,000') MinPay, 
    to_char(avg(salary),'999,000') AvgPay,
    to_char(sum(salary),'999,000') Sumpay
 from employees group by job_id;

    


/*
3. count() 함수를 이용하여 담당업무가 동일한 사원수를 출력하시오.
참고) employees 테이블의 job_id컬럼을 기준으로 한다.
*/
--물리적으로 존재하는 컬럼이 아니라면 함수 혹은 수식을 그대로 order by절에
--기술하면된다.
--수식이 너무 길다면 별칭을 기술해도 된다. 

select job_id, count(*) from employees group by job_id order by count(*)desc;



/*
4. 급여가 10000달러 이상인 직원들의 담당업무별 합계인원수를 출력하시오.
*/
select job_id, count(*) from employees where salary>=10000 
    group by job_id order by count(*) desc;

/*
5. 급여최고액과 최저액의 차액을 출력하시오. 
*/
select max(salary) 최고액, min(salary) 최저액,  max(salary)-min(salary) 차액 from employees;

/*
6. 각 부서에 대해 부서번호, 사원수, 부서 내의 모든 사원의 평균급여를 
출력하시오. 평균급여는 소수점 둘째자리로 반올림하시오.
*/

select
    department_id, count(*), avg(salary),
    round(avg(salary), 2) "평균급여1",
    to_char(avg(salary), '990,000.00') "평균급여2"
from employees group by department_id
order by department_id;