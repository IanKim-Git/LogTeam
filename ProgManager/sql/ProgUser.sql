DROP TABLE PROGUSER;

CREATE TABLE PROGUSER(
	UEMAIL VARCHAR2(30),
	UNAME VARCHAR2(10) NOT NULL,
	UPW VARCHAR2(20) NOT NULL,
	UPHONE VARCHAR2(13),
	UPHOTO BLOB,
	UPROCNT VARCHAR2(4) DEFAULT 0 NOT NULL,
	CONSTRAINT PROGUSER_PK PRIMARY KEY(UEMAIL)
);

--"UEMAIL" , "UNAME" , "UPW" , "UPHONE" , "UPHOTO" , "UPROCNT" 
insert into proguser values('pst5400@naver.com', '박상태', '1234','010-7736-5409', null, 0);
insert into proguser values('hwang@daum.net','황수남','3123','010-3922-3928',null,0);
insert into proguser values('yongdo32@kau.kr','김용두','4432','010-1111-2222',null,0);
insert into proguser values('parkda@daun.kr','박다은','5982','010-3456-7865',null,0);

SELECT UEMAIL, UNAME, UPW, UPHONE, UPROCNT  FROM PROGUSER;
