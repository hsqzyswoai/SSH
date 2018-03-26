create table tbFdTable (
   iTableId             numeric(15)                    not null,
   sTableName           varchar(128)                   not null,
   sTableCName          varchar(128)                   null,
   sComment             varchar(255)                   null,
   sPKField             varchar(128)                   null,
   sFKField             varchar(128)                   null,
   sParentTableName     varchar(128)                   null,
   sParentKeyField      varchar(128)                   null,
   sKeyField            varchar(128)                   null,
   sInsertExec          text                           null,
   sUpdateExec          text                           null,
   sDelExec             text                           null,
   sCreateExec          text                           null,
   sModifyExec          text                           null,
   iUserId              numeric(15)                    null,
   sUserName            varchar(64)                    null,
   iUserDeptId          numeric(15)                    null,
   sUserDeptName        varchar(128)                   null,
   dDefDate             datetime                       not null,
   dLastUpdateDate      datetime                       null,
   constraint PK_TBFDTABLE primary key (iTableId)
)
lock datarows
go

create table tbFdField (
   iFieldId             numeric(15)                    not null,
   iTableId             numeric(15)                    not null,
   sFieldName           varchar(128)                   not null,
   sFieldCName          varchar(256)                   null,
   iRequired            smallint                       not null,
   iFieldType           smallint                       not null,
   iFieldLength         int                            null,
   iFieldPrec           int                            null,
   sDefaultValue        varchar(256)                   null,
   sComment             varchar(256)                   null,
   iIsPrimaryKey        smallint                       null,
   constraint PK_TBFDFIELD primary key (iFieldId)
)
lock datarows
go

create table tbFdApplication (
   iAppId               numeric(15)                    not null,
   sAppName             varchar(256)                   not null,
   sAppCode             varchar(256)                   null,
   iAppType             numeric(15)                    null,
   sComment             varchar(256)                   null,
   sPath                varchar(256)                   not null,
   iFileCreated         smallint                       default 1 not null,
   iUserId              numeric(15)                    null,
   sUserName            varchar(64)                    null,
   iUserDeptId          numeric(15)                    null,
   sUserDeptName        varchar(128)                   null,
   dFileCreateTime      datetime                       null,
   dConfLastUpdateTime  datetime                       null,
   constraint PK_TBFDAPPLICATION primary key (iAppId)
)
go

create table tbFdForm (
   iFormId              numeric(15)                    not null,
   iAppId               numeric(15)                    null,
   sFormName            varchar(128)                   null,
   sTableId             varchar(256)                   null,
   sTableName           varchar(128)                   null,
   iFormColCount        int                            null,
   iIsAccessories       smallint                       null,
   sFormGroupList       varchar(256)                   null,
   sComment             varchar(256)                   null,
   iUserId              numeric(15)                    null,
   sUserName            varchar(64)                    null,
   iUserDeptId          numeric(15)                    null,
   sUserDeptName        varchar(128)                   null,
   dDefDate             datetime                       null,
   dLastUpdateDate      datetime                       null,
   sTemplentName        varchar(128)                   null,
   sEvent               text                           null,
   sEvent2              text                           null,
   sRightMenu           text                           null,
   constraint PK_TBFDFORM primary key (iFormId)
)
lock datarows
go

create table tbFdFormProperty (
   iId                  numeric(15)                    not null,
   iFormId              numeric(15)                    null,
   sPropertyName        varchar(128)                   null,
   iTableId             numeric(15)                    null,
   sTableName           varchar(128)                   null,
   sTableCName          varchar(128)                   null,
   iFieldId             numeric(15)                    null,
   sFieldName           varchar(128)                   null,
   sFieldCName          varchar(128)                   null,
   iRequired            smallint                       null,
   iFieldType           smallint                       null,
   iFieldLength         int                            null,
   iFieldPrec           int                            null,
   iIsVisible           smallint                       null,
   iCanUpdate           smallint                       null,
   iValidType           smallint                       null,
   sValidExp            varchar(3000)                  null,
   iCompareType         smallint                       null,
   iRefType             smallint                       null,
   sRefExp              varchar(3000)                  null,
   sGroup               varchar(128)                   null,
   sComment             varchar(255)                   null,
   sEvent               varchar(3000)                  null,
   iElement             smallint                       null,
   iColCount            smallint                       null,
   iIsUseInEidtPage     smallint                       null,
   iIsPrimaryKey        smallint                       null,
   iSequence            smallint                       null,
   constraint PK_TBFDFORMPROPERTY primary key (iId)
         on "default"
)
go

create table tbFdPropertyCheck (
   iCheckId             numeric(15)                    not null,
   iFormPropertyId      numeric(15)                    null,
   sCheckJS             varchar(512)                   null,
   sCheckHtml           varchar(512)                   null,
   sMsg                 varchar(512)                   null,
   constraint PK_TBFDPROPERTYCHECK primary key (iCheckId)
)
go

create table tbFdUserSearch (
   iId                  numeric(15)                    not null,
   iFormId              numeric(15)                    null,
   iSearchColCount      smallint                       null,
   iUserId              numeric(15)                    null,
   sUserName            varchar(64)                    null,
   dDefDate             datetime                       null,
   dLastUpdateDate      datetime                       null,
   iIsPage              smallint                       null,
   iPageCount           int                            null,
   iEditPageWidth       numeric(6,2)                   null,
   iEditPageHeight      numeric(6,2)                   null,
   iRigthMenuType       smallint                       null,
   iIsRownumbers        smallint                       null,
   iIsRightToolbar      smallint                       null,
   iIsLoadInit          smallint                       null,
   sImportDefine        varchar(256)                   null,
   iImportTemplate      smallint                       null,
   constraint PK_TBFDUSERSEARCH primary key (iId)
)
go

create table tbFdSearchProperty (
   iId                  numeric(15)                    not null,
   iSearchId            numeric(15)                    null,
   iIsCondition         smallint                       null,
   sSqlCondType         varchar(16)                    null,
   sSqlSortType         varchar(8)                     null,
   iIsGridHeader        smallint                       null,
   iGridSortType        smallint                       null,
   iIsGridTip           smallint                       null,
   iSequence            int                            null,
   iPropertyId          numeric(15)                    null,
   sPropertyName        varchar(128)                   null,
   iFieldId             numeric(15)                    null,
   sFieldName           varchar(128)                   null,
   iColumnWidth         int                            null,
   iFieldType           smallint                       null,
   iRightBound          smallint                       null,
   constraint PK_TBFDSEARCHPROPERTY primary key (iId)
)
go

--索引
--tbFdTable
CREATE INDEX tbFdTable_sTableName ON tbFdTable (sTableName)
CREATE INDEX tbFdTable_sTableCName ON tbFdTable (sTableCName)
CREATE INDEX tbFdTable_sUserName ON tbFdTable (sUserName)
CREATE INDEX tbFdTable_sUserDeptName ON tbFdTable (sUserDeptName)
CREATE INDEX tbFdTable_dDefDate ON tbFdTable (dDefDate)
CREATE INDEX tbFdTable_dLastUpdateDate ON tbFdTable (dLastUpdateDate)
--tbFdField
CREATE INDEX tbFdField_iTableId ON tbFdField (iTableId)
CREATE INDEX tbFdField_sFieldName ON tbFdField (sFieldName)
--tbFdApplication
CREATE INDEX tbFdApplication_sAppName ON tbFdApplication (sAppName)
--tbFdForm
CREATE INDEX tbFdForm_iAppId ON tbFdForm (iAppId)
CREATE INDEX tbFdForm_sFormName ON tbFdForm (sFormName)
CREATE INDEX tbFdForm_sTableName ON tbFdForm (sTableName)
CREATE INDEX tbFdForm_sComment ON tbFdForm (sComment)
--tbFdFormProperty
CREATE INDEX FormP_iFormId ON tbFdFormProperty (iFormId)
--tbFdPropertyCheck
CREATE INDEX PCheck_PId ON tbFdPropertyCheck (iFormPropertyId)
--tbFdUserSearch
CREATE INDEX tbFdUserSearch_iFormId ON tbFdUserSearch (iFormId)
CREATE INDEX tbFdUserSearch_sUserName ON tbFdUserSearch (sUserName)
--tbFdSearchProperty
CREATE INDEX SearchP_iSearchId ON tbFdSearchProperty (iSearchId)
CREATE INDEX SearchP_iPropertyId ON tbFdSearchProperty (iPropertyId)

--基础枚举数据
--表格字段数据类型
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '3', '字符串', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '4', '日期时间', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '2', '小数', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '5', '日期', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '1', '整数', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '6', '时间', 1, NULL, 1 ) 

--界面基本呈现控件
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '1', '隐藏域', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '2', '文本框', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '3', '数值框', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '4', '下拉框', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '5', '下拉多选', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '6', '文本域', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '7', '富文本框', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '8', '时间框', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '9', '弹窗选', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '10', '单附件上传', 1, NULL, 1 ) 

--属性参考类型
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '0', '无参考', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '2', '简单对象', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '1', '引用枚举', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '3', '复杂对象', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '4', '引用常量', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '5', '引用变量', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '6', '自动序号', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '7', '系统时间', 1, NULL, 1 )
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '8', '自动计算', 1, NULL, 1 )
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '9', '仅新增时取系统时间', 1, NULL, 1 )

--属性比较类型
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '2', '=', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '3', '>=', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '0', '>', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '1', '<', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '4', '<=', 1, NULL, 1 ) 

--属性基本校验类型
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '0', '无限制', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '1', 'IP地址', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '2', '邮编号码', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '3', '手机号码', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '4', '电话号码', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '5', 'Email地址', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '6', 'URL地址', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '7', '数字', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '8', '整数', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '9', '字母', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '10', '字母与数字', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '11', '中文', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '12', '日期时间', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '13', '日期', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '14', '时间', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '15', '范围', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '16', '字段比较', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '17', '正则表达式', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '18', '年月', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '19', '月日', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '20', '时分', 1, NULL, 1 )
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '21', '分秒', 1, NULL, 1 ) 
