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

--����
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

--����ö������
--����ֶ���������
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '3', '�ַ���', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '4', '����ʱ��', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '2', 'С��', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '5', '����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '1', '����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iFieldType', '6', 'ʱ��', 1, NULL, 1 ) 

--����������ֿؼ�
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '1', '������', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '2', '�ı���', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '3', '��ֵ��', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '4', '������', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '5', '������ѡ', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '6', '�ı���', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '7', '���ı���', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '8', 'ʱ���', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '9', '����ѡ', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iElement', '10', '�������ϴ�', 1, NULL, 1 ) 

--���Բο�����
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '0', '�޲ο�', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '2', '�򵥶���', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '1', '����ö��', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '3', '���Ӷ���', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '4', '���ó���', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '5', '���ñ���', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '6', '�Զ����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '7', 'ϵͳʱ��', 1, NULL, 1 )
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '8', '�Զ�����', 1, NULL, 1 )
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iRefType', '9', '������ʱȡϵͳʱ��', 1, NULL, 1 )

--���ԱȽ�����
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '2', '=', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '3', '>=', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '0', '>', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '1', '<', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iCompareType', '4', '<=', 1, NULL, 1 ) 

--���Ի���У������
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '0', '������', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '1', 'IP��ַ', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '2', '�ʱ����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '3', '�ֻ�����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '4', '�绰����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '5', 'Email��ַ', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '6', 'URL��ַ', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '7', '����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '8', '����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '9', '��ĸ', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '10', '��ĸ������', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '11', '����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '12', '����ʱ��', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '13', '����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '14', 'ʱ��', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '15', '��Χ', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '16', '�ֶαȽ�', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '17', '������ʽ', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '18', '����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '19', '����', 1, NULL, 1 ) 
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '20', 'ʱ��', 1, NULL, 1 )
insert into tbCtEnumTbl2 ( sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId ) values ( 'tbFdFormProperty', 'iValidType', '21', '����', 1, NULL, 1 ) 
