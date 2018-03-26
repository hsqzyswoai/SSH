create table tbFdTable (
   iTableId             numeric(15)                    not null primary key,
   sTableName           varchar2(128)                   not null,
   sTableCName          varchar2(128)                   null,
   sComment             varchar2(255)                   null,
   sPKField             varchar2(128)                   null,
   sFKField             varchar2(128)                   null,
   sParentTableName     varchar2(128)                   null,
   sParentKeyField      varchar2(128)                   null,
   sKeyField            varchar2(128)                   null,
   sInsertExec          Clob                   null,
   sUpdateExec          Clob                   null,
   sDelExec             Clob                   null,
   sCreateExec          Clob                   null,
   sModifyExec          Clob                   null,
   iUserId              numeric(15)                    null,
   sUserName            varchar2(64)                    null,
   iUserDeptId          numeric(15)                    null,
   sUserDeptName        varchar2(128)                   null,
   dDefDate             DATE                       not null,
   dLastUpdateDate      DATE                       null
)
go

create table tbFdField (
   iFieldId             numeric(15)                    not null primary key ,
   iTableId             numeric(15)                    not null,
   sFieldName           varchar2(128)                   not null,
   sFieldCName          varchar2(256)                   null,
   iRequired            smallint                       not null,
   iFieldType           smallint                       not null,
   iFieldLength         int                            null,
   iFieldPrec           int                            null,
   sDefaultValue        varchar2(256)                   null,
   sComment             varchar2(256)                   null,
   iIsPrimaryKey        smallint                       null
)
go

create table tbFdApplication (
   iAppId               numeric(15)                    primary key not null,
   sAppName             varchar2(256)                   not null,
   sAppCode             varchar2(256)                   null,
   iAppType             numeric(15)                    null,
   sComment             varchar2(256)                   null,
   sPath                varchar2(256)                   not null,
   iFileCreated         smallint                       default 1 not null,
   iUserId              numeric(15)                    null,
   sUserName            varchar2(64)                    null,
   iUserDeptId          numeric(15)                    null,
   sUserDeptName        varchar2(128)                   null,
   dFileCreateTime      date                      null,
   dConfLastUpdateTime  date                       null
)
go

create table tbFdForm (
   iFormId              numeric(15)                    primary key not null,
   iAppId               numeric(15)                    null,
   sFormName            varchar2(128)                   null,
   sTableId             varchar2(256)                   null,
   sTableName           varchar2(128)                   null,
   iFormColCount        int                            null,
   iIsAccessories       smallint                       null,
   sFormGroupList       varchar2(256)                   null,
   sComment             varchar2(256)                   null,
   iUserId              numeric(15)                      null,
   sUserName            varchar2(64)                    null,
   iUserDeptId          numeric(15)                     null,
   sUserDeptName        varchar2(128)                   null,
   dDefDate             date                            null,
   dLastUpdateDate      date                            null,
   sTemplentName        varchar2(128)                   null,
   sEvent               CLOB                            null,
   sEvent2              CLOB                            null,
   sRightMenu           CLOB                            null
)
go
update tbFdForm set sEvent=' ',sEvent2=' ',sRightMenu=' '
go


create table tbFdFormProperty (
   iId                  numeric(15)                    not null primary key,
   iFormId              numeric(15)                    null,
   sPropertyName        varchar2(128)                   null,
   iTableId             numeric(15)                    null,
   sTableName           varchar2(128)                   null,
   sTableCName          varchar2(128)                   null,
   iFieldId             numeric(15)                    null,
   sFieldName           varchar2(128)                   null,
   sFieldCName          varchar2(128)                   null,
   iRequired            smallint                       null,
   iFieldType           smallint                       null,
   iFieldLength         int                            null,
   iFieldPrec           int                            null,
   iIsVisible           smallint                       null,
   iCanUpdate           smallint                       null,
   iValidType           smallint                       null,
   sValidExp            varchar2(3000)                   null,
   iRefType             smallint                       null,
   iCompareType         smallint                       null,
   sGroup               varchar2(128)                   null,
   sComment             varchar2(255)                   null,
   sEvent               varchar2(3000)                   null,
   iElement             smallint                       null,
   iColCount            smallint                       null,
   iIsUseInEidtPage     smallint                       null,
   iIsPrimaryKey        smallint                       null,
   sRefExp              varchar2(3000)                 null,
   iSequence            smallint                       null
)
go

create table tbFdPropertyCheck (
   iCheckId             numeric(15)                    not null primary key,
   iFormPropertyId             numeric(15)                    null,
   sCheckJS             varchar2(512)                   null,
   sCheckHtml           varchar2(512)                   null,
   sMsg                 varchar2(512)                   null
)
go

create table tbFdUserSearch  (
   iId                NUMBER(15)    primary key     not null,
   iFormId            NUMBER(15)    null,
   iSearchColCount    SMALLINT      null,
   iUserId            NUMBER(15)    null,
   sUserName          VARCHAR2(64)  null,
   dDefDate           DATE          null,
   dLastUpdateDate    DATE          null,
   iIsPage            SMALLINT      null,
   iPageCount         INTEGER       null,
   iEditPageWidth     numeric(6,2)  null,
   iEditPageHeight    numeric(6,2)  null,
   iRigthMenuType     smallint      null,
   iIsRownumbers      smallint      null,
   iIsRightToolbar    smallint      null,
   iIsLoadInit        smallint      null,
   sImportDefine      varchar2(256) null,
   iImportTemplate    smallint      null
)
go

create table tbFdSearchProperty  (
   iId                NUMBER(15)   primary key   not null,
   iSearchId          NUMBER(15)   null,
   iIsCondition       SMALLINT     null,
   sSqlCondType       VARCHAR2(16) null,
   sSqlSortType       VARCHAR2(8)  null,
   iIsGridHeader      SMALLINT     null,
   iGridSortType      SMALLINT     null,
   iIsGridTip         SMALLINT     null,
   iSequence          INTEGER      null,
   iPropertyId        NUMBER(15)   null,
   sPropertyName      VARCHAR2(128) null,
   iFieldId           NUMBER(15)   null,
   sFieldName         VARCHAR2(128) null,
   iColumnWidth       int	       null,
   iFieldType         smallint     null,
   iRightBound        smallint     null	
)
go

--索引
--tbFdTable
CREATE INDEX tbFdTable_sTableName ON tbFdTable (sTableName)
go
CREATE INDEX tbFdTable_sTableCName ON tbFdTable (sTableCName)
go
CREATE INDEX tbFdTable_sUserName ON tbFdTable (sUserName)
go
CREATE INDEX tbFdTable_sUserDeptName ON tbFdTable (sUserDeptName)
go
CREATE INDEX tbFdTable_dDefDate ON tbFdTable (dDefDate)
go
CREATE INDEX tbFdTable_dLastUpdateDate ON tbFdTable (dLastUpdateDate)
go
--tbFdField
CREATE INDEX tbFdField_iTableId ON tbFdField (iTableId)
go
CREATE INDEX tbFdField_sFieldName ON tbFdField (sFieldName)
go
--tbFdApplication
CREATE INDEX tbFdApplication_sAppName ON tbFdApplication (sAppName)
go
--tbFdForm
CREATE INDEX tbFdForm_iAppId ON tbFdForm (iAppId)
go
CREATE INDEX tbFdForm_sFormName ON tbFdForm (sFormName)
go
CREATE INDEX tbFdForm_sTableName ON tbFdForm (sTableName)
go
CREATE INDEX tbFdForm_sComment ON tbFdForm (sComment)
go
--tbFdFormProperty
CREATE INDEX FormP_iFormId ON tbFdFormProperty (iFormId)
go
--tbFdPropertyCheck
CREATE INDEX PCheck_PId ON tbFdPropertyCheck (iFormPropertyId)
go
--tbFdUserSearch
CREATE INDEX tbFdUserSearch_iFormId ON tbFdUserSearch (iFormId)
go
CREATE INDEX tbFdUserSearch_sUserName ON tbFdUserSearch (sUserName)
go
--tbFdSearchProperty
CREATE INDEX SearchP_iSearchId ON tbFdSearchProperty (iSearchId)
go
CREATE INDEX SearchP_iPropertyId ON tbFdSearchProperty (iPropertyId)
go


--基础枚举数据
--表格字段数据类型
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '3', '字符串', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '4', '日期时间', 1, NULL, 1 )
go 
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '2', '小数', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '5', '日期', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '1', '整数', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iFieldType', '6', '时间', 1, NULL, 1 )
go

--界面基本呈现控件
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '1', '隐藏域', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '2', '文本框', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '3', '数值框', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '4', '下拉框', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '5', '下拉多选', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '6', '文本域', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '7', '富文本框', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '8', '时间框', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '9', '弹窗选', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iElement', '10', '单附件上传', 1, NULL, 1 )
go

--属性参考类型
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '0', '无参考', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '2', '简单对象', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '1', '引用枚举', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '3', '复杂对象', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '4', '引用常量', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '5', '引用变量', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '6', '自动序号', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '7', '系统时间', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '8', '自动计算', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iRefType', '9', '仅新增时取系统时间', 1, NULL, 1 )
go

--属性比较类型
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '2', '=', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '3', '>=', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '0', '>', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '1', '<', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iCompareType', '4', '<=', 1, NULL, 1 )
go

--属性基本校验类型
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '0', '无限制', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '1', 'IP地址', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '2', '邮编号码', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '3', '手机号码', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '4', '电话号码', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '5', 'Email地址', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '6', 'URL地址', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '7', '数字', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '8', '整数', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '9', '字母', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '10', '字母与数字', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '11', '中文', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '12', '日期时间', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '13', '日期', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '14', '时间', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '15', '范围', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '16', '字段比较', 1, NULL, 1 )
go
INSERT INTO TBCTENUMTBL2 ( SENUMTBLNAME, SENUMCOLNAME, IENUMVALUE, SENUMNAME, ISENABLED, SREMARK, IDOMAINID ) VALUES ( 'tbFdFormProperty', 'iValidType', '17', '正则表达式', 1, NULL, 1 )
go
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '18', '年月', 1, NULL, 1 )
go
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '19', '月日', 1, NULL, 1 )
go
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '20', '时分', 1, NULL, 1 )
go
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '21', '分秒', 1, NULL, 1 )
go

commit
go

-----2012-04-16资源系统升级
--表单事件定义
alter table tbfdform add sEvent varchar2(3500) null
go
--加表
--tbFdUserSearch,tbFdSearchProperty
--加索引
