CREATE TABLE dispatch_argument_define (
  arg_id varchar2(66) NOT NULL,
  arg_type char(1) DEFAULT NULL,
  arg_value varchar2(100) DEFAULT NULL,
  code_number varchar2(30) DEFAULT NULL,
  create_user varchar2(30) DEFAULT NULL,
  create_date date DEFAULT NULL,
  modify_user varchar2(30) DEFAULT NULL,
  modify_date date DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  arg_desc varchar2(100) DEFAULT NULL,
  PRIMARY KEY (arg_id)
);

CREATE TABLE dispatch_argument_type_attr (
  arg_type char(10) NOT NULL,
  arg_type_desc varchar2(100) DEFAULT NULL,
  PRIMARY KEY (arg_type)
);

CREATE TABLE dispatch_task_type_attr (
  task_type char(1) NOT NULL,
  task_type_desc varchar2(100) DEFAULT NULL,
  PRIMARY KEY (task_type)
);

CREATE TABLE dispatch_task_define (
  task_id varchar2(66) NOT NULL,
  code_number varchar2(30) DEFAULT NULL,
  task_desc varchar2(200) DEFAULT NULL,
  task_type char(1) DEFAULT NULL,
  create_user varchar2(30) DEFAULT NULL,
  create_date date DEFAULT NULL,
  modify_date date DEFAULT NULL,
  modify_user varchar2(30) DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  script_file varchar2(200) DEFAULT NULL,
  PRIMARY KEY (task_id)
);

CREATE TABLE dispatch_group_define (
  group_id varchar2(66) NOT NULL,
  code_number varchar2(30) DEFAULT NULL,
  group_desc varchar2(200) DEFAULT NULL,
  create_user varchar2(30) DEFAULT NULL,
  create_date date DEFAULT NULL,
  modify_user varchar2(30) DEFAULT NULL,
  modify_date date DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  PRIMARY KEY (group_id)
);

CREATE TABLE dispatch_batch_status_attr (
  batch_status char(1) NOT NULL,
  batch_status_desc varchar2(100) DEFAULT NULL,
  PRIMARY KEY (batch_status)
);

CREATE TABLE dispatch_batch_define (
  batch_id varchar2(66) NOT NULL,
  code_number varchar2(30) DEFAULT NULL,
  batch_desc varchar2(200) DEFAULT NULL,
  batch_status varchar2(20) DEFAULT NULL,
  as_of_date date DEFAULT NULL,
  create_date date DEFAULT NULL,
  create_user varchar2(30) DEFAULT NULL,
  modify_date date DEFAULT NULL,
  modify_user varchar2(30) DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  PRIMARY KEY (batch_id)
);


CREATE TABLE dispatch_batch_argument_rel (
  uuid varchar2(66) NOT NULL,
  batch_id varchar2(66) DEFAULT NULL,
  arg_id varchar2(66) DEFAULT NULL,
  arg_value varchar2(100) DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  PRIMARY KEY (uuid),
  CONSTRAINT fk_dispatch_batch_argument_001 FOREIGN KEY (batch_id) REFERENCES dispatch_batch_define (batch_id) ON DELETE CASCADE
);


CREATE TABLE dispatch_batch_group_relation (
  id varchar2(66) NOT NULL,
  batch_id varchar2(66) DEFAULT NULL,
  group_id varchar2(66) DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_dispatch_batch_group_001 FOREIGN KEY (batch_id) REFERENCES dispatch_batch_define (batch_id) ON DELETE CASCADE ,
  CONSTRAINT fk_dispatch_batch_group_002 FOREIGN KEY (group_id) REFERENCES dispatch_group_define (group_id)
);

CREATE TABLE dispatch_group_task_relation (
  id varchar2(66) NOT NULL,
  group_id varchar2(66) DEFAULT NULL,
  task_id varchar2(66) DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_dispatch_group_task_001 FOREIGN KEY (group_id) REFERENCES dispatch_group_define (group_id) ON DELETE CASCADE,
  CONSTRAINT fk_dispatch_group_task_002 FOREIGN KEY (task_id) REFERENCES dispatch_task_define (task_id)
);

CREATE TABLE dispatch_group_argument_rel (
  uuid varchar2(66) NOT NULL,
  id varchar2(66) DEFAULT NULL,
  arg_id varchar2(66) DEFAULT NULL,
  arg_value varchar2(100) DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  PRIMARY KEY (uuid),
  CONSTRAINT fk_dispatch_group_argument_01 FOREIGN KEY (id) REFERENCES dispatch_group_task_relation (id) ON DELETE CASCADE
);


CREATE TABLE dispatch_group_dependency (
  uuid varchar2(66) NOT NULL,
  id varchar2(66) DEFAULT NULL,
  up_id varchar2(66) DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  PRIMARY KEY (uuid),
  CONSTRAINT fk_dispatch_group_dep_01 FOREIGN KEY (id) REFERENCES dispatch_batch_group_relation (id) ON DELETE CASCADE
);



CREATE TABLE dispatch_task_argument_rel (
  uuid varchar2(66) NOT NULL,
  task_id varchar2(66) DEFAULT NULL,
  arg_id varchar2(66) DEFAULT NULL,
  domain_id varchar2(30) DEFAULT NULL,
  arg_value varchar2(100) DEFAULT NULL,
  sort_id number(11) DEFAULT NULL,
  PRIMARY KEY (uuid),
  CONSTRAINT fk_dispatch_task_argument_001 FOREIGN KEY (task_id) REFERENCES dispatch_task_define (task_id) ON DELETE CASCADE,
  CONSTRAINT fk_dispatch_task_argument_002 FOREIGN KEY (arg_id) REFERENCES dispatch_argument_define (arg_id)
);

CREATE TABLE dispatch_task_dependency (
  uuid varchar2(66) NOT NULL,
  id varchar2(66) DEFAULT NULL,
  up_id varchar2(66) DEFAULT NULL,
  domain_id varchar2(66) DEFAULT NULL,
  PRIMARY KEY (uuid),
  CONSTRAINT fk_dispatch_task_depency_01 FOREIGN KEY (id) REFERENCES dispatch_group_task_relation (id) ON DELETE CASCADE
);


insert into dispatch_argument_type_attr(arg_type,arg_type_desc) values('1','固定参数');
insert into dispatch_argument_type_attr(arg_type,arg_type_desc) values('2','任务参数');
insert into dispatch_argument_type_attr(arg_type,arg_type_desc) values('3','任务组参数');
insert into dispatch_argument_type_attr(arg_type,arg_type_desc) values('4','批次参数');

insert into dispatch_batch_status_attr(batch_status,batch_status_desc) values('1','运行中');
insert into dispatch_batch_status_attr(batch_status,batch_status_desc) values('2','已完成');
insert into dispatch_batch_status_attr(batch_status,batch_status_desc) values('3','错误');
insert into dispatch_batch_status_attr(batch_status,batch_status_desc) values('4','停止');
insert into dispatch_batch_status_attr(batch_status,batch_status_desc) values('0','初始化');

insert into dispatch_task_type_attr(task_type,tasK_type_desc) values('1','shell 脚本');
insert into dispatch_task_type_attr(task_type,tasK_type_desc) values('2','存储过程');
insert into dispatch_task_type_attr(task_type,tasK_type_desc) values('3','CMD 脚本');
insert into dispatch_task_type_attr(task_type,tasK_type_desc) values('4','Jar 包');
insert into dispatch_task_type_attr(task_type,tasK_type_desc) values('5','二进制程序');
commit;
