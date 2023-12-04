/*
파일명 : Or16View.sql
View(뷰) 
설명 : view는 테이블로부터 생성된 가상의 테이블로 물리적으로는 존재하지 않고
    논리적으로 존재하는 테이블이다.(읽기용 짭 생성)
HR 계정으로 하기
*/
/*
view의 생성
    형식]
        create [or replace] view 뷰이름[(컬럼1, 컬럼2,.......)]
        as
        select * from 테이블명 where 조건
            혹은 join문도 가능함.
*/
/*
시나리오] HR계정의 사원테이블에서 담당업무가 ST_CLERK인 사원정보를 
    조회할 수 있는 View를 생성하시오
    출력항목 : 사원아이디, 이름, 직무아이디, 입사일, 부서아이디
*/
-- 1. 조건대로 select하기
select
    employee_id, first_name, job_id, hire_date, department_id
 from employees 
 where job_id = 'ST_CLERK'; --20개 인출
 
--2. View 생성하기
create view view_employees
    as
    select
        employee_id, first_name, job_id, hire_date, department_id
    from employees
    where job_id = 'ST_CLERK';
    
--3. View 실행하기 : select문을 실행한것과 동일한 결과가 인출된다
select * from view_employees;

--4. 데이터 사전에서 뷰 확인하기
-- 생성시 사용한 쿼리문이 그대로 저장되는것을 확인 가능
select * from user_views;

/*
뷰 수정하기
    : 뷰 생성문자에 or replace만 축사하면 된다
    해당뷰가 존재하면 수정되고, 없을 시 새롭게 생성됨
    따라서 뷰 생성시에 써도 무방함
*/

/*
시나리오]앞에서 생성한 View를 다음과 같이 수정하시오
    기존컬럼인 employee_id, first_name, job_id, hire_date, department_id를
    id, fname, jobid, hdate, deptid로 수정하여 인출하시오
*/

create or replace view view_employees
    (id, fname, jobid, hdate, deptid)
    as
    select
        employee_id, first_name, job_id, hire_date, department_id
    from employees
    where job_id = 'ST_CLERK'; -- 수정
select * from view_employees; -- 확인

/*
퀴즈] 위에서 생성한 view_employees 뷰를 아래 조건에 맞게 수정하라
    직무아이디 ST_MAN인 사원의 사원번호, 이름, 이메일, 매니져아이디를 
    조회할 수 있도록 수정하시오.
    View의 컬럼명은 e_id, name, email, m_id 로 지정한다. 
    단, 이름은 first_name과 last_name이 연결된 형태로 출력하시오
*/
    select
        employee_id, concat(first_name||' ',last_name), email, manager_id
    from employees where job_id = 'ST_MAN';  -- 셀렉트문 부터 생성
    
    -- View생성시 컬럼에 별칭 부여
    create or replace view view_employees
    (e_id, name, email, m_id)
    as
    select
    employee_id, concat(first_name||' ',last_name), email, manager_id
    from employees where job_id = 'ST_MAN';
    
select * from view_employees; -- view 확인



/*
퀴즈1] 사원번호, 이름, 연봉을 계산하여 출력하는 뷰를 생성하시오
    컬럼의 이름은 emp_id, l_name, annul_sal로 지정하시오
    연봉계산식 -> (급여+(급여*보너스율))*12
    뷰이름 : v_emp_salary
    단 연봉은 세자리마다 ,가 삽입되어야 한다
*/
select * from employees;
select 
    employee_id, concat(first_name || ' ', last_name), (salary+(salary*nvl(commission_pct,0)))*12
    from employees;

create view v_emp_salary
    (emp_id, l_name, annul_sal)
    as
    select
     employee_id, concat(first_name || ' ', last_name), (salary+(salary*nvl(commission_pct,0)))*12
    from employees;
    
select * from v_emp_salary;


/*
퀴즈2]join을 통한 view 생성
시나리오] 사원테이블과 부서테이블, 지역테이블을 조인하여 다음 조건에 맞는
    view를 생성하시오
    출력항목 : 사원번호, 전체이름, 부서번호, 부서명, 입사일자, 지역명
    view의 명칭 : v_emp_join
    view의 컬럼 : empid, fullname, deptid, deptname, hdate, locname
    컬럼의 출력형태 : 
        fullname => first_name + last_name
        hdate => 0000년 00월 00일
        locname => xxx주의 yyy   --ex) Texas 주의 Southlake
*/





















