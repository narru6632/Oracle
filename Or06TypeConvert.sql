/*
���ϸ� : Or06TypeConvert.sql
����ȯ �Լ� / ��Ÿ�Լ�
���� : ������ Ÿ���� �ٸ� Ÿ������ ��ȯ�ؾ� �� �� ����ϴ� �Լ���
    ��Ÿ�Լ�
HR�������� �ϱ�
*/

/*
sysdate : ���糯¥�� �ð��� �ʴ����� ��ȯ���ش�. �ַ� �Խ����̳�
    ȸ�����Կ��� ���ο� �Խù��� ���� �� �Է��� ��¥�� ǥ���ϱ� ����
    ���ȴ�.
*/
select sysdate from dual;

/*
��¥ ���� : ����Ŭ�� ��ҹ��ڸ� �������� �����Ƿ�, ���Ĺ��� ���� �������� �ʴ´�
���� mm�� MM�� ������ ����� ����Ѵ�
*/
select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'YY/MM/DD') from dual;


--���� ��¥�� "������ 0000�� 00�� 00�� �Դϴ�."�� ���� ���·� ����Ͻÿ�
select to_char(sysdate, '������ yyyy�� mm�� dd���Դϴ�.') from dual;--����
--������(-), ������(/) ���� ���ڴ� �ν����� ���ϹǷ� ���Ĺ��ڸ� ������ ������
--    ���ڿ��� ���������̼�(")���� ��������Ѵ�. '���Ĺ��ڸ� ����'<<����
select to_char(sysdate, '"������ "yyyy"�� "mm"�� "dd"���Դϴ�."') from dual;


--�����̳� �⵵�� ǥ���ϴ� ���Ĺ��ڵ�
select
    to_char(sysdate,'day') "����(ȭ����)",
    to_char(sysdate,'dy') "����(ȭ)",
    to_char(sysdate,'dd') "���� ���ڷ�ǥ��",
    to_char(sysdate,'ddd') "�ϳ��� ���° ������",
    to_char(sysdate,'mon') "��(4��)",
    to_char(sysdate,'mm') "��(04)",
    to_char(sysdate,'month') "��(4��)",
    to_char(sysdate,'yy') "���ڸ��⵵"
    from dual;
    
/*
�ó�����] ������̺��� ����� �Ի����� ������ ���� ����� �� �ֵ���
    ������ �����Ͽ� �������� �ۼ��Ͻÿ�.
    ���] 0000�� 00�� 00�� 0����
*/
select first_name, last_name, to_char(hire_date, 
    '"�Ի����� "yyyy"�� "mm"�� "dd"�� "day" �Դϴ�."') 
    from employees order by hire_date;
    
/*
�ð� ���� : ����ð��� 00:00:00 ���·� ǥ���ϱ�
    �Ǵ� ��¥�� �ð��� ���ÿ� ǥ���� ���� �ִ�.
*/
select
    to_char(sysdate, 'HH:MI:SS'),
    to_char(sysdate, 'hh:mi:ss'), -- �ҹ��� ���� x
    to_char(sysdate, 'hh24:mi:ss'), -- 24�� ǥ��
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') "����ð�"
    from dual;

/*
���� ����
    0: ������ �ڸ����� ��Ÿ���� �ڸ����� ���� �ʴ� ��� 0 ���� �ڸ��� ä���
    9: 0�� ����������, �ڸ����� �����ʴ� ��� �������� ä���.
*/ 

select 
    to_char(123, '0000'), -- 0123, 0�� �������� ����ϸ� �����ڸ��� 0�� ä��
    to_char(123, '9999'), -- 123, 9�� �������� ����ϸ� �����ڸ��� �����̵� (trim���� ���Ű���)
    trim(to_char(123,'9999')) -- ��������
 from dual;
 
 --������ ���ڸ����� �ĸ�(,) ǥ���ϱ�
 --�ڸ����� Ȯ���� ����ȴٸ� 0 ���, �ڸ����� �ٸ��κп��� 9�� ����� ������ �����Ѵ�.
 --��� ������ trim()���� �Լ��� ���� ����
 
select
    12345,
    to_char(12345, '000,000'), to_char(12345, '999,999'),
    ltrim(to_char(12345, '999,999')) 
 from dual;
 
 
-- ��ȭǥ�� : L -> �� ���� �´� ��ȭǥ�ð� �ȴ� -> �츮���� = ��
select to_char(1000000, 'L9,999,000') from dual;

/*
���� ��ȯ �Լ�
    to_number() : ������ �����͸� ���������� ��ȯ�Ѵ�
*/

select to_number('123') + to_number('456') from dual; --���������� �ٲ�� ��꼺��

select to_number('123a') + to_number('456') from dual; --����a�� �����־� �����߻�

/*
to_date() : ���ڿ� �����͸� ��¥�������� ��ȯ�ؼ� ������ش�.
    �⺻ ������ ��/��/�� ������ ����
*/
select to_date('2023-06-13')"��¥�⺻����", 
to_date('20230613') "��¥�⺻����",
to_date('2023/06/13') "��¥�⺻����"
 from dual;
--��¥ ������ ��-��-�� ���� �ƴ� ��쿡�� ����Ŭ�� �ν����� ���Ͽ� �����߻�
--�̶��� ��¥������ �̿��� ����Ŭ�� �νİ����ϰ� �ۼ������ �Ѵ�
select to_date('16-06-2024') from dual; -- ��¥���Ŀ� �����ʾ� �����߻�


/*
����] '2023-11-23 17:49:30�� ���� ������ ���ڿ��� 
    ��¥�� �ν��� �� �ֵ��� �������� �ۼ��Ͻÿ�
*/
--��¥ ������ �ν����� ���ϹǷ� �����߻�
select to_date('2023-11-23 17:49:30') from dual;  --����

-- ��� 1  : ���ڿ��� �߶� ���
-- ���ڿ��� �Ʒ��� ���� �߶� �����Ѵٸ� ��¥�������� �ν��� �� �ִ�.
select to_date('2023-11-23') from dual;
-- substr()�Լ��� ���ڿ��� ��¥�κи� �߶� to_date�� ���ڷ� ����Ѵ�.
select substr('2023-11-23 17:49:30',1,10) "���ڿ� �ڸ���",
to_date(substr('2023-11-23 17:49:30',1,10)) "��¥ �������� ����"
from dual;

-- ��� 2 : ��¥�� �ð� ������ ���
select to_date('2023-11-23 17:49:30', 'yyyy-mm-dd hh24:mi:ss') from dual;
--�ð������ �ȵ�

/*
����]���ڿ� '2022/12/25'�� � �������� ��ȯ�Լ��� ���� ����غ��ÿ�.
    ��, ���ڿ��� ���Ƿ� ������ �� ����.
*/

select to_char('2022/12/25') from dual; -- ��¥����Ȯ��
select to_char(sysdate,'day') from dual; -- ���ϼ���Ȯ��
select to_char(to_date('2022/12/25'),'day') -- ����
 from dual;
    
/*
����]���ڿ�'2024��01��01��'�� � �������� ��ȯ�Լ��� ���� ����غ��ÿ�
�� ���ڿ��� ���Ƿ� ������ �� �����ϴ�.
*/
select
    to_date('2024�� 01�� 01��', 'yyyy "��" mm "��" dd "��"'),
    to_char(to_date('2024�� 01�� 01��','yyyy"��"mm"��"dd"��"'), 'day')
     from dual;

/*
nvl() : null���� �ٸ� �����ͷ� �����ϴ� �Լ�
    ����] nvl(�÷���)
*/
--�̿� ���� ������ �ϸ� ��������� �ƴ� ��� �޿��� null�� ��µȴ�
--null�� ����� ���� null�� �Ǿ������
--���� null�÷��� ������ ó���� �ʿ��ϴ�
select salary+commission_pct from employees;
--null ���� 0���� ������ �� ������ �����ؾ� �������� ����� ��µȴ�
select first_name, commission_pct, salary+nvl(commission_pct, 0) from employees;

/*
decode() : java�� switch���� ����ϰ� Ư������ �ش��ϴ� ��¹��� 
    �ִ� ��� ����Ѵ�.
    ����]decode(�÷���, ��1, ���1, ��2, ���2............, �⺻��)
    *�������� �ڵ尪�� ���ڿ��� ��ȯ�Ͽ� ����� �� ���� ���δ�
*/
select
    first_name, last_name, department_id,
    decode(department_id, 
        10, 'Adminstration', 20, 'Marcketing',--�濵����/������
        30, 'Purchasing', 40, 'Human Resources',--����/�λ�
        50, 'Shipping', 60, 'IT',--����/IT
        70, 'Pubilc Relations', 80, 'Sales',--ȫ��/����
        90, 'Excutive', 100, 'Finance',--�濵/�繫
        110, 'Accounting', '�μ��� Ȯ�� �ȵ�')as department_name --ȸ�� 
     from employees order by department_id;

/*
case() : java�� if~else���� ����� ������ �ϴ� �Լ�
    ����] 
    case
        when ����1 then ��1
        when ����2 then ��2
        .....
        else �⺻��
    end
*/
/*
�ó�����] ������̺��� �� �μ���ȣ�� �ش��ϴ� �μ����� ����ϴ�
    �������� case�� �̿��� �Է��Ͻÿ�
*/
    select
    first_name, last_name, department_id,
    case
        --when ���� then ��
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
        else '�μ��� Ȯ�� �ȵ�'
    end team_name
 from employees order by department_id;
        
 /*************************
��������
*************************/
--scott�������� �����մϴ�.

/*
1. substr() �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ����Ͻÿ�.
*/
select ename, substr(hiredate,1,5) from emp;

/*
2. substr()�Լ��� ����Ͽ� 4���� �Ի��� ����� ����Ͻÿ�. 
��, ������ ������� 4���� �Ի��� ������� ��µǸ� �ȴ�.
*/
select ename "�̸�", substr(hiredate,4,2) as "����" from emp where "����" = 04;
--������� ������ ���� �߻� whereȣ���� selet���� �켱�̹Ƿ� "����"�� �ν���������
select ename "�̸�", hiredate "�����"  from emp where substr(hiredate,4,2) = 04;
--where���� ȣ���� ����� �νİ���


/*
3. mod() �Լ��� ����Ͽ� �����ȣ�� ¦���� ����� ����Ͻÿ�.
mod(�������¼�,������)
*/
select * from emp;
select ename, empno from emp where mod(empno,2)=0;


/*
4. �Ի����� ������ 2�ڸ�(YY), ���� ����(MON)�� ǥ���ϰ� ������ 
���(DY)�� �����Ͽ� ����Ͻÿ�.
*/
select ename, to_char(hiredate,'YY/MONTH/DY') from emp;
select
    hiredate,
    to_char(hiredate, 'yy') "�Ի�⵵",
    to_char(hiredate, 'mon') "�Ի��",
    to_char(hiredate, 'dy') "�Ի����"
 from emp;


/*
5. ���� ��ĥ�� �������� ����Ͻÿ�. ���� ��¥���� ���� 1��1���� �� ����� 
����ϰ� TO_DATE()�Լ��� ����Ͽ� ������ ���� ��ġ ��Ű�ÿ�. 
��, ��¥�� ���´� ��01-01-2020�� �������� ����Ѵ�. 
�� sysdate - ��01-01-2020�� �̿Ͱ��� ������ �����ؾ��Ѵ�. 
*/
select
    sysdate - to_date('01-01-2023') from dual; -- ����ϴ� ��¥�� ������ �޶� ����Ұ�

select
    sysdate - to_date('23/01/01')"�⺻ ��¥ ���� ���", -- ��¥�� ���� �ٲ��ָ� ���갡�� Ȯ��
    to_date('01-01-2023','dd/mm/yyyy') "��¥ ���� ���", -- ��¥�� ���� �ٲ��ֱ�
    trunc(sysdate - to_date('01-01-2023','dd/mm/yyyy')) "��¥����" -- ����
 from dual;


/*
6. ������� �޴��� ����� ����ϵ� ����� ���� ����� ���ؼ��� 
NULL�� ��� 0���� ����Ͻÿ�.
*/
select * from emp;
select ename, nvl(mgr,0) from emp;

/*
7. decode �Լ��� ���޿� ���� �޿��� �λ��Ͽ� ����Ͻÿ�. 
'CLERK'�� 200, 'SALESMAN'�� 180, 'MANAGER'�� 150, 'PRESIDENT'�� 100��
�λ��Ͽ� ����Ͻÿ�.
*/
select * from emp;
select ename, job, decode(job,
    'CLERK', sal + 200,
    'SALESMAN', sal+180,
    'MANAGER', sal+150,
    'PRESIDENT', sal+100,
    sal) "�����ӱ�" 
 from emp order by job;
       

    
    
    
    