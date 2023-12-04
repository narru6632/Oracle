/*****************
���ϸ� : Or12SubQuery.sql
��������
���� : ������ �ȿ� �� �ٸ� �������� ���� ������ select��
    where���� select���� ����ϸ� ����������� �Ѵ�.
*******************/
-- HR �������� �ϱ�

/*
������ ��������
    �� �ϳ��� �ุ ��ȯ�ϴ� ���������� �񱳿�����(=, <, <=, >, >=, <>)�� 
    ����Ѵ�.
    ����] 
        select * from ���̺�� where �÷�=(
            select �÷� from ���̺�� where ����
        );
    * ��ȣ���� ���������� �ݵ�� �ϳ��� ����� �����ؾ� �Ѵ�.
*/
/*
�ó�����] ������̺��� ��ü����� ��ձ޿����� ���� �޿��� �޴� �������
    �����Ͽ� ����Ͻÿ�.
    ����׸� : �����ȣ, �̸�, �̸���, ����ó, �޿�
*/
-- 1.��� �޿� ���ϱ� : 6462
select avg(salary) from employees;
-- 2.�ش� �������� ���ƻ� �´� �������� �׷��Լ��� �����࿡ ������ 
-- �߸��� �������̴�. ������ �߻��Ѵ�.
select * from employees where salary < avg(salary);
-- 3.�տ��� ���� ��� �޿��� �������� select���� �ۼ��Ͻÿ�.
select * from employees where salary<6462;
-- 4.2���� �������� �ϳ��� �������������� ���ļ� ����� Ȯ���Ѵ�.
select employee_id, first_name, email, phone_number, salary
 from employees where salary<(
    select avg(salary) from employees)
 order by salary;

/*
����] ��ü ����� �޿��� �������� ����� �̸��� �޿��� ����ϴ� 
    ������������ �ۼ��Ͻÿ�.
    ����׸� : �̸�1, �̸�2, �̸���, �޿�
*/
-- 1�ܰ� : �ּұ޿��� Ȯ���Ѵ�.
select min(salary) from employees;
-- 2�ܰ� : 2100�� �޴� ������ ������ �����Ͻÿ�.
select * from employees where salary=2100;
-- 3�ܰ� : 2���� ���� ���ļ� ���������� �����.
select * from employees where salary=(
   select min(salary) from employees);
   
/*
�ó�����] ��Ա޿��� ���� �޿��� �޴� ������� ����� ��ȸ�� �� �ִ�
    ������������ �ۼ��Ͻÿ�.
    ��³��� : �̸�1, �̸�2, ��������, �޿�
    * ���������� jobs ���̺� �����Ƿ� join �ؾ� �Ѵ�.
*/
-- 1�ܰ� : ��ձ޿� ȯ���ϱ�
select round(avg(salary)) from employees;
-- 2�ܰ� : ���̺� ����
select
    first_name, last_name, job_title, salary
 from employees inner join jobs using(job_id)
 where salary>6462;
-- 3�ܰ� : �������������� ����
select
    first_name, last_name, job_title, salary
 from employees inner join jobs using(job_id)
 where salary>(select round(avg(salary)) from employees);

/*
������ �������� : ������ ����������� �ϰ� �������� ���� ��ȯ
    �ϴ� ������ in, any, all, exists�� ����ؾ� �Ѵ�.
    ����] select * from ���̺�� where �÷� in (
                select �÷� from ���̺�� where ����
            );
    * ��ȣ���� ���������� 2�� �̻��� ����� �����ؾ� �Ѵ�.
*/
/*
�ó�����] ���������� ���� ���� �޿��� �޴� ����� ����� ��ȸ�Ͻÿ�.
    ��¸�� : ������̵�, �̸�, ��� ���� ���̵�, �޿�
*/
-- 1�ܰ� : �������� ���� ���� �޿��� Ȯ���Ѵ�.
select job_id, max(salary) from employees group by job_id;
-- 2�ܰ� : ���� ����� �ܼ��� or �������� �����.
-- 19���� ����� ��������� 4�������� ����غ���.
select * from employees where
    (job_id='SH_CLERK' and salary=4200) or
    (job_id='AD_ASST' and salary=4400) or
    (job_id='MK_MAN' and salary=13000) or
    (job_id='MK_REP' and salary=6000);
-- 3�ܰ� : ������ �����ڸ� ���� ���������� �����Ѵ�.
select employee_id, first_name, job_id, salary
 from employees where (job_id, salary) in (
    select job_id, max(salary) from employees group by job_id)
 order by salary;

/*
������ ������ : any(����̶�_�� ������ or�� ����ϴ�.
    ���������� �������� ���������� �˻������ �ϳ��̻�
    ��ġ�ϸ� ���̵Ǵ� ������. �� �� �� �ϳ��� �����ϸ� �ش� ���ڵ带
    �����Ѵ�.
*/
/*
�ó�����] ��ü ����߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿��� 
    �޴� �������� �����ϴ� ������������ �ۼ��Ͻÿ�. �� �� �� �ϳ��� 
    �����ϴ��� �����Ͻÿ�.
*/
-- 1�ܰ� : 20�μ� ���� �޿��� Ȯ���Ѵ�.
select first_name, salary from employees where department_id=20;
-- 2�ܰ� : 1���� ����� �ܼ��� or���� �ۼ��غ���.
select first_name, salary from employees
    where salary>13000 or salary>6000;
-- 3�ܰ� : ���� �ϳ��� �����ϸ� �ǹǷ� �����࿬���� any�� �̿��ؼ� ����������
-- ����� �ȴ�. �� 6000���� ũ�� ���� 13000���� ū �������� �����ȴ�.
select first_name, salary from employees
    where salary>any(
        select salary from employees where department_id=20);
/*
    ��������� 6000���� ũ�� ���ǿ� �����Ѵ�. ��� : 55��
*/

/*
������ ������3 : all�� and�� ����� �����ϴ�.
    ���������� �������� ���������� �˻������ ��� ��ġ�ؾ�
    ���ڵ带 �����Ѵ�.
*/
/*
�ó�����] ��ü ����߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿��� 
    �޴� �������� �����ϴ� ������������ �ۼ��Ͻÿ�. �� �Ѵ� �����ϴ� 
    ���ڵ常 �����Ͻÿ�.
*/
select first_name, salary from employees
    where salary>all(
        select salary from employees where department_id=20);
/*
    6000�̻��̰� ���ÿ� 13000���� Ŀ���ϹǷ� ��������� 13000�̻���
    ���ڵ常 �����ϰ� �ȴ�. ��� : 5��
*/

/*
rownum : ���̺��� ���ڵ带 ��ȸ�� ������� ������ �ο��Ǵ� ������
    �÷��� ���Ѵ�. �ش� �÷��� ��� ���̺� �������� �����Ѵ�.
*/
-- ��� ������ �������� �����ϴ� ���̺�
select * from dual;
-- ���ڵ��� ���ľ��� ��� ���ڵ带 �����ͼ� rownum���� �ο��Ѵ�.
-- �̰�� rownum�� ������� ��µȴ�.
select employee_id, first_name, rownum from employees;
-- �̸��� ������������ �����ϸ� rownum�� ������ �̻��ϰ� ���´�.
select employee_id, first_name, rownum from employees
    order by first_name asc;

/*
rownum�� �츮�� ������ ������� ��ο��ϱ� ���� ���������� ����Ѵ�.
from������ ���̺��� ���;� �ϴµ�, �Ʒ��� �������������� ������̺���
��ü ���ڵ带 ������� �ϵ� �̸��� ������������ ���ĵ� ���·� ���ڵ带
�����ͼ� ���̺�ó�� ����Ѵ�.
*/
select first_name, rownum 
 from (select * from employees order by first_name asc);


--------------------------------------------------------
--------------- Sub Query �� �� �� �� ------------------ 
--------------------------------------------------------

-- scott�������� �����մϴ�. 
/*
01.�����ȣ�� 7782�� ����� ��� ������ ���� ����� ǥ���Ͻÿ�.
��� : ����̸�, ��� ����
*/
select * from emp where empno=7782;--7782����� ������ Ȯ��
select * from emp where job='MANAGER';
select * from emp where job=(select job from emp where empno=7782);

/*
02.�����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ���Ͻÿ�.
��� : ����̸�, �޿�, ������
*/
select * from emp where empno=7499;--7499�� �޿� Ȯ��
select * from emp where sal>1600;
select * from emp where sal>(select sal from emp where empno=7499);

/*
03.�ּ� �޿��� �޴� �����ȣ, �̸�, ��� ���� �� �޿��� ǥ���Ͻÿ�.
(�׷��Լ� ���)
*/
select min(sal) from emp;
select * from emp where sal=800;
select empno, ename, job, sal from emp 
    where sal=(select min(sal) from emp);

/*
04.��� �޿��� ���� ���� ����(job)�� ��� �޿��� ǥ���Ͻÿ�.
*/
--���޺� ��ձ޿� ����(job�� �׷����� ����ϹǷ� select���� ����Ҽ��ִ�)
select job, avg(sal) AAA from emp group by job;
--�����߻�. �׷��Լ��� 2�� ���Ʊ� ������ job�÷��� �����ؾ��Ѵ�.
--(��ձ޿� �� �ּҰ��� ã�� �����ϹǷ� job�÷��� �����÷��� �ǹǷ� 
--select������ �����ؾ� �Ѵ�.)
select job, min(AAA) from emp group by job;
--�������. ������ ��ձ޿��� �ּ��� ���ڵ� ����
select min(avg(sal)) from emp group by job;
/*
��ձ޿��� ���������� �����ϴ� �÷��� �ƴϹǷ� where������ ����Ҽ�����
having���� ����ؾ� �Ѵ�. ��, ��ձ޿��� 1017�� ������ ����ϴ� �������
���������� �ۼ��ؾ� �Ѵ�. 
*/
select job, avg(sal) from emp
group by job
having avg(sal)=(select min(avg(sal)) from emp group by job);

/*
05.�� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
*/
--�ܼ� ������ ���� �μ��� �޿� Ȯ��
select deptno, sal from emp order by deptno, sal;
--�׷��Լ��� ���� �μ��� �ּұ޿� Ȯ��
select deptno, min(sal) from emp group by deptno;
--�ܼ� or���� ���� ����
select ename, sal, deptno from emp 
    where (deptno=20 and sal=800) or 
        (deptno=30 and sal=950) or 
        (deptno=10 and sal=1300) ;
--���������� ������ �����ڸ� ���� ���� �ۼ�    
select ename, sal, deptno from emp 
    where (deptno, sal) 
        in (select deptno, min(sal) from emp group by deptno);

/*
06.��� ������ �м���(ANALYST)�� ������� �޿��� �����鼭 
������ �м���(ANALYST)�� �ƴ� ������� ǥ��(�����ȣ, �̸�, ������, �޿�)
�Ͻÿ�.
*/
select * from emp where job='CLERK';--�޿��� 3000�ΰ��� Ȯ��.
select * from emp where sal<3000 and job<>'ANALYST';
/*
ANALYST ������ ���� ����� 1���̹Ƿ� �Ʒ��� ���� ������ �����ڷ� ����������
����� ������, ���� ����� 2���̻��̶�� ������ ������ all Ȥ�� any�� 
�߰��ؾ��Ѵ�. 
*/
select * from emp where sal<(select sal from emp where job='ANALYST') 
    and job<>'ANALYST';
/*
Ex) ���� �������� CLERK�� �־����ٸ� ������ �Ʒ��� ���� �ؾ��Ѵ�. 
*/
select * from emp where job='CLERK';--3���� ����� ����ȴ�.
select * from emp where job<>'CLERK' and (sal<800 or sal<950 or sal<1300);
--�������� �ǹǷ� anyȤ�� all�� ����ؾ� �Ѵ�. 
select * from emp where job<>'CLERK' and 
    sal < any (select sal from emp where job='CLERK');


/*
07.�̸��� K�� ���Ե� ����� ���� �μ����� ���ϴ� ����� 
�����ȣ�� �̸�, �μ���ȣ�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�
*/
--K�� ���Ե� ����� 10, 30�� �μ��� ���Ѱ��� Ȯ��
select * from emp where ename like '%K%';
--10�� Ȥ�� 30�� �μ����� �ٹ��ϴ� ����� ���(or�� ����ص� ��)
select * from emp where deptno in (30, 10);
/*
    or ������ in���� ǥ���� �� �ִ�. ���� ������������ ������ ��������
    in�� ����Ѵ�. 2�� �̻��� ����� or�� �����Ͽ� ����ϴ� ����� 
    ������. 
*/
select * from emp where deptno 
    in (select deptno from emp where ename like '%K%');

/*
08.�μ� ��ġ�� DALLAS�� ����� �̸��� �μ���ȣ �� ��� ������ ǥ���Ͻÿ�.
*/
--20�� �μ����� Ȯ��
select * from dept where loc='DALLAS';
--20�� �μ����� �ٹ��ϴ� �����
select * from emp where deptno=20;
--���������� ����
select * from emp where deptno=(select deptno from dept where loc='DALLAS');

/*
09.��ձ޿� ���� ���� �޿��� �ް� �̸��� K�� ���Ե� ����� ���� 
�μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�.
*/
--��ձ޿�
select avg(sal) from emp;--2077.xxx 
--K�� ���Ե� ���
select * from emp where ename like '%K%';
--�ܼ� �������� �����ۼ�
select * from emp
    where sal>2077 and deptno in (30, 10);
--���������� �ۼ�. �����࿬���ڿ� �����࿬���ڰ� ���ÿ� ���� �������ȴ�.
select * from emp
    where sal>(select avg(sal) from emp) 
    and deptno in (select deptno from emp where ename like '%K%');

/*
10.��� ������ MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�.
*/
select * from emp where job='MANAGER';--10,20,30�� �μ����� Ȯ��
select * from emp where deptno 
    in (select deptno from emp where job='MANAGER');


/*
11.BLAKE�� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� 
���Ǹ� �ۼ��Ͻÿ�. (��, BLAKE�� ����)
*/
select * from emp where ename='BLAKE';--30���μ�
select * from emp where deptno=30 and ename<>'BLAKE';
select ename, hiredate from emp 
    where deptno=(select deptno from emp where ename='BLAKE') 
        and ename<>'BLAKE';

