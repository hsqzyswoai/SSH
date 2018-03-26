CREATE TABLE dbo.tbDefApplication
(
    iAppId       numeric(15,0) NOT NULL,
    sAppName     varchar(255)  NOT NULL,
    iParentAppId numeric(15,0) NULL,
    sComment     varchar(255)  NULL,
    sPath        varchar(255)  NOT NULL,
    CONSTRAINT PK_TBDEFAPPLICATION
    PRIMARY KEY CLUSTERED (iAppId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbDefApplication') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbDefApplication >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbDefApplication >>>'
go

CREATE TABLE dbo.tbDefField
(
    iFieldId      numeric(15,0) NOT NULL,
    iTableId      numeric(15,0) NULL,
    sFieldName    varchar(128)  NULL,
    sFieldCName   varchar(255)  NULL,
    iIsVisible    smallint      NULL,
    iCanUpdate    smallint      NULL,
    iRequired     smallint      NULL,
    iFieldLength  int           NULL,
    iFloatLength  int           NULL,
    sDefaultValue varchar(32)   NULL,
    iFieldType    smallint      NULL,
    iIsLimit      smallint      NULL,
    iMinLength    int           NULL,
    iMaxLength    int           NULL,
    iRefType      smallint      NULL,
    sRefFilter    varchar(255)  NULL,
    sRefFunction  varchar(255)  NULL,
    sConstValue   varchar(255)  NULL,
    sVarName      varchar(128)  NULL,
    sFormula      varchar(255)  NULL,
    iIsSqlCond    smallint      NULL,
    sSqlCondType  varchar(32)   NULL,
    iIsSqlSort    smallint      NULL,
    sSqlSortType  varchar(32)   NULL,
    iIsGridHeader smallint      NULL,
    iIsGridTip    smallint      NULL,
    iIsGridSort   smallint      NULL,
    sReField      varchar(128)  NULL,
    CONSTRAINT PK_TBDEFFIELD
    PRIMARY KEY CLUSTERED (iFieldId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbDefField') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbDefField >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbDefField >>>'
go

CREATE TABLE dbo.tbDefTable
(
    iTableId         numeric(15,0) NOT NULL,
    sTableName       varchar(128)  NULL,
    sTableCName      varchar(255)  NULL,
    sPackageName     varchar(32)   NULL,
    sClassName       varchar(32)   NULL,
    sComment         varchar(128)  NULL,
    sPKField         varchar(128)  NULL,
    sParentTableName varchar(128)  NULL,
    sParentKeyField  varchar(128)  NULL,
    sKeyField        varchar(128)  NULL,
    iAppId           numeric(15,0) NULL,
    iQueryColCount   int           NULL,
    iFormColCount    int           NULL,
    iIsPage          smallint      NULL,
    CONSTRAINT PK_TBDEFTABLE
    PRIMARY KEY CLUSTERED (iTableId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbDefTable') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbDefTable >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbDefTable >>>'
go

/**»ù´¡Êý¾Ý**********************/