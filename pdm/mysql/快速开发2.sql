CREATE TABLE tbFdTable (
   iTableId             NUMERIC(15)                    NOT NULL PRIMARY KEY,
   sTableName           VARCHAR(128)                   NOT NULL,
   sTableCName          VARCHAR(128)                   NULL,
   sComment             VARCHAR(255)                   NULL,
   sPKField             VARCHAR(128)                   NULL,
   sFKField             VARCHAR(128)                   NULL,
   sParentTableName     VARCHAR(128)                   NULL,
   sParentKeyField      VARCHAR(128)                   NULL,
   sKeyField            VARCHAR(128)                   NULL,
   sInsertExec          TEXT                           NULL,
   sUpdateExec          TEXT                           NULL,
   sDelExec             TEXT                           NULL,
   sCreateExec          TEXT                           NULL,
   sModifyExec          TEXT                           NULL,
   iUserId              NUMERIC(15)                    NULL,
   sUserName            VARCHAR(64)                    NULL,
   iUserDeptId          NUMERIC(15)                    NULL,
   sUserDeptName        VARCHAR(128)                   NULL,
   dDefDate             DATETIME                       NOT NULL,
   dLastUpdateDate      DATETIME                       NULL
);

CREATE TABLE tbFdField (
   iFieldId             NUMERIC(15)                    NOT NULL  PRIMARY KEY ,
   iTableId             NUMERIC(15)                    NOT NULL,
   sFieldName           VARCHAR(128)                   NOT NULL,
   sFieldCName          VARCHAR(256)                   NULL,
   iRequired            SMALLINT                       NOT NULL,
   iFieldType           SMALLINT                       NOT NULL,
   iFieldLength         INT                            NULL,
   iFieldPrec           INT                            NULL,
   sDefaultValue        VARCHAR(256)                   NULL,
   sComment             VARCHAR(256)                   NULL,
   iIsPrimaryKey        SMALLINT                       NULL
);

CREATE TABLE tbFdApplication (
   iAppId               NUMERIC(15)                    NOT NULL PRIMARY KEY,
   sAppName             VARCHAR(256)                   NOT NULL,
   sAppCode             VARCHAR(256)                   NULL,
   iAppType             NUMERIC(15)                    NULL,
   sComment             VARCHAR(256)                   NULL,
   sPath                VARCHAR(256)                   NOT NULL,
   iFileCreated         SMALLINT                       DEFAULT 1 NOT NULL,
   iUserId              NUMERIC(15)                    NULL,
   sUserName            VARCHAR(64)                    NULL,
   iUserDeptId          NUMERIC(15)                    NULL,
   sUserDeptName        VARCHAR(128)                   NULL,
   dFileCreateTime      DATETIME                       NULL,
   dConfLastUpdateTime  DATETIME                       NULL
);

CREATE TABLE tbFdForm (
   iFormId              NUMERIC(15)                    NOT NULL  PRIMARY KEY ,
   iAppId               NUMERIC(15)                    NULL,
   sFormName            VARCHAR(128)                   NULL,
   sTableId             VARCHAR(256)                   NULL,
   sTableName           VARCHAR(128)                   NULL,
   iFormColCount        INT                            NULL,
   iIsAccessories       SMALLINT                       NULL,
   sFormGroupList       VARCHAR(256)                   NULL,
   sComment             VARCHAR(256)                   NULL,
   iUserId              NUMERIC(15)                    NULL,
   sUserName            VARCHAR(64)                    NULL,
   iUserDeptId          NUMERIC(15)                    NULL,
   sUserDeptName        VARCHAR(128)                   NULL,
   dDefDate             DATETIME                       NULL,
   dLastUpdateDate      DATETIME                       NULL,
   sTemplentName        VARCHAR(128)                   NULL,
   sEvent               TEXT                           NULL,
   sEvent2              TEXT                           NULL,
   sRightMenu           TEXT                           NULL
);

CREATE TABLE tbFdFormProperty (
   iId                  NUMERIC(15)                    NOT NULL  PRIMARY KEY, 
   iFormId              NUMERIC(15)                    NULL,
   sPropertyName        VARCHAR(128)                   NULL,
   iTableId             NUMERIC(15)                    NULL,
   sTableName           VARCHAR(128)                   NULL,
   sTableCName          VARCHAR(128)                   NULL,
   iFieldId             NUMERIC(15)                    NULL,
   sFieldName           VARCHAR(128)                   NULL,
   sFieldCName          VARCHAR(128)                   NULL,
   iRequired            SMALLINT                       NULL,
   iFieldType           SMALLINT                       NULL,
   iFieldLength         INT                            NULL,
   iFieldPrec           INT                            NULL,
   iIsVisible           SMALLINT                       NULL,
   iCanUpdate           SMALLINT                       NULL,
   iValidType           SMALLINT                       NULL,
   sValidExp            VARCHAR(3000)                  NULL,
   iCompareType         SMALLINT                       NULL,
   iRefType             SMALLINT                       NULL,
   sRefExp              VARCHAR(3000)                  NULL,
   sGroup               VARCHAR(128)                   NULL,
   sComment             VARCHAR(255)                   NULL,
   sEvent               VARCHAR(3000)                  NULL,
   iElement             SMALLINT                       NULL,
   iColCount            SMALLINT                       NULL,
   iIsUseInEidtPage     SMALLINT                       NULL,
   iIsPrimaryKey        SMALLINT                       NULL,
   iSequence            SMALLINT                       NULL
);

CREATE TABLE tbFdPropertyCheck (
   iCheckId             NUMERIC(15)                    NOT NULL PRIMARY KEY,
   iFormPropertyId      NUMERIC(15)                    NULL,
   sCheckJS             VARCHAR(512)                   NULL,
   sCheckHtml           VARCHAR(512)                   NULL,
   sMsg                 VARCHAR(512)                   NULL
);

CREATE TABLE tbFdUserSearch (
   iId                  NUMERIC(15)                    NOT NULL PRIMARY KEY,
   iFormId              NUMERIC(15)                    NULL,
   iSearchColCount      SMALLINT                       NULL,
   iUserId              NUMERIC(15)                    NULL,
   sUserName            VARCHAR(64)                    NULL,
   dDefDate             DATETIME                       NULL,
   dLastUpdateDate      DATETIME                       NULL,
   iIsPage              SMALLINT                       NULL,
   iPageCount           INT                            NULL,
   iEditPageWidth       NUMERIC(6,2)                   NULL,
   iEditPageHeight      NUMERIC(6,2)                   NULL,
   iRigthMenuType       SMALLINT                       NULL,
   iIsRownumbers        SMALLINT                       NULL,
   iIsRightToolbar      SMALLINT                       NULL,
   iIsLoadInit          SMALLINT                       NULL,
   sImportDefine        VARCHAR(256)                   NULL,
   iImportTemplate      SMALLINT                       NULL
);

CREATE TABLE tbFdSearchProperty (
   iId                  NUMERIC(15)                    NOT NULL PRIMARY KEY,
   iSearchId            NUMERIC(15)                    NULL,
   iIsCondition         SMALLINT                       NULL,
   sSqlCondType         VARCHAR(16)                    NULL,
   sSqlSortType         VARCHAR(8)                     NULL,
   iIsGridHeader        SMALLINT                       NULL,
   iGridSortType        SMALLINT                       NULL,
   iIsGridTip           SMALLINT                       NULL,
   iSequence            INT                            NULL,
   iPropertyId          NUMERIC(15)                    NULL,
   sPropertyName        VARCHAR(128)                   NULL,
   iFieldId             NUMERIC(15)                    NULL,
   sFieldName           VARCHAR(128)                   NULL,
   iColumnWidth         INT                            NULL,
   iFieldType           SMALLINT                       NULL,
   iRightBound          SMALLINT                       NULL
);

#索引
#tbFdTable
CREATE INDEX tbFdTable_sTableName ON tbFdTable (sTableName);
CREATE INDEX tbFdTable_sTableCName ON tbFdTable (sTableCName);
CREATE INDEX tbFdTable_sUserName ON tbFdTable (sUserName);
CREATE INDEX tbFdTable_sUserDeptName ON tbFdTable (sUserDeptName);
CREATE INDEX tbFdTable_dDefDate ON tbFdTable (dDefDate);
CREATE INDEX tbFdTable_dLastUpdateDate ON tbFdTable (dLastUpdateDate);
#tbFdField
CREATE INDEX tbFdField_iTableId ON tbFdField (iTableId);
CREATE INDEX tbFdField_sFieldName ON tbFdField (sFieldName);
#tbFdApplication
CREATE INDEX tbFdApplication_sAppName ON tbFdApplication (sAppName);
#tbFdForm
CREATE INDEX tbFdForm_iAppId ON tbFdForm (iAppId);
CREATE INDEX tbFdForm_sFormName ON tbFdForm (sFormName);
CREATE INDEX tbFdForm_sTableName ON tbFdForm (sTableName);
CREATE INDEX tbFdForm_sComment ON tbFdForm (sComment);
#tbFdFormProperty
CREATE INDEX FormP_iFormId ON tbFdFormProperty (iFormId);
#tbFdPropertyCheck
CREATE INDEX PCheck_PId ON tbFdPropertyCheck (iFormPropertyId);
#tbFdUserSearch
CREATE INDEX tbFdUserSearch_iFormId ON tbFdUserSearch (iFormId);
CREATE INDEX tbFdUserSearch_sUserName ON tbFdUserSearch (sUserName);
#tbFdSearchProperty
CREATE INDEX SearchP_iSearchId ON tbFdSearchProperty (iSearchId);
CREATE INDEX SearchP_iPropertyId ON tbFdSearchProperty (iPropertyId);

#基础枚举数据
#表格字段数据类型
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '3', '字符串', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '4', '日期时间', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '2', '小数', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '5', '日期', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '1', '整数', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '6', '时间', 1, NULL, 1 ); 

#界面基本呈现控件
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '1', '隐藏域', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '2', '文本框', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '3', '数值框', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '4', '下拉框', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '5', '下拉多选', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '6', '文本域', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '7', '富文本框', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '8', '时间框', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '9', '弹窗选', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '10', '单附件上传', 1, NULL, 1 ); 

#属性参考类型
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '0', '无参考', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '2', '简单对象', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '1', '引用枚举', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '3', '复杂对象', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '4', '引用常量', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '5', '引用变量', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '6', '自动序号', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '7', '系统时间', 1, NULL, 1 );
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '8', '自动计算', 1, NULL, 1 );
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '9', '仅新增时取系统时间', 1, NULL, 1 );

#属性比较类型
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '2', '=', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '3', '>=', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '0', '>', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '1', '<', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '4', '<=', 1, NULL, 1 ); 

#属性基本校验类型
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '0', '无限制', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '1', 'IP地址', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '2', '邮编号码', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '3', '手机号码', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '4', '电话号码', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '5', 'Email地址', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '6', 'URL地址', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '7', '数字', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '8', '整数', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '9', '字母', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '10', '字母与数字', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '11', '中文', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '12', '日期时间', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '13', '日期', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '14', '时间', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '15', '范围', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '16', '字段比较', 1, NULL, 1 ); 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '17', '正则表达式', 1, NULL, 1 ); 
INSERT INTO tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) VALUES ( 'tbFdFormProperty', 'iValidType', '18', '年月', 1, NULL, 1 ); 
INSERT INTO tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) VALUES ( 'tbFdFormProperty', 'iValidType', '19', '月日', 1, NULL, 1 );
INSERT INTO tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) VALUES ( 'tbFdFormProperty', 'iValidType', '20', '时分', 1, NULL, 1 );
INSERT INTO tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) VALUES ( 'tbFdFormProperty', 'iValidType', '21', '分秒', 1, NULL, 1 ); 

SELECT * FROM tbCtEnumTbl2 WHERE sEnumTblName <> 'tbFdFormProperty'