/*****************
파일명 : Or11Join.sql
테이블 조인
설명 : 듀개 이상의 테이블을 동시에 참조하는 데이터를 가여와야 할 때
    사용하는 SQL문
*******************/
-- HR 계정으로 하기

/*
1] inner join(내부조인)
    - 가장 많이 사용되는 조인문으로 테이블간에 연결조건을 모두 만족하는
    레코드를 검색할 때 사용한다.
    - 일반적으로 기본키(primary key) 와 외래키(foreign key)를 사용하여
    join하는 경유가 대부분이다.
    - 두개의 테이블에 동일한 이름의 컬럼이 존재하면 "테이블명.컬럼명"
    형태로 기술해야 한다.
    - 테이블의 별칭을 사용하면 "별칭.컬럼명"형태로 기술할 수 있다.
    
    형식1(표준방식)
        select 컬럼1, 컬럼2,...
         from 테이블1 inner join 테이블2
            on 테이블1.기본컬럼 = 테이블2.외래키컬럼
            where 조건1 and 조건2 ...;
*/
/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어던 부서에서
    근무하는지 출력하시오. 단, 표준방식으로 작성하시오.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/
desc employees;
desc departments;
/*
ORA-00918: 열의 정의가 애매합니다
00918. 00000 -  "column ambiguously defined"
department_id는 조인한 양쪽 데이블에 존재하는 컬럼이므로
어떤 테이블에서 가져와 출력할지 결졍해야 한다.
*/
select
    employee_id, first_name, last_name, email, department_id, department_name
 from 
    employees inner join departments
 on employees.department_id=departments.department_id;
-- 열의 정의가 애매한 경우 컬럼앞에 테이블명을 추가한다.
select
    employee_id, first_name, last_name, email, 
    employees.department_id, department_name
 from 
    employees inner join departments
 on employees.department_id=departments.department_id;
-- as(알리아스)를 통해 테이블에 별칭을 부여하여 쿼리문을 간소화할 수 있다.
select
    employee_id, first_name, last_name, email, 
    Emp.department_id, department_name
 from 
    employees Emp inner join departments Dep
 on Emp.department_id=Dep.department_id;
/*
    실행결과에서는 소속된 부서가 없는 1명을 제외한 나머지 106명의 레코드가
    인출된다. 즉, inner join 은 조인한 테이블에서 양족 모두 만족되는 레코드만
    자여오게 된다.
*/

-- 3개이상 테이블 조인하기
/*
시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를
    출력하는 쿼리문을 작성하시오. 단 표준방식으로 작성하시오.
    출력결과] 사원이름. 이메일. 부서아이디. 부서명. 담당업무아이디,
        담당업무명, 근무지역
    위 출력결과는 다음 테이블에 존재한다.
    사원테이블 : 사원이름, 이메일, 부서아이디, 담당업무 아이디
    부서테이블 : 부서아이디(참조), 부서명, 지역일련번호(참조)
    담당업무테이블 : 담당업무명, 담당업무아이디(참조)
    지역테이블 : 근무무서, 지역일련번호(참조)
*/
-- 1.지역테이블을 통해 레코드 확인하기 -> 지역일련번호 1700 확인
select * from locations where lower(city)='seattle';
-- 2. 지역 일련번호를 통해 부서 테이블의 레코드 확인하기 -> 21개 부서 확인
select * from departments where location_id=1700;
-- 3. 부서일련번호를 통해 사원테이블?l 레코드 확인하기 -> 6명 확인하기
select * from employees where department_id=30;
-- 4. 담당업무명 확인하기
select * from jobs where job_id='PU_MAN';
select * from jobs where job_id='PU_CLERK';
-- 5. join 쿼리문 작성
select
    first_name, email, D.department_id, department_name, E.job_id, job_title,
    city, state_province
 from locations L
    inner join departments D on L.location_id=D.location_id
    inner join employees E on D.department_id=E.department_id
    inner join jobs J on E.job_id=J.job_id
 where
    lower(city)='seattle';

/*
형식2] 오라클 방식
    select 컬럼1, 컬럼2,...
    from 테이블1, 테이블2,....
    where
        테이블1.기본키컬럼=테이블2.외래키컬럼
        and 조건1 and 조건2 ...;
*/
/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어떤부서에서
    근무하는지 출려하시오. 단 오라클방식으로 적성하시오.
    출력결과 : 사원아이디, 이름1, 이름23, 이메일, 부서번호, 부서명
*/
select 
    employee_id, first_name, last_name, email, D.department_id, department_name
 from departments D, employees E
 where 
    D.department_id=E.department_id;

/*
시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를
    출력하는 쿼리문을 작성하시오. 단 오라클방식으로 작성하시오.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디,
        담당업무명, 근무지역
    위 추력결과는 다음 테이블에 존재한다.
    사원테이블 : 사원이름, 이메일, 부서아이디, 담당업무 아이디
    부서테이블 : 부서아이디(참조), 부서명, 지력일련번호(참조)
    담당업무테이블 : 담당업무명, 담당업무아이디(참조)
    지역 데이블 : 근무부서, 지역일련번호(참조)
*/
select
    first_name, last_name, email, D.department_id, 
    department_name, J.job_id, job_title, city, state_province
 from employees E, departments D, jobs J, locations L
 where
    D.department_id=E.department_id and
    D.location_id=L.location_id and
    J.job_id=E.job_id and city=initcap('seattle');

/*
2] outer join(외부조인)
    outer join은 inner join과는 달리 두 테이블에 조인조건이 정확히 일치하지
    않아도 기준이 되는 테이블에서 레코드를 인출하는 join방식이다.
    outer join을 사용할 때는 반드시 outer 전에 기준이 되는 테이블을 결정하고
    쿼리문을 작성해야 한다.
    -> left(왼쪽테이블), right(오른쪽 테이블), full(양쪽 테이블)
    
    형식1(표준방식)
        select 컬럼1, 컬럼2, ...
        from 테이블1
            left[right, full] outer join 테이블2
                on 테이블1.기본키=테이블2.참조키
        where 조건1 and 조건2 or 조건3;
*/
/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을
    외부조인(left)을 통해 출력하시오.
*/
-- 실행결과를 보면 내부조인과는 다르게 107개가 인출된다. 부서가 지정되지 않은
-- 사원까지 인출되기 때문이다. 이 경우 부서쪽에 레코드가 없으므로 null로 
-- 출력된다.
select 
    employee_id, first_name, E.department_id, department_name, city
 from employees E
    left outer join departments D on E.department_id=D.department_id
    left outer join locations L on D.location_id=L.location_id;
    
/*
형식2 (오라클방식)
    select 컬럼1, 컬럼2, ...
    from 테이블1, 테이블2
    where
        테이블1.기본키=테이블2.참조키 (+)
        and 조건1 or 조건2;
        
=> 오라클방식으로 변경시에는 outer join 연산자인 (+)를 붙여준다.
=> 위의 경우 왼쪽 테이블이 기준이 된다.
=> 기준이 되는 테이블을 변경할 때는 테이블의 위치를 옮겨준다. (+)를
    옮기지 않는다.
*/

/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을
    외부조인(left)을 통해 출력하시오. 단 오라클방식으로 작성하시오.
*/
select 
    employee_id, first_name, E.department_id, department_name, city
 from employees E, departments D, locations L
 where
    E.department_id=D.department_id (+)
    and D.location_id=L.location_id (+);
    
/*
연급문제] 2007년에 입사한 사원을 조회하시오. 단, 부서에 배치되지 않은 
    직원의 경우 <부서없음>으로 출력하시오. 단, 표준방식으로 작성하시오.
    출력항목 : 사번, 이름, 성, 부서명
*/
-- 우선 저장된 레코드 확인
select first_name, hire_date, to_char(hire_date, 'yyyy') from employees;
-- 2007년 에 입사한 사원을 인출
-- 방법1 : like를 이용하여 07로 시작하는 레코드를 인출한다.
select first_name, hire_date from employees where hire_date like '07%';
-- 방법2 : to_char()를 통해 날짜서식을 만든 후 레코드를 출력한다.
select first_name, hire_date from employees 
    where to_char(hire_date, 'yyyy')='2007';
--  외부조인(표준방식)으로 결과 확인
-- nvl(컬럼명, '변경할 값') : null값의 데이터를 특정한 값으로 변경해 준다.
select employee_id, first_name, last_name, nvl(department_name, '<부서없음>')
 from employees E
    left outer join departments D on E.department_id=D.department_id
 where to_char(hire_date, 'yyyy')='2007';
    
/*
시나리오] 2007년에 입사항 사원을 조회하시오. 단, 부서에 배치되지 않은
    직원의 경우 <부서없음> 으로 출력하시오. 단, 오라클방식으로 작성하시오.
    출력항목 : 사번, 이름, 성명, 부서명
*/
select employee_id, first_name, last_name, nvl(department_name, '<부서없음>')
 from employees E, departments D 
 where E.department_id=D.department_id (+)
 and to_char(hire_date, 'yyyy')='2007';

/*
3] self joion(셀프 조인)
    셀프 조인은 하나의 테이블에 있는 컬럼끼리 연결해야 하는 경우 사용한다.
    즉 자기자신이 테이블과 조인을 맺는 것이다.
    셀프조인에서는 별칭이 테이블을 구분하는 구분자의 역할을 하므로 굉장히
    중요하다.
    
    형식] 
        select
            별칭1.컬럼, 별칭2.컬럼 ...
        from
            테이블 별칭1, 테이블 별칭2
        where
            별칭1.컬럼=별칭2.컬럼;
*/

/*
시나리오] 사원테이블에서 각 사원의 메니저아이디와 메니저이름을 출력하시오.
    단, 이름은 forst_name과 last_name을 하나로 연결해서 출력하시오.
*/
/*
여기서는 사원입장의 테이블 empClerk과 메니저입장의 테이블 empManger를
별칭으로 생성한 후 where절에 셀프조인 조건을 기술한다.
메니저도 사원이기 때문에 사원입장의 메니저아이디는 메니저입장에서는 
사원아이디가 된다.
*/
select 
    empClerk.employee_id "사원번호",
    empClerk.first_name||' '||empClerk.last_name "사원이름",
    empManager.employee_id "메니저 사원번호",
    concat(empManager.first_name||' ', empManager.last_name) "메니저이름" 
 from employees empClerk, employees empManager
 where empClerk.manager_id=empManager.employee_id;
    
/*
시나리오] self join을 사용하여 "Kimberely / Grant"사원보다 입사일이 늦은
    사원의 이름과 입사일을 출력하시오.
    출력목록 : first_name, last_name, hire_date
*/
-- 1.Kimberely의 정보 확인
select * from employees where first_name='Kimberely';
-- 2.07/05/24 이후의 입사한 사원의 레코드를 출력하시오.
select * from employees where hire_date>'07/05/24';
-- 3.self join으로 쿼리문 합치기
select 
    Clerk.first_name, Clerk.last_name, Clerk.hire_date
 from employees Kimberely, employees Clerk
 where
    Kimberely.hire_date < Clerk.hire_date
    and Kimberely.first_name='Kimberely' and Kimberely.last_name='Grant'
 order by hire_date;

/*
using : join문에서 주로 사용하는 on절을 대체할 수 있는 문장
    형식] on 테이블1.컬럼=테이블2.컬럼
            ==> using(컬럼)
*/
/*
시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를
    출력하는 쿼리문을 작성하시오. 단 using을 사용해서 작성하시오.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무 아이디,
        담당업무명, 근무지역
*/
select
    first_name, last_name, email, department_id,
    department_name, job_id, job_title, city, state_province
 from locations
    inner join departments using(location_id)
    inner join employees using(department_id)
    inner join jobs using(job_id)
 where
    lower(city)='seattle';
/*
    using 절에 사용된 참조컬럼의 경우 select절에서 테이블의 별칭을 붙이면
    오히려 오류가 발생한다.
    using 절에 사용된 컬럼은 양쪽의 테이블에 동시에 존재하는 컬럼이라는
    것을 전재로 작성되기 때문에 굳이 별칭을 사용할 이유가 없기 때문이다.
    즉  using 은 테입릉의 별칭 및 on절에 제거하여 좀 더 심플하게 join쿼리문을
    작성할 수 있게 해준다.
*/

/*
퀴즈] 2005년에 입사한 사원들 중 California(SRATE_PROVINCE) /
    South San Francisco(CITY)에서 근무하는 사원들의 정보를 출력하시오.
    단 표준방식과 using을 사용해서 작성하시오.
    
    출력결과] 사원번호, 이름, 성, 급여, 부서명, 국가코드, 국가명(COUNTRY_NAME),
        급여는 세자리마다 컴마를 표시한다.
    참고] '국가명'은 contries 테이블에 입력되어있다.
*/
-- 1.2005년에 입사한 사원
select first_name, hire_date, substr(hire_date,1,2) from employees;
select * from employees where substr(hire_date,1,2)='05';
-- 2.South San Francisco에 위치한 부서 확인
select * from locations where city='South San Francisco';
    -- location_id가 1500인 것을 확인
select * from departments where location_id=1500;
    -- department_id가 50인것을 확인
-- 3.위에서 확인한 정보를 토대로 쿼리문 작성
select * from employees
    where department_id=50 and substr(hire_date,1,2)='05';
    -- 50번 부서(Shipping)에서 근무하면서 입사년이 2005년인 사원 추출 : 12명
-- 4.join 쿼리문 작성하기
select 
    employee_id, first_name, last_name, trim(to_char(salary, '$990,000')) as "월급",
    department_name, country_id, country_name
 from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
    inner join countries using(country_id)
 where
    city='South San Francisco' and substr(hire_date,1,2)='05'
    and state_province='California';