-----------授权信息表-----------
create table tbLicense (
   iId                  numeric                        not null,
   sSysName             varchar(64)                    null,
   sCusName             varchar(64)                    null,
   sLinkName            varchar(32)                    null,
   sTelNum              varchar(32)                    null,
   sEmail               varchar(64)                    null,
   sSourceChName        varchar(32)                    null,
   sTableName           varchar(32)                    null,
   iLicenseNum          varchar(128)                   null,
   iOnLineNum           smallint                       null,
   iBfNum               smallint                       null,
   sVersionNum          varchar(16)                    null,
   dEndDate             datetime                       null,
   iDateType            smallint                       null,
   sHardwareSn          varchar(256)                   null,
   sCpuSn               varchar(32)                    null,
   sDiskSn              varchar(128)                    null,
   dCreateDate          datetime                       null,
   iUserId              numeric                        null,
   sUserAccount         varchar(32)                    null,
   sUserName            varchar(32)                    null,
   sRemark              varchar(500)                   null,
   isValid              smallint                       null,
   dLastUpdateDate      datetime                       null,
   iLastUpdateUserId    numeric                        null,
   sLastUpdateUserAccount varchar(32)                    null,
   sLastUpdateUserName  varchar(32)                    null,
   iCpuCore             smallint                       null,
   CONSTRAINT tbLicense_iId
    PRIMARY KEY CLUSTERED (iId)
)

LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbLicense') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbLicense >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbLicense >>>'
go

CREATE NONCLUSTERED INDEX tbLicense_sSysName
    ON dbo.tbLicense(sSysName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbLicense') AND name='tbLicense_sSysName')
    PRINT '<<< CREATED INDEX dbo.tbLicense.tbLicense_sSysName >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbLicense.tbLicense_sSysName >>>'
go

CREATE NONCLUSTERED INDEX tbLicense_sCusName
    ON dbo.tbLicense(sCusName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbLicense') AND name='tbLicense_sCusName')
    PRINT '<<< CREATED INDEX dbo.tbLicense.tbLicense_sCusName >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbLicense.tbLicense_sCusName >>>'
go

CREATE NONCLUSTERED INDEX tbLicense_dCreateDate
    ON dbo.tbLicense(dCreateDate)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbLicense') AND name='tbLicense_dCreateDate')
    PRINT '<<< CREATED INDEX dbo.tbLicense.tbLicense_dCreateDate >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbLicense.tbLicense_dCreateDate >>>'
go

CREATE NONCLUSTERED INDEX tbLicense_sUserName
    ON dbo.tbLicense(sUserName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbLicense') AND name='tbLicense_sUserName')
    PRINT '<<< CREATED INDEX dbo.tbLicense.tbLicense_sUserName >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbLicense.tbLicense_sUserName >>>'
go

CREATE NONCLUSTERED INDEX tbLicense_isValid
    ON dbo.tbLicense(isValid)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbLicense') AND name='tbLicense_isValid')
    PRINT '<<< CREATED INDEX dbo.tbLicense.tbLicense_isValid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbLicense.tbLicense_isValid >>>'
go

CREATE NONCLUSTERED INDEX tbLicense_iDateType
    ON dbo.tbLicense(iDateType)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbLicense') AND name='tbLicense_iDateType')
    PRINT '<<< CREATED INDEX dbo.tbLicense.tbLicense_iDateType >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbLicense.tbLicense_iDateType >>>'
go
