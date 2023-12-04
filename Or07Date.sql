/*
파일명 : Or07Date.sql
형변환 함수 / 날짜함수
설명 : 년, 월, 일, 시, 분, 초의 포맷으로 날짜형식을 지정하거나
    날짜를 계산할 때 사용하는 함수들
HR계정으로 하기
*/

/*
months_between() :
현재 날짜와 기준날짜 사이의 개월수를 반환한다
    형식] months_between(현재날짜, 기준날짜[과거날짜]);
*/
--2020년 1월 20일(코로나 첫 발생일)부터 지금까지 지난 개월수는??
select
    months_between(sysdate, '2020-01-20') " 기본 날짜 서식",
    months_between(sysdate, to_date('2020년01월20일','yyyy"년"mm"월"dd"일"')) "to_date사용",
    ceil(months_between(sysdate, to_date('2020년01월20일','yyyy"년"mm"월"dd"일"'))) "소수점처리",
    add_months(sysdate,4)
 from dual;

/*
퀴즈] employees 테이블에 입력된 직원들의 근속개월수를 계산하여 출력하시오.
    단, 근속개월수의 오름차순으로 정렬하시오
*/
select
    first_name, hire_date, months_between(sysdate, hire_date) "근속개월수1",
    trunc(months_between(sysdate, hire_date)) "근속개월수2"
 from employees order by "근속개월수2";
 --                          ㄴ order by trunc(months_between(sysdate, hire_date))
 
/*
select 결과를 정렬하기 위해 orderby를 사용할 때 컬럼명은 
위와 같이 두가지 형태로 사용할 수 있다
방법1 - 계산식이 포함된 컬럼을 그대로 사용한다
방법2 - 별칭을 사용한다
*/

/*
next_day() : 현재날짜를 기준으로 인자로 주어진 요일에 해당하는 
    미래의 날짜를 반환하는 함수
    형식] next_day(현재날짜, '월요일')
        => 다음주 월요일은 몇일일까요?
*/
select 
    to_char(sysdate, 'yyyy-mm-dd') "오늘날짜" ,
    next_day(sysdate, '월요일') "다음 월요일",
    to_char(next_day(sysdate, '월요일'), 'yyyy-mm-dd') "날짜서식지정"
 from dual;
 
/*
last_day() : 해당월의 마지막 날짜를 반환
*/
select last_day('23-12-01') from dual; -- 23년 12월의 마지막 날짜 23/12/31 반환
select last_day('23-02-01') from dual; -- 23년 2월의 마지막 날짜 23/22/28 반환
select last_day('24-02-01') from dual; -- 24년 2월의 마지막 날짜 23/22/29 반환(윤년)

-- 컬럼이 date타입인 경우 간단한 날짜연산이 가능하다.

select
    sysdate "오늘",
    sysdate+1 "내일",
    sysdate-1 "어제",
    sysdate+14 "보름후"
 from dual;
