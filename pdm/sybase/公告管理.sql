--公告信息表
CREATE TABLE dbo.T_BULLETIN_TICKET_INFO
(
    I_BULLETIN_SEG_ID  numeric(15,0) NOT NULL,
    I_IS_SUP           numeric(7,0)  DEFAULT '2'       NOT NULL,
    I_TICKET_STATUS    numeric(7,0)  DEFAULT '1'       NOT NULL,
    I_BULLETIN_STATUS  numeric(7,0)  NULL,
    I_KIND             numeric(7,0)  NULL,
    I_RELATE_ID        numeric(15,0) NULL,
    S_RELATE_URL       varchar(128)  NULL,
    S_CONTENT          varchar(4000) NOT NULL,
    I_RANGE            numeric(7,0)  NOT NULL,
    S_TITLE            varchar(128)  NOT NULL,
    S_CODE             varchar(128)  NOT NULL,
    I_LEVEL            numeric(7,0)  NULL,
    D_BEGIN_DATE       date          NULL,
    D_END_DATE         date          NOT NULL,
    I_NEED_FEEDBACK    numeric(7,0)  DEFAULT '1'       NULL,
    I_APPOINT_DOMAIN   numeric(7,0)  DEFAULT '2'       NULL,
    I_AUDIT_STAFF_ID   numeric(15,0) NULL,
    S_AUDIT_STAFF_NAME varchar(64)   NULL,
    I_DOMAIN_ID        numeric(15,0) NOT NULL,
    S_DOMAIN_NAME      varchar(128)  NULL,
    I_DEPT_ID          numeric(15,0) NULL,
    S_DEPT_NAME        varchar(128)  NULL,
    I_STAFF_ID         numeric(15,0) NULL,
    S_STAFF_NAME       varchar(128)  NULL,
    S_STAFF_TEL        varchar(30)   NULL,
    D_CREATE_DATE      date          DEFAULT 'SYSDATE' NULL,
    D_PIGEONHOLE_DATE  date          NULL,
    S_REMARK           varchar(512)  NULL,
    I_ISSEND_OSS       numeric(1,0)  DEFAULT (0)       NULL,
    I_FLAG_OSS         numeric(1,0)  DEFAULT (0)       NULL,
    S_STAFF_ACCOUNT    varchar(32)   NULL,
    CONSTRAINT T_BULLETIN_5691020872
    PRIMARY KEY CLUSTERED (I_BULLETIN_SEG_ID)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.T_BULLETIN_TICKET_INFO') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.T_BULLETIN_TICKET_INFO >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.T_BULLETIN_TICKET_INFO >>>'
go

--公告审核表
CREATE TABLE dbo.T_PRO_BULLETIN_AUDIT
(
    I_AUDIT_SEG_ID    numeric(15,0) NOT NULL,
    I_BULLETIN_SEG_ID numeric(15,0) NOT NULL,
    I_IS_MIND         numeric(7,0)  NOT NULL,
    S_STAFF_NAME      varchar(128)  NOT NULL,
    I_STAFF_ID        numeric(15,0) NOT NULL,
    S_DEPT_NAME       varchar(128)  NOT NULL,
    I_DEPT_ID         numeric(15,0) NOT NULL,
    S_DOMAN_NAME      varchar(128)  NOT NULL,
    I_DOMAN_ID        numeric(15,0) NOT NULL,
    S_STAFF_TEL       varchar(30)   NOT NULL,
    D_CREATE_DATE     datetime      NOT NULL,
    I_WFINST_ID       numeric(15,0) NOT NULL,
    I_ACTINST_ID      numeric(15,0) NOT NULL,
    I_WORKITEM_ID     numeric(15,0) NOT NULL,
    S_REMARK          varchar(255)  NOT NULL,
    CONSTRAINT PK_T_PRO_BULLETIN_AUDIT
    PRIMARY KEY CLUSTERED (I_AUDIT_SEG_ID)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.T_PRO_BULLETIN_AUDIT') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.T_PRO_BULLETIN_AUDIT >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.T_PRO_BULLETIN_AUDIT >>>'
go

--公告范围表
CREATE TABLE dbo.T_PRO_BULLETIN_RANGE
(
    I_RANGE_SEG_ID    numeric(15,0) NOT NULL,
    I_BULLETIN_SEG_ID numeric(15,0) NULL,
    I_RENGE_TYPE      numeric(7,0)  NULL,
    I_OBJ_ID          numeric(15,0) NULL,
    S_OBJ_NAME        varchar(64)   NULL,
    I_IS_TEMP_DATA    numeric(7,0)  NULL,
    I_DOMAIN_ID       numeric(15,0) NULL,
    S_DOMAIN_NAME     varchar(64)   NULL,
    I_RANGE_MARK      numeric(7,0)  NULL,
    S_REMARK          varchar(512)  NULL,
    CONSTRAINT PK_T_PRO_BULLETIN_RANGE
    PRIMARY KEY NONCLUSTERED (I_RANGE_SEG_ID)
)
LOCK DATAROWS
go
IF OBJECT_ID('dbo.T_PRO_BULLETIN_RANGE') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.T_PRO_BULLETIN_RANGE >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.T_PRO_BULLETIN_RANGE >>>'
go

/*索引*/
CREATE NONCLUSTERED INDEX idx_iBulletinSegId
    ON dbo.T_BULLETIN_TICKET_INFO(I_BULLETIN_SEG_ID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.T_BULLETIN_TICKET_INFO') AND name='idx_iBulletinSegId')
    PRINT '<<< CREATED INDEX dbo.T_BULLETIN_TICKET_INFO.idx_iBulletinSegId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.T_BULLETIN_TICKET_INFO.idx_iBulletinSegId >>>'
go


CREATE NONCLUSTERED INDEX idx_iAuditSegId
    ON dbo.T_PRO_BULLETIN_AUDIT(I_AUDIT_SEG_ID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.T_PRO_BULLETIN_AUDIT') AND name='idx_iAuditSegId')
    PRINT '<<< CREATED INDEX dbo.T_PRO_BULLETIN_AUDIT.idx_iAuditSegId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.T_PRO_BULLETIN_AUDIT.idx_iAuditSegId >>>'
go

CREATE NONCLUSTERED INDEX idx_iRangeSegId
    ON dbo.T_PRO_BULLETIN_RANGE(I_RANGE_SEG_ID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.T_PRO_BULLETIN_RANGE') AND name='idx_iRangeSegId')
    PRINT '<<< CREATED INDEX dbo.T_PRO_BULLETIN_RANGE.idx_iRangeSegId >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX dbo.T_PRO_BULLETIN_RANGE.idx_iRangeSegId >>>'
go

/*基础数据*/
--T_BULLETIN_TICKET_INFO
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 558810, 1, 2, 5, 1, NULL, ' ', '待发布状态', 2, '待发布状态', 'CATT_NO1', 1, '09/27/2011', '11/11/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 1500022542, '网管技术室', 1, '网络监控室测试', '18926239263', '09/27/2011', '11/14/2011', ' ', 0, 1, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 558811, 1, 2, 5, 2, NULL, ' ', '待审核状态', 2, '待审核状态', 'CATT_NO2', 1, '09/27/2011', '11/10/2011', NULL, 2, 1100000621, '陈勃', 1030005, '省公司', 1500022542, '网管技术室', 1, '网络监控室测试', '18926239263', '09/27/2011', '11/11/2011', ' ', 0, 1, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 558812, 1, 2, 5, 3, NULL, ' ', '待发布状态', 2, '待发布状态', 'CATT_NO3', 2, '09/28/2011', '11/12/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 1500022542, '网管技术室', 1, '网络监控室测试', '18926239263', '09/27/2011', '11/14/2011', ' ', 0, 1, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10005134, 1, 1, 5, 5, NULL, ' ', '公告内容', 2, '公告标题5', 'CATT_NO8', 1, '10/27/2011', '11/01/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '10/27/2011', NULL, ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 558854, 1, 2, 5, 3, NULL, ' ', '公告标题1', 2, '公告标题1', 'CATT_NO5', NULL, '09/28/2011', '10/08/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 1500022542, '网管技术室', 1, '网络监控室测试', '18926239263', '09/28/2011', '11/11/2011', ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 558855, 1, 2, 5, 3, NULL, ' ', '公告标题2', 1, '公告标题2', 'CATT_NO6', 1, '09/28/2011', '09/30/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 1500022542, '网管技术室', 1, '网络监控室测试', '18926239263', '09/28/2011', '11/11/2011', ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 558857, 1, 2, 5, 1, NULL, ' ', '公告标题3', 1, '公告标题3', 'CATT_NO7', 1, '09/28/2011', '09/29/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 1500022542, '网管技术室', 1, '网络监控室测试', '18926239263', '09/28/2011', '09/29/2011', ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10005135, 1, 1, 5, 3, NULL, ' ', '公告内容', 2, '公告标题5', 'CATT_NO9', 1, '10/27/2011', '11/02/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '10/27/2011', NULL, ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10005133, 1, 1, 5, 4, NULL, ' ', '公告内公告内容', 2, '公告标题6', 'CATT_NO10', 2, '10/27/2011', '11/01/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '10/27/2011', NULL, ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10005136, 1, 1, 5, 4, NULL, ' ', '公告内容', 2, '公告标题7', 'CATT_NO11', 2, '10/27/2011', '11/01/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '10/27/2011', NULL, ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10005137, 1, 1, 5, 3, NULL, ' ', '公告内容', 2, '公告标题8', 'CATT_NO12', NULL, '10/27/2011', '11/03/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '10/27/2011', NULL, ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10031641, 1, 2, 5, 2, NULL, ' ', '22222', 1, '222', '112', 2, '11/03/2011', '12/02/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '11/03/2011', '12/05/2011', ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10044361, 1, 2, 5, 1, NULL, ' ', 'ww', 1, 'ww', '22', 1, '11/11/2011', '11/11/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '11/11/2011', '11/11/2011', ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10050831, 1, 2, 5, 1, NULL, ' ', '公告内容', 4, '公告标题', 'CATTNO1', 1, '11/15/2011', '11/17/2011', NULL, 1, 1100000621, '陈勃', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '11/15/2011', '11/18/2011', ' ', 0, 0, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10055256, 1, 2, 5, 1, NULL, ' ', '33', 4, '33', '33', 2, '11/16/2011', '11/17/2011', NULL, 1, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '11/16/2011', '11/18/2011', ' ', 0, 0, NULL ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10060560, 1, 2, 5, 4, NULL, ' ', 'rrrr', 1, 'rrrr', 'rrrrr', NULL, '11/18/2011', '11/22/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '11/18/2011', '12/02/2011', ' ', 0, 1, 'nocjktest' ) 
go
INSERT INTO dbo.T_BULLETIN_TICKET_INFO ( I_BULLETIN_SEG_ID, I_IS_SUP, I_TICKET_STATUS, I_BULLETIN_STATUS, I_KIND, I_RELATE_ID, S_RELATE_URL, S_CONTENT, I_RANGE, S_TITLE, S_CODE, I_LEVEL, D_BEGIN_DATE, D_END_DATE, I_NEED_FEEDBACK, I_APPOINT_DOMAIN, I_AUDIT_STAFF_ID, S_AUDIT_STAFF_NAME, I_DOMAIN_ID, S_DOMAIN_NAME, I_DEPT_ID, S_DEPT_NAME, I_STAFF_ID, S_STAFF_NAME, S_STAFF_TEL, D_CREATE_DATE, D_PIGEONHOLE_DATE, S_REMARK, I_ISSEND_OSS, I_FLAG_OSS, S_STAFF_ACCOUNT ) 
		 VALUES ( 10069061, 1, 2, 5, 1, NULL, ' ', 'tttttt', 1, 'tttttt', 'sksk', 1, '11/21/2011', '11/24/2011', NULL, 2, NULL, ' ', 1030005, '省公司', 17, 'test', 1, '网络监控室测试', '18926239263', '11/21/2011', '12/02/2011', ' ', 0, 0, 'nocjktest' ) 
go

--T_PRO_BULLETIN_RANGE
INSERT INTO dbo.T_PRO_BULLETIN_RANGE ( I_RANGE_SEG_ID, I_BULLETIN_SEG_ID, I_RENGE_TYPE, I_OBJ_ID, S_OBJ_NAME, I_IS_TEMP_DATA, I_DOMAIN_ID, S_DOMAIN_NAME, I_RANGE_MARK, S_REMARK ) 
		 VALUES ( 10050832, 10050831, 3, 10001584, '罗德成测试', 2, 1030005, '省公司', 1, NULL ) 
go
INSERT INTO dbo.T_PRO_BULLETIN_RANGE ( I_RANGE_SEG_ID, I_BULLETIN_SEG_ID, I_RENGE_TYPE, I_OBJ_ID, S_OBJ_NAME, I_IS_TEMP_DATA, I_DOMAIN_ID, S_DOMAIN_NAME, I_RANGE_MARK, S_REMARK ) 
		 VALUES ( 10050833, 10050831, 3, 1500025057, '专业公司', 2, 1030005, '省公司', 1, NULL ) 
go
INSERT INTO dbo.T_PRO_BULLETIN_RANGE ( I_RANGE_SEG_ID, I_BULLETIN_SEG_ID, I_RENGE_TYPE, I_OBJ_ID, S_OBJ_NAME, I_IS_TEMP_DATA, I_DOMAIN_ID, S_DOMAIN_NAME, I_RANGE_MARK, S_REMARK ) 
		 VALUES ( 10055259, 10055256, 3, 10001584, '罗德成测试', 2, 1030005, '省公司', 1, NULL ) 
go
INSERT INTO dbo.T_PRO_BULLETIN_RANGE ( I_RANGE_SEG_ID, I_BULLETIN_SEG_ID, I_RENGE_TYPE, I_OBJ_ID, S_OBJ_NAME, I_IS_TEMP_DATA, I_DOMAIN_ID, S_DOMAIN_NAME, I_RANGE_MARK, S_REMARK ) 
		 VALUES ( 10055260, 10055256, 3, 1500025057, '专业公司', 2, 1030005, '省公司', 1, NULL ) 
go
INSERT INTO dbo.T_PRO_BULLETIN_RANGE ( I_RANGE_SEG_ID, I_BULLETIN_SEG_ID, I_RENGE_TYPE, I_OBJ_ID, S_OBJ_NAME, I_IS_TEMP_DATA, I_DOMAIN_ID, S_DOMAIN_NAME, I_RANGE_MARK, S_REMARK ) 
		 VALUES ( 10055261, 10055256, 3, 33412216, '其他', 2, 1010001, '深圳', 1, NULL ) 
go
INSERT INTO dbo.T_PRO_BULLETIN_RANGE ( I_RANGE_SEG_ID, I_BULLETIN_SEG_ID, I_RENGE_TYPE, I_OBJ_ID, S_OBJ_NAME, I_IS_TEMP_DATA, I_DOMAIN_ID, S_DOMAIN_NAME, I_RANGE_MARK, S_REMARK ) 
		 VALUES ( 10055262, 10055256, 3, 134553426, '深圳10000号亚运专席', 2, 1010001, '深圳', 1, NULL ) 
go

--枚举数据
--I_BULLETIN_STATUS
INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_BULLETIN_STATUS', '1', '待审核', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_BULLETIN_STATUS', '2', '待修改', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_BULLETIN_STATUS', '3', '待发布', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_BULLETIN_STATUS', '4', '已发布', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_BULLETIN_STATUS', '5', '已结束', 1, NULL, 1)
go

--I_KIND
INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_KIND', '1', '故障公告', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_KIND', '2', '检修公告', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_KIND', '3', '事件公告', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_KIND', '4', '新闻公告', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_KIND', '5', '预警公告', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_KIND', '6', '管理公告', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_KIND', '7', '其他公告', 1, NULL, 1)
go

--I_LEVEL
INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_LEVEL', '1', '重要', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_LEVEL', '2', '普通', 1, NULL, 1)
go

--I_RANGE
INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_RANGE', '1', '全省范围', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_RANGE', '2', '公司内部', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_RANGE', '3', '部门内部', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_BULLETIN_TICKET_INFO', 'I_RANGE', '4', '其他', 1, NULL, 1)
go

--I_IS_MIND
INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_PRO_BULLETIN_AUDIT', 'I_IS_MIND', '1', '通过', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_PRO_BULLETIN_AUDIT', 'I_IS_MIND', '2', '回退', 1, NULL, 1)
go

INSERT INTO dbo.tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) 
	VALUES('T_PRO_BULLETIN_AUDIT', 'I_IS_MIND', '3', '撤销', 1, NULL, 1)
go