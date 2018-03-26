CREATE TABLE tbPubSequence
(
    sTblName    varchar(64)   NOT NULL,
    iCurSquence numeric(15,0) DEFAULT 1 NOT NULL,
    CONSTRAINT PK_TBPUBSEQUENCE
    PRIMARY KEY CLUSTERED (sTblName)
)
LOCK DATAROWS
go

CREATE TABLE tbCtEnumTbl2
(
    sEnumTblName varchar(64)   NOT NULL,
    sEnumColName varchar(64)   NOT NULL,
    iEnumValue   varchar(64)   NOT NULL,
    sEnumName    varchar(64)   NOT NULL,
    isEnabled    smallint      NOT NULL,
    sRemark      varchar(300)  NULL,
    iDomainId    numeric(15,0) NOT NULL
)
LOCK DATAROWS
go
CREATE NONCLUSTERED INDEX tbCtEnumTbl2_sEnumTblName  ON tbCtEnumTbl2(sEnumTblName)
go
CREATE NONCLUSTERED INDEX tbCtEnumTbl2_sEnumColName  ON tbCtEnumTbl2(sEnumColName)
go


CREATE TABLE tbPubFilesUpload
(
    iFileId      numeric(15,0) NOT NULL,
    sTableName   varchar(32)   NOT NULL,
    iTablePKId   numeric(15,0) NOT NULL,
    sNewFileName varchar(128)  NOT NULL,
    sOldFileName varchar(128)  NOT NULL,
    dUploadTime  datetime      NOT NULL,
    cUpStaffName varchar(64)   NULL,
    iUpStaffId   numeric(15,0) NULL,
    cDeptName    varchar(64)   NULL,
    iDeptId      numeric(15,0) NULL,
    iDomainId    numeric(15,0) NULL,
    cSvrFilePath varchar(512)  NULL,
    sFileSize    varchar(32)   NULL,
    iDownTimes   numeric(15,0) NULL
)
LOCK DATAROWS
go
CREATE NONCLUSTERED INDEX tbPubFilesUpload_sNewFileName    ON tbPubFilesUpload(sNewFileName)
go
CREATE NONCLUSTERED INDEX tbPubFilesUpload_cUpStaffName    ON tbPubFilesUpload(cUpStaffName)
go
CREATE NONCLUSTERED INDEX tbPubFilesUpload_cDeptName    ON tbPubFilesUpload(cDeptName)
go
CREATE NONCLUSTERED INDEX tbPubFilesUpload_dUploadTime    ON tbPubFilesUpload(dUploadTime)
go


CREATE TABLE tbSysImg
(
    iId          numeric(15,0) NOT NULL,
    sImgName     varchar(64)   NOT NULL,
    sCss         varchar(128)  NULL,
    sCssFilePath varchar(256)  NULL,
    sImgPath     varchar(256)  NOT NULL,
    sRemark      varchar(256)  NULL,
    sStandard    varchar(64)   NULL,
    sClass       varchar(128)  NULL,
    CONSTRAINT PK_TBSYSIMG
    PRIMARY KEY CLUSTERED (iId)
)
LOCK DATAROWS
go
CREATE NONCLUSTERED INDEX tbSysImg_sImgName    ON tbSysImg(sImgName)
go
CREATE NONCLUSTERED INDEX tbSysImg_sCss    ON tbSysImg(sCss)
go
CREATE NONCLUSTERED INDEX tbSysImg_sCssFilePath    ON tbSysImg(sCssFilePath)
go

/**»ù´¡Êý¾Ý**********************/
INSERT INTO tbPubSequence ( sTblName, iCurSquence ) VALUES ( 'Global', 100 ) 
INSERT INTO tbPubSequence ( sTblName, iCurSquence ) VALUES ( 'Global2', 100000 ) 
