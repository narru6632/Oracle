/*****************
���ϸ� : Or04Number.sql
����(����) ���� �Լ�
���� : ���ڵ����͸� ó���ϱ� ���� ���ڰ��� �Լ��� �˾ƺ���.
    ���̺� ������ number Ÿ������ ����� �÷��� ����� �����͸�
    ������� �Ѵ�.
*******************/
-- HR �������� �ϱ�
-- ���� ������ ������ ������ ���̺�, �並 �����ش�.
select * from tab;

select * from seoulit;
/*
Dual ���̺�
    : �ϳ��� ������ ����� ����ϱ� ���� �����Ǵ� ���̺��
    ����Ŭ���� �ڵ����� �����Ǵ� ���� ���̺��̴�.
    vachar2(1)�� ���ǵ� dummy��� �� �ϳ��� �÷����� �����Ǿ��ִ�.
*/
select * from dual;
select 1+2 from dual;

/*
abs() : ���밪 ���ϱ�
*/
select abs(12000) from dual;
select abs(-9000) from dual;
select abs(salary) "�޿��� ���밪" from employees;

/*
trunc() : �Ҽ����� Ư���ڸ������� �߶󳾶� ����ϴ� �Լ�
    ���� : trunc(�÷� Ȥ�� ��, �Ҽ� ���� �ڸ���)
        �ι��� ���ڰ�
            ����϶� : �־��� ���ڸ�ŭ �Ҽ����� ǥ��
            ������ : �����θ� ǥ��. �� �Ҽ��� �Ʒ��κ��� ������
            �����϶� : �����θ� ���ڸ�ŭ �ڸ��� �������� 0���� ä��
*/
select trunc(12345.12345, 2) from dual;
select trunc(12345.12345) from dual;
select trunc(12345.12345, -2) from dual;
-- �ݾ��̶�� 100�������� ����� ���� ���·� Ȱ���� �� �ִ�.

/*
�ó�����] ������̺��� ��������� 1000�ҿ� ���� Ŀ�̼��� ����Ͽ� 
    �޿��� ���� ����� ����ϴ� �������� �ۼ��Ͻÿ�.
    Ex) �޿� : 1000, ���ʽ��� : 0.1
        => 1000 + (1000*0.1) = 1100
*/
-- 1. ��������� ���� ã�� �����Ͻÿ�.(��������� job_id�� SA_XX�� �Ǿ��ִ�.
select * from employees where job_id like 'SA_%';
-- ��������� Ŀ�̼��� �ޱ⶧���� ���� ����Ǿ��ִ�.)
select * from employees where commission_pct is not null;
-- 2. Ŀ�̼��� ����Ͽ� �̸��� �Բ� ����Ѵ�.
select first_name, salary, commission_pct, (salary + (salary*commission_pct))
    from employees where job_id like 'SA_%';
-- 3. Ŀ�̼��� �Ҽ��� 1�ڸ����������� �ݾ� ����ϱ�
select first_name, salary, trunc(commission_pct,1), 
    (salary + (salary*trunc(commission_pct,1)))
    from employees where job_id like 'SA_%';
-- 4. ������ ���Ե� �÷����� ��Ī�� �ο��Ѵ�.
select first_name, salary, trunc(commission_pct,1) comm_pct, 
    (salary + (salary*trunc(commission_pct,1))) as TotalSalary
    from employees where job_id like 'SA_%';

/*
�Ҽ��� �����Լ�
    ceil() : �Ҽ��� ���ϸ� ������ �ø�ó��
    floor() : ������ ���� ó��
    round(��, �ڸ���) : �ݿø� ó��
        �ι�° ���ڰ�
            ������ : ���ڸ�ŭ �Ҽ����� ǥ���ǹǷ� �� �������� 5�̻��̸� �ø�, 
            5�̸��̸� ����.
            ������ : �Ҽ��� ù��°�ڸ��� 5�̻��̸� �ø�, 5�̸��̸� ����.
*/
select ceil(32.8) from dual;
select ceil(32.2) from dual;

select floor(32.8) from dual;
select floor(32.2) from dual;

select round(0.123), round(0.533) from dual;
-- ù��° �׸� : �Ҽ����� 6�ڸ����� ǥ���ϹǷ� 7�� �ø�ó���Ѵ�.
-- �ι�° �׸� : �Ҽ����� 4�ڸ����� ǥ���ϹǷ� 1�� ����ó���Ѵ�.
select round(0.1234567, 6), round(2.345612, 4) from dual;

/*
mod() : �������� ���ϴ� �Լ�
power() : �ŵ������� ���ϴ� �Լ�
sqrt() : ������(��Ʈ)�� ���ϴ� �Լ�
*/
select mod(99,4) "99�� 4�� ���� ������" from dual;
select power(2,10) "2�� 10��" from dual;
select sqrt(49) "49�� ������" from dual;

/*
��������] ������̺��� ���ʽ����� �ִ� ����� ������ �� ���ʽ����� 
    �Ҽ��� 1�ڸ��� ǥ���Ͻÿ�. 
    ��³��� : �̸�, �޿�, ���ʽ���
*/
-- 1.Ŀ�̼��� �ִ� ����� ����
select first_name, last_name, salary, commission_pct from employees
    where commission_pct is not null;
-- 2.�Ҽ��� ó���ϱ�
select first_name, last_name, salary, trunc(commission_pct,1) 
    from employees
    where commission_pct is not null
 order by trunc(commission_pct,1);

