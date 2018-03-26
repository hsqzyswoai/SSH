CREATE TABLE dbo.tbOsDepartment
(
    iDeptId            numeric(15,0) NOT NULL,
    sDeptName          varchar(255)  NOT NULL,
    sDispName          varchar(255)  NOT NULL,
    sShortName         varchar(64)   NULL,
    sDeptCode          varchar(64)   NULL,
    iParentId          numeric(15,0) NULL,
    iDelFlag           int           DEFAULT 0 NULL,
    dCreateDate        datetime      NOT NULL,
    iCreateStaffId     numeric(15,0) NOT NULL,
    dLastModify        datetime      NULL,
    iLastModifyStaffId numeric(15,0) NULL,
    iDomainId          numeric(15,0) NOT NULL,
    sGuid              varchar(16)   NULL,
    sPathId            varchar(128)  NULL,
    iDeptType          smallint      DEFAULT 0 NULL,
    iAgCompanyId       numeric(15,0) NULL,
    iIsSynch           smallint      DEFAULT 0 NULL,
    sUUVOrgID          varchar(12)   NULL,
    sDispName_zte      varchar(255)  NULL,
    sDataSrc           varchar(255)  NULL,
    iDeptId_zte        numeric(15,0) NULL,
    iIsDutyDept        tinyint       DEFAULT 1 NOT NULL,
    sCityCode          nvarchar(200) NULL,
    iRegionId          numeric(15,0) NULL,
    iSortIndex         int           DEFAULT 0 NOT NULL,
    iDeptLevel         int           NULL,
    CONSTRAINT PK_tbOsDepartment
    PRIMARY KEY CLUSTERED (iDeptId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsDepartment') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsDepartment >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsDepartment >>>'
go
CREATE NONCLUSTERED INDEX tbOsDepartment_iParentId
    ON dbo.tbOsDepartment(iParentId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDepartment') AND name='tbOsDepartment_iParentId')
    PRINT '<<< CREATED INDEX dbo.tbOsDepartment.tbOsDepartment_iParentId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDepartment.tbOsDepartment_iParentId >>>'
go
CREATE NONCLUSTERED INDEX tbOsDepartment_sPathId
    ON dbo.tbOsDepartment(sPathId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDepartment') AND name='tbOsDepartment_sPathId')
    PRINT '<<< CREATED INDEX dbo.tbOsDepartment.tbOsDepartment_sPathId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDepartment.tbOsDepartment_sPathId >>>'
go
CREATE NONCLUSTERED INDEX tbOsDepartment_iDomainId
    ON dbo.tbOsDepartment(iDomainId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDepartment') AND name='tbOsDepartment_iDomainId')
    PRINT '<<< CREATED INDEX dbo.tbOsDepartment.tbOsDepartment_iDomainId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDepartment.tbOsDepartment_iDomainId >>>'
go
CREATE NONCLUSTERED INDEX tbOsDepartment_sUUVOrgID
    ON dbo.tbOsDepartment(sUUVOrgID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDepartment') AND name='tbOsDepartment_sUUVOrgID')
    PRINT '<<< CREATED INDEX dbo.tbOsDepartment.tbOsDepartment_sUUVOrgID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDepartment.tbOsDepartment_sUUVOrgID >>>'
go
CREATE NONCLUSTERED INDEX tbOsDepartment_iIsDutyDept
    ON dbo.tbOsDepartment(iIsDutyDept)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDepartment') AND name='tbOsDepartment_iIsDutyDept')
    PRINT '<<< CREATED INDEX dbo.tbOsDepartment.tbOsDepartment_iIsDutyDept >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDepartment.tbOsDepartment_iIsDutyDept >>>'
go
CREATE NONCLUSTERED INDEX tbOsDepartment_sGuid
    ON dbo.tbOsDepartment(sGuid)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDepartment') AND name='tbOsDepartment_sGuid')
    PRINT '<<< CREATED INDEX dbo.tbOsDepartment.tbOsDepartment_sGuid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDepartment.tbOsDepartment_sGuid >>>'
go
CREATE NONCLUSTERED INDEX tbOsDepartment_sCityCode
    ON dbo.tbOsDepartment(sCityCode)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDepartment') AND name='tbOsDepartment_sCityCode')
    PRINT '<<< CREATED INDEX dbo.tbOsDepartment.tbOsDepartment_sCityCode >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDepartment.tbOsDepartment_sCityCode >>>'
go
CREATE NONCLUSTERED INDEX tbOsDepartment_iRegionId
    ON dbo.tbOsDepartment(iRegionId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDepartment') AND name='tbOsDepartment_iRegionId')
    PRINT '<<< CREATED INDEX dbo.tbOsDepartment.tbOsDepartment_iRegionId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDepartment.tbOsDepartment_iRegionId >>>'
go

CREATE TABLE dbo.tbOsDomain
(
    iDomainId   numeric(15,0) NOT NULL,
    sDomainName varchar(32)   NOT NULL,
    iDomainType smallint      NOT NULL,
    sDomainCode varchar(32)   NULL,
    iParentId   numeric(15,0) NULL,
    iSequence   numeric(15,0) NULL,
    sPathId     varchar(255)  NULL,
    sRelateId varchar(32)  NULL,
    CONSTRAINT PK_TBOSDOMAIN
    PRIMARY KEY CLUSTERED (iDomainId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsDomain') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsDomain >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsDomain >>>'
go
CREATE NONCLUSTERED INDEX tbOsDomain_sDomainName
    ON dbo.tbOsDomain(sDomainName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDomain') AND name='tbOsDomain_sDomainName')
    PRINT '<<< CREATED INDEX dbo.tbOsDomain.tbOsDomain_sDomainName >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDomain.tbOsDomain_sDomainName >>>'
go
CREATE NONCLUSTERED INDEX tbOsDomain_sDomainCode
    ON dbo.tbOsDomain(sDomainCode)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDomain') AND name='tbOsDomain_sDomainCode')
    PRINT '<<< CREATED INDEX dbo.tbOsDomain.tbOsDomain_sDomainCode >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDomain.tbOsDomain_sDomainCode >>>'
go
CREATE NONCLUSTERED INDEX tbOsDomain_iParentId
    ON dbo.tbOsDomain(iParentId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsDomain') AND name='tbOsDomain_iParentId')
    PRINT '<<< CREATED INDEX dbo.tbOsDomain.tbOsDomain_iParentId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsDomain.tbOsDomain_iParentId >>>'
go

CREATE TABLE dbo.tbOsPost
(
    iPostId            numeric(15,0) NOT NULL,
    sPostName          varchar(32)   NOT NULL,
    sShortName         varchar(32)   NULL,
    sPostCode          varchar(32)   NULL,
    iDeptId            numeric(15,0) NOT NULL,
    iDomainId          numeric(15,0) NOT NULL,
    iDelFlag           int           NOT NULL,
    dCreateDate        datetime      NOT NULL,
    iCreateStaffId     numeric(15,0) NOT NULL,
    dLastMofidy        datetime      NULL,
    iLastModifyStaffId numeric(15,0) NULL,
    CONSTRAINT PK_tbOsPost
    PRIMARY KEY CLUSTERED (iPostId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsPost') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsPost >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsPost >>>'
go
CREATE NONCLUSTERED INDEX tbOsPost_iDeptId
    ON dbo.tbOsPost(iDeptId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPost') AND name='tbOsPost_iDeptId')
    PRINT '<<< CREATED INDEX dbo.tbOsPost.tbOsPost_iDeptId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPost.tbOsPost_iDeptId >>>'
go
CREATE NONCLUSTERED INDEX tbOsPost_iDomainId
    ON dbo.tbOsPost(iDomainId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPost') AND name='tbOsPost_iDomainId')
    PRINT '<<< CREATED INDEX dbo.tbOsPost.tbOsPost_iDomainId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPost.tbOsPost_iDomainId >>>'
go

CREATE TABLE dbo.tbOsPostRelRight
(
    iPostId   numeric(15,0) NOT NULL,
    iDeptId   numeric(15,0) NOT NULL,
    iDomainId numeric(15,0) NOT NULL,
    iRightId  numeric(15,0) NOT NULL,
    CONSTRAINT PK_TBOSPOSTRELRIGHT
    PRIMARY KEY CLUSTERED (iPostId,iDeptId,iDomainId,iRightId)
)
LOCK DATAROWS
WITH EXP_ROW_SIZE=1
go
IF OBJECT_ID('dbo.tbOsPostRelRight') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsPostRelRight >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsPostRelRight >>>'
go
CREATE NONCLUSTERED INDEX tbOsPostRelRight_iPostId
    ON dbo.tbOsPostRelRight(iPostId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPostRelRight') AND name='tbOsPostRelRight_iPostId')
    PRINT '<<< CREATED INDEX dbo.tbOsPostRelRight.tbOsPostRelRight_iPostId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPostRelRight.tbOsPostRelRight_iPostId >>>'
go
CREATE NONCLUSTERED INDEX tbOsPostRelRight_iDeptId
    ON dbo.tbOsPostRelRight(iDeptId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPostRelRight') AND name='tbOsPostRelRight_iDeptId')
    PRINT '<<< CREATED INDEX dbo.tbOsPostRelRight.tbOsPostRelRight_iDeptId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPostRelRight.tbOsPostRelRight_iDeptId >>>'
go
CREATE NONCLUSTERED INDEX tbOsPostRelRight_iDomainId
    ON dbo.tbOsPostRelRight(iDomainId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPostRelRight') AND name='tbOsPostRelRight_iDomainId')
    PRINT '<<< CREATED INDEX dbo.tbOsPostRelRight.tbOsPostRelRight_iDomainId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPostRelRight.tbOsPostRelRight_iDomainId >>>'
go
CREATE NONCLUSTERED INDEX tbOsPostRelRight_iRightId
    ON dbo.tbOsPostRelRight(iRightId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPostRelRight') AND name='tbOsPostRelRight_iRightId')
    PRINT '<<< CREATED INDEX dbo.tbOsPostRelRight.tbOsPostRelRight_iRightId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPostRelRight.tbOsPostRelRight_iRightId >>>'
go

CREATE TABLE dbo.tbOsPostRelStaff
(
    iPostId   numeric(15,0) NOT NULL,
    iDeptId   numeric(15,0) NOT NULL,
    iDomainId numeric(15,0) NOT NULL,
    iStaffId  numeric(15,0) NOT NULL,
    iTitleId  numeric(15,0) NULL,
    CONSTRAINT PK_TBOSPOSTRELSTAFF
    PRIMARY KEY CLUSTERED (iPostId,iStaffId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsPostRelStaff') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsPostRelStaff >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsPostRelStaff >>>'
go
CREATE NONCLUSTERED INDEX tbOsPostRelStaff_iPostId
    ON dbo.tbOsPostRelStaff(iPostId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPostRelStaff') AND name='tbOsPostRelStaff_iPostId')
    PRINT '<<< CREATED INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iPostId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iPostId >>>'
go
CREATE NONCLUSTERED INDEX tbOsPostRelStaff_iDeptId
    ON dbo.tbOsPostRelStaff(iDeptId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPostRelStaff') AND name='tbOsPostRelStaff_iDeptId')
    PRINT '<<< CREATED INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iDeptId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iDeptId >>>'
go
CREATE NONCLUSTERED INDEX tbOsPostRelStaff_iStaffId
    ON dbo.tbOsPostRelStaff(iStaffId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPostRelStaff') AND name='tbOsPostRelStaff_iStaffId')
    PRINT '<<< CREATED INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iStaffId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iStaffId >>>'
go
CREATE NONCLUSTERED INDEX tbOsPostRelStaff_iTitleId
    ON dbo.tbOsPostRelStaff(iTitleId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPostRelStaff') AND name='tbOsPostRelStaff_iTitleId')
    PRINT '<<< CREATED INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iTitleId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iTitleId >>>'
go
CREATE NONCLUSTERED INDEX tbOsPostRelStaff_iDomainId
    ON dbo.tbOsPostRelStaff(iDomainId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsPostRelStaff') AND name='tbOsPostRelStaff_iDomainId')
    PRINT '<<< CREATED INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iDomainId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsPostRelStaff.tbOsPostRelStaff_iDomainId >>>'
go

CREATE TABLE dbo.tbOsRight
(
    iRight     numeric(15,0) NOT NULL,
    sRightName varchar(225)  NOT NULL,
    iSeq       int           NOT NULL,
    iParentId  numeric(15,0) NULL,
    iType      int           NULL,
    sURL       varchar(255)  NULL,
    sIcon      varchar(64)   NULL,
    sRemark    varchar(255)  NULL,
    sGuid      varchar(16)   NULL,
    iStatus    tinyint       DEFAULT 1 NULL,
    iAppFor    tinyint       DEFAULT 2 NULL,
    sRightNo   varchar(32)   DEFAULT '' NOT NULL,
    sPathId    varchar(255)  NULL,
    sCompId    varchar(64)   NULL,
    sExInfo    varchar(3000)          NULL,
	iIsSensitive tinyint     NULL,
    CONSTRAINT PK_tbOsRight
    PRIMARY KEY CLUSTERED (iRight),
    CONSTRAINT unique_sSRightNo
    UNIQUE NONCLUSTERED (sRightNo)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsRight') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsRight >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsRight >>>'
go
CREATE NONCLUSTERED INDEX tbOsRight_sRightName
    ON dbo.tbOsRight(sRightName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsRight') AND name='tbOsRight_sRightName')
    PRINT '<<< CREATED INDEX dbo.tbOsRight.tbOsRight_sRightName >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsRight.tbOsRight_sRightName >>>'
go
CREATE NONCLUSTERED INDEX tbOsRight_iParentId
    ON dbo.tbOsRight(iParentId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsRight') AND name='tbOsRight_iParentId')
    PRINT '<<< CREATED INDEX dbo.tbOsRight.tbOsRight_iParentId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsRight.tbOsRight_iParentId >>>'
go
CREATE NONCLUSTERED INDEX tbOsRight_sGuid
    ON dbo.tbOsRight(sGuid)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsRight') AND name='tbOsRight_sGuid')
    PRINT '<<< CREATED INDEX dbo.tbOsRight.tbOsRight_sGuid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsRight.tbOsRight_sGuid >>>'
go

CREATE TABLE dbo.tbOsRole
(
    sRoleName      varchar(32)   NOT NULL,
    dCreateDate    datetime      NOT NULL,
    sGuid          varchar(16)   NULL,
    iRoleId        numeric(15,0) NOT NULL,
    iDomainId      numeric(15,0) NOT NULL,
    iCreateStaffId numeric(15,0) NOT NULL,
    iAppFor        tinyint       DEFAULT 2 NULL,
    sPathId        varchar(300)  NULL,
    iParentId      numeric(15,0) NULL,
    sRemark        varchar(255)  NULL,
    CONSTRAINT PK_tbOsRole
    PRIMARY KEY CLUSTERED (iRoleId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsRole') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsRole >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsRole >>>'
go
CREATE NONCLUSTERED INDEX tbOsRole_iDomainId
    ON dbo.tbOsRole(iDomainId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsRole') AND name='tbOsRole_iDomainId')
    PRINT '<<< CREATED INDEX dbo.tbOsRole.tbOsRole_iDomainId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsRole.tbOsRole_iDomainId >>>'
go
CREATE NONCLUSTERED INDEX tbOsRole_sGuid
    ON dbo.tbOsRole(sGuid)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsRole') AND name='tbOsRole_sGuid')
    PRINT '<<< CREATED INDEX dbo.tbOsRole.tbOsRole_sGuid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsRole.tbOsRole_sGuid >>>'
go

CREATE TABLE dbo.tbOsRoleRelDept
(
    iRoleId numeric(15,0) NOT NULL,
    iDeptId numeric(15,0) NOT NULL,
    iRight  numeric(15,0) NOT NULL,
    CONSTRAINT PK_TBOSROLERELDEPT
    PRIMARY KEY CLUSTERED (iRoleId,iDeptId,iRight)
)
LOCK DATAROWS
WITH EXP_ROW_SIZE=1
go
IF OBJECT_ID('dbo.tbOsRoleRelDept') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsRoleRelDept >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsRoleRelDept >>>'
go

CREATE TABLE dbo.tbOsRoleRelDomain
(
    iRoleId   numeric(15,0) NOT NULL,
    iDomainId numeric(15,0) NOT NULL,
    iRight    numeric(15,0) NOT NULL,
    CONSTRAINT PK_TBOSROLERELDOMAIN
    PRIMARY KEY CLUSTERED (iRoleId,iDomainId,iRight)
)
LOCK DATAROWS
WITH EXP_ROW_SIZE=1
go
IF OBJECT_ID('dbo.tbOsRoleRelDomain') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsRoleRelDomain >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsRoleRelDomain >>>'
go

CREATE TABLE dbo.tbOsRoleRelRight
(
    iRoleId   numeric(15,0) NOT NULL,
    iRightId  numeric(15,0) NOT NULL,
    iMenuType int           NULL,
    CONSTRAINT PK_TBOSROLERELRIGHT
    PRIMARY KEY CLUSTERED (iRoleId,iRightId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsRoleRelRight') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsRoleRelRight >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsRoleRelRight >>>'
go
CREATE NONCLUSTERED INDEX tbOsRoleRelRight_iRoleId
    ON dbo.tbOsRoleRelRight(iRoleId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsRoleRelRight') AND name='tbOsRoleRelRight_iRoleId')
    PRINT '<<< CREATED INDEX dbo.tbOsRoleRelRight.tbOsRoleRelRight_iRoleId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsRoleRelRight.tbOsRoleRelRight_iRoleId >>>'
go
CREATE NONCLUSTERED INDEX tbOsRoleRelRight_iRightId
    ON dbo.tbOsRoleRelRight(iRightId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsRoleRelRight') AND name='tbOsRoleRelRight_iRightId')
    PRINT '<<< CREATED INDEX dbo.tbOsRoleRelRight.tbOsRoleRelRight_iRightId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsRoleRelRight.tbOsRoleRelRight_iRightId >>>'
go


CREATE TABLE dbo.tbOsStaff
(
    iStaffId           numeric(15,0) NOT NULL,
    sStaffName         varchar(32)   NOT NULL,
    sStaffNo           varchar(32)   NOT NULL,
    sStaffAccount      varchar(32)   NOT NULL,
    sPassword          varchar(32)   NOT NULL,
    sTelphone          varchar(16)   NULL,
    sMobile            varchar(16)   NULL,
    cCDMA              varchar(16)   NULL,
    sPHS               varchar(16)   NULL,
    sOutEmail          varchar(64)   NULL,
    sInEmail           varchar(64)   NULL,
    sFaxCode           varchar(16)   NULL,
    dAvailBeginDate    datetime      NOT NULL,
    dAvailEndDate      datetime      NOT NULL,
    iDeptId            numeric(15,0) NOT NULL,
    iDomainId          numeric(15,0) NOT NULL,
    iTitleId           numeric(15,0) NOT NULL,
    iDelFlag           int           DEFAULT 0 NOT NULL,
    dCreateDate        datetime      DEFAULT getdate() NOT NULL,
    iCreateStaffId     numeric(15,0) NOT NULL,
    dLastModify        datetime      DEFAULT getdate() NULL,
    iLastModifyStaffId numeric(15,0) NULL,
    sGuid              varchar(16)   NULL,
    iKnowledge         smallint      NULL,
    dBirthday          date          NULL,
    dEntryDate         date          NULL,
    sRemark            varchar(255)  NULL,
    sLongevity         varchar(64)   NULL,
    sMaintInfo         varchar(255)  NULL,
    sWorkLoc           varchar(255)  NULL,
    sTrainingInfo      varchar(255)  NULL,
    iIsSynch           smallint      DEFAULT 0 NULL,
    sUUVUserID         varchar(12)   NULL,
    iEiacDeptId        numeric(15,0) NULL,
    iStaffAccountId    numeric(6)  NULL,
    sPasswordId        varchar(32)   NULL,
    iPubAccount        smallint      NULL,
    dUpdatePassTime    datetime      NULL,
    iLeaderId          numeric(15,0) NULL,
    sPwdQuestion	   varchar(64)   NULL,
    sCustomQuestion	   varchar(64)   NULL,
    sPwdAnswer		   varchar(64)   NULL,
    iErrorTime		   int		     DEFAULT 0 NULL,
    dErrorDate		   datetime		 NULL,
    iSex               int           DEFAULT 1 NULL,
    sCard              varchar(32)   NULL,
    sSpecIds varchar(256) null,
    sSpecNames varchar(256) null,
    CONSTRAINT PK_tbOsStaff
    PRIMARY KEY NONCLUSTERED (iStaffId),
    CONSTRAINT tbOsStaff_unique_sStaffAccount
    UNIQUE NONCLUSTERED (sStaffAccount)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsStaff') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsStaff >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsStaff >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_iStaffId
    ON dbo.tbOsStaff(iStaffId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_iStaffId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_iStaffId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_iStaffId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_sStaffName
    ON dbo.tbOsStaff(sStaffName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_sStaffName')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_sStaffName >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_sStaffName >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_iDeptId
    ON dbo.tbOsStaff(iDeptId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_iDeptId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_iDeptId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_iDeptId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_iDomainId
    ON dbo.tbOsStaff(iDomainId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_iDomainId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_iDomainId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_iDomainId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_iTitleId
    ON dbo.tbOsStaff(iTitleId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_iTitleId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_iTitleId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_iTitleId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_sGuid
    ON dbo.tbOsStaff(sGuid)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_sGuid')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_sGuid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_sGuid >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_sUUVUserID
    ON dbo.tbOsStaff(sUUVUserID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_sUUVUserID')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_sUUVUserID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_sUUVUserID >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_sMobile
    ON dbo.tbOsStaff(sMobile)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_sMobile')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_sMobile >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_sMobile >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_cCDMA
    ON dbo.tbOsStaff(cCDMA)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_cCDMA')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_cCDMA >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_cCDMA >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_iStaffAccountId
    ON dbo.tbOsStaff(iStaffAccountId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_iStaffAccountId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_iStaffAccountId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_iStaffAccountId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_sPasswordId
    ON dbo.tbOsStaff(sPasswordId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_sPasswordId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_sPasswordId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_sPasswordId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_iPubAccount
    ON dbo.tbOsStaff(iPubAccount)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_iPubAccount')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_iPubAccount >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_iPubAccount >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaff_sPHS
    ON dbo.tbOsStaff(sPHS)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='tbOsStaff_sPHS')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.tbOsStaff_sPHS >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.tbOsStaff_sPHS >>>'
go
CREATE NONCLUSTERED INDEX Index_dUpdatePassTime
    ON dbo.tbOsStaff(dUpdatePassTime)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaff') AND name='Index_dUpdatePassTime')
    PRINT '<<< CREATED INDEX dbo.tbOsStaff.Index_dUpdatePassTime >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaff.Index_dUpdatePassTime >>>'
go

CREATE TABLE dbo.tbOsStaffRelDept
(
    iStaffId numeric(15,0) NOT NULL,
    iDeptId  numeric(15,0) NOT NULL,
    CONSTRAINT PK_TBOSSTAFFRELDEPT
    PRIMARY KEY CLUSTERED (iStaffId,iDeptId)
)
LOCK DATAROWS
WITH EXP_ROW_SIZE=1
go
IF OBJECT_ID('dbo.tbOsStaffRelDept') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsStaffRelDept >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsStaffRelDept >>>'
go

CREATE TABLE dbo.tbOsStaffRelRight
(
    iStaffId numeric(15,0) NOT NULL,
    iRightId numeric(15,0) NOT NULL,
    CONSTRAINT PK_TBOSSTAFFRELRIGHT
    PRIMARY KEY CLUSTERED (iStaffId,iRightId)
)
LOCK DATAROWS
WITH EXP_ROW_SIZE=1
go
IF OBJECT_ID('dbo.tbOsStaffRelRight') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsStaffRelRight >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsStaffRelRight >>>'
go

CREATE TABLE dbo.tbOsStaffRelRole
(
    iStaffId       numeric(15,0) NOT NULL,
    iRoleId        numeric(15,0) NOT NULL,
    iTitleId       numeric(15,0) NULL,
    iDeptId        numeric(15,0) NOT NULL,
    iDomainId      numeric(15,0) NOT NULL,
    iCreateStaffId numeric(15,0) NULL,
    iType          numeric(15,0) NOT NULL,
    sRemark    varchar(128) NULL,
    CONSTRAINT PK_TBOSSTAFFRELROLE
    PRIMARY KEY CLUSTERED (iStaffId,iRoleId,iType)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsStaffRelRole') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsStaffRelRole >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsStaffRelRole >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaffRelRole_iStaffId
    ON dbo.tbOsStaffRelRole(iStaffId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaffRelRole') AND name='tbOsStaffRelRole_iStaffId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iStaffId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iStaffId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaffRelRole_iRoleId
    ON dbo.tbOsStaffRelRole(iRoleId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaffRelRole') AND name='tbOsStaffRelRole_iRoleId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iRoleId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iRoleId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaffRelRole_iTitleId
    ON dbo.tbOsStaffRelRole(iTitleId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaffRelRole') AND name='tbOsStaffRelRole_iTitleId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iTitleId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iTitleId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaffRelRole_iDeptId
    ON dbo.tbOsStaffRelRole(iDeptId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaffRelRole') AND name='tbOsStaffRelRole_iDeptId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iDeptId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iDeptId >>>'
go
CREATE NONCLUSTERED INDEX tbOsStaffRelRole_iDomainId
    ON dbo.tbOsStaffRelRole(iDomainId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsStaffRelRole') AND name='tbOsStaffRelRole_iDomainId')
    PRINT '<<< CREATED INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iDomainId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsStaffRelRole.tbOsStaffRelRole_iDomainId >>>'
go

CREATE TABLE dbo.tbOsTeamRelStaff
(
    iDeptId  numeric(15,0) NOT NULL,
    iObjId   numeric(15,0) NOT NULL,
    iObjType smallint      DEFAULT 0 NULL,
    CONSTRAINT PK_TBOSTEAMRELSTAFF
    PRIMARY KEY CLUSTERED (iDeptId,iObjId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsTeamRelStaff') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsTeamRelStaff >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsTeamRelStaff >>>'
go
CREATE NONCLUSTERED INDEX tbOsTeamRelStaff_iDeptId
    ON dbo.tbOsTeamRelStaff(iDeptId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsTeamRelStaff') AND name='tbOsTeamRelStaff_iDeptId')
    PRINT '<<< CREATED INDEX dbo.tbOsTeamRelStaff.tbOsTeamRelStaff_iDeptId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsTeamRelStaff.tbOsTeamRelStaff_iDeptId >>>'
go
CREATE NONCLUSTERED INDEX tbOsTeamRelStaff_iObjId
    ON dbo.tbOsTeamRelStaff(iObjId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsTeamRelStaff') AND name='tbOsTeamRelStaff_iObjId')
    PRINT '<<< CREATED INDEX dbo.tbOsTeamRelStaff.tbOsTeamRelStaff_iObjId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsTeamRelStaff.tbOsTeamRelStaff_iObjId >>>'
go

CREATE TABLE dbo.tbOsTitle
(
    iTitleId           numeric(15,0) NOT NULL,
    sTitleName         varchar(32)   NOT NULL,
    sTitleShortName    varchar(32)   NULL,
    sTitleCode         varchar(32)   NULL,
    iDeptId            numeric(15,0) NOT NULL,
    iDomainId          numeric(15,0) NOT NULL,
    iDelFlag           int           NOT NULL,
    iSeq               int           NOT NULL,
    dCreateDate        datetime      DEFAULT getdate() NOT NULL,
    iCreateStaffId     numeric(15,0) NOT NULL,
    dLastMofidy        datetime      DEFAULT getdate() NULL,
    iLastModifyStaffId numeric(15,0) NULL,
    sGuid              varchar(16)   NULL,
    iIsSynch           smallint      DEFAULT 0 NULL,
    sUUVTitleID        varchar(12)   NULL,
    CONSTRAINT PK_tbOsTitle
    PRIMARY KEY CLUSTERED (iTitleId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbOsTitle') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbOsTitle >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbOsTitle >>>'
go
CREATE NONCLUSTERED INDEX tbOsTitle_iDeptId
    ON dbo.tbOsTitle(iDeptId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsTitle') AND name='tbOsTitle_iDeptId')
    PRINT '<<< CREATED INDEX dbo.tbOsTitle.tbOsTitle_iDeptId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsTitle.tbOsTitle_iDeptId >>>'
go
CREATE NONCLUSTERED INDEX tbOsTitle_iDomainId
    ON dbo.tbOsTitle(iDomainId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsTitle') AND name='tbOsTitle_iDomainId')
    PRINT '<<< CREATED INDEX dbo.tbOsTitle.tbOsTitle_iDomainId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsTitle.tbOsTitle_iDomainId >>>'
go
CREATE NONCLUSTERED INDEX tbOsTitle_sGuid
    ON dbo.tbOsTitle(sGuid)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsTitle') AND name='tbOsTitle_sGuid')
    PRINT '<<< CREATED INDEX dbo.tbOsTitle.tbOsTitle_sGuid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsTitle.tbOsTitle_sGuid >>>'
go
CREATE NONCLUSTERED INDEX tbOsTitle_sUUVTitleID
    ON dbo.tbOsTitle(sUUVTitleID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbOsTitle') AND name='tbOsTitle_sUUVTitleID')
    PRINT '<<< CREATED INDEX dbo.tbOsTitle.tbOsTitle_sUUVTitleID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbOsTitle.tbOsTitle_sUUVTitleID >>>'
go

CREATE TABLE dbo.tbUIMGrp2Right
(
    iId        numeric(15,0) NOT NULL,
    iMenuGrpId numeric(15,0) NOT NULL,
    iRight     numeric(15,0) NOT NULL,
    sDspName   varchar(32)   NULL,
    iSeq       int           DEFAULT 0 NULL,
    CONSTRAINT PK_TBUIMGRP2RIGHT
    PRIMARY KEY CLUSTERED (iId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbUIMGrp2Right') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbUIMGrp2Right >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbUIMGrp2Right >>>'
go
CREATE NONCLUSTERED INDEX tbUIMGrp2Right_iMenuGrpId
    ON dbo.tbUIMGrp2Right(iMenuGrpId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbUIMGrp2Right') AND name='tbUIMGrp2Right_iMenuGrpId')
    PRINT '<<< CREATED INDEX dbo.tbUIMGrp2Right.tbUIMGrp2Right_iMenuGrpId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbUIMGrp2Right.tbUIMGrp2Right_iMenuGrpId >>>'
go

CREATE TABLE dbo.tbUIMenuGrp
(
    iMenuGrpId   numeric(15,0) NOT NULL,
    sMenuGrpName varchar(32)   NOT NULL,
    iPGrpId      numeric(15,0) NULL,
    iSeq         int           DEFAULT 1 NOT NULL,
    iType        int           DEFAULT 1 NOT NULL,
    iStaffId     numeric(15,0) NOT NULL,
    iDeptId      numeric(15,0) NOT NULL,
    iDomainId    numeric(15,0) NOT NULL,
    CONSTRAINT PK_TBUIMENUGRP
    PRIMARY KEY CLUSTERED (iMenuGrpId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbUIMenuGrp') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbUIMenuGrp >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbUIMenuGrp >>>'
go
CREATE NONCLUSTERED INDEX tbUIMenuGrp_iPGrpId
    ON dbo.tbUIMenuGrp(iPGrpId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbUIMenuGrp') AND name='tbUIMenuGrp_iPGrpId')
    PRINT '<<< CREATED INDEX dbo.tbUIMenuGrp.tbUIMenuGrp_iPGrpId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbUIMenuGrp.tbUIMenuGrp_iPGrpId >>>'
go
CREATE NONCLUSTERED INDEX tbUIMenuGrp_iStaffId
    ON dbo.tbUIMenuGrp(iStaffId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbUIMenuGrp') AND name='tbUIMenuGrp_iStaffId')
    PRINT '<<< CREATED INDEX dbo.tbUIMenuGrp.tbUIMenuGrp_iStaffId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbUIMenuGrp.tbUIMenuGrp_iStaffId >>>'
go
CREATE NONCLUSTERED INDEX tbUIMenuGrp_iDeptId
    ON dbo.tbUIMenuGrp(iDeptId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbUIMenuGrp') AND name='tbUIMenuGrp_iDeptId')
    PRINT '<<< CREATED INDEX dbo.tbUIMenuGrp.tbUIMenuGrp_iDeptId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbUIMenuGrp.tbUIMenuGrp_iDeptId >>>'
go

CREATE TABLE dbo.tbWfActorCatalog
(
    iCataId     numeric(15,0) NOT NULL,
    iDomainId   numeric(15,0) NULL,
    sDomainName varchar(32)   NULL,
    iDeptId     numeric(15,0) NULL,
    sDeptName   varchar(128)  NULL,
    iStaffId    numeric(15,0) NULL,
    sStaffName  varchar(32)   NULL,
    dCreatetime datetime      NOT NULL,
    sWfCode     varchar(128)  NOT NULL,
    iWfId       numeric(15,0) NULL,
    sWfName     varchar(64)   NOT NULL,
    sRemark     varchar(255)  NULL,
    iOrderby    int           NOT NULL,
    CONSTRAINT PK_TBWFACTORCATALOG
    PRIMARY KEY NONCLUSTERED (iCataId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbWfActorCatalog') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbWfActorCatalog >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbWfActorCatalog >>>'
go

CREATE TABLE dbo.tbWfActorDefinition
(
    iActorId         numeric(15,0) NOT NULL,
    iModuleId        numeric(15,0) NOT NULL,
    iDomainId        numeric(15,0) NULL,
    sDomainName      varchar(32)   NULL,
    iDeptId          numeric(15,0) NULL,
    sDeptName        varchar(128)  NULL,
    iStaffId         numeric(15,0) NULL,
    sStaffName       varchar(32)   NULL,
    dCreatetime      datetime      NOT NULL,
    iActorType       smallint      NOT NULL,
    sActorIdValue    varchar(64)   NOT NULL,
    sActorNameValue  varchar(128)  NOT NULL,
    sActorDispName   varchar(128)  NOT NULL,
    iActorDomainId   numeric(15,0) NULL,
    sActorDomainName varchar(32)   NULL,
    iActorDeptId     numeric(15,0) NULL,
    sActorDeptName   varchar(128)  NULL,
    iActorStaffId    numeric(15,0) NULL,
    sActorStaffName  varchar(32)   NULL,
    sPhone           varchar(64)   NULL,
    iOrderby         int           NOT NULL,
    iParentId        numeric(15,0) NOT NULL,
    iModeratorID numeric(15,0) null,
    sModeratorName varchar(32)  null,
    CONSTRAINT PK_TBWFACTORDEFINITION
    PRIMARY KEY NONCLUSTERED (iActorId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbWfActorDefinition') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbWfActorDefinition >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbWfActorDefinition >>>'
go

CREATE TABLE dbo.tbWfActorModule
(
    iModuleId   numeric(15,0) NOT NULL,
    iDomainId   numeric(15,0) NULL,
    sDomainName varchar(32)   NULL,
    iDeptId     numeric(15,0) NULL,
    sDeptName   varchar(128)  NULL,
    iStaffId    numeric(15,0) NULL,
    sStaffName  varchar(32)   NULL,
    dCreatetime datetime      NOT NULL,
    iCataId     numeric(15,0) NOT NULL,
    sModuleCode varchar(64)   NOT NULL,
    sModuleName varchar(64)   NOT NULL,
    sRemark     varchar(255)  NULL,
    iOrderby    int           NOT NULL,
    iSetType    smallint      DEFAULT 1 NULL,
    CONSTRAINT PK_TBWFACTORMODULE
    PRIMARY KEY NONCLUSTERED (iModuleId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbWfActorModule') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbWfActorModule >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbWfActorModule >>>'
go


/*IP黑白明单*/
create TABLE tbOsIPRight
(
  iIPId    NUMERIC(15,0) NOT NULL ,
  iObjType  SMALLINT NOT NULL,
  iObjId    NUMERIC(15,0) NOT NULL,
  iListType  SMALLINT NOT NULL,
  sIP      VARCHAR(1024) NOT NULL,
  sRemark    VARCHAR(255)  NULL,
 CONSTRAINT PK_tbOsIPRight
    PRIMARY KEY CLUSTERED (iIPId)
)
LOCK DATAROWS
go
CREATE NONCLUSTERED INDEX tbOsIPRight_iObjId
    ON tbOsIPRight(iObjId)
go


/*账号更新日志*/
CREATE TABLE tbOsOperationNote  (
   iOptId             NUMERIC(15,0)                    NOT NULL , 
   iOptObjId          NUMERIC(15,0)                    NOT NULL,
   iOptObjType        SMALLINT                        NOT NULL,
   iOptType           SMALLINT                        NOT NULL,
   sOptJson           VARCHAR(4000) null,
   sOptMsg            VARCHAR(255) null,
   sIP          VARCHAR(255) null,
   iUserId            NUMERIC(15,0) null,
   sUserName          VARCHAR(32) null,
   sAccount           VARCHAR(32) null,
   iUserDeptId        NUMERIC(15,0) null,
   sUserDeptName      VARCHAR(32) null,
   iUserDomainId      NUMERIC(15,0) null,
   sUserDomainName    VARCHAR(32) null,
   dOptDate           DATETIME                          NOT NULL,
   CONSTRAINT PK_tbOsOperationNote
    PRIMARY KEY CLUSTERED (iOptId)
)
LOCK DATAROWS
go
CREATE NONCLUSTERED INDEX tbOsOperationNote_iObjId
    ON tbOsOperationNote(iOptObjId)
go
CREATE NONCLUSTERED INDEX tbOsOperationNote_dOptDate
    ON tbOsOperationNote(dOptDate)
go
CREATE NONCLUSTERED INDEX tbOsON_iUserDomainId
    ON tbOsOperationNote(iUserDomainId)
go


/**基础数据**********************/
--用户首面自定义菜单
INSERT INTO dbo.tbUIMenuGrp ( iMenuGrpId, sMenuGrpName, iPGrpId, iSeq, iType, iStaffId, iDeptId, iDomainId ) VALUES ( 1, '我的根目录', null, 1, 1, 1, 1, 1030005 ) 
--区域
INSERT INTO tbOsDomain ( iDomainId, sDomainName, iDomainType, sDomainCode, iParentId ) 
		 VALUES ( 1030005, '省公司', 1, 'CT', 1000000 );
--部门
INSERT INTO tbOsDepartment ( iDeptId, sDeptName, sDispName, sShortName, sDeptCode, iParentId, iDelFlag, dCreateDate, iCreateStaffId, dLastModify, iLastModifyStaffId, iDomainId, sGuid, sPathId, iDeptType, iAgCompanyId, iIsSynch, sUUVOrgID, sDispName_zte, sDataSrc, iDeptId_zte, iIsDutyDept, sCityCode, iRegionId, iSortIndex ) 
		 VALUES (1, '网络监控室', '/网络监控室/', ' ', NULL, 0, 0, '2009-03-24 03:45:07', 1, '2009-03-24 10:44:04', NULL, 1030005, NULL, '/0/1/', 0, NULL, 1, 'OR1500022546', '中国电信广东分公司/省网络操作维护中心/网络监控室', NULL, 103000500000018, 1, NULL, NULL, 0 ) 
;
--职位
INSERT INTO tbOsTitle ( iTitleId, sTitleName, sTitleShortName, sTitleCode, iDeptId, iDomainId, iDelFlag, iSeq, dCreateDate, iCreateStaffId, dLastMofidy, iLastModifyStaffId, sGuid, iIsSynch, sUUVTitleID ) 
		 VALUES ( 1, '网络监控室职位A', 'titleA', '1', 1, 1030005, 0, 1, '2009-03-24 04:32:17', 140466, NULL, NULL, ' ', NULL, ' ' ) 
;
--账号
INSERT INTO tbOsStaff ( iStaffId, sStaffName, sStaffNo, sStaffAccount, sPassword, sTelphone, sMobile, cCDMA, sPHS, sOutEmail, sInEmail, sFaxCode, dAvailBeginDate, dAvailEndDate, iDeptId, iDomainId, iTitleId, iDelFlag, dCreateDate, iCreateStaffId, dLastModify, iLastModifyStaffId, sGuid, iKnowledge, dBirthday, dEntryDate, sRemark, sLongevity, sMaintInfo, sWorkLoc, sTrainingInfo, iIsSynch, sUUVUserID, iEiacDeptId, iStaffAccountId, sPasswordId, iPubAccount, dUpdatePassTime, iLeaderId ) 
		 VALUES ( 1, '网络监控室测试', '1', 'nocjktest', 'c4ca4238a0b923820dcc509a6f75849b', '18926239263', '18926239263', '18926239263', '211323', 'bbb@126.com', 'aaa@126.com', ' ', '2009-03-24 12:00:00', '2030-03-24 12:00:00', 1, 1030005, 1, 0, '2010-04-24 12:10:00', -103000500000999, '2010-04-24 10:53:40', 103000500001239, ' ', 1, '1987-04-24', '1900-01-01', ' ', ' ', ' ', ' ', ' ', 0, ' ', NULL, NULL, ' ', 0, '2010-04-24 10:53:40', NULL ) 
;

--权限
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 1, '权限树', 1, NULL, 1, ' ', 'qwerer', '权限树/', ' ', 1, 1, '1', '/1/' ) 
go

INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 61, '安全管理', 15, 16133, 1, ' ', 'safte', 'admin/safeMgr/safeIndex.html', ' ', 1, 1, '61', '/1/16133/61/' ) 
go

INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 72, '部门人员管理', 1, 61, 1, 'admin/safeMgr/dept/index.jsp', ' ', ' ', ' ', 1, 1, '72', '/1/16133/61/72/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 73, '角色管理', 2, 61, 1, 'admin/safeMgr/role/index.jsp', ' ', ' ', ' ', 1, 1, '73', '/1/16133/61/73/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 74, '权限管理', 3, 61, 1, 'admin/safeMgr/right/right_mgr.jsp', ' ', ' ', ' ', 1, 1, '74', '/1/16133/61/74/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 76, '密码修改', 40, 16031, 1, 'admin/safeMgr/reviseM/revise_pword.jsp', ' ', ' ', ' ', 1, 1, '76', '/1/16031/61/76/' ) 
go
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 77, '修改个人信息', 40, 16031, 1, 'admin/safeMgr/staff/staffDetail.jsp', ' ', ' ', ' ', 1, 1, '77', '/1/16031/61/77/' ) 
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 120, '区域管理', 5, 16133, 1, 'admin/safeMgr/domain/domainIndex.jsp', ' ', ' ', ' ', 1, 1, '120', '/1/16133/120/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 246, '新增', 1, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '149fc50d866d4f06810b88b5d4a7cd67', '/1/16133/61/74/246/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 247, '修改', 2, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '0b4d236b753c4cebbbd89f13bb84135d', '/1/16133/61/74/247/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 248, '删除', 3, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '06a9a8ecd17a464b85705642c792a754', '/1/16133/61/74/248/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 249, '移动', 4, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '699bd647c9e04da9893abcc355c86793', '/1/16133/61/74/249/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 250, '人员', 5, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '1a06a7beebb5490db868273dd707744e', '/1/16133/61/74/250/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 251, '查询', 1, 119, 2, ' ', ' ', ' ', ' ', 1, 1, '6696265cc72f4c39b0f72b705ef4cd7e', '/1/16133/16030/119/251/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 252, '删除', 2, 119, 2, ' ', ' ', ' ', ' ', 1, 1, '3174e48c9ee749919bab177d89c621bc', '/1/16133/16030/119/252/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 253, '新增', 1, 120, 2, ' ', ' ', ' ', ' ', 1, 1, 'b2766d428616425a9128529e7c856159', '/1/16133/120/253/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 254, '修改', 2, 120, 2, ' ', ' ', ' ', ' ', 1, 1, 'e41d37f13f09483ab3c1ec7101981843', '/1/16133/120/254/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 255, '删除', 3, 120, 2, ' ', ' ', ' ', ' ', 1, 1, '3f7e0838be694cccbae9a15c2c921c2a', '/1/16133/120/255/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 256, '移动', 4, 120, 2, ' ', ' ', ' ', ' ', 1, 1, '8f13b1b59032402d97b87cf9c00c1040', '/1/16133/120/256/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 258, '部门-新增', 2, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '0f2e8e850e0f4e44b019cb835e9c880e', '/1/16133/61/72/258/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 259, '部门-修改', 3, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '7525e24a9e4c4f3ba22a3a0d32cc4738', '/1/16133/61/72/259/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 260, '部门-删除', 4, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'a13c5a8d35984d87bc713f8baf77922b', '/1/16133/61/72/260/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 261, '职位-新增', 5, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '6b3c2bcf212546f3bbad454267dfd3f2', '/1/16133/61/72/261/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 262, '职位-修改', 6, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '3aa1848c107a4966b4fafa9328bfc2f3', '/1/16133/61/72/262/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 263, '职位-删除', 7, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'c22ee78301f744f894d8b068a02ed5d2', '/1/16133/61/72/263/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 264, '岗位-新增', 8, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'a415b2a3513f451ea78fb81099abaebe', '/1/16133/61/72/264/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 265, '岗位-修改', 9, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '93949f7256a74c3bbbb2cf0994941ebc', '/1/16133/61/72/265/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 266, '岗位-删除', 10, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '49c797fd1fae4dbab6d6f7f2ed439c51', '/1/16133/61/72/266/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 267, '岗位-新增人员', 11, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '9f22db6ed3b245a1be5f6e6c4a18322c', '/1/16133/61/72/267/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 268, '岗位-删除人员', 12, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '7c4f20c67b474c24b88f9bd8414d26a0', '/1/16133/61/72/268/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 269, '岗位-权限编辑', 13, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '5bf3472bb0a0415c9e5dbcfc9a150c4c', '/1/16133/61/72/269/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 270, '人员-查询', 14, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '0f3fb9e474424f9ebafdaae5469dc88b', '/1/16133/61/72/270/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 271, '人员-新增', 15, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'd0551bcaa7974e92af8cf362f4035d13', '/1/16133/61/72/271/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 272, '人员-修改', 16, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '7e4c67cc582242f1ae0977ff280347eb', '/1/16133/61/72/272/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 273, '人员-删除', 17, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '47910220734b47eda340f0e3e61b47db', '/1/16133/61/72/273/' ) 
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100412, '人员-锁定', 18, 72, 2, ' ', ' ', ' ', ' ', 1, '3fd7254cc07f43ba8e53ec3ca8f5c66a', '/1/16133/61/72/100412/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100413, '人员-解锁', 18, 72, 2, ' ', ' ', ' ', ' ', 1, '738b2bf967e14bcb856748e788c9d8b5', '/1/16133/61/72/100413/', 1)
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 274, '人员-初始密码', 18, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'cd93e2b3980d430689a71c1587661602', '/1/16133/61/72/274/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 275, '人员-更改部门', 19, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '4250a80beb394f1bbf39fad62e147fc3', '/1/16133/61/72/275/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 276, '人员-设置领导', 20, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '3dc93d0af3db40dc86a28e73087e62c4', '/1/16133/61/72/276/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 277, '人员-职位-保存', 21, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'a7e52a05b1c144dba0c559705deceda1', '/1/16133/61/72/277/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 278, '人员-岗位-保存', 22, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '7a6b5d9688b84cf8b1053924ce9e1410', '/1/16133/61/72/278/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16134, '界面布局', 0, 16132, 1, ' ', ' ', ' ', ' ', 1, 1, '6d4747c0e19942b2b909effa0704b97e', '/1/16130/16132/16134/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16135, '客户端控件', 1, 16132, 1, ' ', ' ', ' ', ' ', 1, 1, 'a9239b070f8a4370b5fa1e1020a317a4', '/1/16130/16132/16135/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16137, 'fastDFS上下载说明', 2, 16034, 1, 'fastdfs/readme.jsp', ' ', ' ', ' ', 1, 1, 'fastDFS_readMe', '/1/46/16034/16137/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 279, '人员-角色-新增', 23, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '2765df5503294b1393c224cbc1a65fef', '/1/16133/61/72/279/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 280, '人员-角色-删除', 24, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'cb636918c2e14af6ad283cc2a93421d2', '/1/16133/61/72/280/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 281, '人员-直接权限-修改', 25, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '6b984f0fc224414a8535b01220c8d617', '/1/16133/61/72/281/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 282, '人员-业务部门-修改', 26, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '298fa69dfadc43d1ac40bb98347cfe0f', '/1/16133/61/72/282/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 283, '权限-修改', 1, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '46af1e4a1052402d8e675f98d1e6ca17', '/1/16133/61/73/283/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 284, '团队-选择人员', 28, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '6806390b334b4581873db8fc17a190fe', '/1/16133/61/72/284/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 285, '团队-选择部门', 29, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'd980b708047f4ae6adf8f491192fc34a', '/1/16133/61/72/285/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 286, '团队-删除人员', 30, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'a296bea93119435b96ee66df16e2947a', '/1/16133/61/72/286/' ) 
go

insert into dbo.tbOsRight  ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor ) 
values (100401, '人员-群组管理', 445, 72, 2, ' ', ' ', ' ', ' ', 1, 'af232fbe3dd849ca849f534ca6772777', '/1/16133/61/72/100401/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100403, '群组-新增目录', 447, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz001', '/1/16133/61/72/100403/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100404, '群组-新增群组', 448, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz002', '/1/16133/61/72/100404/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100405, '群组-修改目录群组', 449, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz003', '/1/16133/61/72/100405/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100406, '群组-删除目录群组', 450, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz004', '/1/16133/61/72/100406/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100407, '群组-新增群组目录', 451, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz005', '/1/16133/61/72/100407/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100408, '群组-新增部门', 452, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz006', '/1/16133/61/72/100408/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100409, '群组-新增人员', 453, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz007', '/1/16133/61/72/100409/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100410, '群组-修改(目录、部门、人员)', 454, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz008', '/1/16133/61/72/100410/', 1)
go
insert into dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
values (100411, '群组-删除(目录、部门、人员)', 455, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz009', '/1/16133/61/72/100411/', 1)
go


INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16032, 'excel导出', 3, 119, 2, ' ', ' ', ' ', ' ', 1, 1, '0a6c8101eaf64835b8043144d8f01b4b', '/1/16133/16030/119/16032/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16033, 'HTC控件', 1, 46, 1, ' ', ' ', ' ', ' ', 1, 1, '111', '/1/46/16033/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16034, '上传与下载', 2, 46, 1, ' ', ' ', ' ', ' ', 1, 1, '112', '/1/46/16034/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 287, '团队-删除部门', 31, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'bc5ac0204add455281389267d51a3ddd', '/1/16133/61/72/287/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 288, '角色-新增', 2, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '7838061175ca4e74bbdb3f03b088b0eb', '/1/16133/61/73/288/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 289, '角色-修改', 3, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '17808779ead441de8194e43736aee0fb', '/1/16133/61/73/289/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 290, '角色-删除', 4, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '044b5976d00d40f4b834e96738495910', '/1/16133/61/73/290/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
         VALUES ( 2901, '角色-复制', 4, 73, 2, ' ', ' ', ' ', ' ', 1, 1, 'd55528e364b44c43a6c93f13a5120fc9', '/1/16133/61/73/2901/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16063, '部门-查询', 1, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '789f393ea3b14eba84949f71d0d9ae59', '/1/16133/61/72/16063/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16061, '人员-员工详情', 444, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'e9c1a11b54eb4159ac66b2525893b063', '/1/16133/61/72/16061/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16041, '日志接口说明', 116, 16036, 1, 'demo/login/logExample.jsp', ' ', ' ', ' ', 1, 1, '1106', '/1/46/16036/16041/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16067, '权限-批量删权', 5, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '5401886cf8f847b58a331ef04e879fda', '/1/16133/61/73/16067/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16070, '菜单-新增', 1, 16008, 2, ' ', 'ss', ' ', ' ', 1, 1, 'bd05883b70d449b5a773b346dfd37f6d', '/1/16133/16008/16070/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16071, '菜单-修改', 2, 16008, 2, ' ', 'edit', ' ', ' ', 1, 1, '3b74a6ef9a6f44fb9f915ae16be64d21', '/1/16133/16008/16071/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16073, '菜单-删除', 3, 16008, 2, ' ', 'delete', ' ', ' ', 1, 1, '3bb34aa2778e4c0a8248148502bf3dd2', '/1/16133/16008/16073/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16074, '菜单-移动', 4, 16008, 2, ' ', 'edit', ' ', ' ', 1, 1, '6c53b9bef858436d95d9059b38fb3c91', '/1/16133/16008/16074/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16076, '我的菜单', 0, 16008, 2, ' ', ' ', ' ', ' ', 1, 1, '293b03dae2b04e0d92311813db63008d', '/1/16133/16008/16076/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16077, '菜单-刷新', 5, 16008, 2, ' ', 'search', ' ', ' ', 1, 1, 'dda01fb6c49b4e298e8bea849865c77e', '/1/16133/16008/16077/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16079, '可选择的菜单', 6766, 16008, 2, ' ', ' ', ' ', ' ', 1, 1, '5836c7c2fb904b5baaf90e222f26f46f', '/1/16133/16008/16079/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16059, '批量赋权', 6, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '105362faef224973805990c8c113153f', '/1/16133/61/74/16059/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16081, '刷新', 65454, 16008, 2, ' ', 'search', ' ', ' ', 1, 1, 'c7c3bb14ecf14458a0b6ccc2b2a2c5b7', '/1/16133/16008/16081/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16086, '模块访问统计', 111, 16030, 1, 'admin/safeMgr/log/moduleTj.jsp', ' ', '模块访问统计', ' ', 1, 1, 'mkfwtj', '/1/16133/16030/16086/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16087, '模块访问查询', 123, 16030, 1, 'admin/safeMgr/log/moduleSearch.jsp', ' ', '模块访问查询', ' ', 1, 1, 'mkfwcx02', '/1/16133/16030/16087/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16088, '用户访问统计', 134, 16030, 1, 'admin/safeMgr/log/userVisit.jsp', ' ', '用户访问统计', ' ', 1, 1, 'yhfwtj', '/1/16133/16030/16088/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16089, '查询', 1, 16086, 2, ' ', ' ', ' ', ' ', 1, 1, 'fe45c53d5e06469998648a7aaafd39ea', '/1/16133/16030/16086/16089/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16090, '导出', 22, 16086, 2, ' ', ' ', ' ', ' ', 1, 1, 'a6c29cb349304afdb20038c139eb0ed7', '/1/16133/16030/16086/16090/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16092, '查询', 1, 16087, 2, ' ', ' ', ' ', ' ', 1, 1, '86d183557a9f44448d1986162dd43981', '/1/16133/16030/16087/16092/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16093, '导出', 2, 16087, 2, ' ', ' ', ' ', ' ', 1, 1, '9d005b5385864b05943ea2c08770c8d4', '/1/16133/16030/16087/16093/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16094, '查询', 1, 16088, 2, ' ', ' ', ' ', ' ', 1, 1, '8c5cbf06695f4ea0a0081d593b013b2a', '/1/16133/16030/16088/16094/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16095, '导出', 2, 16088, 2, ' ', ' ', ' ', ' ', 1, 1, 'e9d0f645db0247feb15bcfd7bebb1a95', '/1/16133/16030/16088/16095/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16097, '部门人员统计', 135, 16030, 1, 'admin/safeMgr/log/depStaffTj.jsp', ' ', '部门人员统计', ' ', 1, 1, 'bmrytj', '/1/16133/16030/16097/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16098, '查询', 1, 16097, 2, ' ', ' ', ' ', ' ', 1, 1, 'f5e2ecf7e3b445359fb233455cfd86eb', '/1/16133/16030/16097/16098/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16099, '导出', 2, 16097, 2, ' ', ' ', ' ', ' ', 1, 1, 'ba4edb5d950a4d1ba7265af775fb6bda', '/1/16133/16030/16097/16099/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16008, '菜单自定义', 125, 16133, 1, 'admin/safeMgr/menu/selfRight.jsp', ' ', ' ', ' ', 1, 1, '121', '/1/16133/16008/' ) 
go
INSERT INTO dbo.tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16133, '系统管理', 4, 1, 1, ' ', 'safte', ' ', ' ', 1, 1, 'safe', '/1/16133/' ) 
go
INSERT INTO tbOsRight (iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId)
  VALUES(102132, 'IP黑白名单', 9, 61, 1, 'admin/safeMgr/ipRight/index.jsp', ' ', 'IP黑白名单', ' ', 1, 1, '159baf5647964643b53a970f18e79a8d', '/1/61/12634600/')
INSERT INTO tbOsRight (iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId)
  VALUES(102131, '账号变更日志', 41, 16031, 1, 'admin/safeMgr/log/operateLog.jsp', ' ', '账号变更日志', ' ', 1, 1, '56f5e80670c444659e6e455d9d6f9a7e', '/1/61/16031/12634400/')

/*防SQL注入枚举数据*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'drop ', ' ｄｒｏｐ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'create ', ' ｃｒｅａｔｅ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'exec ', ' ｅｘｅｃ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'insert ', ' ｉｎｓｅｒｔ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'select ', ' ｓｅｌｅｃｔ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)  VALUES('Defense_SQL_Injection', 'invalidString', 'delete ', ' ｄｅｌｅｔｅ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)  VALUES('Defense_SQL_Injection', 'invalidString', 'update ', ' ｕｐｄａｔｅ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', ' or ', ' ｏｒ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', ' and ', ' ａｎｄ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'truncate ', ' ｔｒｕｎｃａｔｅ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'execute ', ' ｅｘｅｃｕｔｅ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'grant ', ' ｇｒａｎｔ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'use ', ' ｕｓｅ ', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'group_concat ', ' ｇｒｏｕｐ＿ｃｏｎｃａｔ ', 1, NULL, 1)
/*防SQL注入放开的URL*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'allow', '1', '/fastDfs!', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'allow', '2', '/commonEnum!', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'allow', '3', 'ctEnumTbl!', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'allow', '4', '/commonModule/fastDevelop/', 1, NULL, 1)

/*防Xss攻击枚举数据*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '+', '＋', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '%', '％', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '"', '＂', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '>', '＞', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '(', '（', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '''', '＇＇', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '<', '＜', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', ')', '）', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '&', '＆', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', ';', '；', 1, NULL, 1)

/*防XSS放开的URL*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '1', '/commonModule/fastDevelop/', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '2', '/commonEnum!getEnumMeaning.action', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '3', '/fastDfs/', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '4', '/dgtTableFields!', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '5', '/commonModule/dgt', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '6', 'enumMgr!', 1, NULL, 1);

/*密码取回问题*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)	VALUES('Retrieve_Password', 'Question', '1', '你读的小学名称？', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Retrieve_Password', 'Question', '2', '你母亲的名字？', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Retrieve_Password', 'Question', '3', '你父亲的名字？', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Retrieve_Password', 'Question', '4', '自定义问题', 1, NULL, 1)

/*IP黑白名单枚举*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)	VALUES('tbOsIpRight', 'iObjType', '1', '账号', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)	VALUES('tbOsIpRight', 'iObjType', '2', '权限', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)	VALUES('tbOsIpRight', 'iListType', '1', '白名单', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)	VALUES('tbOsIpRight', 'iListType', '2', '黑名单', 1, NULL, 1)

--修改密码、锁定解锁日志对象枚举
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)	VALUES('tbOsOperateLog', 'iOptObjType', '1', '账号', 1, NULL, 1)
	
--修改密码、锁定解锁日志类型枚举
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '2', '修改密码', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '4', '自动锁定', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '5', '自动解锁', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '6', '手动锁定', 1, NULL, 1)
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '7', '手动解锁', 1, NULL, 1)
