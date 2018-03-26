-----------授权信息表-----------
create table TBLICENSE
(
  IID                    INTEGER not null,
  SSYSNAME               VARCHAR2(64),
  SCUSNAME               VARCHAR2(64),
  SLINKNAME              VARCHAR2(32),
  STELNUM                VARCHAR2(32),
  SEMAIL                 VARCHAR2(64),
  SSOURCECHNAME          VARCHAR2(32),
  STABLENAME             VARCHAR2(32),
  ILICENSENUM            VARCHAR2(128),
  IONLINENUM             INTEGER,
  SVERSIONNUM            VARCHAR2(16),
  DENDDATE               DATE,
  IDATETYPE              INTEGER,
  SHARDWARESN            VARCHAR2(256),
  SCPUSN                 VARCHAR2(32),
  SDISKSN                VARCHAR2(128),
  DCREATEDATE            DATE,
  IUSERID                INTEGER,
  SUSERACCOUNT           VARCHAR2(32),
  SUSERNAME              VARCHAR2(32),
  SREMARK                VARCHAR2(500),
  ISVALID                INTEGER,
  DLASTUPDATEDATE        DATE,
  ILASTUPDATEUSERID      INTEGER,
  SLASTUPDATEUSERACCOUNT VARCHAR2(32),
  SLASTUPDATEUSERNAME    VARCHAR2(32),
  IBFNUM                 INTEGER,
  ICPUCORE               INTEGER
)
;
alter table TBLICENSE
  add primary key (PK_TBLICENSE);
  
--------创建索引-----
create index TBLICENSE_SSYSNAME on TBLICENSE (SSYSNAME);
create index TBLICENSE_SCUSNAME on TBLICENSE (SCUSNAME);
create index TBLICENSE_DCREATEDATE on TBLICENSE (DCREATEDATE);
create index TBLICENSE_SUSERNAME on TBLICENSE (SUSERNAME);
create index TBLICENSE_ISVALID on TBLICENSE (ISVALID);
create index TBLICENSE_IDATETYPE on TBLICENSE (IDATETYPE);