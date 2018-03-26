--表结构
--通用导入模板表tbImportTemplates
create table tbImportTemplates ( 
    iId            	bigint   NOT NULL primary key,
    sTemplateName  	varchar(64) NOT NULL,
    sTableName     	varchar(64) NOT NULL,
    sDataSource    	varchar(32) NOT NULL,
    dLastUpdateTime	datetime NULL,
    sRemark        	text(512) NULL,
    iFieldGetType  	smallint NULL,
    iFormId        	bigint NULL,
    sCheckClass     varchar(128) NULL,
    sWhereSql       varchar(128) NULL   
)

--通用导入模板字段tbImportFields
create table tbImportFields ( 
    iFieldId       	bigint NOT NULL primary key,
    iTemplateId    	bigint NOT NULL,
    sFieldName     	varchar(32) NOT NULL,
    sFieldCName    	varchar(32) NOT NULL,
    iFieldType     	smallint NULL,
    iIsPrimaryKey  	smallint NULL,
    iRequired      	smallint NULL,
    iFieldLength   	int NULL,
    iFieldPrec     	int NULL,
    sDefaultValue  	varchar(256) NULL,
    iValidType     	smallint NULL,
    sValidExp      	text(512) NULL,
    iRefType       	smallint NULL,
    sRefSQL        	text(512) NULL,
    iCellWidth     	int NULL,
    iSequence      	smallint NULL,
    sValidDesc     	text(512) NULL,
    iFormPropertyId  bigint NULL,
    iImport         tinyint default 1,
    sCheckJS            text(512) NULL
)
--通用导入日志 tbImportLog
create table tbImportLog
(
  iLogId        bigint primary key,
  iTemplateId   bigint not null,
  dBeginTime    datetime NULL,
  dEndTime      datetime NULL,
  iCostTime     numeric(10,1) NULL,
  iStaffid      bigint NULL,
  sStaffName    varchar(32) NULL,
  sStaffacCount varchar(32) NULL,
  iDeptId       bigint NULL,
  sDeptName     varchar(10) NULL,
  sContent      text(512) NULL,
  iAddCount     int default 0,
  iEditCount    int default 0,
  iAllCount     int default 0
)


--索引
-- tbImportTemplates
CREATE INDEX tbImport_sTableName ON tbImportTemplates (sTableName)
CREATE INDEX tbImport_iFormId ON tbImportTemplates (iFormId)
--tbImportFields
CREATE INDEX tbImport_iTemplateId ON tbImportFields (iTemplateId)



INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '10', '/commonModule/importMgr/', 1, NULL, 1)