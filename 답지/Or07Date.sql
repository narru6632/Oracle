/*****************
���ϸ� : Or07Date.sql
��¥�Լ�
���� : ��, ��, ��, ��, ��, ���� �������� ���������� �����ϰų�
    ��¥�� ����� �� Ȱ���ϴ� �Լ���
*******************/
-- HR �������� �ϱ�

/*
months_between() : ���糯¥�� ���س�¥ ������ �������� ��ȯ�Ѵ�.
    ����] months_between(���糯¥, ���س�¥[���ų�¥]);
*/
-- 2020�� 1�� 20��(�ڷγ� ù �ߺ���)���� ���ݱ��� ���� ��������??
select
    months_between(sysdate, '2020-01-20') "�⺻��¥ ����",
    months_between(sysdate, 
        to_date('2020��01��20��', 'yyyy"��"mm"��"dd"��"')) "to_date���",
    ceil(months_between(sysdate, 
        to_date('2020��01��20��', 'yyyy"��"mm"��"dd"��"'))) "�Ҽ��� �ø� ó��",
    add_months(sysdate, 4)
 from dual;

/*
����] employees ���̺� �Էµ� �������� �ټӰ������� ����Ͽ� ����Ͻÿ�.
    ��, �ټӰ������� ������������ �����Ͻÿ�.
*/
select
    first_name, hire_date,
    months_between(sysdate, hire_date) "�ټӰ�����1",
    trunc(months_between(sysdate, hire_date)) "�ټӰ�����2"
 from employees
    order by "�ټӰ�����2" asc;
--    order by trunc(months_between(sysdate, hire_date)) asc;
/*
select ����� �����ϱ� ���� order by �� ����� �� �÷����� ���Ͱ���
2���� ���·� ����� �� �ִ�.
���1 : ������ ���Ե� �÷��� �״�� ����Ѵ�.
���2 : ��Ī�� ����Ѵ�.
*/

/*
next_day() : ���糯¥�� �������� ���ڷ� �־��� ���Ͽ� �ش��ϴ� 
    �̷��� ���ڸ� ��ȯ�ϴ� �Լ�
    ����] next_day(���糯¥, '������')
        => ������ �������� �����ϱ��?
*/
select
    to_char(sysdate, 'yyyy-mm-dd') "���ó�¥",  --1
    next_day(sysdate, '������') "����������",   --2
    to_char(next_day(sysdate, '������'), 'yyyy-mm-dd') "��¥ ��������"   -- 1+2
 from dual;

/*
last_day() : �ش���� ������ ���ڸ� ��ȯ�Ѵ�.
*/
select last_day('23-12-01') from dual;  -- 23�� 12���� ������ 31��
select last_day('23-02-01') from dual;  -- 25�� ���
select last_day('24-02-01') from dual;  -- 2024���� �����̹Ƿ� 29�� ��µ�.

-- �÷��� dateŸ���� ��� ���� ���� ������ �����ϴ�.
select 
    sysdate "����", 
    sysdate+1 "����", 
    sysdate-1 "����",
    sysdate+15 "������"
from dual;





