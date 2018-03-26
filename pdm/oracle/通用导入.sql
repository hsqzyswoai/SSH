--表结构
--通用导入模板表tbImportTemplates
create table tbImportTemplates ( 
    iId            	number(15)  NOT NULL primary key,
    sTemplateName  	varchar2(64) NOT NULL,
    sTableName     	varchar2(64) NOT NULL,
    sDataSource    	varchar2(32) NOT NULL,
    dLastUpdateTime	DATE NULL,
    sRemark        	varchar2(512) NULL,
    iFieldGetType  	smallint NULL,
    iFormId        	number(15) NULL,
    sCheckClass     varchar2(128)NULL,
    sWhereSql       varchar2(128) NULL
)

--通用导入模板字段tbImportFields
create table tbImportFields ( 
    iFieldId       	number(15) NOT NULL primary key,
    iTemplateId    	number(15) NOT NULL,
    sFieldName     	varchar2(32) NOT NULL,
    sFieldCName    	varchar2(32) NOT NULL,
    iFieldType     	smallint NULL,
    iIsPrimaryKey  	smallint NULL,
    iRequired      	smallint NULL,
    iFieldLength   	int NULL,
    iFieldPrec     	int NULL,
    sDefaultValue  	varchar2(256) NULL,
    iValidType     	smallint NULL,
    sValidExp      	varchar2(512) NULL,
    iRefType       	smallint NULL,
    sRefSQL        	varchar2(512) NULL,
    iCellWidth     	int NULL,
    iSequence      	smallint NULL,
    sValidDesc     	varchar2(512) NULL,
    iFormPropertyId  number(15) NULL,
    iImport         number(4) default 1,
    sCheckJS            varchar2(512) NULL
)
--通用导入日志 tbImportLog
create table tbImportLog
(
  iLogId        NUMBER(15) primary key,
  iTemplateId   NUMBER(15) not null,
  dBeginTime    DATE NULL,
  dEndTime      DATE NULL,
  iCostTime     NUMBER(10,1) NULL,
  iStaffid      NUMBER(15) NULL,
  sStaffName    VARCHAR2(32) NULL,
  sStaffacCount VARCHAR2(32) NULL,
  iDeptId       NUMBER(15) NULL,
  sDeptName     VARCHAR2(10) NULL,
  sContent      VARCHAR2(512) NULL,
  iAddCount     NUMBER(8) default 0,
  iEditCount    NUMBER(8) default 0,
  iAllCount     NUMBER(8) default 0
)


--索引
-- tbImportTemplates
CREATE INDEX tbImport_sTableName ON tbImportTemplates (sTableName)
CREATE INDEX tbImport_iFormId ON tbImportTemplates (iFormId)
--tbImportFields
CREATE INDEX tbImport_iTemplateId ON tbImportFields (iTemplateId)


INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES ('Defense_Xss_Attack', 'allow', '10', '/commonModule/importMgr/', 1, NULL, 1)