--��ṹ
--ͨ�õ���ģ���tbImportTemplates
create table tbImportTemplates ( 
    iId            	numeric(15,0)   NOT NULL primary key,
    sTemplateName  	varchar(64) NOT NULL,
    sTableName     	varchar(64) NOT NULL,
    sDataSource    	varchar(32) NOT NULL,
    dLastUpdateTime	datetime NULL,
    sRemark        	varchar(512) NULL,
    iFieldGetType  	smallint NULL,
    iFormId        	numeric(15,0) NULL,
    sCheckClass     varchar(128) NULL,
    sWhereSql       varchar(128) NULL   
)

--ͨ�õ���ģ���ֶ�tbImportFields
create table tbImportFields ( 
    iFieldId       	numeric(15,0) NOT NULL primary key,
    iTemplateId    	numeric(15,0) NOT NULL,
    sFieldName     	varchar(32) NOT NULL,
    sFieldCName    	varchar(32) NOT NULL,
    iFieldType     	smallint NULL,
    iIsPrimaryKey  	smallint NULL,
    iRequired      	smallint NULL,
    iFieldLength   	int NULL,
    iFieldPrec     	int NULL,
    sDefaultValue  	varchar(256) NULL,
    iValidType     	smallint NULL,
    sValidExp      	varchar(512) NULL,
    iRefType       	smallint NULL,
    sRefSQL        	varchar(512) NULL,
    iCellWidth     	int NULL,
    iSequence      	smallint NULL,
    sValidDesc     	varchar(512) NULL,
    iFormPropertyId  numeric(15,0) NULL,
    iImport         tinyint default 1,
    sCheckJS            varchar(512) NULL
)
--ͨ�õ�����־ tbImportLog
create table tbImportLog
(
  iLogId        numeric(15,0) primary key,
  iTemplateId   numeric(15,0) not null,
  dBeginTime    datetime NULL,
  dEndTime      datetime NULL,
  iCostTime     numeric(10,1) NULL,
  iStaffId      numeric(15,0) NULL,
  sStaffName    varchar(32) NULL,
  sStaffAccount varchar(32) NULL,
  iDeptId       numeric(15,0) NULL,
  sDeptName     varchar(10) NULL,
  sContent      varchar(512) NULL,
  iAddCount     int default 0,
  iEditCount    int default 0,
  iAllCount     int default 0
)


--����
-- tbImportTemplates
CREATE INDEX tbImport_sTableName ON tbImportTemplates (sTableName)
CREATE INDEX tbImport_iFormId ON tbImportTemplates (iFormId)
--tbImportFields
CREATE INDEX tbImport_iTemplateId ON tbImportFields (iTemplateId)



INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '10', '/commonModule/importMgr/', 1, NULL, 1)