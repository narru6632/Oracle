/*
���ϸ� : Or05String.sql
���ڿ� ó���Լ�
���� : ���ھ� ���� ��ҹ��ڸ� ��ȯ�ϰų�
���ڿ��� ���̸� ��ȯ�ϴ� �� ���ڿ��� �����ϴ� �Լ�
HR�������� �ϱ�
*/

/*
concat('���ڿ�1', '���ڿ�2')
���ڿ�1�� ���ڿ�2�� �����ؼ� ����ϴ� �Լ�
    ���� 1: concat('���ڿ�1', '���ڿ�2')
    ���� 2: '���ڿ�1' || '���ڿ�2'
*/

select concat('Good','mornig')as"��ħ�λ�" from dual;
select 'Good'||'mornig' as"��ħ�λ�" from dual;
select 'Oracle' || '21C' || 'Good...' from dual;
-- => �� sql���� concat���� ������ (2������ ����)
select concat(concat('Oracle', '21C'), 'Good...') from dual;
/*
�ó�����] ������̺��� ����� �̸��� �����ؼ� �Ʒ��� ���� ����Ͻÿ�
��³��� : first+last name, �޿�, �μ���ȣ
*/
--step1 - �̸��� �����ؼ� ��������� ���Ⱑ �ȵǾ� �������� ��������s
select concat(first_name, last_name), salary, department_id
        from employees;
--step2 - �����̽��� �߰��ϱ�
select concat(concat(first_name,' '), last_name), salary, department_id
        from employees;
--step3 - ��ó��  2���� �Լ��� ���°� ���ٴ� }}�� �̿��ϸ� ������ ǥ���� �� �ִ�
-- ���� �÷����� as�� �̿��ؼ� ��Ī�� �ٿ��� �� �ִ� ,�Լ��� �ϳ��� ���⿡ ���굵 ����
select first_name || ' ' ||  last_name as fullname, salary, department_id
        from employees;
        
        
        
/*
initcap(���ڿ�)
    : ���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�
    ��, ù���ڸ� �ν��ϴ� ������ ������ ����
    - ���鹮�� ������ ù ���ڸ� �빮�ڷ� ��ȯ�Ѵ�
    - ���ĺ��� ���ڸ� ������ ������ ���� ������ ������ 
            ù��° ���ڸ� �빮�ڷ� ��ȯ�Ѵ�
*/
--hi, hello�� ù���ڸ� �빮�ڷ� ����

select initcap('hi, hello �ȳ�')from dual;

--g b m �� �빮�ڷ� ����
select initcap('good, bad / morning')from dual;
--n g b�� �빮�ڷ� ����, �� 6�� ����

select initcap('naver6say*good*bye') from dual;

/*
�ó�����] ������̺��� first_name�� john�λ���� ã�� �����Ͻÿ�.
*/

--�Ʒ��� ���� �����ϸ� ����� ������� �ʴ´� << �����ʹ� ��ҹ��ڸ� �����ϱ⶧��
select * from employees where first_name = 'john';
--���� �Ʒ��� ���� �Լ��� ����ϰų� �빮�ڰ� ���Ե� �̸��� ����ؾ��Ѵ�
--�� �� 3���� �˻������ ����ȴ�
select * from employees where first_name = initcap('john');
select * from employees where first_name = 'John';

/*
��ҹ��� �����ϱ�
    lower() : �빮�ڸ� �ҹ��ڷ� ����
    upper() : �ҹ��ڸ� �빮�ڷ� ����
*/
select lower('GOOD'), upper('bad')from dual;
--���� ���� john�� �˻��ϱ� ���� ������ ���� ����� �� �ִ�
select * from employees where lower(first_name)='john'; 
--   �� first name�׸��� ���� �ҹ��ڷ� �ٲ� ���� �˻�
select * from employees where upper(first_name)='JOHN'; 
--   �� first name�׸��� ���� �빮�ڷ� �ٲ� ���� �˻�

/*
lpad() rpad() 
    : ���ڿ��� ����, �������� Ư���� ��ȣ�� ä�� �� ���
    ����] ipad('���ڿ�','��ü�ڸ���','ä�﹮�ڿ�')
    ->��ü�ڸ������� ���ڿ��� ���̸�ŭ�� ä���ִ� �Լ�
    lpad()�� ����, rpad()�� ������
*/
--��°�� good, ###good, good###,(����3ĭ)good
select 'good', lpad('good', 7, '#'), rpad('good',7,'#'), lpad('good',7)
    from dual;
    
--�̸� ��ü�� 12�ڷ� �����Ͽ� �̸��� ������ ������ �κ��� *�� ä���
select rpad(first_name,12,'*') from employees;
select rpad(first_name,12,'*')||rpad(last_name,12) as fullname from employees;

/*
substr() : ���ڿ����� �����ε������� ���̸�ŭ �߶� ���ڿ��� ����Ѵ�.
    ����] substr(�÷�, �����ε���, ����)
    ����1] ����Ŭ���ε����� '1'���� ������
    ����2] '����'�� �ش��ϴ� ���ڰ� ������ ���ڿ��� �������� �ǹ��Ѵ�
    ����3] �����ε����� ������ ���������� �������� �ε����� �����Ѵ�
*/
select substr('good morning john', 8,4) from dual;
select substr('good morning john', 8) from dual;
select substr('good morning john', 1,1) from dual;


/*
�ó�����] ������̺��� first_name�� ù���ڸ� ������ ������ �κ��� 
        *�� ����ŷ ó���ϴ� �������� �ۼ��Ͻÿ�
*/

select rpad(substr(first_name,1,1),5,'*')||
rpad(substr(last_name,1,1),5,'*') from employees;

--length(���ڿ� Ȥ�� �÷�) : �ش繮�ڿ��� ���̸� ��ȯ��
select
    first_name,
    rpad(substr(first_name,1,1),length(first_name),'*') "����ŷ"
 from employees;
 
 /*
 trim() : ������ �����Ҷ� ����Ѵ�.
    ����] trim([leading | trailing | both} ������ ���� from �÷���)
                  ��         ��      �Ѵ�(�̼����� �⺻)
        [����1] ������ ���ڸ� ���ŵǰ�, �߰��� �ִ� ���ڴ� ���ŵ��� ����
        [����2] '����'�� ���� �����ϰ�, '���ڿ�'�� ������ �� ���� <-�����߻�
 */ 
 select ' ���������׽�Ʈ' as trim1,
    trim(' ���������׽�Ʈ ') as trim2, --���ʰ�������
    trim('��' from '�ٶ��㰡 ������ ž�ϴ�')as trim3,--������'��'����(����Ʈ�ɼ�)
    trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�')as trim4,--������'��'����
    trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�')as trim5,--������'��'����
    trim(trailing '��' from '�ٶ��㰡 ������ ž�ϴ�')as trim6--��������'��'����
 from dual; 
 --trim�� �߰��� ���ڴ� ������ �� ����
 --trim�� ���ڿ��� ������ �� ���� ������ �߻��Ѵ�
 select
    trim('�ٶ���' from '�ٶ��㰡 ������ Ÿ�ٰ� ���������') trimerror from dual;

 /*
 ltrim(), rtrim() : ����, ���� ���� Ȥ�� '���ڿ�'�� ������ �� ���
    trim�� �޸� ���ڿ����� ���Ű� �����ϴ�, ���� �� �����̳� �ٸ� ���ڰ� 
    ������� �߰��� �ִٰ� �ν��Ͽ� ������ �� ����
 */
 select 
    ltrim( ' ������������') ltrim, -- ������������
    ltrim( ' ������������ ','����') ltrim2, -- ������ �־� ���ڿ��� �������� ����
    ltrim( '������������ ' ,'����') ltrim2, -- ����'����'�̶�� ���ڿ��� ������
    rtrim('������������','����') rtrim1, -- ������'����'��� ���ڿ��� ������
    rtrim('������������ ','����') rtrim2 from dual; -- ���ڿ� �߰��� ���� X
    
/*
substrb() : ���ڿ��� ����Ʈ������ �ڸ� �� ���.
    ����] substrb (���ڿ�, ������ġ, ����)
*/
select substrb('�ȳ��ϼ���',4)from dual;  -- 4����Ʈ ���� ���
select substrb('Johns',2,4)from dual; -- 2����Ʈ���� 4����Ʈ���� ���

/*
replace() : ���ڿ��� �ٸ� ���ڿ��� ��ü�� �� ����Ѵ�. 
        ���� �� ���ڿ��� ���ڿ��� ��ü�Ѵٸ� ���ڿ��� �����Ǵ� ����� �����
        ����] replace(�÷��� or ���ڿ�, '������ ����� ����', '������ ����')
        
        *trim(), ltrim(), rtrim() �Լ��� ����� 
         replace()�Լ� �ϳ��� ��ü�� �� �����Ƿ� trim()�� ���� 
         replace()�� �ξ� �� ��� �󵵰� ����
*/
--���ڿ��� �����Ѵ�.
select replace('good morning john', 'morning', 'evening') from dual;
--���ڿ��� �����Ѵ�.(�� ���ڿ��� ��ü)
select replace('good morning john', 'john', '') from dual;
--trim�� ������ ���鸸 ���� �����ϴ�
select trim(' good morning john ') as ���� from dual;
--replace�� �¿������� �ƴ϶� �߰��� ������� ���� ���� �� �ִ�.
select replace('good morning john', ' ', '') from dual;

--102������� ���ڵ带 ������� ���ڿ� ������ �غ���
select first_name, last_name, 
    ltrim(first_name, 'L') "���� L ����",
    Rtrim(first_name, 'ex') "������ ex ����",
    replace(last_name, ' ','') "�߰���������",
    replace(last_name,'De','Dea') "�� ����" 
    from employees where employee_id=102;
    

/*
instr() : �ش� ���ڿ����� Ư�� ���ڰ� ��ġ�� �ε������� ��ȯ�Ѵ�
    ����1] instrr(�÷���, 'ã�� ����')
        :���ڿ��� ó������ ���ڸ� ã�´�.
    ����2] instrr(�÷���, 'ã�� ����', 'Ž���� ������ �ε���', '���° ����')
        :Ž���� �ε������� ���ڸ� ã�´�. ��, ã�� ������ ���°�� �ִ�
        �������� ������ �� �ִ�.
    *Ž���� ������ �ε����� ������ ��� �������� �������� ã�Եȴ�.
*/
-- n�� �߰ߵ� ù��° �ε��� ��ȯ
select instr('good morning john', 'n') from dual;
-- �ε��� 1���� Ž���� �����ؼ� n�� �߰ߵ� �ι�° �ε��� ��ȯ
select instr('good morning john', 'n', 1, 2) from dual;
-- �ε��� 8���� Ž���� �����ؼ� h�� �߰ߵ� ù��° �ε��� ��ȯ
select instr('good morning john', 'h', 8, 1) from dual;

