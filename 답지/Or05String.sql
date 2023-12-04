/*****************
파일명 : Or05String.sql
문자열 처리 함수
설명 : 문자열에 대해 대소문자를 반환하거나 문자열의 길이를 반환하는 등
    문자열을 조작하는 함수
*******************/
-- HR 계정으로 하기

/*
concat('문자열1', '문자열2')
    : 문자열1과 문자열2를 연결해서 출력하는 함수
    사용법1 : concat('문자열1', '문자열2')
    사용법2 : '문자열1' || '문자열2'
*/
select concat('Good ', 'morning') as "아침 인사" from dual;
select 'Good ' || 'morning' from dual;

select 'Oracle '||'21C '||'Good...!!' from dual;
-- => 위 SQL문을 concat()으로 변경하면 다음과 같다.(조금 불편하다)
select concat(concat('Oracle ', '21C '), 'Good...!!') from dual;

/*
시나리오] 사원테이블에서 사원의 이름을 연결해서 아래와 같이 출력하시오.
    출력내용 : first+lasr name, 급여, 부서번호
*/
-- step1 : 이름을 연결해서 출력하지만 띄어쓰기가 안돼서 가독성이 떨어진다.
select concat(first_name, last_name), salary, department_id
    from employees;
-- step2 : 스페이스를 추가하기 위해 concat()을 하나 더 사용한다.
select concat(concat(first_name, ' '), last_name), salary, department_id
    from employees;
/*step3 : 2개의 함수를 사용하는 것보다는 ||을 이용하면 간단히 표현할 수
있어 편리하다. 또한 컬럼명에는 as을 이용해서 별칭을 부여한다.*/
select first_name || ' ' || last_name as fullname, salary, department_id
    from employees;

/*
initcap(문자열)
    : 문자열의 첫문자만 대문자로 변환하는 함수
    단, 첫문자를 인식하는 기준은 다음과 같다.
    - 공백문자 다음에 나오는 첫문자를 대문자로 변환한다.
    - 알파벳과 숫자를 제외한 나머지 문자 다음에 나오는 첫번째 문자를
    대문자로 변환한다.
*/
-- hi, hello의 첫글자를 대문자로 변경
select initcap('hi hello 안녕')from dual;
-- g, b, m이 대문자로 변경된다.
select initcap('good/bad morning')from dual;
-- n, g, b가 대문자로 변경된다. 6은 숫자이므로 say는 변경되지 않는다.
select initcap('naver6say*good가bye')from dual;

/*
시나리오] 사원테이블에서 first_name이 john인 사원을 찾아 인출하시오.
*/
-- 이와같이 쿼리하면 결과가 인출되지 않는다.(데이터는 대소문자를 구분한다.)
select * from employees where first_name='john';
-- 따라서 아래와 같이 함수를 사용하거나 대문자가 포함된 이름을 사용해야 한다.
-- 둘다 3개의 검색 결과가 인출된다.
select * from employees where first_name=initcap('john');
select * from employees where first_name='John';

/*
대소문자 변경하기
    lower() : 소문자로 변경함.
    upper() : 대문자로 변경함.
*/
select lower('GOOD'), upper('bad') from dual;
-- 위와같이 john을 검색하기 위해 다음과 같이 활용할수도 있다.
-- 컬럼자체를 대문자 혹은 소문자로 변경한 후 쿼리한다.
select * from employees where lower(first_name)='john';
select * from employees where upper(first_name)='JOHN';

/*
lpad(), rpad()
    : 문자열의 왼쪽, 오른쪽을 특정한 기호로 채울때 사용한다.
    형식] lpad('문자열', '전체자리수', '체울문자열')
        -> 전체자리수에서 문장열의 길이만큼을 채워주는 함수
        rpad()는 오른쪽을 채워줌.
*/
-- 출력결과 : good,	###good, good###, ...good(공백 3개가 좌측에 출력됨)
select 'good', lpad('good', 7, '#'), rpad('good', 7, '#'), lpad('good', 7)
    from dual;
-- 이름 전체를 12자로 간주하여 이름을 제외한 나머지 부분을 *로 채운다.
select  rpad(first_name, 12, '*') from employees;
select  rpad(first_name, 12, '*')||rpad(last_name, 12) as fullname 
    from employees;

/*
substr() : 문자열에서 시작인덱스부터 길이만큼 잘라서 문자열을 출력한다.
    형식] substr(컬럼, 시작인덱스, 길이)
    
    참고1] 오라클의 인덱스는 1부터 시작한다.(0부터 아님)
    참고2] '길이'에 해당하는 인자가 없으면 문자열의 끝까지를 의미한다.
    참고3] 시작인덱스가 ㅇ므수면 우측끝부터 좌측으로 인덱스를 적용한다.
*/
select substr('good morning john', 8, 4) from dual;
select substr('good morning john', 8) from dual;

/*
시나리오] 사원테이블의 first_name을 첫글자를 제외한 나머지 부분을 
    *로 마스킹 처리하는 쿼리문을 작성하시오.
*/
-- substr(문자열 혹은 컬럼, 시작인덱스, 길이) : 시작인덱스부터 길이만큼
-- 잘라낸다.
select substr('abcdefg', 1, 1) from dual;
select substr(first_name, 1, 1) from employees;
-- 문자열의 길이를 10으로 지정하여 남은 부분을 *로 채운다.
-- 즉 이름을 제외한 나머지 5를 *로 채원준다.
select rpad('Ellen', 10, '*') from dual;
-- length(문자열 혹은 컬럼) : 해당 문자열의 길이를 반환한다.
select
    first_name,
    rpad(substr(first_name, 1, 1), length(first_name), '*') "마스킹"
 from employees;

/*
trim() : 공백을 제거할 때 사용한다.
    형식] trim([leading | trailing | both] 제거할 문자 from 컬럼명)
        leading : 왼쪽에서 제거함
        trailing : 오른쪽에서 제거함
        both : 양쪽에서 제거함. 설정값이 없으면 both가 디폴트
        [주의1] 양쪽의 문자만 제거되고, 중간에 있는 문자는 제거되지 않음.
        [주의2] 문자만 제거할 수 있고, '문자열'은 제거할 수 없다. 에러발생됨.
*/
select ' 공백제거테스트' as trim1, 
    trim(' 공백제 거테스트 ') as trim2, -- 양쪽의 공백 제거됨
    trim('다' from '다람쥐가 다 나무를 탑니다') trim3,    --  양쪽의 '다' 제거
    trim(both '다' from '다람쥐가 나무를 탑니다') trim4,  -- both 는 디폴트 옵션
    trim(leading '다' from '다람쥐가 나무를 탑니다') trim5, -- 좌측의 '다' 제거
    trim(trailing '다' from '다람쥐가 나무를 탑니다') trim6 -- 우측의 '다' 제거
 from dual;
-- trim()은 중간의 문자는 제거할 수 없고, 양쪽의 문자만 제거할 수 있다.

-- trim()은 문자열을 제거할 수 없어 에러가 발생한다.
select
    trim('다람쥐' from '다람쥐가 나무를 타다가 떨어졌어요TT') TrimError
 from dual;

/*
ltrim(), rtrim() : L[eft]Trim, R[ight]Trim
    : 좌측, 우측 '문자' 혹은 '문자열'을 제거할 때 사용한다.
    * TRIM은 문자열을 제거할 수 없지만, LTRIM, RTRIM은 문자열까지
    제거할 수 있다.
*/
select 
    ltrim(' 좌측공백제거 ') ltrim,  -- 좌측 공백이 제거된다.
    -- 이경우 좌측에 스페이스가 포함된 문자열이므로 삭제되지 않는다.
    ltrim(' 좌측공백제거 ', '좌측') ltrim2,
    -- 여기서는 '좌측'이라는 문자열이 삭제된다.
    ltrim('좌측공백제거 ', '좌측') ltrim3,
    -- 우측의 문자열이 제거된다.
    rtrim('우측공백제거', '제거') rtrim1,
    -- 문자열 중간은 제거되지 않는다.
    rtrim('우측공백제거 ', '공백') rtrim2
from dual;

/*
substrb() :바이트 단위로 문자열을 자를 때 사용한다.
    형식] substrb(문자열, 시작위치, 길이)
*/
SELECT * 
  FROM nls_database_parameters 
 WHERE parameter LIKE '%CHARACTERSET%';  -- 한글 1글자는 3바이트임.
 -- 4바이트 부터 출력. 그래서 '녕하세요'
select substrb('안녕하세요', 4) from dual;  
select substrb('JONES', 2, 4) from dual;

/*
replace() : 문자열을 다른 문자열로 대체할 때 사용한다. 만약 공백으로
    문자열을 대체한다면 문자열이 삭제되는 결과가 된다.
    형식] replace(컬럼명 or 문자열, '변경할 대상의 문자', '변경할 문자')
    
    * trim(), ltrim(), rtrim() 함수의 기능을 replace()함수 하나로 대체할 수 
    있으므로 trim() 에 비해 replace()가 훨씬 더 사용빈도가 높다.
*/
-- 문자열을 변경한다.
select replace('good morning john', 'morning', 'evening') from dual;
-- 문자열을 삭제한다. 빈문자열로 변경되므로 삭제라고 할수 있다.
select replace('good morning john', 'john', '') from dual;
-- trim은 양쪽의 공백만 제거된다.
select trim(' good morning john ') as "공백" from dual;
-- replace는 좌우측뿐 아니라 중간의 공백돟 제거할 수 있다.
select replace(' good morning john ', ' ', '') from dual;

-- 102번 사원의 레코드를 대상으로 문자열 변경을 해보자.
select first_name, last_name,
    ltrim(first_name, 'L') "좌측 L 제거",
    rtrim(first_name, 'ex') "우측 ex 제거",
    replace(last_name, ' ', '') "중간 공백 제거",
    replace(last_name, 'De', 'Dea') "성변경"
 from employees where employee_id=102;

/*
instr() : 해당 문자열에서 특정 문자가 위치한 인덱스값을 반환한다.
    형식1] instr(컬럼명, '찾을 문자')
        : 문자열의 처음부터 문자를 찾는다.
    형식2] instr(컬럼명, '찾을 문자', '탐색을 시작할 인덱스', '몇번째 문자')
        : 탐색할 인덱스부터 문자를 찾는다. 단, 찾는 문자중 몇번째에 있는
        문자인지 지정할 수 있다.
    * 탐색을 시작할 인덱스가 음수인 경우 우측에서 좌측으로 찾게된다.
*/
-- n이 발견된 첫번재 인덱스 반환
select instr('good morning john', 'n') from dual;
-- 인덱스1부터 탐색을 시작해서 n이 발견된 두번째 인덱스 반환
select instr('good morning john', 'n', 1, 2) from dual;
-- 인덱스 8부터 탐색을 시작하여 h가 발견된 첫번째 인덱스 반환
select instr('good morning john', 'h', 8, 1) from dual;


