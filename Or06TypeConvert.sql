/*
파일명 : Or06TypeConvert.sql
형변환 함수 / 기타함수
설명 : 데이터 타입을 다른 타입으로 변환해야 할 때 사용하는 함수와
    기타함수
HR계정으로 하기
*/

/*
sysdate : 현재날짜와 시간을 초단위로 반환해준다. 주로 게시판이나
    회원가입에서 새로운 게시물이 있을 때 입력한 날짜를 표현하기 위해
    사용된다.
*/
select sysdate from dual;

/*
날짜 포멧 : 오라클은 대소문자를 구분하지 않으므로, 서식문자 역시 구분하지 않는다
따라서 mm과 MM은 동일한 결과를 출력한다
*/
select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'YY/MM/DD') from dual;


--현재 날짜를 "오늘은 0000년 00월 00일 입니다."와 같은 형태로 출력하시오
select to_char(sysdate, '오늘은 yyyy년 mm월 dd일입니다.') from dual;--에러
--하이픈(-), 슬래시(/) 외의 문자는 인식하지 못하므로 서식문자를 제외한 나머지
--    문자열을 더블쿼테이션(")으로 묶어줘야한다. '서식문자를 제외'<<주의
select to_char(sysdate, '"오늘은 "yyyy"년 "mm"월 "dd"일입니다."') from dual;


--요일이나 년도를 표현하는 서식문자들
select
    to_char(sysdate,'day') "요일(화요일)",
    to_char(sysdate,'dy') "요일(화)",
    to_char(sysdate,'dd') "일을 숫자로표현",
    to_char(sysdate,'ddd') "일년중 몇번째 일인지",
    to_char(sysdate,'mon') "월(4월)",
    to_char(sysdate,'mm') "월(04)",
    to_char(sysdate,'month') "월(4월)",
    to_char(sysdate,'yy') "두자리년도"
    from dual;
    
/*
시나리오] 사원테이블에서 사원의 입사일을 다음과 같이 출력할 수 있도록
    서식을 지정하여 쿼리문을 작성하시오.
    출력] 0000년 00월 00일 0요일
*/
select first_name, last_name, to_char(hire_date, 
    '"입사일은 "yyyy"년 "mm"월 "dd"일 "day" 입니다."') 
    from employees order by hire_date;
    
/*
시간 포멧 : 현재시간을 00:00:00 형태로 표시하기
    또는 날짜와 시간을 동시에 표현할 수도 있다.
*/
select
    to_char(sysdate, 'HH:MI:SS'),
    to_char(sysdate, 'hh:mi:ss'), -- 소문자 영향 x
    to_char(sysdate, 'hh24:mi:ss'), -- 24시 표기
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') "현재시간"
    from dual;

/*
숫자 포멧
    0: 숫자의 자리수를 나타내며 자리수가 맞지 않는 경우 0 으로 자리를 채운다
    9: 0과 동일하지만, 자리수가 맞지않는 경우 공백으로 채운다.
*/ 

select 
    to_char(123, '0000'), -- 0123, 0을 서식으로 사용하면 남은자리를 0이 채움
    to_char(123, '9999'), -- 123, 9를 서식으로 사용하면 남은자리는 공백이됨 (trim으로 제거가능)
    trim(to_char(123,'9999')) -- 공백제거
 from dual;
 
 --숫자의 세자리마다 컴마(,) 표시하기
 --자리수가 확실히 보장된다면 0 사용, 자리수가 다른부분에는 9를 사용해 서식을 지정한다.
 --대신 공백은 trim()으로 함수를 통해 제거
 
select
    12345,
    to_char(12345, '000,000'), to_char(12345, '999,999'),
    ltrim(to_char(12345, '999,999')) 
 from dual;
 
 
-- 통화표시 : L -> 각 나라에 맞는 통화표시가 된다 -> 우리나라 = 원
select to_char(1000000, 'L9,999,000') from dual;

/*
숫자 변환 함수
    to_number() : 문자형 데이터를 숫자형으로 변환한다
*/

select to_number('123') + to_number('456') from dual; --숫자형으로 바뀌어 계산성립

select to_number('123a') + to_number('456') from dual; --문자a가 섞여있어 에러발생

/*
to_date() : 문자열 데이터를 날짜형식으로 변환해서 출력해준다.
    기본 서식은 년/월/일 순으로 지정
*/
select to_date('2023-06-13')"날짜기본형식", 
to_date('20230613') "날짜기본형식",
to_date('2023/06/13') "날짜기본형식"
 from dual;
--날짜 포맷이 년-월-일 순이 아닌 경우에는 오라클이 인식하지 못하여 에러발생
--이때는 날짜서식을 이용해 오라클이 인식가능하게 작성해줘야 한다
select to_date('16-06-2024') from dual; -- 날짜형식에 맞지않아 에러발생


/*
퀴즈] '2023-11-23 17:49:30와 같은 형태의 문자열을 
    날짜로 인식할 수 있도록 쿼리문을 작성하시오
*/
--날짜 서식을 인식하지 못하므로 에러발생
select to_date('2023-11-23 17:49:30') from dual;  --에러

-- 방법 1  : 문자열을 잘라서 사용
-- 문자열을 아래와 같이 잘라서 수정한다면 날짜서식으로 인식할 수 있다.
select to_date('2023-11-23') from dual;
-- substr()함수로 문자열을 날짜부분만 잘라 to_date의 인자로 사용한다.
select substr('2023-11-23 17:49:30',1,10) "문자열 자르기",
to_date(substr('2023-11-23 17:49:30',1,10)) "날짜 서식으로 변경"
from dual;

-- 방법 2 : 날짜와 시간 서식을 사용
select to_date('2023-11-23 17:49:30', 'yyyy-mm-dd hh24:mi:ss') from dual;
--시간출력은 안됨

/*
퀴즈]문자열 '2022/12/25'는 어떤 요일인지 변환함수를 통해 출력해보시오.
    단, 문자열은 임의로 변경할 수 없다.
*/

select to_char('2022/12/25') from dual; -- 날짜서식확인
select to_char(sysdate,'day') from dual; -- 요일서식확인
select to_char(to_date('2022/12/25'),'day') -- 조합
 from dual;
    
/*
퀴즈]문자열'2024년01월01일'은 어떤 요일인지 변환함수를 통해 출력해보시오
단 문자열은 임의로 변경할 수 없습니다.
*/
select
    to_date('2024년 01월 01일', 'yyyy "년" mm "월" dd "일"'),
    to_char(to_date('2024년 01월 01일','yyyy"년"mm"월"dd"일"'), 'day')
     from dual;

/*
nvl() : null값을 다른 데이터로 변경하는 함수
    형식] nvl(컬럼명)
*/
--이와 같이 덧셈을 하면 영업사원이 아닌 경우 급여가 null이 출력된다
--null과 연산시 전부 null이 되어버린다
--따라서 null컬럼은 별도의 처리가 필요하다
select salary+commission_pct from employees;
--null 값을 0으로 변경한 후 연산을 진행해야 정상적인 결과가 출력된다
select first_name, commission_pct, salary+nvl(commission_pct, 0) from employees;

/*
decode() : java의 switch문과 비슷하게 특정값에 해당하는 출력문이 
    있는 경우 사용한다.
    형식]decode(컬럼명, 값1, 결과1, 값2, 결과2............, 기본값)
    *내부적인 코드값을 문자열로 변환하여 출력할 때 많이 쓰인다
*/
select
    first_name, last_name, department_id,
    decode(department_id, 
        10, 'Adminstration', 20, 'Marcketing',--경영관리/마케팅
        30, 'Purchasing', 40, 'Human Resources',--구매/인사
        50, 'Shipping', 60, 'IT',--물류/IT
        70, 'Pubilc Relations', 80, 'Sales',--홍보/영업
        90, 'Excutive', 100, 'Finance',--경영/재무
        110, 'Accounting', '부서명 확인 안됨')as department_name --회계 
     from employees order by department_id;

/*
case() : java의 if~else문과 비슷한 역할을 하는 함수
    형식] 
    case
        when 조건1 then 값1
        when 조건2 then 값2
        .....
        else 기본값
    end
*/
/*
시나리오] 사원테이블에서 각 부서번호에 해당하는 부서명을 출력하는
    쿼리문을 case를 이용해 입력하시오
*/
    select
    first_name, last_name, department_id,
    case
        --when 조건 then 값
        when department_id = 10  then 'Adminstration'
        when department_id = 20  then 'Marcketing'
        when department_id = 30  then 'Purchasing'
        when department_id = 40  then 'Human Resources'
        when department_id = 50  then 'Shipping'
        when department_id = 60  then 'IT'
        when department_id = 70  then 'Pubilc Relations'
        when department_id = 80  then 'Sales'
        when department_id = 90  then 'Excutive'
        when department_id = 100 then 'Finance'
        when department_id = 110 then 'Accounting'
        else '부서명 확인 안됨'
    end team_name
 from employees order by department_id;
        
 /*************************
연습문제
*************************/
--scott계정에서 진행합니다.

/*
1. substr() 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력하시오.
*/
select ename, substr(hiredate,1,5) from emp;

/*
2. substr()함수를 사용하여 4월에 입사한 사원을 출력하시오. 
즉, 연도에 상관없이 4월에 입사한 모든사원이 출력되면 된다.
*/
select ename "이름", substr(hiredate,4,2) as "고용달" from emp where "고용달" = 04;
--실행순서 때문에 에러 발생 where호출이 selet보다 우선이므로 "고용달"을 인식하지못함
select ename "이름", hiredate "고용일"  from emp where substr(hiredate,4,2) = 04;
--where에서 호출을 해줘야 인식가능


/*
3. mod() 함수를 사용하여 사원번호가 짝수인 사람만 출력하시오.
mod(나눠지는수,나눌수)
*/
select * from emp;
select ename, empno from emp where mod(empno,2)=0;


/*
4. 입사일을 연도는 2자리(YY), 월은 숫자(MON)로 표시하고 요일은 
약어(DY)로 지정하여 출력하시오.
*/
select ename, to_char(hiredate,'YY/MONTH/DY') from emp;
select
    hiredate,
    to_char(hiredate, 'yy') "입사년도",
    to_char(hiredate, 'mon') "입사월",
    to_char(hiredate, 'dy') "입사요일"
 from emp;


/*
5. 올해 며칠이 지났는지 출력하시오. 현재 날짜에서 올해 1월1일을 뺀 결과를 
출력하고 TO_DATE()함수를 사용하여 데이터 형을 일치 시키시오. 
단, 날짜의 형태는 ‘01-01-2020’ 포맷으로 사용한다. 
즉 sysdate - ‘01-01-2020’ 이와같은 연산이 가능해야한다. 
*/
select
    sysdate - to_date('01-01-2023') from dual; -- 계산하는 날짜의 형식이 달라 연산불가

select
    sysdate - to_date('23/01/01')"기본 날짜 서식 사용", -- 날짜의 형식 바꿔주면 연산가능 확인
    to_date('01-01-2023','dd/mm/yyyy') "날짜 서식 사용", -- 날짜의 형식 바꿔주기
    trunc(sysdate - to_date('01-01-2023','dd/mm/yyyy')) "날짜연산" -- 연산
 from dual;


/*
6. 사원들의 메니져 사번을 출력하되 상관이 없는 사원에 대해서는 
NULL값 대신 0으로 출력하시오.
*/
select * from emp;
select ename, nvl(mgr,0) from emp;

/*
7. decode 함수로 직급에 따라 급여를 인상하여 출력하시오. 
'CLERK'는 200, 'SALESMAN'은 180, 'MANAGER'은 150, 'PRESIDENT'는 100을
인상하여 출력하시오.
*/
select * from emp;
select ename, job, decode(job,
    'CLERK', sal + 200,
    'SALESMAN', sal+180,
    'MANAGER', sal+150,
    'PRESIDENT', sal+100,
    sal) "변동임금" 
 from emp order by job;
       

    
    
    
    