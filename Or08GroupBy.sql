/*
���ϸ� : Or08GruopBy.sql
�׷��Լ�(select�� 2��°)
���� : ��ü ���ڵ�(row)���� ������� ����� ���ϱ� ����
    �� �� �̻��� ���ڵ带 �׷����� ��� ���� �� ����� ��ȯ�ϴ� �Լ�/������
HR�������� �ϱ�
*/

--������̺��� ������ ���� : �� 107���� �����
select job_id from employees;

/*
distinct
    -������ ���� �ִ� ��� �ߺ��� ���ڵ带 ������ �ϳ��� �����ͼ� �����ش�
    -�ϳ��� ������ ���ڵ��̹Ƿ� ������� ���� ��� �� �� �ִ�
*/
select distinct(job_id) from employees;



/*
group by
    - ������ ���� �ִ� ���ڵ带 �ϳ��� ������ ��� �����´�
    - �������°� �ϳ��� ���ڵ����� �ټ��� ���ڵ尡 �ϳ��� �׷����� 
    ������ ����̹Ƿ� ������ΰ��� ����� �� �ִ�
    - �ִ� �ּ� ��� �ջ���� ������ �����ϴ�
*/
--�� �������� �������� ������� ī��Ʈ�Ѵ�.
select job_id, count(*) from employees group by job_id; 

--������ ���� �ش������ ���� select�ؼ� ����Ǵ� ���� ������ ���غ���
select first_name, job_id from employees where job_id='FI_ACCOUNT';
select first_name, job_id from employees where job_id='ST_CLERK';


/*
group���� ���Ե� select���� ����

select
	�÷�1, �÷�2,.......�÷�N Ȥ�� *(��ü)
from
	���̺��
[where 
	����1 and ����2 or ����N....]
[group by
	������ �׷�ȭ�� ���� �÷���]
[having
	�׷쿡�� ã�� ����]
[order by
	������ ������ ���� �÷��� ���Ĺ��]
	
�������� �������
	from(���̺�) -> where(����) -> group by(�׷�ȭ) -> 
    having(�׷�����) -> select(�÷�����) -> order by(���Ĺ��)

*/
/*
sum() : �հ踦 ���� �� ����ϴ� �Լ�
    - numbrt Ÿ���� �÷������� ����� �� �ִ�.
    - �ʵ���� �ʿ��� ��� as�� �̿��ؼ� ��Ī�� �ο��� �� �ִ�.
*/
--��ü ������ �޿��� �հ踦 ����Ͻÿ�
select
    sum(salary) as sumSalary1,
    to_char(sum(salary), '999,000') sumsalary2,
    ltrim(to_char(sum(salary), '$999,000')) sumsalary3,
    ltrim(to_char(sum(salary), 'L999,000')) sumsalary4
    from employees;
    
--10�� �μ��� �ٹ��ϴ� ������� �޿��հ�� ������ ����Ͻÿ�.
select
    sum(salary) "�޿��հ�",
    ltrim(to_char(sum(salary), '$999,000')) "������������, ���ڸ� �޸�, �޷�ǥ��"
 from employees where department_id = 10;
 
--sum�� ���� �׷��Լ��� numberŸ���� �÷������� ����� �� �ִ�.
select sum(first_name) from employees; -- �����߻�

/*
count() : �׷�ȭ�� ���ڵ��� ������ ī��Ʈ�� �� ����ϴ� �Լ�
*/
select count(*) from employees;
select count(employee_id) from employees;
--count�Լ��� ����� ���� �� 2���� ��� ��� �����ϳ� *�� ����Ұ��� ������
--�÷�(_)�� Ư��Ȥ�� �����Ϳ� ���� ���ظ� ���� �ʾ� ����ӵ��� ������.
/*
count()�Լ��� 
    ���� 1 : count(all �÷���)
        => ����Ʈ �������� �÷� ��ü�� ���ڵ带 �������� ī��Ʈ �Ѵ�.
    ���� 2 : count(distinct �÷���)
        => �ߺ��� ������ ���¿��� ī��Ʈ�Ѵ�
*/
select
    count(job_id) "��������ü����",
    count(all job_id) "������ ��ü ����2",
    count(distinct job_id) "������ �ߺ�����"
 from employees;
 
/*
avg() : ��հ��� ���� �� ����ϴ� �Լ�
*/
-- ��ü ����� ��� �޿��� ������ ����ϴ� �������� �ۼ��Ͻÿ�.
select
    count(*) "��ü������",
    sum(salary) "��� �޿��� ��",
    sum(salary)/count(*) "��ձ޿�->�������",
    avg(salary) "��ձ޿�->avg�Լ�",
    trim(to_char(avg(salary),'$999,000')) "���� �� ��������"
 from employees;
 
 -- ������(SALES)�� ��� �޿��� ���ΰ���
 -- 1. �μ����̺��� ������ �μ���ȣ���� Ȯ���Ѵ�
 -- 2. �����˻��� ��ҹ���/������ ���Ե� ��� ��� ���ڵ忡 ���� 
 --     ���ڿ��� Ȯ���ϴ� ���� �Ұ��� �ϹǷ� �ϰ����� ��Ģ��
 --     ������ ���� upper()�� ���� ��ȯ�Լ��� Ȱ���Ͽ� �˻��ϴ� ���� ����
 
 select * from departments where department_name = initcap('sales');//initcap << ù���� �빮��
 select * from departments where lower(department_name) = 'sales';
 select * from departments where upper(department_name) = upper('sales');
 
 -- �μ� ��ȣ�� 80�� ���� Ȯ�� �� ���� �������� �ۼ��Ѵ�
 select ltrim(to_char(avg(salary), '$999,000')) "������ ��ձ޿�"
    from employees where department_id = 80;

/*
min(), max() �Լ� : �ִ밪,�ּҰ��� ã�� �� ����ϴ� �Լ�
*/
-- ��ü ����� ���� ���� �޿��� ���ΰ�?
select min(salary) from employees; -- 2100
-- ���� ���� �޿��� �޴� ������ �����ΰ�
select first_name, salary from employees where salary=min(salary);
      --�� �������� ���� ������ �߻���, �׷��Լ��� �Ϲ��÷��� ��� �Ұ����ϴ�
-- ������̺��� ���� ���� �޿��� 2100�� �޴� ����� �����Ѵ�
select first_name, salary from employees where salary=2100;
/*
����� ���� ���� �޿��� min()���� ���� �� ������, ���� ���� �޿��� �޴� �����
�Ʒ��� ���� ���������� ���� ���� �� �ִ�. ���� ������ ���� ���������� �������
���θ� �����ؾ��Ѵ�.
*/
select first_name, salary
    from employees where salary=(select min(salary) from employees); --���������̸�����

/*
group by �� : �������� ���ڵ带 �ϳ��� �׷����� �׷�ȭ�Ͽ� 
        ������ ����� ��ȯ�ϴ� ������
        ��distinct << �ܼ��� �ߺ����� ����
*/
-- ������̺��� �� �μ��� �޿��� �հ�� ���ΰ�?
-- IT �μ��� �޿� �հ�
select sum(salary) from employees where department_id =60;--28800
-- Finance�μ��� �޿� �հ�
select sum(salary) from employees where department_id =100; --51608

-- stage 1 : �μ��� ������� ������ �μ����� Ȯ���� �� �����Ƿ� �μ���
--      �׷�ȭ �Ѵ�. �ߺ��� ���ŵ� ����� �������� ������ ���ڵ尡
--      �ϳ��� �׷����� ������ ����� ����ȴ�
select department_id, sum(salary) from employees group by department_id;

-- stage 2 : �� �μ����� �޿��� �հ踦 ���� �� �ִ�. 4�ڸ��� �Ѿ�� ���
--      �������� �������Ƿ� ������ �̿��ؼ� ���ڸ����� �޸��� ǥ���Ѵ�.
select department_id, sum(salary), trim(to_char(sum(salary), '999,000'))
    from employees 
    group by department_id 
    order by sum(salary) desc;

/*
����] ������̺��� �� �μ��� ������� ��� �޿��� ������ ����ϴ�
        �������� �ۼ��Ͻÿ�
        ��°�� : �μ���ȣ, �޿�����, �������, ��ձ޿�
        ��½� �μ���ȣ�� �������� �������� �����Ͻÿ�
*/
select department_id "�μ���ȣ", 
        rtrim(to_char(sum(salary), '999,000')) "�޿�����",
        count(*) "�������",
        rtrim(to_char(avg(salary), '999,000')) "��ձ޿�" 
        from employees
        group by department_id
        order by department_id;
        
/*
�տ��� ����ߴ� �������� �Ʒ��� ���� �����ϸ� ������ �߻��Ѵ�
*/
select
    department_id, sum(salary), count(*), avg(salary), first_name -- firstname�� �����߻�
    from employees
    group by department_id;
/*     ����
group by ������ ����� �÷��� select������ ����� �� ������
�� ���� �����÷��� select������ ����� �� ����.
�׷�ȭ�� ���¿��� Ư�� ���ڵ� �ϳ��� �����ϴ� ���� �ָ��ϱ� �����̴�.
*/




/*
�ó�����] �μ����̵� 50�� ������� ���� ����, ��� �޿�, �޿������� ������
        ����ϴ� �������� �ۼ��Ͻÿ�
*/
 select 
    '50�� �μ�', count(*), round(avg(salary)), sum(salary)
 from employees where department_id = 50
 group by department_id;
 
 /*
 having �� : ���������� �����ϴ� �÷��� �ƴ� �׷��Լ��� ���� ��������
        ������ �÷��� ������ �߰��� �� ����Ѵ�.
        �ش� ������ where���� �߰��ϸ� ������ �߻��Ѵ�.
 */
 /*
 �ó�����] ������̺��� �� �μ����� �ٹ��ϰ� �ִ� ������ ��������
        ������� ��ձ޿��� ������ ����ϴ� �������� �ۼ��Ͻÿ�
        ��, ������� 10�� �ʰ��ϴ� ���ڵ常 �����Ͻÿ�
 */
 --���� �μ��� �ٹ��ϴ��� �������� �ٸ� �� �����Ƿ� �� ���������� 
 --group by�� ���� 2���� �÷��� ����ؾ� �Ѵ�. �� �μ��� �׷�ȭ �� ��
 -- �ٽ� ���������� �׷�ȭ �Ͽ��� �Ѵ�
 
select 
    department_id, job_id, count(*), avg(salary)
 from employees
 where count(*)>10  <<���⼭ �����߻�
 group by department_id, job_id;
 
/* 
 ��� ������ ������� ���������� �����ϴ� �÷��� �ƴϹǷ�
 where���� ���� ������ �߻���, �̷���쿡�� having���� ������ �߰��ؾ��Ѵ�.
 ex) �޿��� 3000�� ��� -> ���������� �����ϹǷ� where���� ���
     ��� �޿��� 3000�� ��� -> �������� �����ϹǷ� having �� ���
                                ��, group�Լ��� ���� ���� �� �ִ� �����ʹ�.
*/
select 
    department_id, job_id, count(*), avg(salary)
 from employees
 group by department_id, job_id
having count(*)>10;

/*******************************************
��������
*******************************************/

--#�ش� ������ hr������ employees ���̺��� ����մϴ�.

/*
1. ��ü ����� �޿��ְ��, ������, ��ձ޿��� ����Ͻÿ�. �÷��� ��Ī�� 
�Ʒ��� ���� �ϰ�, ��տ� ���ؼ��� �������·� �ݿø� �Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
*/
--round(), to_char() : �ݿø� ó�� �Ǿ� ��µ�
--trunc() : �Ҽ� ���ϸ� �߶� ��µ�. �ݿø����� ����.

select max(salary) MaxPay, min(salary) MinPay, 
    to_char(avg(salary),'999,000') Avgpay
    from employees;
    
/*
2. �� ������ �������� �޿��ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. 
�÷��� ��Ī�� �Ʒ��� �����ϰ� ��� ���ڴ� to_char�� �̿��Ͽ� ���ڸ����� 
�ĸ��� ��� �������·� ����Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
�޿��Ѿ� -> SumPay
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
*/
select 
    job_id,
    to_char(max(salary),'999,000') MaxPay, 
    to_char(min(salary),'999,000') MinPay, 
    to_char(avg(salary),'999,000') AvgPay,
    to_char(sum(salary),'999,000') Sumpay
 from employees group by job_id;

    


/*
3. count() �Լ��� �̿��Ͽ� �������� ������ ������� ����Ͻÿ�.
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
*/
--���������� �����ϴ� �÷��� �ƴ϶�� �Լ� Ȥ�� ������ �״�� order by����
--����ϸ�ȴ�.
--������ �ʹ� ��ٸ� ��Ī�� ����ص� �ȴ�. 

select job_id, count(*) from employees group by job_id order by count(*)desc;



/*
4. �޿��� 10000�޷� �̻��� �������� �������� �հ��ο����� ����Ͻÿ�.
*/
select job_id, count(*) from employees where salary>=10000 
    group by job_id order by count(*) desc;

/*
5. �޿��ְ�װ� �������� ������ ����Ͻÿ�. 
*/
select max(salary) �ְ��, min(salary) ������,  max(salary)-min(salary) ���� from employees;

/*
6. �� �μ��� ���� �μ���ȣ, �����, �μ� ���� ��� ����� ��ձ޿��� 
����Ͻÿ�. ��ձ޿��� �Ҽ��� ��°�ڸ��� �ݿø��Ͻÿ�.
*/

select
    department_id, count(*), avg(salary),
    round(avg(salary), 2) "��ձ޿�1",
    to_char(avg(salary), '990,000.00') "��ձ޿�2"
from employees group by department_id
order by department_id;