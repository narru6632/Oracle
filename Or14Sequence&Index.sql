/*
���ϸ� : Or14Sequence&Index.sql
������&�ε���
���� : ���̺��� �⺻Ű �ʵ忡 �������� �Ϸù�ȣ�� �ο��ϴ� ��������
    �˻��ӵ��� ����ų �� �ִ� �ε���
STUDY �������� �ϱ�
*/

/*
������
    - ���̺��� �÷�(�ʵ�)�� �ߺ����� ���� �������� �Ϸù�ȣ�� �ο�
    - �������� ���̺� ���� �� ������ ������ �Ѵ�. �� �������� ���̺�� 
        ���������� ����ǰ� �����ȴ�
[������ ��������]
create sequence ��������
    [increment by N] -- ����ġ����
    [Start with N] -- ���۰�����
    [Minvalues n | NoMinvalue] ->������ �ּҰ� ���� : ����Ʈ1
    [Maxvalues n | NoMAXvalue] ->������ �ִ밪 ���� : ����Ʈ1.0000E+28
    [Cycle | NoCycle] -<�ִ�, �ּҰ��� ������ ��� ó����� �ٽ� ��������
       ���θ� ����, (Cycle�� ������ �ִ밪����
       ���� �� �ٽ� ���۰����� �� ���۵�
    [Cycle | NoCache ]=> cache �޸𸮿� ����Ŭ ������ ���������� �Ҵ��ϴ� ���θ� ����
    
���ǻ���
    1. start with�� minvalue���� ���� ���� ������ �� ����.
    ��,  start with����    minvalue�� ���ų� Ŀ���Ѵ�
    2. nocycle�� �����ϰ� �������� ��� ���� �� minsvalue�� �������� �ʰ��ϸ� ������ �߻��Ѵ�
    3. primary key�� cycle�ɼ���  ���� �����ϸ� �ȵȴ�
    
*/

create table tb_goods(
    g_idx number(10) primary key,
    g_name varchar(30)
);

insert into tb_goods values (1, '�������ݸ�');
insert into tb_goods values (1, '�����'); -- �Է½��� / ���Ἲ �������� ����(PK�ߺ�)

create sequence seq_serial_num
    increment by 1 -- ����ġ : 1
    start with 100 -- �ʱⰪ : 100
    minvalue 99 -- �ּҰ� : 99
    maxvalue 110 -- �ִ밪 : 110
    cycle -- �ִ밪 ���޽� ���۰����� ��������� ���� : �Ѵ�
    nocache; -- ĳ�ø޸� ��� ���� : NO
-- ������ �������� ������ ������ Ȯ���ϱ�
select * from user_sequences;

/*
������ ���� �� ���ʽ���� ������ �߻��Ѵ�.
nextval�� ���� ������ �� ����
*/
select seq_serial_num.currval from dual;
/*
���� �Է��� ������(�Ϸù�ȣ)�� ��ȯ�Ѵ�. ������ �� ���� �������� �Ѿ��
*/
select seq_serial_num.nextval from dual;

insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��1');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��2');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��3');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��4');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��5');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��6');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��7');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��8');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��9');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��10');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��11');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��12');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��13');  -- �ϷĹ�ȣ �ߺ� / ���Ἲ������������
--�������� cycle �ɼǿ� ���� �ִ밪�� �����ϸ� �ٽ� ó������ �Ϸù�ȣ��
--�����ǹǷ� ���Ἲ �������ǿ� ����ȴ�. ��, �⺻Ű�� ����� �������� 
--cycle�ɼ��� ������� �ʾƾ� �Ѵ�

select * from tb_goods;
select seq_serial_num.nextval from dual;

/*
������ ����
    : start with�� �������� �ʴ´�
*/
alter sequence seq_serial_num
    increment by 10
    minvalue 1
    nomaxvalue 
    nocycle
    nocache;
--���� �� ������ �������� Ȯ��
select * from user_sequences;
--����ġ�� 10���� ����Ȱ��� Ȯ��
select seq_serial_num.nextval from dual;

--������ ����
drop sequence seq_serial_num;
--���� �� ������ �������� Ȯ��
select * from user_sequences;

--�Ϲ����� ������������ �Ʒ��� ���� �ϸ�ȴ�
creat sequence seq_serial_num
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;    -- ���� ���ϰ� ���� ������ ����
    
    
/*
�ε���(Index)
    ���� �˻��ӵ��� ����ų �� �ִ� ��ü
    �ε����� �����(create index) �Ǵ� 
    �ڵ�������(primary key, unique) ������ �� �ִ�
    �÷��� ���� �ε����� ������ ���̺� ��ü���˻��ϰ� �ȴ�
    �� �ε����� ������ ������ ����Ű�� ���� �����̴�
    �ε����� �Ʒ��� ���� ��쿡 �����Ѵ�
        1. where�����̳� join���ǿ� ���� ����ϴ� �÷�
        2. �������� ���� �����ϴ� ���÷�
        3. ���� null ���� �����ϴ� �÷�
*/
desc tb_goods;
select * from tb_goods;

--�ε��������ϱ�, Ư�� ���̺��� �÷��� �����Ͽ� �����Ѵ�
create index tb_goods_name_idx on tb_goods (g_name);
--������ �ε��� Ȯ���ϱ�
/*������ �������� Ȯ���ϸ� PKȤ�� Unique�� ������ Į���� �ڵ����� �ε����� �����ǹǷ�
�̹� ������ �ε����� ���� Ȯ�εȴ�*/
select * from user_ind_columns;
/*
Ư�� ���̺��� �ε��� Ȯ��
        : ������ ������ ��Ͻ� �빮�ڷ� �ԷµǹǷ� upper�� ���� ��ȯ�Լ���
        ����ϸ� ���ϴ�.
*/
select * from user_ind_columns where table_name=upper('tb_goods');

--������ ���� ���ڵ尡 �ִٰ� �������� �� �˻��ӵ��� ����� �ִ�
select * from tb_goods where g_name like '%��%';

--�ε�������
drop index tb_goods_name_idx;

--�ε��� ���� - �Ұ���, ������ �ٽ� �����ؾ���