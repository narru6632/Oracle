alter table board add constraint board_mem_fk
    foreign key (id)  references member (id);

select * from user_cons_columns;


create sequence seq_board_num
    start with 1   
    increment by 1
    minvalue 1
    nomaxvalue
    nocycle 
    nocache;   
