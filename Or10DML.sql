/*
���ϸ� : Or10DML.sql
DML : Data Manupulation Language(������ ���۾�)
���� : ���ڵ带 ������ �� ����ϴ� ������, �տ��� �н��ߴ� select���� ����Ͽ� 
        update(���ڵ� ����), delete(���ڵ� ����), insert(���ڵ� �Է�)�� �ִ�.
study �������� �ϱ�
*/

/*
���ڵ� �Է��ϱ� �� insert
    ���ڵ� �Է��� ���� ������ �������� �ݵ�� '�� ���ξ� �Ѵ�.
    �������� '���� �׳� ���� �ȴ�. ���� ��������  '�� ���θ� �ڵ�����
    ��ȯ�Ǿ� �Էµȴ�.
*/
-- ���ο� ���̺� �����ϱ�
create table tb_sample(
    dept_no number(10),
    dept_name varchar(20),
    dept_loc varchar(15),
    dept_manager varchar(30)
    );
desc tb_sample;--Ȯ��

--������ �Է�1 : �÷��� ������ �� insert�Ѵ�
insert into tb_sample (dept_no, dept_name, dept_loc, dept_manager)
            values(10, '��ȹ��', '����', '����');
insert into tb_sample (dept_no, dept_name, dept_loc, dept_manager)
            values(20, '������', '����', '����');
select * from tb_sample;            

--������ �Է�2 : �÷��������� ��ü �÷��� ������� insert�Ѵ�.
insert into tb_sample values(30, '������', '�뱸', '���');
insert into tb_sample values(40, '�λ���', '�λ�', '�糪');
select * from tb_sample; 

/*
�÷��� �����ؼ� insert�ϴ� ��� �����͸� �������� ���� �÷��� ������ �� �ִ�.
�Ʒ��� ��� dept_name�� null�� �ȴ�.
*/
insert into tb_sample (dept_no, dept_loc, dept_manager)
            values(20, '����', '����');

select * from tb_sample; 

/*
    ���ݱ��� �۾�(Ʈ�����)�� �״�� �����ϰڴٴ� ������� Ŀ����
    �������� ������ �ܺο����� ����� ���ڵ带 Ȯ���� �� ����.
    ���⼭ ���ϴ� �ܺζ� Java/Jsp�� ���� Oracle �̿��� ���α׷��� ���Ѵ�
    *Ʈ������̶� �۱ݰ� ���� �ϳ��� �����۾��� ���Ѵ�.
*/
commit; -- ������ ����(git�� ����)

--Ŀ������ ���ο� ���ڵ带 �����ϸ� �ӽ����̺� ����ȴ�
insert into tb_sample values(60, '������', '����', '�����');
--����Ŭ���� Ȯ���ϸ� ���� ���ԵȰ�ó�� ���δ�, ������ ���� �ݿ����� ���� ����
select * from tb_sample;--Ȯ��

--�ѹ���, ������ Ŀ�� ���·� ȣ��
rollback;
select * from tb_sample;--Ȯ��
/*
 rollback ����� ������ Ŀ�� ���·� �ǵ����ش�.
 ��, commit �� ������ ���·δ� �ѹ��� �� ����.
*/


/*
���ڵ� �����ϱ�  : update
    ����] 
        update ���̺�� 
            set �÷�1=��1, �÷�2=��2, ....
            where ����;
        �������� ���� ��� ��� ���ڵ尡 �Ѳ����� �����ȴ�
        �����̺�� �տ� from�� ���� �ʴ´�
*/

-- �μ���ȣ 40�� ���ڵ��� ������ '�̱�'���� �����Ͻÿ�
update tb_sample set dept_loc='�̱�' where dept_no=40;
select * from tb_sample;--Ȯ��
-- ������ ������ ���ڵ��� �Ŵ������� '������'���� �����Ͻÿ�
update tb_sample set dept_manager='������' where dept_loc='����';
select * from tb_sample;--Ȯ��
--��� ���ڵ带 ������� ������ '����'���� �����Ͻÿ�
update tb_sample set dept_loc='����';
--��ü ���ڵ� ����̹Ƿ� where���� ���� �ʴ´�.
select * from tb_sample;--Ȯ��

/*
���ڵ� �����ϱ� : delete
    ����]
        delete from ���̺�� where ����;
    * ���ڵ带 �����ϹǷ� delete �ڿ� �÷��� ������� �ʴ´�.
*/
-- �μ���ȣ�� 10�� ���ڵ带 �����Ͻÿ�.
delete from tb_sample where dept_no = 10;
select * from tb_sample;

--���ڵ� ��ü�� �����Ͻÿ�
delete from tb_sample; --����(where��)���Է½� ��� ����
select * from tb_sample;

--�������� commit �ߴ� �������� �ǵ�����
rollback;
select * from tb_sample;

/*
DML�� : ���ڵ带 �Է� �� �����ϴ� ������
(Data Manifulation Language : ������ ���۾�)
    ���ڵ� �Է� : insert into ���̺�� (�÷�) values (��)
    ���ڵ� ���� : update ���̺�� set (�÷�) = (��) where (����)
    ���ڵ� ���� : delete from ���̺�� where ���� 
    ��insert�� ��� �÷��� ������ �� �ִ�.
    ��delete�� ��� ������ ������ ��� ����
*/









--------------------------------------------------------
---------------��������

/*
1. DDL�� �������� 2������ ���� ��pr_emp�� ���̺� ������ ���� ���ڵ带 
�����Ͻÿ�.
1, '���¿�', '��¹�', to_date('1975-11-21') -- ���1
2, '������', '���л��¹�', to_date('1978-07-23') 
3, '�Ѱ���', '�����', to_date('1982-10-24')  -- ���2
4, '�����', '���л�����', to_date('1988-05-21')
*/
select * from pr_emp;
desc pr_emp;
insert into pr_emp (eno, ename, job, regist_date)
    values(1,'���¿�', '��¹�', to_date('1975-11-21')); 
insert into pr_emp (eno,ename, job, regist_date)
    values(2,'������', '���л��¹�', to_date('1978-07-23')); 
insert into pr_emp 
    values(3,'�Ѱ���', '�����', to_date('1982-10-24'));
insert into pr_emp 
    values(4,'�����', '���л�����', to_date('1988-05-21'));


/*
2. pr_emp ���̺��� eno�� ¦���� ���ڵ带 ã�Ƽ� job �÷��� 
������ ������ ���� �����Ͻÿ�.
job=job||'(¦��)'
job=concat(job,'(Ȧ��)')
*/
select * from pr_emp;
update pr_emp set job = job||'(¦��)' where mod(eno,2)=0;
update pr_emp set job=concat(job,'(Ȧ��)') where mod(eno,2)=1;

update tb_sample set dept_loc='�̱�' where dept_no=40;
select * from tb_sample;
/*
3. pr_emp ���̺��� job �� ���л��� ���ڵ带 ã�� �̸��� �����Ͻÿ�. 
���ڵ�� �����Ǹ� �ȵ˴ϴ�.
*/
commit;
rollback;
select * from pr_emp;
update pr_emp set ename = '' where job like'%���л�%';


/*
4.  pr_emp ���̺��� ������� 10���� ��� ���ڵ带 �����Ͻÿ�.
*/
delete from pr_emp where regist_date like'___10%';
select * from pr_emp;



/*
5. pr_emp ���̺��� �����ؼ� pr_emp_clone ���̺��� �����ϵ� ���� ���ǿ� �����ÿ�. 
����1 : ������ �÷����� idx, name, nickname, regidate �Ͱ��� �����ؼ� �����Ѵ�. 
����2 : ���ڵ���� ��� �����Ѵ�. 
*/
create table pr_emp_clone(idx, name, nickname, regidate)
    as
    select * from pr_emp;
select * from pr_emp_clone;


/*
6. 5������ ������ pr_emp_clone ���̺���� pr_emp_rename ���� �����Ͻÿ�.
*/
ALTER TABLE pr_emp_clone RENAME TO pr_emp_rename;



/*
7. pr_emp_rename ���̺��� �����Ͻÿ�
*/
drop table pr_emp_rename;







