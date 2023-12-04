/*
���ϸ� : Or16View.sql
View(��) 
���� : view�� ���̺�κ��� ������ ������ ���̺�� ���������δ� �������� �ʰ�
    �������� �����ϴ� ���̺��̴�.(�б�� ¬ ����)
HR �������� �ϱ�
*/
/*
view�� ����
    ����]
        create [or replace] view ���̸�[(�÷�1, �÷�2,.......)]
        as
        select * from ���̺�� where ����
            Ȥ�� join���� ������.
*/
/*
�ó�����] HR������ ������̺��� �������� ST_CLERK�� ��������� 
    ��ȸ�� �� �ִ� View�� �����Ͻÿ�
    ����׸� : ������̵�, �̸�, �������̵�, �Ի���, �μ����̵�
*/
-- 1. ���Ǵ�� select�ϱ�
select
    employee_id, first_name, job_id, hire_date, department_id
 from employees 
 where job_id = 'ST_CLERK'; --20�� ����
 
--2. View �����ϱ�
create view view_employees
    as
    select
        employee_id, first_name, job_id, hire_date, department_id
    from employees
    where job_id = 'ST_CLERK';
    
--3. View �����ϱ� : select���� �����ѰͰ� ������ ����� ����ȴ�
select * from view_employees;

--4. ������ �������� �� Ȯ���ϱ�
-- ������ ����� �������� �״�� ����Ǵ°��� Ȯ�� ����
select * from user_views;

/*
�� �����ϱ�
    : �� �������ڿ� or replace�� ����ϸ� �ȴ�
    �ش�䰡 �����ϸ� �����ǰ�, ���� �� ���Ӱ� ������
    ���� �� �����ÿ� �ᵵ ������
*/

/*
�ó�����]�տ��� ������ View�� ������ ���� �����Ͻÿ�
    �����÷��� employee_id, first_name, job_id, hire_date, department_id��
    id, fname, jobid, hdate, deptid�� �����Ͽ� �����Ͻÿ�
*/

create or replace view view_employees
    (id, fname, jobid, hdate, deptid)
    as
    select
        employee_id, first_name, job_id, hire_date, department_id
    from employees
    where job_id = 'ST_CLERK'; -- ����
select * from view_employees; -- Ȯ��

/*
����] ������ ������ view_employees �並 �Ʒ� ���ǿ� �°� �����϶�
    �������̵� ST_MAN�� ����� �����ȣ, �̸�, �̸���, �Ŵ������̵� 
    ��ȸ�� �� �ֵ��� �����Ͻÿ�.
    View�� �÷����� e_id, name, email, m_id �� �����Ѵ�. 
    ��, �̸��� first_name�� last_name�� ����� ���·� ����Ͻÿ�
*/
    select
        employee_id, concat(first_name||' ',last_name), email, manager_id
    from employees where job_id = 'ST_MAN';  -- ����Ʈ�� ���� ����
    
    -- View������ �÷��� ��Ī �ο�
    create or replace view view_employees
    (e_id, name, email, m_id)
    as
    select
    employee_id, concat(first_name||' ',last_name), email, manager_id
    from employees where job_id = 'ST_MAN';
    
select * from view_employees; -- view Ȯ��



/*
����1] �����ȣ, �̸�, ������ ����Ͽ� ����ϴ� �並 �����Ͻÿ�
    �÷��� �̸��� emp_id, l_name, annul_sal�� �����Ͻÿ�
    �������� -> (�޿�+(�޿�*���ʽ���))*12
    ���̸� : v_emp_salary
    �� ������ ���ڸ����� ,�� ���ԵǾ�� �Ѵ�
*/
select * from employees;
select 
    employee_id, concat(first_name || ' ', last_name), (salary+(salary*nvl(commission_pct,0)))*12
    from employees;

create view v_emp_salary
    (emp_id, l_name, annul_sal)
    as
    select
     employee_id, concat(first_name || ' ', last_name), (salary+(salary*nvl(commission_pct,0)))*12
    from employees;
    
select * from v_emp_salary;


/*
����2]join�� ���� view ����
�ó�����] ������̺�� �μ����̺�, �������̺��� �����Ͽ� ���� ���ǿ� �´�
    view�� �����Ͻÿ�
    ����׸� : �����ȣ, ��ü�̸�, �μ���ȣ, �μ���, �Ի�����, ������
    view�� ��Ī : v_emp_join
    view�� �÷� : empid, fullname, deptid, deptname, hdate, locname
    �÷��� ������� : 
        fullname => first_name + last_name
        hdate => 0000�� 00�� 00��
        locname => xxx���� yyy   --ex) Texas ���� Southlake
*/





















