create table TBCTENUMTBL2
(
  SENUMTBLNAME VARCHAR2(64) not null,
  SENUMCOLNAME VARCHAR2(64) not null,
  IENUMVALUE   VARCHAR2(64) not null,
  SENUMNAME    VARCHAR2(64) not null,
  ISENABLED    INTEGER not null,
  SREMARK      VARCHAR2(300),
  IDOMAINID    NUMBER(15) not null
)
;
create index TBCTENUMTBL2_SENUMCOLNAME on TBCTENUMTBL2 (SENUMCOLNAME);
create index TBCTENUMTBL2_SENUMTBLNAME on TBCTENUMTBL2 (SENUMTBLNAME);

create table TBCTFILESUPLOAD
(
  IFILEID      NUMBER(15) not null,
  SGUID        VARCHAR2(32) not null,
  STABLENAME   VARCHAR2(128) not null,
  ITABLEPKID   NUMBER(15) not null,
  SNEWFILENAME VARCHAR2(128) not null,
  SOLDFILENAME VARCHAR2(512) not null,
  DLASTUPDATE  DATE,
  SFILEPATH    VARCHAR2(255),
  DCREATETIME  DATE default sysdate
)
;
alter table TBCTFILESUPLOAD
  add constraint PK_TBCTFILESUPLOAD primary key (IFILEID);

  create table TBPUBFILESUPLOAD
(
  IFILEID      NUMBER(15) not null,
  STABLENAME   VARCHAR2(32) not null,
  ITABLEPKID   NUMBER(15) not null,
  SNEWFILENAME VARCHAR2(128) not null,
  SOLDFILENAME VARCHAR2(128) not null,
  DUPLOADTIME  DATE not null,
  CUPSTAFFNAME VARCHAR2(64),
  IUPSTAFFID   NUMBER(15),
  CDEPTNAME    VARCHAR2(64),
  IDEPTID      NUMBER(15),
  IDOMAINID    NUMBER(15),
  CSVRFILEPATH VARCHAR2(512),
  SFILESIZE    VARCHAR2(32),
  IDOWNTIMES   NUMBER(15)
)
;
alter table TBPUBFILESUPLOAD
  add constraint PK_tbPubFilesUpload primary key (IFILEID);
create index TBPUBFILESUPLOAD_CDEPTNAME on TBPUBFILESUPLOAD (CDEPTNAME);
create index TBPUBFILESUPLOAD_CUPSTAFFNAME on TBPUBFILESUPLOAD (CUPSTAFFNAME);
create index TBPUBFILESUPLOAD_DUPLOADTIME on TBPUBFILESUPLOAD (DUPLOADTIME);
create index TBPUBFILESUPLOAD_SNEWFILENAME on TBPUBFILESUPLOAD (SNEWFILENAME);

create table TBPUBSEQUENCE
(
  STBLNAME    VARCHAR2(64) not null,
  ICURSQUENCE NUMBER(15) default 1 not null
)
;
alter table TBPUBSEQUENCE
  add primary key (STBLNAME);

create table TBSYSIMG
(
  IID          NUMBER(15) not null,
  SIMGNAME     VARCHAR2(64) not null,
  SCSS         VARCHAR2(128),
  SCSSFILEPATH VARCHAR2(256),
  SIMGPATH     VARCHAR2(256) not null,
  SREMARK      VARCHAR2(256),
  SSTANDARD    VARCHAR2(64),
  SCLASS       VARCHAR2(128)
)
;
alter table TBSYSIMG
  add constraint PK_TBSYSIMG primary key (IID);
create index TBSYSIMG_SCSS on TBSYSIMG (SCSS);
create index TBSYSIMG_SCSSFILEPATH on TBSYSIMG (SCSSFILEPATH);
create index TBSYSIMG_SIMGNAME on TBSYSIMG (SIMGNAME);

/**��������**********************/
INSERT INTO tbPubSequence ( sTblName, iCurSquence ) VALUES ( 'Global', 100 ) ;
INSERT INTO tbPubSequence ( sTblName, iCurSquence ) VALUES ( 'Global2', 100000 ) ;

