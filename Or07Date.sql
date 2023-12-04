/*
���ϸ� : Or07Date.sql
����ȯ �Լ� / ��¥�Լ�
���� : ��, ��, ��, ��, ��, ���� �������� ��¥������ �����ϰų�
    ��¥�� ����� �� ����ϴ� �Լ���
HR�������� �ϱ�
*/

/*
months_between() :
���� ��¥�� ���س�¥ ������ �������� ��ȯ�Ѵ�
    ����] months_between(���糯¥, ���س�¥[���ų�¥]);
*/
--2020�� 1�� 20��(�ڷγ� ù �߻���)���� ���ݱ��� ���� ��������??
select
    months_between(sysdate, '2020-01-20') " �⺻ ��¥ ����",
    months_between(sysdate, to_date('2020��01��20��','yyyy"��"mm"��"dd"��"')) "to_date���",
    ceil(months_between(sysdate, to_date('2020��01��20��','yyyy"��"mm"��"dd"��"'))) "�Ҽ���ó��",
    add_months(sysdate,4)
 from dual;

/*
����] employees ���̺� �Էµ� �������� �ټӰ������� ����Ͽ� ����Ͻÿ�.
    ��, �ټӰ������� ������������ �����Ͻÿ�
*/
select
    first_name, hire_date, months_between(sysdate, hire_date) "�ټӰ�����1",
    trunc(months_between(sysdate, hire_date)) "�ټӰ�����2"
 from employees order by "�ټӰ�����2";
 --                          �� order by trunc(months_between(sysdate, hire_date))
 
/*
select ����� �����ϱ� ���� orderby�� ����� �� �÷����� 
���� ���� �ΰ��� ���·� ����� �� �ִ�
���1 - ������ ���Ե� �÷��� �״�� ����Ѵ�
���2 - ��Ī�� ����Ѵ�
*/

/*
next_day() : ���糯¥�� �������� ���ڷ� �־��� ���Ͽ� �ش��ϴ� 
    �̷��� ��¥�� ��ȯ�ϴ� �Լ�
    ����] next_day(���糯¥, '������')
        => ������ �������� �����ϱ��?
*/
select 
    to_char(sysdate, 'yyyy-mm-dd') "���ó�¥" ,
    next_day(sysdate, '������') "���� ������",
    to_char(next_day(sysdate, '������'), 'yyyy-mm-dd') "��¥��������"
 from dual;
 
/*
last_day() : �ش���� ������ ��¥�� ��ȯ
*/
select last_day('23-12-01') from dual; -- 23�� 12���� ������ ��¥ 23/12/31 ��ȯ
select last_day('23-02-01') from dual; -- 23�� 2���� ������ ��¥ 23/22/28 ��ȯ
select last_day('24-02-01') from dual; -- 24�� 2���� ������ ��¥ 23/22/29 ��ȯ(����)

-- �÷��� dateŸ���� ��� ������ ��¥������ �����ϴ�.

select
    sysdate "����",
    sysdate+1 "����",
    sysdate-1 "����",
    sysdate+14 "������"
 from dual;
