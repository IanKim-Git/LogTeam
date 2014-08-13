--drop table

drop table judge;
drop table account;
drop table schedule;
drop table todo;
drop table logcomment;
drop table attendance;
drop table userproject;
drop table structure;
drop table announcement;
drop table meeting;
drop table log;
drop table project;
drop table proguser;


--proguser table

CREATE TABLE "PROGUSER" 
   (	"UEMAIL" VARCHAR2(30) NOT NULL ENABLE, 
	"UNAME" VARCHAR2(10) NOT NULL ENABLE, 
	"UPW" VARCHAR2(20) NOT NULL ENABLE, 
	"UPHONE" VARCHAR2(13), 
	"UPHOTO" BLOB, 
	"UPROCNT" VARCHAR2(4) DEFAULT 0 NOT NULL ENABLE, 
	 CONSTRAINT "PROGUSER_PK" PRIMARY KEY ("UEMAIL") ENABLE
   );
 
--project table

CREATE TABLE "PROJECT" 
   (	"PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"PNAME" VARCHAR2(20) NOT NULL ENABLE, 
	"PPW" VARCHAR2(20) NOT NULL ENABLE, 
	"PMENTO" VARCHAR2(30), 
	"PSTART" DATE NOT NULL ENABLE, 
	"PEND" DATE, 
	"PLEADER" VARCHAR2(20) NOT NULL ENABLE, 
	"PTERMINATE" NUMBER(1,0) NOT NULL ENABLE, 
	 CONSTRAINT "PROJECT_PK" PRIMARY KEY ("PNUM") ENABLE, 
	 CONSTRAINT "P_PLEADER_FK" FOREIGN KEY ("PLEADER")
	  REFERENCES "PROGUSER" ("UEMAIL") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "P_PMENTO_FK" FOREIGN KEY ("PMENTO")
	  REFERENCES "PROGUSER" ("UEMAIL") ON DELETE SET NULL ENABLE
   );
 
--log table

CREATE TABLE "LOG" 
   (	"LNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"L_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"L_UEMAIL" VARCHAR2(30), 
	"LDATA" DATE NOT NULL ENABLE, 
	"LTEXT" VARCHAR2(1000), 
	"LPHOTO" BLOB, 
	"LFILE" BLOB, 
	"LPUBLIC" NUMBER(1,0) NOT NULL ENABLE, 
	"LADMISSION" NUMBER(1,0) NOT NULL ENABLE, 
	 CONSTRAINT "LOG_PK" PRIMARY KEY ("LNUM", "L_PNUM") ENABLE, 
	 CONSTRAINT "L_PNUM_FK" FOREIGN KEY ("L_PNUM")
	  REFERENCES "PROJECT" ("PNUM") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "L_UEMAIL_FK" FOREIGN KEY ("L_UEMAIL")
	  REFERENCES "PROGUSER" ("UEMAIL") ON DELETE SET NULL ENABLE
   ) ;
 
--announcement table

CREATE TABLE "ANNOUNCEMENT" 
   (	"ANNUM" NUMBER NOT NULL ENABLE, 
	"AN_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"ANDATE" DATE, 
	"AN_UEMAIL" VARCHAR2(30), 
	"ANCONTENT" VARCHAR2(1000), 
	"ANIMPORTANCE" NUMBER(1,0), 
	 CONSTRAINT "ANNOUNCEMENT_PK" PRIMARY KEY ("ANNUM", "AN_PNUM") ENABLE, 
	 CONSTRAINT "AN_PNUM_FK" FOREIGN KEY ("AN_PNUM")
	  REFERENCES "PROJECT" ("PNUM") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "AN_UEMAIL_FK" FOREIGN KEY ("AN_UEMAIL")
	  REFERENCES "PROGUSER" ("UEMAIL") ON DELETE SET NULL ENABLE
   );
 


--meeting table

CREATE TABLE "MEETING" 
   (	"MNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"M_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"MDATE" DATE, 
	"MPLACE" VARCHAR2(30), 
	"MPOINT" VARCHAR2(30), 
	"MCONTENT" VARCHAR2(100), 
	 CONSTRAINT "MEETING_PK" PRIMARY KEY ("MNUM", "M_PNUM") ENABLE, 
	 CONSTRAINT "M_PNUM_FK" FOREIGN KEY ("M_PNUM")
	  REFERENCES "PROJECT" ("PNUM") ON DELETE CASCADE ENABLE
   ); 
 
--structure table


CREATE TABLE "STRUCTURE" 
   (	"ST_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"ST_AN" NUMBER(1,0), 
	"ST_AT" NUMBER(1,0), 
	"ST_AH" NUMBER(1,0), 
	"ST_AC" NUMBER(1,0), 
	 CONSTRAINT "STRUCTURE_PK" PRIMARY KEY ("ST_PNUM") ENABLE, 
	 CONSTRAINT "ST_PNUM_FK" FOREIGN KEY ("ST_PNUM")
	  REFERENCES "PROJECT" ("PNUM") ON DELETE CASCADE ENABLE
   );
 
--UserProject table

CREATE TABLE "USERPROJECT" 
   (	"UP_UEMAIL" VARCHAR2(30) NOT NULL ENABLE, 
	"UP_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"UPCLICK" NUMBER(4,0) NOT NULL ENABLE, 
	 CONSTRAINT "USERPROJECT_PK" PRIMARY KEY ("UP_UEMAIL", "UP_PNUM") ENABLE, 
	 CONSTRAINT "UP_UEMAIL_FK" FOREIGN KEY ("UP_UEMAIL")
	  REFERENCES "PROGUSER" ("UEMAIL") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "UP_PNUM_FK" FOREIGN KEY ("UP_PNUM")
	  REFERENCES "PROJECT" ("PNUM") ON DELETE CASCADE ENABLE
   );
 


--Attendance table

CREATE TABLE "ATTENDANCE" 
   (	"AT_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"AT_MNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"AT_UEMAIL" VARCHAR2(30) NOT NULL ENABLE, 
	"ATCHECK" NUMBER(1,0), 
	"ATIP" VARCHAR2(16), 
	 CONSTRAINT "ATTENDANCE_PK" PRIMARY KEY ("AT_PNUM", "AT_MNUM", "AT_UEMAIL") ENABLE, 
	 CONSTRAINT "AT_UEMAIL_FK" FOREIGN KEY ("AT_UEMAIL")
	  REFERENCES "PROGUSER" ("UEMAIL") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "AT_P_MNUM_FK" FOREIGN KEY ("AT_MNUM", "AT_PNUM")
	  REFERENCES "MEETING" ("MNUM", "M_PNUM") ENABLE
   ); 
 
--logComment table

CREATE TABLE "LOGCOMMENT" 
   (	"C_LNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"CNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"CDATE" DATE NOT NULL ENABLE, 
	"C_UEMAIL" VARCHAR2(30) NOT NULL ENABLE, 
	"CTEXT" VARCHAR2(1000), 
	"C_L_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	 CONSTRAINT "LOGCOMMENT_PK" PRIMARY KEY ("CNUM", "C_L_PNUM", "C_LNUM") ENABLE, 
	 CONSTRAINT "C_L_PNUM_FK" FOREIGN KEY ("C_LNUM", "C_L_PNUM")
	  REFERENCES "LOG" ("LNUM", "L_PNUM") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "C_UEMAIL_FK" FOREIGN KEY ("C_UEMAIL")
	  REFERENCES "PROGUSER" ("UEMAIL") ON DELETE CASCADE ENABLE
   ); 
 
--ToDo table

CREATE TABLE "TODO" 
   (	"TD_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"TDNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"TDDATE" DATE NOT NULL ENABLE, 
	"TDWHO" VARCHAR2(30), 
	"TDWHAT" VARCHAR2(1000) NOT NULL ENABLE, 
	 CONSTRAINT "TODO_PK" PRIMARY KEY ("TDNUM", "TD_PNUM") ENABLE, 
	 CONSTRAINT "TD_PNUM_FK" FOREIGN KEY ("TD_PNUM")
	  REFERENCES "PROJECT" ("PNUM") ON DELETE CASCADE ENABLE
   ); 
 

--schedule table

CREATE TABLE "SCHEDULE" 
   (	"S_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"SNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"SDATE" DATE NOT NULL ENABLE, 
	"STEXT" VARCHAR2(100), 
	 CONSTRAINT "SCHEDULE_PK" PRIMARY KEY ("SNUM", "S_PNUM") ENABLE, 
	 CONSTRAINT "S_PNUM_FK" FOREIGN KEY ("S_PNUM")
	  REFERENCES "PROJECT" ("PNUM") ON DELETE CASCADE ENABLE
   ); 
 
--Account

CREATE TABLE "ACCOUNT" 
   (	"AC_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"ACNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"ACPLUS" NUMBER(9,0), 
	"ACMINUS" NUMBER(9,0), 
	"ACCONTENTS" VARCHAR2(50) NOT NULL ENABLE, 
	"ACPHOTO" BLOB, 
	 CONSTRAINT "ACCOUNT_PK" PRIMARY KEY ("ACNUM", "AC_PNUM") ENABLE, 
	 CONSTRAINT "AC_PNUM_FK" FOREIGN KEY ("AC_PNUM")
	  REFERENCES "PROJECT" ("PNUM") ON DELETE CASCADE ENABLE
   ); 
 
-- Judge


CREATE TABLE "JUDGE" 
   (	"J_UEMAIL" VARCHAR2(30) NOT NULL ENABLE, 
	"J_LNUM" NUMBER(4,0) NOT NULL ENABLE, 
	"JSCORE" NUMBER(1,0), 
	"J_L_PNUM" NUMBER(4,0) NOT NULL ENABLE, 
	 CONSTRAINT "JUDGE_PK" PRIMARY KEY ("J_UEMAIL", "J_LNUM", "J_L_PNUM") ENABLE, 
	 CONSTRAINT "J_L_PNUM_FK" FOREIGN KEY ("J_LNUM", "J_L_PNUM")
	  REFERENCES "LOG" ("LNUM", "L_PNUM") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "J_UEMAIL_FK" FOREIGN KEY ("J_UEMAIL")
	  REFERENCES "PROGUSER" ("UEMAIL") ON DELETE CASCADE ENABLE
   ); 
 
--drop
DROP SEQUENCE SEQ_P;
DROP SEQUENCE SEQ_L;
DROP SEQUENCE SEQ_AN;
DROP SEQUENCE SEQ_M;
DROP SEQUENCE SEQ_C;
DROP SEQUENCE SEQ_S;
DROP SEQUENCE SEQ_TD;
DROP SEQUENCE SEQ_AC;

--create sequence
CREATE SEQUENCE SEQ_P INCREMENT BY 1 START WITH 1 maxvalue 9990;
CREATE SEQUENCE SEQ_L INCREMENT BY 1 START WITH 1 maxvalue 9990;
CREATE SEQUENCE SEQ_AN INCREMENT BY 1 START WITH 1 maxvalue 9990;
CREATE SEQUENCE SEQ_M INCREMENT BY 1 START WITH 1 maxvalue 9990;
CREATE SEQUENCE SEQ_C INCREMENT BY 1 START WITH 1 maxvalue 9990;
CREATE SEQUENCE SEQ_S INCREMENT BY 1 START WITH 1 maxvalue 9990;
CREATE SEQUENCE SEQ_TD INCREMENT BY 1 START WITH 1 maxvalue 9990;
CREATE SEQUENCE SEQ_AC INCREMENT BY 1 START WITH 1 maxvalue 9990;

--팀원
insert into proguser values('a@a.a','박상태','1234','010-3921-1324',null,0);
--멘토
insert into proguser values('b@b.b','김용두','1234','010-3921-1324',null,1);
--팀장
insert into proguser values('c@c.c','황수남','1234','010-3921-1324',null,0);

insert into project values(seq_p.nextval,'p1','32','b@b.b',sysdate,null,'c@c.c',0);

insert into log values(seq_l.nextval,seq_p.currval,'a@a.a',sysdate,'aaa',null,null,0,0);

insert into announcement values(seq_an.nextval,seq_p.currval,sysdate,'a@a.a','bbb',1);

insert into meeting values(seq_m.nextval, seq_p.currval, sysdate, '전자관','2981929','디비확인');

insert into structure values(seq_p.currval, 1,1,1,1);

insert into userproject values('a@a.a',seq_p.currval,1);

insert into attendance values(seq_p.currval,seq_m.currval,'a@a.a',1,'218,432,21,32');

insert into logcomment values(seq_l.currval, seq_c.nextval,sysdate, 'a@a.a','잘했네 쫌', seq_p.currval );

insert into todo values(seq_p.currval, seq_td.nextval, sysdate, '상태','디비작업');

insert into schedule values(seq_p.currval, seq_s.nextval, sysdate, '호호호');

insert into account values(seq_p.currval, seq_ac.nextval, 200,0,'지원비',null);

insert into judge values('a@a.a', seq_l.currval, 1, seq_p.currval);

commit;

-- project insert 시 담당자 id 등록하면 proguser 테이블의 uprocnt 값이 자동 증가되는 트리거

drop trigger IncreaseManageProject;
create or replace trigger IncreaseManageProject
before insert
on project
for each row
begin
	update proguser set uprocnt=uprocnt+1 where uemail=:new.pmento;
end;
/

-- project delete 시 proguser 테이블의 uprocnt 값이 자동 감소되는 트리거

drop trigger DecreaseManageProject;
create or replace trigger DecreaseManageProject
before delete
on project
for each row
begin
	update proguser set uprocnt=uprocnt-1 where uemail=:old.pmento;
end;
/

commit;

CREATE OR REPLACE PACKAGE test_pkg 
 IS
  TYPE tp_UEMAIL    IS TABLE OF PROGUSER.UEMAIL   %TYPE INDEX BY BINARY_INTEGER;
  TYPE tp_UNAME     IS TABLE OF PROGUSER.UNAME    %TYPE INDEX BY BINARY_INTEGER;
  TYPE tp_UPW IS TABLE OF PROGUSER.UPW		%TYPE INDEX BY BINARY_INTEGER;
  TYPE tp_UPHONE    IS TABLE OF PROGUSER.UPHONE  %TYPE   INDEX BY BINARY_INTEGER;
  TYPE tp_UPHOTO IS TABLE OF PROGUSER.UPHOTO   %TYPE INDEX BY BINARY_INTEGER;
  TYPE tp_UPROCNT    IS TABLE OF PROGUSER.UPROCNT   %TYPE  INDEX BY BINARY_INTEGER;

  v_UEMAIL    tp_UEMAIL   ;
  v_UNAME     tp_UNAME    ;
  v_UPW	tp_UPW;
  v_UPHONE    tp_UPHONE   ;
  v_UPHOTO	tp_UPHOTO;
  v_UPROCNT    tp_UPROCNT   ;

  i BINARY_INTEGER;
END test_pkg;
/

CREATE OR REPLACE TRIGGER tr_test_1
BEFORE INSERT OR UPDATE OR DELETE ON PROGUSER
BEGIN
  test_pkg.i := 0;
END;
/


CREATE OR REPLACE TRIGGER tr_test_2
BEFORE INSERT OR UPDATE OR DELETE ON PROGUSER
FOR EACH ROW
BEGIN
  test_pkg.i := test_pkg.i + 1;
  IF INSERTING THEN
    test_pkg.v_UEMAIL   (test_pkg.i) := :new.UEMAIL;
    test_pkg.v_UNAME    (test_pkg.i) := :new.UNAME;
    test_pkg.v_UPW	 (test_pkg.i) := :new.UPW;
    test_pkg.v_UPHONE   (test_pkg.i) :=:new.UPHONE;
    test_pkg.v_UPHOTO	  (test_pkg.i) := :new.UPHOTO;
    test_pkg.v_UPROCNT   (test_pkg.i) :=:new.UPROCNT;

 ELSIF DELETING THEN
    test_pkg.v_UEMAIL   (test_pkg.i) := :old.UEMAIL;
    test_pkg.v_UNAME    (test_pkg.i) := :old.UNAME;
    test_pkg.v_UPW	 (test_pkg.i) := :old.UPW;
    test_pkg.v_UPHONE   (test_pkg.i) :=:old.UPHONE;
    test_pkg.v_UPHOTO	  (test_pkg.i) := :old.UPHOTO;
    test_pkg.v_UPROCNT   (test_pkg.i) :=:old.UPROCNT;
  END IF;
END;
/

commit;



