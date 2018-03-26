CREATE TABLE dbo.tbDept
(
    iDeptId   numeric(10,0) NOT NULL,
    cDeptName varchar(64)   NOT NULL,
    CONSTRAINT PK_tbDept
    PRIMARY KEY CLUSTERED (iDeptId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbDept') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbDept >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbDept >>>'
go

CREATE TABLE dbo.tbDuty
(
    iDutyId   numeric(10,0) NOT NULL,
    cDutyName varchar(64)   NOT NULL,
    iDeptId   numeric(10,0) NULL,
    CONSTRAINT PK_tbDuty
    PRIMARY KEY CLUSTERED (iDutyId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbDuty') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbDuty >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbDuty >>>'
go

CREATE TABLE dbo.tbEmployee
(
    iEmployeeId      numeric(10,0) NOT NULL,
    cEmployeeName    varchar(64)   NOT NULL,
    iSex             smallint      NOT NULL,
    iDutyId          numeric(10,0) NOT NULL,
    iDeptId          numeric(10,0) NOT NULL,
    iLengthOfService smallint      NOT NULL,
    dEmployDate      datetime      NOT NULL,
    cTel             varchar(20)   NULL,
    remark           varchar(512)  NULL,
    CONSTRAINT PK_tbEmployee
    PRIMARY KEY CLUSTERED (iEmployeeId)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbEmployee') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbEmployee >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbEmployee >>>'
go
CREATE NONCLUSTERED INDEX tbEmployee_iSex
    ON dbo.tbEmployee(iSex)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbEmployee') AND name='tbEmployee_iSex')
    PRINT '<<< CREATED INDEX dbo.tbEmployee.tbEmployee_iSex >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbEmployee.tbEmployee_iSex >>>'
go
CREATE NONCLUSTERED INDEX tbEmployee_iDutyId
    ON dbo.tbEmployee(iDutyId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbEmployee') AND name='tbEmployee_iDutyId')
    PRINT '<<< CREATED INDEX dbo.tbEmployee.tbEmployee_iDutyId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbEmployee.tbEmployee_iDutyId >>>'
go
CREATE NONCLUSTERED INDEX tbEmployee_iDeptId
    ON dbo.tbEmployee(iDeptId)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbEmployee') AND name='tbEmployee_iDeptId')
    PRINT '<<< CREATED INDEX dbo.tbEmployee.tbEmployee_iDeptId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbEmployee.tbEmployee_iDeptId >>>'
go
CREATE NONCLUSTERED INDEX tbEmployee_dEmployDate
    ON dbo.tbEmployee(dEmployDate)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.tbEmployee') AND name='tbEmployee_dEmployDate')
    PRINT '<<< CREATED INDEX dbo.tbEmployee.tbEmployee_dEmployDate >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.tbEmployee.tbEmployee_dEmployDate >>>'
go

CREATE TABLE dbo.tbRight
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
    CONSTRAINT PK_tbOsRight
    PRIMARY KEY CLUSTERED (iRight),
    CONSTRAINT unique_sSRightNo
    UNIQUE NONCLUSTERED (sRightNo)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.tbRight') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.tbRight >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.tbRight >>>'
go


/**��������**********************/
insert  into tbDept(iDeptId,cDeptName) values (1,'�з���');
insert  into tbDept(iDeptId,cDeptName) values(2,'��ǰ��');
insert  into tbDept(iDeptId,cDeptName) values(3,'���²�');
insert  into tbDept(iDeptId,cDeptName) values(4,'��Ʒ��');
insert  into tbDept(iDeptId,cDeptName) values(5,'����');
insert  into tbDept(iDeptId,cDeptName) values(6,'���̲�');


INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 1, '��������', 1 )
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 2, '����������', 1 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 3, '�����Ծ���', 1 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 4, '��Ŀ����������', 1 )
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 5, '�ͻ�����', 2 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 6, '�߼��ͻ�����', 2 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 7, '��ǰ�ܾ���', 2 )
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 8, '������Դ����', 3 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 9, '��������', 3 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 10, '��ǰaְ', 2 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 11, '��ǰbְ', 2 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 12, '��ǰcְ', 2 )
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 13, '��ǰdְ', 2 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 14, '��ǰeְ', 2 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 15, '��ǰfְ', 2 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 16, '��ǰgְ', 2 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 17, '��ǰhְ', 2 ) 
go
INSERT INTO tbDuty ( iDutyId, cDutyName, iDeptId )  VALUES ( 18, '��ǰiְ', 2 ) 
go


insert  into tbEmployee(iEmployeeId,cEmployeeName,iSex,iDeptId,iLengthOfService,dEmployDate,cTel,remark,iDutyId) values (10000430,'AA',1,1,5,'2011-08-22 02:02:00','13322333322','test',1);
insert  into tbEmployee(iEmployeeId,cEmployeeName,iSex,iDeptId,iLengthOfService,dEmployDate,cTel,remark,iDutyId) values (10000431,'BB',1,1,5,'2011-08-22 02:02:00','13322333322','test',1);
insert  into tbEmployee(iEmployeeId,cEmployeeName,iSex,iDeptId,iLengthOfService,dEmployDate,cTel,remark,iDutyId) values (10000432,'CC',1,1,5,'2011-08-22 02:02:00','13322333322','test',1);
insert  into tbEmployee(iEmployeeId,cEmployeeName,iSex,iDeptId,iLengthOfService,dEmployDate,cTel,remark,iDutyId) values (10000433,'DD',1,1,5,'2011-08-22 02:02:00','13322333322','test',1);
insert  into tbEmployee(iEmployeeId,cEmployeeName,iSex,iDeptId,iLengthOfService,dEmployDate,cTel,remark,iDutyId) values (10000434,'EE',1,1,5,'2011-08-22 02:02:00','13322333322','test',1);