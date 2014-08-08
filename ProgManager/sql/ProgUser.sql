DROP TABLE PROGUSER;

CREATE TABLE "PROGUSER" 
   (	"UEMAIL" VARCHAR2(30) NOT NULL ENABLE, 
	"UNAME" VARCHAR2(10) NOT NULL ENABLE, 
	"UPW" VARCHAR2(20) NOT NULL ENABLE, 
	"UPHONE" VARCHAR2(13), 
	"UPHOTO" BLOB, 
	"UPROCNT" VARCHAR2(4) DEFAULT 0 NOT NULL ENABLE, 
	 CONSTRAINT "PROGUSER_PK" PRIMARY KEY ("UEMAIL") ENABLE
   );

--"UEMAIL" , "UNAME" , "UPW" , "UPHONE" , "UPHOTO" , "UPROCNT" 
--팀원
insert into proguser values('a@a.a','박상태','1234','010-3921-1324',null,0);
--멘토
insert into proguser values('b@b.b','김용두','1234','010-3921-1324',null,0);
--팀장
insert into proguser values('c@c.c','황수남','1234','010-3921-1324',null,0);


SELECT UEMAIL, UNAME, UPW, UPHONE, UPROCNT  FROM PROGUSER;
