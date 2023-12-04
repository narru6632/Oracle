/*****************
���ϸ� : Or05String.sql
���ڿ� ó�� �Լ�
���� : ���ڿ��� ���� ��ҹ��ڸ� ��ȯ�ϰų� ���ڿ��� ���̸� ��ȯ�ϴ� ��
    ���ڿ��� �����ϴ� �Լ�
*******************/
-- HR �������� �ϱ�

/*
concat('���ڿ�1', '���ڿ�2')
    : ���ڿ�1�� ���ڿ�2�� �����ؼ� ����ϴ� �Լ�
    ����1 : concat('���ڿ�1', '���ڿ�2')
    ����2 : '���ڿ�1' || '���ڿ�2'
*/
select concat('Good ', 'morning') as "��ħ �λ�" from dual;
select 'Good ' || 'morning' from dual;

select 'Oracle '||'21C '||'Good...!!' from dual;
-- => �� SQL���� concat()���� �����ϸ� ������ ����.(���� �����ϴ�)
select concat(concat('Oracle ', '21C '), 'Good...!!') from dual;

/*
�ó�����] ������̺��� ����� �̸��� �����ؼ� �Ʒ��� ���� ����Ͻÿ�.
    ��³��� : first+lasr name, �޿�, �μ���ȣ
*/
-- step1 : �̸��� �����ؼ� ��������� ���Ⱑ �ȵż� �������� ��������.
select concat(first_name, last_name), salary, department_id
    from employees;
-- step2 : �����̽��� �߰��ϱ� ���� concat()�� �ϳ� �� ����Ѵ�.
select concat(concat(first_name, ' '), last_name), salary, department_id
    from employees;
/*step3 : 2���� �Լ��� ����ϴ� �ͺ��ٴ� ||�� �̿��ϸ� ������ ǥ���� ��
�־� ���ϴ�. ���� �÷����� as�� �̿��ؼ� ��Ī�� �ο��Ѵ�.*/
select first_name || ' ' || last_name as fullname, salary, department_id
    from employees;

/*
initcap(���ڿ�)
    : ���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�
    ��, ù���ڸ� �ν��ϴ� ������ ������ ����.
    - ���鹮�� ������ ������ ù���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
    - ���ĺ��� ���ڸ� ������ ������ ���� ������ ������ ù��° ���ڸ�
    �빮�ڷ� ��ȯ�Ѵ�.
*/
-- hi, hello�� ù���ڸ� �빮�ڷ� ����
select initcap('hi hello �ȳ�')from dual;
-- g, b, m�� �빮�ڷ� ����ȴ�.
select initcap('good/bad morning')from dual;
-- n, g, b�� �빮�ڷ� ����ȴ�. 6�� �����̹Ƿ� say�� ������� �ʴ´�.
select initcap('naver6say*good��bye')from dual;

/*
�ó�����] ������̺��� first_name�� john�� ����� ã�� �����Ͻÿ�.
*/
-- �̿Ͱ��� �����ϸ� ����� ������� �ʴ´�.(�����ʹ� ��ҹ��ڸ� �����Ѵ�.)
select * from employees where first_name='john';
-- ���� �Ʒ��� ���� �Լ��� ����ϰų� �빮�ڰ� ���Ե� �̸��� ����ؾ� �Ѵ�.
-- �Ѵ� 3���� �˻� ����� ����ȴ�.
select * from employees where first_name=initcap('john');
select * from employees where first_name='John';

/*
��ҹ��� �����ϱ�
    lower() : �ҹ��ڷ� ������.
    upper() : �빮�ڷ� ������.
*/
select lower('GOOD'), upper('bad') from dual;
-- ���Ͱ��� john�� �˻��ϱ� ���� ������ ���� Ȱ���Ҽ��� �ִ�.
-- �÷���ü�� �빮�� Ȥ�� �ҹ��ڷ� ������ �� �����Ѵ�.
select * from employees where lower(first_name)='john';
select * from employees where upper(first_name)='JOHN';

/*
lpad(), rpad()
    : ���ڿ��� ����, �������� Ư���� ��ȣ�� ä�ﶧ ����Ѵ�.
    ����] lpad('���ڿ�', '��ü�ڸ���', 'ü�﹮�ڿ�')
        -> ��ü�ڸ������� ���忭�� ���̸�ŭ�� ä���ִ� �Լ�
        rpad()�� �������� ä����.
*/
-- ��°�� : good,	###good, good###, ...good(���� 3���� ������ ��µ�)
select 'good', lpad('good', 7, '#'), rpad('good', 7, '#'), lpad('good', 7)
    from dual;
-- �̸� ��ü�� 12�ڷ� �����Ͽ� �̸��� ������ ������ �κ��� *�� ä���.
select  rpad(first_name, 12, '*') from employees;
select  rpad(first_name, 12, '*')||rpad(last_name, 12) as fullname 
    from employees;

/*
substr() : ���ڿ����� �����ε������� ���̸�ŭ �߶� ���ڿ��� ����Ѵ�.
    ����] substr(�÷�, �����ε���, ����)
    
    ����1] ����Ŭ�� �ε����� 1���� �����Ѵ�.(0���� �ƴ�)
    ����2] '����'�� �ش��ϴ� ���ڰ� ������ ���ڿ��� �������� �ǹ��Ѵ�.
    ����3] �����ε����� ���Ǽ��� ���������� �������� �ε����� �����Ѵ�.
*/
select substr('good morning john', 8, 4) from dual;
select substr('good morning john', 8) from dual;

/*
�ó�����] ������̺��� first_name�� ù���ڸ� ������ ������ �κ��� 
    *�� ����ŷ ó���ϴ� �������� �ۼ��Ͻÿ�.
*/
-- substr(���ڿ� Ȥ�� �÷�, �����ε���, ����) : �����ε������� ���̸�ŭ
-- �߶󳽴�.
select substr('abcdefg', 1, 1) from dual;
select substr(first_name, 1, 1) from employees;
-- ���ڿ��� ���̸� 10���� �����Ͽ� ���� �κ��� *�� ä���.
-- �� �̸��� ������ ������ 5�� *�� ä���ش�.
select rpad('Ellen', 10, '*') from dual;
-- length(���ڿ� Ȥ�� �÷�) : �ش� ���ڿ��� ���̸� ��ȯ�Ѵ�.
select
    first_name,
    rpad(substr(first_name, 1, 1), length(first_name), '*') "����ŷ"
 from employees;

/*
trim() : ������ ������ �� ����Ѵ�.
    ����] trim([leading | trailing | both] ������ ���� from �÷���)
        leading : ���ʿ��� ������
        trailing : �����ʿ��� ������
        both : ���ʿ��� ������. �������� ������ both�� ����Ʈ
        [����1] ������ ���ڸ� ���ŵǰ�, �߰��� �ִ� ���ڴ� ���ŵ��� ����.
        [����2] ���ڸ� ������ �� �ְ�, '���ڿ�'�� ������ �� ����. �����߻���.
*/
select ' ���������׽�Ʈ' as trim1, 
    trim(' ������ ���׽�Ʈ ') as trim2, -- ������ ���� ���ŵ�
    trim('��' from '�ٶ��㰡 �� ������ ž�ϴ�') trim3,    --  ������ '��' ����
    trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�') trim4,  -- both �� ����Ʈ �ɼ�
    trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�') trim5, -- ������ '��' ����
    trim(trailing '��' from '�ٶ��㰡 ������ ž�ϴ�') trim6 -- ������ '��' ����
 from dual;
-- trim()�� �߰��� ���ڴ� ������ �� ����, ������ ���ڸ� ������ �� �ִ�.

-- trim()�� ���ڿ��� ������ �� ���� ������ �߻��Ѵ�.
select
    trim('�ٶ���' from '�ٶ��㰡 ������ Ÿ�ٰ� ���������TT') TrimError
 from dual;

/*
ltrim(), rtrim() : L[eft]Trim, R[ight]Trim
    : ����, ���� '����' Ȥ�� '���ڿ�'�� ������ �� ����Ѵ�.
    * TRIM�� ���ڿ��� ������ �� ������, LTRIM, RTRIM�� ���ڿ�����
    ������ �� �ִ�.
*/
select 
    ltrim(' ������������ ') ltrim,  -- ���� ������ ���ŵȴ�.
    -- �̰�� ������ �����̽��� ���Ե� ���ڿ��̹Ƿ� �������� �ʴ´�.
    ltrim(' ������������ ', '����') ltrim2,
    -- ���⼭�� '����'�̶�� ���ڿ��� �����ȴ�.
    ltrim('������������ ', '����') ltrim3,
    -- ������ ���ڿ��� ���ŵȴ�.
    rtrim('������������', '����') rtrim1,
    -- ���ڿ� �߰��� ���ŵ��� �ʴ´�.
    rtrim('������������ ', '����') rtrim2
from dual;

/*
substrb() :����Ʈ ������ ���ڿ��� �ڸ� �� ����Ѵ�.
    ����] substrb(���ڿ�, ������ġ, ����)
*/
SELECT * 
  FROM nls_database_parameters 
 WHERE parameter LIKE '%CHARACTERSET%';  -- �ѱ� 1���ڴ� 3����Ʈ��.
 -- 4����Ʈ ���� ���. �׷��� '���ϼ���'
select substrb('�ȳ��ϼ���', 4) from dual;  
select substrb('JONES', 2, 4) from dual;

/*
replace() : ���ڿ��� �ٸ� ���ڿ��� ��ü�� �� ����Ѵ�. ���� ��������
    ���ڿ��� ��ü�Ѵٸ� ���ڿ��� �����Ǵ� ����� �ȴ�.
    ����] replace(�÷��� or ���ڿ�, '������ ����� ����', '������ ����')
    
    * trim(), ltrim(), rtrim() �Լ��� ����� replace()�Լ� �ϳ��� ��ü�� �� 
    �����Ƿ� trim() �� ���� replace()�� �ξ� �� ���󵵰� ����.
*/
-- ���ڿ��� �����Ѵ�.
select replace('good morning john', 'morning', 'evening') from dual;
-- ���ڿ��� �����Ѵ�. ���ڿ��� ����ǹǷ� ������� �Ҽ� �ִ�.
select replace('good morning john', 'john', '') from dual;
-- trim�� ������ ���鸸 ���ŵȴ�.
select trim(' good morning john ') as "����" from dual;
-- replace�� �¿����� �ƴ϶� �߰��� ���鉥 ������ �� �ִ�.
select replace(' good morning john ', ' ', '') from dual;

-- 102�� ����� ���ڵ带 ������� ���ڿ� ������ �غ���.
select first_name, last_name,
    ltrim(first_name, 'L') "���� L ����",
    rtrim(first_name, 'ex') "���� ex ����",
    replace(last_name, ' ', '') "�߰� ���� ����",
    replace(last_name, 'De', 'Dea') "������"
 from employees where employee_id=102;

/*
instr() : �ش� ���ڿ����� Ư�� ���ڰ� ��ġ�� �ε������� ��ȯ�Ѵ�.
    ����1] instr(�÷���, 'ã�� ����')
        : ���ڿ��� ó������ ���ڸ� ã�´�.
    ����2] instr(�÷���, 'ã�� ����', 'Ž���� ������ �ε���', '���° ����')
        : Ž���� �ε������� ���ڸ� ã�´�. ��, ã�� ������ ���°�� �ִ�
        �������� ������ �� �ִ�.
    * Ž���� ������ �ε����� ������ ��� �������� �������� ã�Եȴ�.
*/
-- n�� �߰ߵ� ù���� �ε��� ��ȯ
select instr('good morning john', 'n') from dual;
-- �ε���1���� Ž���� �����ؼ� n�� �߰ߵ� �ι�° �ε��� ��ȯ
select instr('good morning john', 'n', 1, 2) from dual;
-- �ε��� 8���� Ž���� �����Ͽ� h�� �߰ߵ� ù��° �ε��� ��ȯ
select instr('good morning john', 'h', 8, 1) from dual;


