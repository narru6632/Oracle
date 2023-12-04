/*
���ϸ� : Or15DCL.sql
DCL : Data Control Language(������ �����) / ����� ����
���� : ���ο� ����� ������ �����ϰ� �ý��۱����� �ο��ϴ� ����� �н�
system �������� �ϱ�
*/

/*
[����� ���� ���� �� ���Ѽ���]
�ش�κ��� DBA������ �ִ� �ְ������(sys,system)���� ������ �� �����ؾ��Ѵ�
���ο� ����� ������ ������ �� ���� �� �������� �׽�Ʈ�� cmd(���������Ʈ)â���� 
�����Ѵ�
*/
/*
1. ����� ���� ���� �� ��ȣ����
����]
    create user ���̵� identified by �н�����;
*/
-- ����Ŭ 12C ���ĺ��ʹ� �ش� ����� ���� ������ �� ������ �����ؾ� �Ѵ�
-- �̽��� ���¿��� ������ �����ϸ� ������ �߻��Ѵ�
alter session set "_ORACLE_SCRIPT"=true;

-- �� ����� ���ٸ� ���������� C##�� ������ �տ� �߰��ؾ� �Ѵ�
create user test_user1 identified by 1234;

/*
���� ���� ���� cmd���� sqlplus ������� ������ �õ��غ��� login denied
������ �߻��ȴ�. (create session =���ӱ����� �������� �ʾұ� ����)
*/

/*
2. ������ ����� ������ ���� Ȥ�� ���� �ο��ϱ�
����]
    grant �ý��۱���1,����2,.....
        to ����ڰ�����
            [with grant�ɼ�]
*/
--���� ������ �ο��Ѵ�. ������ �ο��� ������ to�� ����Ѵ�
grant create session to test_user1;
--���� �ο� �� ������ ���������� ���̺� ������ �Ұ����ϴ�(���Ѻ���)

--���̺� ���� ���� �ο�
grant create table to test_user1;

/*
3. ��ȣ ����
����]
    alter user ����ڰ��� identified by ������ ��ȣ;
*/
alter user test_user1 identified by 4321;

/*
quit Ȥ�� exit������� ������ ������ �� �ٽ� �����ϸ� 
������ȣ�� ���ӿ� ����� �� ����, ������ 4321�� ����
*/

/*
4] Role(��,����)�� ���� �������� ������ ���ÿ� �ο��ϱ�
    ���� ����ڰ� �پ��� ������ ȿ�������� ������ �� �ֵ���
    ���õ� ���ѳ��� ����� ���� ���Ѵ�. 
    �츮�� �ǽ��� ���� ���Ӱ� ������ ������  connect, resource�� �ַ� �ο��Ѵ�
*/
alter session set "_ORACLE_SCRIPT"=true;
create user test_user2 identified by 1234;
grant connect, resource to test_user2;
/*
test_user2������ ���� ���� ������ �ο��� �� ���� �� ���̺� ������ ���������� �ȴ�.
*/

/*
4-1. �� �����ϱ� : ����ڰ� ����ϴ� ������ ���� ���ο� ���� �����Ѵ�
*/
create role my_role;

/*
4-2. ������ �ѿ� ���� �ο��ϱ�
*/
-- ���Ӱ� ������ �ѿ� 3���� ������ �ο��Ѵ�
grant create session, create table, create view to my_role;
-- ���ο� ����� ������ �����Ѵ�
create user test_user3 identified by 1234;
-- ����ڿ��� role�� ���� ������ �ο��Ѵ�
grant my_role to test_user3;
-- ���� �� ���̺���� �� ������ �ο���

--4-3. �� �����ϱ�
drop role my_role;
-- test_user3�� my_role�� ���� �ο��޾Ҵ� ��� ������ ȸ���ȴ�
-- ��, �� �����Ŀ��� ������ �� ����

/*
5. ��������(ȸ��)
    ����]
        revoke ���� �� ���� from ����ڰ���;
*/
revoke create session from test_user1;--���ǻ���(���ӱ���) ��Ż, cmd �α��� �Ұ���


/*
6. ����� ���� ����
    ����]
        drop user ����ڰ��� [cascade];
    @@ cascade�� ����ϸ� ����� ������ ���õ� ��� �����ͺ��̽� ��Ű����
        ������ �������� ���� �����ǰ� ��� ��Ű�� ��ü�� ���������� �����ȴ�.
*/
-- ���� ������ ����� ����� Ȯ���� �� �ִ� ������ ����
select * from dba_users;
-- ������ �����Ϸ��� ��� �������� ��Ű��(���̺� ��)���� ���� �����Ѵ�
alter session set "_ORACLE_SCRIPT"=true;
drop user test_user1 cascade;

select * from dba_users where lower(username)='test_user1'; -- Ư�������˻�, ���������Ƿ� ����
select * from dba_users where lower(username)='test_user2'; -- ���� �� ������ �˻�����
select * from dba_users where username=upper('test_user3'); -- ���� �� ������ �˻�����


------------------------------------------------------------------------------------------
alter session set "_ORACLE_SCRIPT"=true;
create user test_user4 identified by 1234;
grant create session, create table to test_user4;

/*
���̺� �����̽���?
    ��ũ ������ �Һ��ϴ� ���̺�� ��, �׸��� �� ���� �ٸ� ������ ���̽�
    ��ü���� ����Ǵ� ����̴�. ���� ��� ����Ŭ�� ���ʷ� ��ġ�ϸ� hr������
    �����͸� �����ϴ� user��� ���̺� �����̽��� �ڵ����� �����ȴ�.
*/
--���̺� �����̽� ��ȸ�ϱ�;
desc dba_tablespaces;
select tablespace_name, status, contents from dba_tablespaces;

--���̺� �����̽� �� ��밡���� ���� Ȯ���ϱ�
select 
    tablespace_name,sum(bytes),max(bytes),
    trim(to_char(sum(bytes),'9,999,999,000')) �հ�,
    trim(to_char(max(bytes),'9,999,999,000')) �ִ�
 from dba_free_space
 group by tablespace_name;
 
--�տ��� ������ test_user4 ������� ���̺����̽� Ȯ���ϱ�
select username, default_tablespace from dba_users
    where username in upper('test_user4'); -- users ���̺� �����̽����� Ȯ��
    
--���̺� �����̽� ���� �Ҵ�
alter user test_user4 quota 2m on users;
/*
    test_user4�� system ���̺� �����̽��� ���̺��� ������ �� �ֵ��� 
    2m(�ް�����Ʈ)�� �뷮�� �Ҵ��Ѵ�
*/

--cmd���� ���̺� insert�Ǵ��� Ȯ��