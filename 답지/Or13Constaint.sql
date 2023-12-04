/*****************
���ϸ� : Or13Constaint.sql
��������
���� : ���̺� ������ �ʿ��� �������� �������ǿ� ���� �н��Ѵ�.
*******************/
-- study �������� �ϱ�

/*
primary key : �⺻Ű
    - ���� ���Ἲ�� �����ϱ� ���� ��������
    - �ϳ��� ���̺� �ϳ��� �⺻Ű�� ������ �� �ִ�.
    - Ű��Ű�� ������ �÷��� �ߺ��� ���̳� Null���� �Է��� �� ����.
    - �ַ� ���ڵ� �ϳ��� Ư���ϱ� ���� ���ȴ�.
*/
/*
����1] �ζ��� ��� : �÷� ������ ������ ���� ������ ����Ѵ�.
    create table ���̺��(
        �÷��� �ڷ���(ũ��) [constaint �����] primary key
    );
    * []���ȣ �κ��� ���� �����ϰ�, ������ ������� �ý�����
    �ڵ����� �ο��Ѵ�.
*/
create table tb_primary1 (
    idx number(10) primary key,
    user_id varchar2(30),
    user_name varchar2(50)
    );
desc tb_primary1;

/*
���� ���� �� ���̺� ��� Ȯ���ϱ�
    tab : ���� ������ ������ ���̺��� ����� Ȯ���� �� �ִ�.
    user_cons_columns : ���̺� ������ �������ǰ� �÷����� ������
        ������ �����Ѵ�.
    user_constraints : ���̺� ������ ���������� ���� ���� ������
        �����Ѵ�.
    * �̿� ���� ���������̳� ��, ���ν������� ������ �����ϰ� �ִ�
        �ý��� ���̺��� "������ ����"�̶�� �Ѵ�.
*/
select * from tab;
select * from user_cons_columns;
select * from user_constraints;

-- ���ڵ� �Է�
insert into tb_primary1 (idx, user_id, user_name)
    values (1, 'boopyung1', '����');
insert into tb_primary1 (idx, user_id, user_name)
    values (2, 'boopyung2', '�����');

insert into tb_primary1 (idx, user_id, user_name)
    values (2, 'boopyung3', '�����߻�');
/*
    ���Ἲ �������� ����� ������ �߻��Ѵ�. PK�� ������ �÷� idx����
    �ߺ��� ���� �Է��� �� ����.
*/
insert into tb_primary1 values (3, 'white', 'ȭ��Ʈ');
insert into tb_primary1 values ('', 'black', '��');
-- PK�� ������ �÷����� null���� �Է��� �� ����.
select * from tb_primary1;

update tb_primary1 set idx=1 where user_name='���꽽';
/*
    update���� ���������� idx���� �̹� �����ϴ� 2�� ���������Ƿ�
    �������� ����� ������ �߻��Ѵ�.
*/
/*
����2] �ƿ����� ���
    create table ���̺�� (
        �÷��� �ڷ���(ũ��)
        [constraint �����] primary key (�÷���)
    );
*/
create table tb_primary2 (
    idx number(10),
    user_id varchar2(30),
    user_name varchar2(50),
    constraint my_pk1 primary key (user_id)
    );
desc tb_primary2;
select * from user_cons_columns;
select * from user_constraints;

insert into tb_primary2 values (1, 'white', 'ȭ��Ʈ1');
insert into tb_primary2 values (2, 'white', 'ȭ��Ʈ2');

select * from tb_primary2;

/*
����3] ���̺��� ������ �� alter������ �������� �߰�
    alter table ���̺�� add [constraint �����] primary key (�÷���);
*/
create table tb_primary3 (
    idx number(10),
    user_id varchar2(30),
    user_name varchar2(50)
    );
/*
    ���̺��� ������ �� alter����� ���� ���������� �ο����� �� �ִ�.
    ������� ��� ������ �����ϴ�.
*/
alter table tb_primary3 add constraint tb_primary3_pk
    primary key (user_name);
-- ������ �������� �������� Ȯ���ϱ�
select * from user_constraints;
-- ���������� ���̺��� ������� �ϹǷ� ���̺��� �����Ǹ� ���� �����ȴ�.
drop table tb_primary3;
-- Ȯ�ν� �����뿡 �� ���� ���� �ִ�.
select * from user_cons_columns;

-- PK�� ���̺�� �ϳ��� ������ �� �ִ�. ���� �ش� ������ ������ �߻��Ѵ�.
create table tb_primary4 (
    idx number(10) primary key,
    user_id varchar2(30) primary key,
    user_name varchar2(50)
    );

/*
unique : ����ũ
    - ���� �ߺ��� ������� �ʴ� ������������
    - ����, ���ڴ� �ߺ��� ������� �ʴ´�.
    - ������ null���� ���ؼ��� �ߺ��� ����Ѵ�.
    - unique�� �� ���̺� 2���̻� ������ �� �ִ�.
*/
create table tb_unique (
    -- idx�÷��� �ܵ����� unique�� �����ȴ�.
    idx number unique not null,
    name varchar2(30),
    telephone varchar2(20),
    nickname varchar2(30),
    /*
        2���� �÷��� ���ļ� �����Ѵ�. �̰�� ������ ������������
        unique�� �����ȴ�.
    */
    unique(telephone, nickname)
    );
-- ���ڵ� �Է�
insert into tb_unique (idx, name, telephone, nickname)
    values(1, '���̸�', '010-1111-1111', '���座��');
insert into tb_unique (idx, name, telephone, nickname)
    values(2, '����', '010-2222-2222', '');
insert into tb_unique (idx, name, telephone, nickname)
    values(3, '����', '', '');
-- unique �� �ߺ��� ������� �ʴ� �������������� null�� ������ �� �� �ִ�.  
select * from tb_unique;

-- idx�÷��� �ߺ��� ���� �ԷµǹǷ� ������ �߻��Ѵ�.
insert into tb_unique (idx, name, telephone, nickname)
    values(1, '����', '010-3333-3333', '');

insert into tb_unique values(4, '���켺', '010-4444-4444', '��ȭ���');  
insert into tb_unique values(5, '������', '010-5555-5555', '��ȭ���');  -- �Է�
insert into tb_unique values(6, 'Ȳ����', '010-4444-4444', '��ȭ���');  -- ����
/*
    telephone�� nickname�� ������ ��������� �����Ǿ����Ƿ� �ΰ���
    �÷��� ���ÿ�[ ������ ���� ������ ��찡 �ƴ϶�� �ߺ��� ���� �Ͽ�ȴ�.
    ��, 4���� 5���� ���� �ٸ� �����ͷ� �ν��ϹǷ� �Էµǰ�, 4���� 6���� 
    ������ ����Ŀ�� �νĵǾ� ������ �߻��Ѵ�.
*/

select * from user_cons_columns;
    
/*
Foreign Key : �ܷ�Ű, ����Ű
    - �ܷ�Ű�� ���� ���Ἲ�� �����ϱ� ���� ������������
    - ���� ���̺��� �ܷ�Ű�� �����Ǿ� �ִٸ� �ڽ����̺� ��������
        ������ ��� �θ����̺��� ���ڵ�� ������ �� ����.
    
    ����1] �ζ��� ���
        create table ���̺��(
        �÷��� �ڷ��� [constraint �����]
            references �θ����̺�� (������ �÷���)
        );
*/  
create table tb_foreign1 (
    f_idx number(10) primary key,
    f_name varchar2(50),
    /*
        �ڽ����̺��� tb_foreign1���� �θ����̺��� tb_primary2�� user_id�÷���
        �����ϴ� �ܷ�Ű�� �����Ѵ�.
    */
    f_id varchar2(30) constraint tb_foreign_fk1
        references tb_primary2(user_id)
    );
-- �θ� ���̺��� ���ڵ� 1�� ���ԵǾ� ����.
select * from tb_primary2;
-- �ڽ� ���̺��� ���ڵ尡 ���� ������.
select * from tb_foreign1;
-- ���� �߻�. �θ����̺��� gildong�̶�z ���̵� ����.
insert into tb_foreign1 values (1, 'ȫ�浿', 'gildong');
-- �Է� ����. �θ����̺� white��� ���̵� ����.
insert into tb_foreign1 values (1, '�Ͼ��', 'white');
/*
    �ڽ����̺��� �����ϴ� ���ڵ尡 �����Ƿ�, �θ����̺��� ���ڵ带 ������ ��
    ����. �� ��� �ݵ�� �ڽ� ���̺��� ���ڵ带 ���� ������ �� �θ����̺���
    ���ڵ带 �����ؾ� �Ѵ�.
*/
-- ���� �߻�
delete from tb_primary2 where user_id='white';

-- �ڽ����̺��� ���ڵ带 ���� ������ �� ...
delete from tb_foreign1 where f_id='white';
-- �θ� ���̺��� ���ڵ带 �����ϸ� ���� ó�� �ȴ�.
delete from tb_primary2 where user_id='white';

-- ��� ���ڵ尡 ������ �����̴�.
select * from tb_foreign1;
select * from tb_primary2;    

/*
    2���� ���̺��� �ܷ�Ű(����Ű)�� �����Ǿ� �ִ� ���
    �θ����̺��� ������ ���ڵ尡 ���ٸ� �ڽ����̺� insert�� �� ����.
    �ڽ����̺��� �θ� �����ϴ� ���ڵ尡 ���������� �θ����̺���
    ���ڵ带 delete�� �� ����.
*/

/*
����2] �ƿ����� ���
    create table ���̺��(
        �÷��� �ڷ���,
        [constaint �����] foreign key(�÷���)
            references �θ����̺� (������ �÷�)
        );
*/
create table tb_foreign2 (
    f_id number primary key,
    f_name varchar2(30),
    f_date date,
    foreign key (f_id) references tb_primary1 (idx)
    );
select * from user_cons_columns;
/*
    ������ �������� �������� Ȯ�ν��� �÷���
    P : Primary key
    R : Refernce integrity �� Foreign key �� ���Ѵ�.
    C : Check Ȥ�� Not null
    U : Unique
*/
/*
����2] ���̺� ���� �� alter ������ �ܷ�Ű �������� �߰�
    alter table ���̺�� add [constraint �����]
        foreign key (�÷���)
            references �θ����̺� (���� �÷���)
*/
create table tb_foreign3 (
    idx number primary key,
    f_name varchar2(30),
    f_idx number(10)
    );
alter table tb_foreign3 add
    foreign key (f_idx) references tb_primary1 (idx);
select * from user_cons_columns;
/*
    �ϳ��� �θ����̺� �� �̻��� �ڽ����̺��� �ܷ�Ű�� ������ �� �ִ�.
*/
/*
�ܷ�Ű ���� �ɼ�
[on delete cascade]
    : �θ��ڵ� ������ �ڽķ��ڵ���� ���� �����ȴ�.
    ����] 
        �÷��� �ڷ��� references �θ����̺� (pk�÷�)
            on delete cacade;
[on dalete set null]
    :�θ��ڵ� ������ �ڽķ��ڵ� ���� null�� ����ȴ�.
    ����]
        �÷��� �ڷ��� references �θ����̺� (pk�÷�)
            on delete set null
* �ǹ����� ����Խù��� ���� ȸ���� �� �Խñ��� �ϰ������� �����ؾ��� ��
    ����� �� �ִ� �ɼ��̴�. ��, �ڽ����̺��� ��� ���ڵ尡 �����ǹǷ� 
    ��뿡 �����ؾ� �Ѵ�.
*/
create table tb_primary4 (
    user_id varchar2(30) primary key,
    user_name varchar2(100)
    );

create table tb_foreign4 (
    f_idx number(10) primary key,
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign4_fk
        references tb_primary4 (user_id)
            on delete cascade
    );
/*
    �ܷ�Ű�� ������ ��� �ݵ�� �θ����̺� ���ڵ带 ���� �Է��� ��
    �ڽ� ���̺� �Է��ؾ� �Ѵ�.
*/
insert into tb_primary4 values ('student', '�Ʒû�1');
insert into tb_foreign4 values (1, '����1�Դϴ�.', 'student');
insert into tb_foreign4 values (2, '����2�Դϴ�.', 'student');
insert into tb_foreign4 values (3, '����3�Դϴ�.', 'student');
insert into tb_foreign4 values (4, '����4�Դϴ�.', 'student');
insert into tb_foreign4 values (5, '����5�Դϴ�.', 'student');
insert into tb_foreign4 values (6, '����6�Դϴ�.', 'student');
insert into tb_foreign4 values (7, '����7�Դϴ�.', 'student');
-- �θ�Ű�� �����Ƿ� ���ڵ带 ������ �� ����. ���� �߻�
insert into tb_foreign4 values (8, '��???����??', 'teacher');

-- �տ��� ������ ���ڵ尡 �ԷµǾ��ִ� ������.
select * from tb_primary4;
select * from tb_foreign4;

/*
    �θ����̺��� ���ڵ带 ������ ��� on delete cascade �ɼǿ� ����
    �ڽ��ʰ��� ��� ���ڵ尡 �����ȴ�. ���� �ش� �ɼ��� �������� ���·�
    �ܷ�Ű�� �����ߴٸ� ���ڵ�� �������� �ʰ� ������ �߻��ϰ� �ȴ�.
*/
delete from tb_primary4 where user_id='student';

-- �θ� �ڽ� ���̺��� ��� ���ڵ尡 �����ȴ�.
select * from tb_primary4;
select * from tb_foreign4;

--------------------------------------------------------------------
-- on delete set null �ɼ� �׽�Ʈ
create table tb_primary5 (
    user_id varchar2(30) primary key,
    user_name varchar2(100)
    );

create table tb_foreign5 (
    f_idx number(10) primary key,
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign5_fk
        references tb_primary5 (user_id)
            on delete set null
    );

insert into tb_primary5 values ('student', '�Ʒû�1');
insert into tb_foreign5 values (1, '����1�Դϴ�.', 'student');
insert into tb_foreign5 values (2, '����2�Դϴ�.', 'student');
insert into tb_foreign5 values (3, '����3�Դϴ�.', 'student');
insert into tb_foreign5 values (4, '����4�Դϴ�.', 'student');
insert into tb_foreign5 values (5, '����5�Դϴ�.', 'student');
insert into tb_foreign5 values (6, '����6�Դϴ�.', 'student');
insert into tb_foreign5 values (7, '����7�Դϴ�.', 'student');

select * from tb_primary5;
select * from tb_foreign5;
/*
    on delete set null �ɼ����� �ڽ����̺��� ���ڵ�� �������� �ʰ�, ����Ű
    �κи� null������ ����ȴ�. ���� ���̻� ������ �� ���� ���ڵ�� ����ȴ�.
*/
delete from tb_primary5 where user_id='student';

-- �θ����̺��� ���ڵ�� �����ȴ�.
select * from tb_primary5;
-- �ڽ����̺��� ���ڵ�� �����ִ�. ��, �����÷��� null�� ����ȴ�.
select * from tb_foreign5;

/*
not null : null ���� ������� �ʴ� ��������
    ����]
        create table ���̺�� (
            �÷��� �ڷ��� not null,
            �÷��� �ڷ��� null <- null �� ����Ѵٴ� �ǹ̷� �ۼ��ߵ� 
                                    �̷��� ������� �ʴ´�. null�� �������
                                    ������ �ڵ����� ����Ѵٴ� �ǹ̰� �ȴ�.
        );
*/
create table tb_not_null (
    m_idx number(10) primary key,    -- PK�̹Ƿ� NN
    m_id varchar2(20) not null,      -- NN
    m_pw varchar2(30) null,         -- null ���.(�Ϲ������� �̷��� ��� ����.)
    m_name varchar2(40)             -- null ���.(�̿Ͱ��� ���)
    );
desc tb_not_null;
-- 10~30������ ���������� �Էµȴ�.
insert into tb_not_null values (10, 'hong1', '1111', 'ȫ�浿');
insert into tb_not_null values (20, 'hong2', '2222', '');
insert into tb_not_null values (30, 'hong3', '', '');
-- m_id�� NN���� �����Ǿ����Ƿ� null���� ������ �� ���� ������ �߻��Ѵ�.
insert into tb_not_null values (40, '', '', '');
-- �Է� ����  space�� �����̹Ƿ� �Էµȴ�.
insert into tb_not_null values (50, ' ', '5555', '���浿');
-- �����߻�. PK����  null���� �Է��� �� ����. �÷��� ������� ������ null��
-- �Էµȴ�.
insert into tb_not_null (m_id, m_pw, m_name)
    values ('hong6', '6666', '���浿');
    
select * from tb_not_null;

/*
default : insert �� �ƹ��� ���� �Է����� �ʾ����� �ڵ����� ���ԵǴ�
    �����͸� ������ �� �ִ�.
*/
create table tb_default (
    id varchar2(30) not null,
    pw varchar2(50) default 'gwer'
);
insert into tb_default values ('aaaa','1234');  -- 1234 �Էµ�.
insert into tb_default (id) values ('bbbb');  -- �÷���ü�� �����Ƿ� default ���Է�
insert into tb_default values ('cccc','');  -- null �� �Է�
insert into tb_default values ('dddd',' '); -- ����(space) �Է�
insert into tb_default values ('eeee',default); -- default�� �Է�
/*
    default ���� �Է��Ϸ��� insert������ �÷� ��ü�� ���ܽ�Ű�ų�
    default Ű���带 ����ؾ� �Ѵ�.
*/
select * from tb_default;

/*
check : Domain(�ڷ���) ���Ἲ�� �����ϱ� ���� ������������ �ش� �÷���
    �߸��� �����Ͱ� �Էµ��� �ʵ��� �����ϴ� ���������̴�.
*/
-- M, F�� �Է��� ����ϴ� check ��������
create table tb_check1 (
    gender char(1) not null
        constraint check_gender
            check (gender in ('M', 'F'))
);
insert into tb_check1 values ('M');
insert into tb_check1 values ('F');
-- check �������� ����� ���� �߻�
insert into tb_check1 values ('T');
-- �Էµ� �����Ͱ� �÷��� ũ�⺸�� ũ�Ƿ� ���� �߻�
insert into tb_check1 values ('����');
select * from tb_check1;

-- 10������ ���� �Է��� �� �ִ� check �������� ����
create table tb_check2 (
    sale_count number not null
        check (sale_count<=10)
);
insert into tb_check2 values (9);
insert into tb_check2 values (10);
-- �������� ����� �Է½���
insert into tb_check2 values (11);
select * from tb_check2;

