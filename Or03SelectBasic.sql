+/*
���ϸ� : Or03SelectBasic.sql
ó������ �����غ��� ���Ǿ�(SQL�� Ȥ�� Query��)
�����ڵ� ���̿����� '����'�̶�� ǥ���ϱ⵵ �Ѵ�
���� : select, where �� ���� �⺻���� DQL�� ����غ���
*/
--HR �������� �ϱ�
/*
SQL Developer ���� �ּ� ����ϱ�
    �� ���� �ּ� : �ڹٿ� ������
    ���� ���� �ּ� : -- ���๮ (����Ǭ �ΰ�)
*/

--select�� : ���̺� ����� ���ڵ带 ��ȸ�ϴ� SQL������ DQL���� �ش��Ѵ�
/*
����]
    select �÷�1, �÷�2, .... Ȥ�� *
    from ���̺��
    where ����1 and ����2 or ����3
    order by ������ �÷� asc(��������), desc(��������);
*/

-- ������̺� ����� ��� ���ڵ带 ������� ��� �÷��� ��ȸ�ϱ�
-- (�������� ��ҹ��ڸ� �������� �ʴ´�.)
select * from employees;
SELECT * from employees;

/*
�÷����� �����ؼ� ��ȸ�ϰ� ���� �÷��� ��ȸ�ϱ�
=> �����ȣ, �̸�, �̸���, �μ���ȣ�� ��ȸ�Ͻÿ�
*/
select employee_id, first_name, last_name, email, department_id
    from employees;  -- �ϳ��� �������� ���� �� ;�� �ݵ�� ����ؾ��Ѵ�
    
-- ���̺��� ������ �÷��� �ڷ��� �� ũ�⸦ ��� 
-- �� ���̺��� ��Ű���� �� �� �ִ�
desc employees;

-- as�� ������ �� �ִ�
select employee_id "������̵�", first_name as "�̸�", last_name "��"
    from employees where first_name = 'William';

--����Ŭ�� �⺻������ ��ҹ��ڸ� �������� �����Ƿ�
--������� ��� ��ҹ��� ���о��� ����� �� �ִ�.
seLecT employee_id "������̵�", fiRSt_name as "�̸�", last_name "��"
    FROM EmPLOyees WHERE first_name = 'William';
    
--��, ���ڵ�(�����Ͱ�)�� ��� ��ҹ��ڸ� �����Ѵ�    
-- ���� �Ʒ� SQL���� �����ϸ� �ƹ��� ����� ������ �ʴ´�
select employee_id "������̵�", first_name as "�̸�", last_name "��"
    from employees where first_name = 'WILLIAM';

/*
where���� �̿��ؼ� ���ǿ� �´� ���ڵ� �����ϱ�
-> last_name�� Smith�� ���ڵ带 �����Ͻÿ�
*/
select * from employees where last_name = 'Smith';

/* and/or ������ w: where������ �� �̻��� ������ �ʿ��� �� ����� �� �ִ�
-> last_name�� Smith�̸鼭 �޿��� 8,000���� ����� �����Ͻÿ�
*/
--�÷��� �������� ��� ��Ŭ�����̼�(')���� ���Ѵ�, �����ΰ�� �����Ѵ�
select * from employees where last_name = 'Smith' and salary = 8000;

--�÷��� �������ΰ�� �̱������̼�(')�� ������ �����߻�
--select * from employees where last_name = Smith and salary = 8000;
--�÷��� �������ΰ�� �̱������̼�(')���� ���ε� �����̹߻� x
select * from employees where last_name = 'Smith' and salary = '8000';

/*
�񱳿����ڸ� ���� ������ �ۼ�
    :�̻�, ���Ͽ� ���� ���ǿ� >, <= �� ���� �񱳿����ڸ� ����� �� �ִ�.
    ��¥�ΰ�� ����(�̸�), ����(�ʰ�)�� ���� ���ǵ� �����ϴ�
*/
-- �޿��� 5000�̸��� ����� ������ �����Ͻÿ�.
select * from employees where salary < 5000;
-- �Ի����� 04�� 01�� 01�� ����(����) ��������� �����Ͻÿ�
select * from employees where Hire_Date >= '04/01/01'; --��¥�� �̱������̼� �ʿ�

/*
in ������
    : or �����ڿ� ���� �ϳ��� �÷��� �������� ������ ������ �ɰ���� ��
    ����Ѵ�. => �޿��� 4200, 6400, 8000�� ����� ������ �����Ͻÿ�
*/
--���1 : or���, �̋� �÷����� �ݺ������� ����ؾ� �ϹǷ� �����ϴ�
select * from employees where salary = 4200 or salary = 6400 or salary = 8000;
--���2 : in ���, �÷����� �ѹ��� ����ϸ� �ǹǷ� ���ϴ�
select * from employees where salary in(4200, 6400, 8000);

/*
not ������
    : �ش� ������ �ƴ� ���ڵ带 �����Ѵ�
    -> �μ���ȣ�� 50�� �ƴ� ��������� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
*/
select * from employees where department_id<> 50;
select * from employees where not (department_id = 50);
-- <> = not

/*
between and ������
    : �÷��� ������ ���� �˻��� �� ����Ѵ�.
    => �޿��� 4000~8000������ ����� �����Ͻÿ�.
*/
-- ���1 and������
select * from employees where salary >= 4000 and salary <=8000; -- �˻� 2��
-- ���2 between and ������
select * from employees where salary between 4000 and 8000; -- �˻� 1��

/*
distinct ������
    : �÷����� �ߺ��Ǵ� ���ڵ带 ������ �� ����Ѵ�
    Ư�� ���Ŵɷ� select ���� �� �ϳ��� �÷����� �ߺ��Ǵ� ���� �ִ� ���
    �ߺ����� ������ �� ����� ����� �� �ִ�
    -- ������ ���̵� �ߺ��� ������ �� ����Ͻÿ�
*/
-- ��ü ����� ���� ���������� ����
select job_id from employees;
-- �ߺ��Ȱ� ����
select distinct job_id from employees;

/*
like ������
    : Ư�� Ű���带 ���� ���ڿ��� �˻��� �� ����Ѵ�
    ����] �÷��� like '%�˻���%'
    ���ϵ�ī�� ����
        % : ��� ���� / ���ڿ��� ��ü��
        EX) D�� �����ϴ� �ܾ� : D% -> Da, Dea, Daewoo
            Z�� ������ �ܾ� : %Z -> aZ, adxZ
            C�� ���Ե� �ܾ� : %C% => ACd, abCde, Vitamin-C
            
        _ : �ϳ��� ���ڸ� ��ü��
        Ex) D�� �����ϴ� ������ �ܾ� : D__ -> Dad, Ddd, Dxy
            A�� �߰��� ���� 3���� �ܾ� : _A_ -> aAa, xAy
*/
-- first_name�� 'D'�� �����ϴ� ������ �˻��Ͻÿ�
select * from employees where first_name like 'D%';
-- first_name�� ����° ���ڰ� A�� ������ �����Ͻÿ�
select * from employees where first_name like '__a%';
-- last_name�� 'Y'�� ������ ������ �����Ͻÿ�
select * from employees where last_name like '%y';
-- ��ȭ��ȣ�� 1344�� ���Ե� ������ü�� �����Ͻÿ�
select * from employees where phone_number like '%1344%';

/*
���ڵ� �����ϱ�(sorting)
    �������� ���� : order by �÷��� asc(Ȥ�� ��������)
    �������� ���� : order by �÷��� desc
    
    2���̻��� �÷����� �����ؾ� �� ��� �޸�(,)�� ������ �����Ѵ�
    ��, �̶� ���� �Է��� �÷����� ���ĵ� ���¿��� �ι�° �÷��� ���ĵȴ�
*/

-- ����������̺��� �޿��� ���� �������� ���� ������ ����ǵ���
-- �����Ͽ� ��ȸ�Ͻÿ� / ����� �÷� : first_name, salary, emanil, phone_number
select first_name, salary, email, phone_number 
    from employees order by salary asc;
    select first_name, salary, email, phone_number 
    from employees order by salary ;
    
/*
�μ���ȣ�� ������������ ������ �� �ش�μ����� ���� �޿��� 
�޴� ������ ���� ��µǵ��� �ϴ� sql���� �ۼ��Ͻÿ�
����׸� : �����ȣ, �̸�, ��, �޿�, �μ���ȣ
*/
select EMPLOYEE_ID , FIRST_NAME, LAST_NAME, SALARY , DEPARTMENT_ID from employees order by department_id desc, salary;

/*
is null�� is not null
    : ���� null�̰ų� null�� �ƴ� ���ڵ� ��������.
    �÷��� null���� ����ϴ� ��� ���� �Է����� ������ 
    null���� �Ǵµ� �̸� ������� select�� �� ����Ѵ�.
*/
--���ʽ����� ���� ����� ��ȸ�Ͻÿ�
select * from employees where commission_pct is null;
--��������̸鼭 �޿��� 8000�̻��� ����� ��ȸ�Ͻÿ�
select * from employees where commission_pct is not null and salary >=8000;




/***********************
��������(scott�������� �����մϴ�.)
************************/
/*
1. ���� �����ڸ� �̿��Ͽ� ��� ����� ���ؼ� $300�� �޿��λ��� ������� 
�̸�, �޿�, �λ�� �޿��� ����Ͻÿ�.
*/
select * from emp; -- ��ü ��� Ȯ��
select ename "�̸�",sal "�޿�",sal+300 "�λ�ȱ޿�" from emp; 

/*
2. ����� �̸�, �޿�, ������ ������ �����ͺ��� ���������� ����Ͻÿ�. 
������ ���޿� 12�� ������ $100�� ���ؼ� ����Ͻÿ�.
*/
select ename, sal, (sal*12+100) "����" from emp;
--���Ľ� ���������� �����ϴ� �÷����� ����ϴ°� �⺻
select ename, sal, (sal*12+100) "����" from emp order by sal desc;
--���������� �������� ���� �÷��̶�� ���� �״�θ�
--orderby ���� ����Ѵ�
select ename, sal, (sal*12+100) "����" from emp order by "����" desc;


/*
3. �޿���  2000�� �Ѵ� ����� �̸��� �޿��� ������������ �����Ͽ� ����Ͻÿ�
*/
select ename, sal from emp where sal>2000 order by sal desc;

/*
4. �����ȣ��  7782�� ����� �̸��� �μ���ȣ�� ����Ͻÿ�.
*/
select ename, deptno from emp where mgr = 7782;


/*
5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ����Ͻÿ�.
*/
select ename, sal from emp where sal not between 2000 and 3000;


/*
6. �Ի����� 81��2��20�� ���� 81��5��1�� ������ ����� �̸�, 
������, �Ի����� ����Ͻÿ�.
*/
select ename, job, hiredate from emp where hiredate between '81/2/20' and '81/5/1';


/*
7. �μ���ȣ�� 20 �� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸��� 
����(��������)���� ����Ͻÿ�
*/
select ename, deptno from emp where deptno in(20,30) order by ename desc;

/*
8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� 
����� �̸�, �޿��� �μ���ȣ�� ����ϵ� �̸���(��������)���� ����Ͻÿ�
*/
select * from emp;
select ename, sal, empno from emp where sal between 2000 and 3000 order by ename;
    
/*
9. 1981�⵵�� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. (like �����ڿ� ���ϵ�ī�� ���)
*/  
select * from emp;
select ename, hiredate from emp where hiredate like'81%';

/*
10. �����ڰ� ���� ����� �̸��� �������� ����Ͻÿ�. 
*/
select * from emp;
select ename, job from emp where comm is null order by job;


/*
11. Ŀ�̼��� ������ �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� 
����ϵ� �޿� �� Ŀ�̼��� �������� ������������ �����Ͽ� ����Ͻÿ�.
*/
select ename, sal, comm from emp order by sal desc, comm desc;

/*
12. �̸��� ����° ���ڰ� R�� ����� �̸��� ǥ���Ͻÿ�.
*/
select ename from emp where ename like'__R%';

/*
13. �̸��� A�� E�� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�.
*/
select ename from emp where 
(ename like'%A%' and ename like'%E%');


/*
14. �������� �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸鼭 �޿��� 
$1600, $950, $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�. 
*/
select ename, job, sal from emp where 
    job in('CLERK', 'SALESMAN') and
    sal not in (1600, 950, 1300);
    


/*
15. Ŀ�̼��� $500 �̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�. 
*/
select * from emp;
select ename, sal, comm from emp where comm>=500;