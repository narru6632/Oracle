/*
���ϸ� : Or09DDL.sql
DDL : Data Definition Language(������ ���Ǿ�)
���� : ���̺� ��� ���� ��ü�� ���� �� �����ϴ� �������� ���Ѵ�

*/

--@@@@system�������� ����@@@
--���ο� ������ ������ ��  ���� ���Ѱ� ���̺���� ���ѵ��� �ο��Ѵ�

--Oracle 21c �̻���ʹ� ���� ������ �ش� ����� �����ؾ��Ѵ�.
alter session set "_ORACLE_SCRIPT" = true; --Seesion�� ����Ǿ����ϴ�

--study ������ �����ϰ�, �н����带 1234�� �ο��Ѵ�
create user study identified by 1234; --User STUDY�� �����Ǿ����ϴ�

--������ ������ ��� ������ �ο��Ѵ�.
grant connect, resource to study; -- Grant�� �����߽��ϴ�(study�� ������ �Ǹ�)

--ȭ�� 11�� ��� ���ڰ� ������ ��������

----------------------------------------------------------------------------

--@@@@Study������ ������ �� ����@@@@

-- ��� ������ �����ϴ� ���� ���̺�(dual)
select * from dual;

-- �ش� ������ ������ ���̺��� ����� ������ �ý��� ���̺�
-- �̿� ���� ���̺��� "������ ����"�̶�� �Ѵ�
select * from tab; -- ���� dual���� �ٸ� ���̺��� �����Ƿ� ���̴°� ����


/*
���̺� �����ϱ�
����] create table ���̺�� {
        �÷���1 �ڷ���,
        �÷���2 �ڷ���,
        ........
        primary key(�÷���)���� �������� �߰�
     );
*/
create table tb_number(
    idx number(10), -- 10�ڸ��� ������ ǥ��
    userid varchar2(30), -- ���������� 30byte ���尡��
    passwd varchar2(50), -- ��ȣȭ �ϹǷ� �˳���
    username varchar2(30),
    mileage number(7,2) -- �Ǽ�ǥ�� ��ü7�ڸ� �Ҽ��� 2�ڸ�
 );
-- ���� ������ ������ ������ ���̺� ����� Ȯ���Ѵ�
select * from tab;

-- ���̺��� ����(��Ű��) Ȯ��. �÷���, �ڷ���, ũ�� ���� Ȯ���Ѵ�.
desc tb_number;

/*
���� ������ ���̺� ���ο� �÷� �߰��ϱ�
    -> tb_member ���̺� email �÷��� �߰��Ͻÿ�.
    ����]
    alter table ���̺�� add �߰����÷� �ڷ���(ũ��) ��������;
*/
alter table tb_number add email varchar2(100);
desc tb_number;

/*���̺� �÷� �����ϱ�
alter table ���̺�� drop column �÷���;
*/
alter table tb_number draop column mileage;
desc tb_number;

/*
���� ������ ���̺��� �÷� �����ϱ�
    -> tb_number ���̺��� email �÷��� ����� 200���� ����Ͻÿ�
    ���� �̸��� ����Ǵ� user_name �÷��� 60���� Ȯ���Ͻÿ�
    ����[alter table ���̺�� motify ������ �÷��� �ڷ���(ũ��)
*/
alter table tb_number modify email varchar2(200);
alter table userid modify email varchar2(60);

/*
���̺� ���ٻ���
*/
create table employees(
employee_id	number(6,0),
first_name	varchar2(20 byte),
last_name	varchar2(25 byte),
email	varchar2(25 byte),
phone_number	varchar2(20 byte),
hire_date	date,
job_id	varchar2(10 byte),
salary	number(8,2),
commission_pct	number(2,2),
manager_id	number(6,0),
department_id	number(4,0)
);
desc employees;

/*
���̺� �����ϱ�
    -> employees ���̺��� ���̻� ������� �����Ƿ� �����Ͻÿ�.
    ����] drop table ������ ���̺�� 
*/
select * from tab; -- ���̺� Ȯ��
--���̺� ����
drop table employees;
drop table empolyees;
select * from tab; 
-- ���� �� ���̺� ��Ͽ����� ������ �ʽ��ϴ�.(�����뿡 �� ����)
-- �ٸ���� �������ص� '��ü�� �������� �ʽ��ϴ�' < �����߻�

/*
tb_number ���̺� ���ο� ���ڵ带 �����Ѵ�.(DML�κп��� �н��� ����)
������ ���̺� �����̽���� ������ ��� ������ �� ���� �����̴�
*/

insert into tb_number values
    (1, 'hong', '1234', 'ȫ�浿', 'hong@naver.com'); 
    -- ���̺����̽� users ���� ���� ����

/*
����Ŭ11g������ ���ο� ������ ������ �� connect, resource�� 
(Role)�� �ο��ϸ� ���̺� ���� �� ���Ա��� �����ϳ�,
�� ���� ���������� ���̺� �����̽� ���� ������ �߻��Ѵ�.
���� �Ʒ��� ���� ���̺� �����̽��� ���� ���ѵ� �ο��ؾ� �Ѵ�.
�ش� ����� system�������� ������ �� �����ؾ� �Ѵ�
*/
--system�������� ��ȯ ��
grant unlimited tablespace to study;
--study�������� ��ȯ�Ͽ� ���� Ȯ��
insert into tb_number values
    (1, 'hong', '1234', 'ȫ�浿', 'hong@naver.com'); --����
insert into tb_number values
    (2, 'yu', '9876', '����', 'yu@hanmail.com');
--���Ե� ���ڵ� Ȯ��
select * from tb_number;

/*
���̺� ���� 1 - �Ӽ��� ���ڵ���� ��� �����ϱ�
select���� ����Ҷ� where ���� ������ ��� ���ڵ带 ����϶�� ���
�Ʒ������� ��� ���ڵ带 �����ͼ� ���纻 ���̺��� ���� - ��, ���ڵ���� �����Ѵ�
*/
create table tb_number_copy
    as
    select * from tb_number;
desc tb_number_copy; -- Ȯ��
select * from tb_number_copy;

/*
���̺� ���� 2 - ���ڵ带 ������ ���̺� ����(�Ӽ�)�� ����
*/

create table tb_number_empty
    as
    select * from tb_number where 1=0;
desc tb_number_empty; -- Ȯ��
select * from tb_number_empty;
/*
DDL �� : ���̺��� ���� �� �����ϴ� ������
(Date Definition Language : ������ ���Ǿ�)
    ���̺���� : create table ���̺��
    ���̺����
        - �÷��߰� : alter table ���̺�� add �÷���
        - �÷����� : alter table ���̺�� modify �÷���
        - �÷����� : alter table ���̺�� drop column �÷���
    ���̺���� : drop table ���̺��
*/






--�������� 
-- study �������� �Ͻÿ�.
/*
1. ���� ���ǿ� �´� ��pr_dept�� ���̺��� �����Ͻÿ�.
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
*/
create table pr_dept(
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
);

select * from pr_dept;


/*
2. ���� ���ǿ� �´� ��pr_emp�� ���̺��� �����Ͻÿ�.
    eno number(4),
    ename varchar2(10),
    job varchar2(30),
    regist_date date
*/
create table pr_emp(
    eno number(4),
    ename varchar2(10),
    job varchar2(30),
    regist_date date
    );
select * from pr_emp;
desc pr_emp;

/*
3. pr_emp ���̺��� ename �÷��� varchar2(50) �� �����Ͻÿ�.
*/
alter table pr_emp modify ename varchar2(50);
desc pr_emp;

/*
4. 1������ ������ pr_dept ���̺��� dname Į���� �����Ͻÿ�.
*/
alter table pr_dept drop column dname;
desc pr_dept;



/*
5. ��pr_emp�� ���̺��� job �÷��� varchar2(50) ���� �����Ͻÿ�.
*/

alter table pr_emp modify job varchar2(50);
desc pr_emp;

