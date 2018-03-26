CREATE TABLE tbLogFileInfo
(
   iLogId numeric(15,0) NOT NULL primary key,
   sLogPattern varchar(50),
   sLogFileIp varchar(32),
   sLogFilePath varchar(128),
   iSizeCount numeric(15,0),
   iStatus numeric(15,0),
   dFileCreateTime datetime,
   sSystemName varchar(32)
)

CREATE TABLE tbExceptionLog
(
   iId numeric(15,0) PRIMARY KEY NOT NULL,
   sMd5 varchar(64),
   dThrowTime datetime NOT NULL,
   iStaffId numeric(15,0),
   sStaffAccount varchar(32),
   sStaffName varchar(32),
   sSysExceptionName text,
   sSysExceptionMessage text,
   sSelfExceptionMessage text,
   sPath text,
   sParams text,
   sDataSource varchar(32),
   sSql text,
   sUrl varchar(255),
   iActionId numeric(15,0),
   iCostTime int,
   iRightId numeric(15,0) null,
   iBtnRightId numeric(15,0) null,
   sContent varchar(512) null,
   sSystemName varchar(32),
   sReferer varchar(256)
)

CREATE TABLE tbJdbcLog
(
   iId numeric(15,0) PRIMARY KEY NOT NULL,
   sMd5 varchar(64),
   sSql text,
   iCostTime int,
   iRowCount int,
   sDataSource varchar(32),
   dInsertTime datetime NOT NULL,
   sPath text,
   sRemark text,
   sSystemName varchar(32)
)

CREATE TABLE tbActionRelRight
(
   iActionId numeric(15,0) PRIMARY KEY NOT NULL,
   sActionName varchar(128) NOT NULL,
   sMethodName varchar(64) NOT NULL,
   iRightId numeric(15,0),
   iBtnRightId numeric(15,0),
   sContent text
)

CREATE TABLE tbLoginLog
(
   sessionID varchar(50) NOT NULL,
   sLoginName varchar(30),
   sMd5 varchar(64),
   iState smallint,
   dLoginTime datetime NOT NULL,
   dLoginOutTime datetime,
   iLoginSeconds numeric(14,0),
   sBrowserType varchar(30),
   sLoginIP varchar(30),
   sSystemName varchar(32),
   CONSTRAINT PK_TBLOGINLOG PRIMARY KEY (sessionID,dLoginTime)
)

--创建action方法和按钮的关联表
CREATE TABLE TBACTION2RIGHT ( 
    IID     numeric(15,0) PRIMARY KEY NOT NULL,
    IACTIONID    numeric(15,0) NULL, -- 关联按钮对应的action
    IRIGHTID    numeric(15,0) NULL, -- 关联按钮所在模块ID,当无关联状态，该字段为空
    IBTNRIGHTID numeric(15,0) NULL, -- 关联按钮ID,当无关联状态，该字段为空
    SCONTENT    varchar(512) NULL, --关联状态下用来将方法重命名；非关联状态下用来备注
    IRELTYPE    numeric(2,0) NULL, -- -1:无关联 0：标记但未做关联 1：一对一关联 2：一对多关联 
    SREQPARAMNAME varchar(64) NULL,  --一对多关联的时候，用来存参数名
    SBTNPARAMVALUE varchar(128) NULL, --一对多关联的时候，用来存参数和值
    
    SUPDATEUSERNAME varchar(64) NULL, -- 关联配置人员名称
    DUPDATEDATE datetime NULL,  -- 关联配置最后更新时间
    SREMARK varchar(256) NULL -- 备注
);