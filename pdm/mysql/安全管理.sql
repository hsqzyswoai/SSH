CREATE TABLE `tbosdepartment` (
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `sDeptName` VARCHAR(255) NOT NULL,
  `sDispName` VARCHAR(255) NOT NULL,
  `sShortName` VARCHAR(64) DEFAULT NULL,
  `sDeptCode` VARCHAR(64) DEFAULT NULL,
  `iParentId` DECIMAL(15,0) DEFAULT NULL,
  `iDelFlag` INT(11) DEFAULT '0',
  `dCreateDate` DATETIME NOT NULL,
  `iCreateStaffId` DECIMAL(15,0) NOT NULL,
  `dLastModify` DATETIME DEFAULT NULL,
  `iLastModifyStaffId` DECIMAL(15,0) DEFAULT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `sGuid` VARCHAR(16) DEFAULT NULL,
  `sPathId` VARCHAR(128) DEFAULT NULL,
  `iDeptType` SMALLINT(6) DEFAULT '0',
  `iAgCompanyId` DECIMAL(15,0) DEFAULT NULL,
  `iIsSynch` SMALLINT(6) DEFAULT '0',
  `sUUVOrgID` VARCHAR(12) DEFAULT NULL,
  `sDispName_zte` VARCHAR(255) DEFAULT NULL,
  `sDataSrc` VARCHAR(255) DEFAULT NULL,
  `iDeptId_zte` DECIMAL(15,0) DEFAULT NULL,
  `iIsDutyDept` SMALLINT(6) NOT NULL DEFAULT '1',
  `sCityCode` VARCHAR(100) DEFAULT NULL,
  `iRegionId` DECIMAL(15,0) DEFAULT NULL,
  `iSortIndex` INT(11) NOT NULL DEFAULT '0',
  `iDeptLevel` INT(11) DEFAULT NULL,
  PRIMARY KEY (`iDeptId`),
  KEY `tbOsDepartment_iParentId` (`iParentId`),
  KEY `tbOsDepartment_sPathId` (`sPathId`),
  KEY `tbOsDepartment_iDomainId` (`iDomainId`),
  KEY `tbOsDepartment_sUUVOrgID` (`sUUVOrgID`),
  KEY `tbOsDepartment_iIsDutyDept` (`iIsDutyDept`),
  KEY `tbOsDepartment_sGuid` (`sGuid`),
  KEY `tbOsDepartment_sCityCode` (`sCityCode`),
  KEY `tbOsDepartment_iRegionId` (`iRegionId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosdomain` (
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `sDomainName` VARCHAR(32) NOT NULL,
  `iDomainType` SMALLINT(6) NOT NULL,
  `sDomainCode` VARCHAR(32) DEFAULT NULL,
  `iParentId` DECIMAL(15,0) DEFAULT NULL,
  `iSequence` DECIMAL(15,0) DEFAULT NULL,
  `sPathId`    VARCHAR(255) DEFAULT NULL,
  `sRelateId` VARCHAR(32)  NULL,
  PRIMARY KEY (`iDomainId`),
  KEY `tbOsDomain_sDomainName` (`sDomainName`),
  KEY `tbOsDomain_sDomainCode` (`sDomainCode`),
  KEY `tbOsDomain_iParentId` (`iParentId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbospost` (
  `iPostId` DECIMAL(15,0) NOT NULL,
  `sPostName` VARCHAR(32) NOT NULL,
  `sShortName` VARCHAR(32) DEFAULT NULL,
  `sPostCode` VARCHAR(32) DEFAULT NULL,
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `iDelFlag` INT(11) NOT NULL,
  `dCreateDate` DATETIME NOT NULL,
  `iCreateStaffId` DECIMAL(15,0) NOT NULL,
  `dLastMofidy` DATETIME DEFAULT NULL,
  `iLastModifyStaffId` DECIMAL(15,0) DEFAULT NULL,
  PRIMARY KEY (`iPostId`),
  KEY `tbOsPost_iDeptId` (`iDeptId`),
  KEY `tbOsPost_iDomainId` (`iDomainId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbospostrelright` (
  `iPostId` DECIMAL(15,0) NOT NULL,
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `iRightId` DECIMAL(15,0) NOT NULL,
  PRIMARY KEY (`iPostId`,`iDeptId`,`iDomainId`,`iRightId`),
  KEY `tbOsPostRelRight_iPostId` (`iPostId`),
  KEY `tbOsPostRelRight_iDeptId` (`iDeptId`),
  KEY `tbOsPostRelRight_iDomainId` (`iDomainId`),
  KEY `tbOsPostRelRight_iRightId` (`iRightId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbospostrelstaff` (
  `iPostId` DECIMAL(15,0) NOT NULL,
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `iStaffId` DECIMAL(15,0) NOT NULL,
  `iTitleId` DECIMAL(15,0) DEFAULT NULL,
  PRIMARY KEY (`iPostId`,`iStaffId`),
  KEY `tbOsPostRelStaff_iPostId` (`iPostId`),
  KEY `tbOsPostRelStaff_iDeptId` (`iDeptId`),
  KEY `tbOsPostRelStaff_iStaffId` (`iStaffId`),
  KEY `tbOsPostRelStaff_iTitleId` (`iTitleId`),
  KEY `tbOsPostRelStaff_iDomainId` (`iDomainId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosright` (
  `iRight` DECIMAL(15,0) NOT NULL,
  `sRightName` VARCHAR(225) NOT NULL,
  `iSeq` INT(11) NOT NULL,
  `iParentId` DECIMAL(15,0) DEFAULT NULL,
  `iType` INT(11) DEFAULT NULL,
  `sURL` VARCHAR(255) DEFAULT NULL,
  `sIcon` VARCHAR(64) DEFAULT NULL,
  `sRemark` VARCHAR(255) DEFAULT NULL,
  `sGuid` VARCHAR(16) DEFAULT NULL,
  `iStatus` TINYINT(4) DEFAULT '1',
  `iAppFor` TINYINT(4) DEFAULT '2',
  `sPathId` VARCHAR(255) DEFAULT NULL,
  `sRightNo` VARCHAR(32) NOT NULL DEFAULT '',
  `sCompId` VARCHAR(64) DEFAULT NULL,
  `sExInfo` VARCHAR(3000) DEFAULT NULL,
  `iIsSensitive` TINYINT(4) DEFAULT NULL,
  PRIMARY KEY (`iRight`),
  UNIQUE KEY `NONCLUSTERED` (`sRightNo`),
  KEY `tbOsRight_sRightName` (`sRightName`),
  KEY `tbOsRight_iParentId` (`iParentId`),
  KEY `tbOsRight_sGuid` (`sGuid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosrole` (
  `sRoleName` VARCHAR(32) NOT NULL,
  `dCreateDate` DATETIME NOT NULL,
  `sGuid` VARCHAR(16) DEFAULT NULL,
  `iRoleId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `iCreateStaffId` DECIMAL(15,0) NOT NULL,
  `iAppFor` TINYINT(4) DEFAULT '2',
  `sPathId` VARCHAR(300) DEFAULT NULL,
  `iParentId` DECIMAL(15,0) DEFAULT NULL,
  `sRemark` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`iRoleId`),
  KEY `tbOsRole_iDomainId` (`iDomainId`),
  KEY `tbOsRole_sGuid` (`sGuid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosrolereldept` (
  `iRoleId` DECIMAL(15,0) NOT NULL,
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `iRight` DECIMAL(15,0) NOT NULL,
  PRIMARY KEY (`iRoleId`,`iDeptId`,`iRight`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosrolereldomain` (
  `iRoleId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `iRight` DECIMAL(15,0) NOT NULL,
  PRIMARY KEY (`iRoleId`,`iDomainId`,`iRight`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosrolerelright` (
  `iRoleId` DECIMAL(15,0) NOT NULL,
  `iRightId` DECIMAL(15,0) NOT NULL,
  `iMenuType` INT(11) DEFAULT NULL,
  PRIMARY KEY (`iRoleId`,`iRightId`),
  KEY `tbOsRoleRelRight_iRoleId` (`iRoleId`),
  KEY `tbOsRoleRelRight_iRightId` (`iRightId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosstaff` (
  `iStaffId` DECIMAL(15,0) NOT NULL,
  `sStaffName` VARCHAR(32) NOT NULL,
  `sStaffNo` VARCHAR(32) NOT NULL,
  `sStaffAccount` VARCHAR(32) NOT NULL,
  `sPassword` VARCHAR(32) NOT NULL,
  `sTelphone` VARCHAR(16) DEFAULT NULL,
  `sMobile` VARCHAR(16) DEFAULT NULL,
  `cCDMA` VARCHAR(16) DEFAULT NULL,
  `sPHS` VARCHAR(16) DEFAULT NULL,
  `sOutEmail` VARCHAR(64) DEFAULT NULL,
  `sInEmail` VARCHAR(64) DEFAULT NULL,
  `sFaxCode` VARCHAR(16) DEFAULT NULL,
  `dAvailBeginDate` DATETIME NOT NULL,
  `dAvailEndDate` DATETIME NOT NULL,
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `iTitleId` DECIMAL(15,0) NOT NULL,
  `iDelFlag` INT(11) NOT NULL DEFAULT '0',
  `dCreateDate` DATETIME NOT NULL,
  `iCreateStaffId` DECIMAL(15,0) NOT NULL,
  `dLastModify` DATETIME DEFAULT NULL,
  `iLastModifyStaffId` DECIMAL(15,0) DEFAULT NULL,
  `sGuid` VARCHAR(16) DEFAULT NULL,
  `iKnowledge` SMALLINT(6) DEFAULT NULL,
  `dBirthday` DATE DEFAULT NULL,
  `dEntryDate` DATE DEFAULT NULL,
  `sRemark` VARCHAR(255) DEFAULT NULL,
  `sLongevity` VARCHAR(64) DEFAULT NULL,
  `sMaintInfo` VARCHAR(255) DEFAULT NULL,
  `sWorkLoc` VARCHAR(255) DEFAULT NULL,
  `sTrainingInfo` VARCHAR(255) DEFAULT NULL,
  `iIsSynch` SMALLINT(6) DEFAULT '0',
  `sUUVUserID` VARCHAR(12) DEFAULT NULL,
  `iEiacDeptId` DECIMAL(15,0) DEFAULT NULL,
  `iStaffAccountId` DECIMAL(6,0) DEFAULT NULL,
  `sPasswordId` VARCHAR(32) DEFAULT NULL,
  `iPubAccount` SMALLINT(6) DEFAULT NULL,
  `iLeaderId` DECIMAL(15,0) DEFAULT NULL,
  `dUpdatePassTime` DATETIME DEFAULT NULL,
  `iDeptLevel` INT(11) DEFAULT NULL,
  `iMenuType` INT(11) DEFAULT NULL,
  `sPwdQuestion`	   VARCHAR(64) DEFAULT  NULL,
  `sCustomQuestion`	 VARCHAR(64)  DEFAULT NULL,
  `sPwdAnswer`		   VARCHAR(64)   NULL,
  `iErrorTime`		   INT		DEFAULT 0 NULL,
  `dErrorDate`		   DATE		NULL,
  `iSex` INT DEFAULT 1 NOT NULL,
  `sCard`	 VARCHAR(32)   DEFAULT NULL,
  `sSpecIds` varchar2(256) DEFAULT null,
  `sSpecNames`  varchar2(256) DEFAULT null, 
  PRIMARY KEY (`iStaffId`),
  UNIQUE KEY `NONCLUSTERED` (`sStaffAccount`),
  KEY `tbOsStaff_sStaffName` (`sStaffName`),
  KEY `tbOsStaff_iDeptId` (`iDeptId`),
  KEY `tbOsStaff_iDomainId` (`iDomainId`),
  KEY `tbOsStaff_iTitleId` (`iTitleId`),
  KEY `tbOsStaff_sGuid` (`sGuid`),
  KEY `tbOsStaff_sUUVUserID` (`sUUVUserID`),
  KEY `tbOsStaff_sMobile` (`sMobile`),
  KEY `tbOsStaff_cCDMA` (`cCDMA`),
  KEY `tbOsStaff_iStaffAccountId` (`iStaffAccountId`),
  KEY `tbOsStaff_sPasswordId` (`sPasswordId`),
  KEY `tbOsStaff_iPubAccount` (`iPubAccount`),
  KEY `tbOsStaff_sPHS` (`sPHS`),
  KEY `Index_dUpdatePassTime` (`dUpdatePassTime`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosstaffreldept` (
  `iStaffId` DECIMAL(15,0) NOT NULL,
  `iDeptId` DECIMAL(15,0) NOT NULL,
  PRIMARY KEY (`iStaffId`,`iDeptId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosstaffrelright` (
  `iStaffId` DECIMAL(15,0) NOT NULL,
  `iRightId` DECIMAL(15,0) NOT NULL,
  PRIMARY KEY (`iStaffId`,`iRightId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosstaffrelrole` (
  `iStaffId` DECIMAL(15,0) NOT NULL,
  `iRoleId` DECIMAL(15,0) NOT NULL,
  `iTitleId` DECIMAL(15,0) DEFAULT NULL,
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `iCreateStaffId` DECIMAL(15,0) DEFAULT NULL,
  `iType` SMALLINT(6) NOT NULL DEFAULT '0',
  `sRemark`    VARCHAR(128) DEFAULT NULL,
  PRIMARY KEY (`iStaffId`,`iRoleId`,`iType`),
  KEY `tbOsStaffRelRole_iStaffId` (`iStaffId`),
  KEY `tbOsStaffRelRole_iRoleId` (`iRoleId`),
  KEY `tbOsStaffRelRole_iTitleId` (`iTitleId`),
  KEY `tbOsStaffRelRole_iDeptId` (`iDeptId`),
  KEY `tbOsStaffRelRole_iDomainId` (`iDomainId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbosteamrelstaff` (
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `iObjId` DECIMAL(15,0) NOT NULL,
  `iObjType` SMALLINT(6) DEFAULT '0',
  PRIMARY KEY (`iDeptId`,`iObjId`),
  KEY `tbOsTeamRelStaff_iDeptId` (`iDeptId`),
  KEY `tbOsTeamRelStaff_iObjId` (`iObjId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbostitle` (
  `iTitleId` DECIMAL(15,0) NOT NULL,
  `sTitleName` VARCHAR(32) NOT NULL,
  `sTitleShortName` VARCHAR(32) DEFAULT NULL,
  `sTitleCode` VARCHAR(32) DEFAULT NULL,
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  `iDelFlag` INT(11) NOT NULL,
  `iSeq` INT(11) NOT NULL,
  `dCreateDate` DATETIME NOT NULL,
  `iCreateStaffId` DECIMAL(15,0) NOT NULL,
  `dLastMofidy` DATETIME DEFAULT NULL,
  `iLastModifyStaffId` DECIMAL(15,0) DEFAULT NULL,
  `sGuid` VARCHAR(16) DEFAULT NULL,
  `iIsSynch` SMALLINT(6) DEFAULT '0',
  `sUUVTitleID` VARCHAR(12) DEFAULT NULL,
  PRIMARY KEY (`iTitleId`),
  KEY `tbOsTitle_iDeptId` (`iDeptId`),
  KEY `tbOsTitle_iDomainId` (`iDomainId`),
  KEY `tbOsTitle_sGuid` (`sGuid`),
  KEY `tbOsTitle_sUUVTitleID` (`sUUVTitleID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbuimenugrp` (
  `iMenuGrpId` DECIMAL(15,0) NOT NULL,
  `sMenuGrpName` VARCHAR(32) NOT NULL,
  `iPGrpId` DECIMAL(15,0) DEFAULT NULL,
  `iSeq` INT(11) NOT NULL DEFAULT '1',
  `iType` INT(11) NOT NULL DEFAULT '1',
  `iStaffId` DECIMAL(15,0) NOT NULL,
  `iDeptId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) NOT NULL,
  PRIMARY KEY (`iMenuGrpId`),
  KEY `tbUIMenuGrp_iStaffId` (`iStaffId`),
  KEY `tbUIMenuGrp_iDeptId` (`iDeptId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbuimgrp2right` (
  `iId` DECIMAL(15,0) NOT NULL,
  `iMenuGrpId` DECIMAL(15,0) NOT NULL,
  `iRight` DECIMAL(15,0) NOT NULL,
  `sDspName` VARCHAR(32) DEFAULT NULL,
  `iSeq` INT(11) DEFAULT '0',
  PRIMARY KEY (`iId`),
  KEY `tbUIMGrp2Right_iRight` (`iRight`),
  KEY `tbUIMGrp2Right_iMenuGrpId` (`iMenuGrpId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbwfactorcatalog` (
  `iCataId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) DEFAULT NULL,
  `sDomainName` VARCHAR(32) DEFAULT NULL,
  `iDeptId` DECIMAL(15,0) DEFAULT NULL,
  `sDeptName` VARCHAR(128) DEFAULT NULL,
  `iStaffId` DECIMAL(15,0) DEFAULT NULL,
  `sStaffName` VARCHAR(32) DEFAULT NULL,
  `dCreatetime` DATETIME NOT NULL,
  `sWfCode` VARCHAR(128) NOT NULL,
  `iWfId` DECIMAL(15,0) DEFAULT NULL,
  `sWfName` VARCHAR(64) NOT NULL,
  `sRemark` VARCHAR(255) DEFAULT NULL,
  `iOrderby` INT(11) NOT NULL,
  PRIMARY KEY (`iCataId`),
  KEY `tbWfActorCatalog_iDomainId` (`iDomainId`),
  KEY `tbWfActorCatalog_iDeptId` (`iDeptId`),
  KEY `tbWfActorCatalog_iStaffId` (`iStaffId`),
  KEY `tbWfActorCatalog_iWfId` (`iWfId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbwfactordefinition` (
  `iActorId` DECIMAL(15,0) NOT NULL,
  `iModuleId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) DEFAULT NULL,
  `sDomainName` VARCHAR(32) DEFAULT NULL,
  `iDeptId` DECIMAL(15,0) DEFAULT NULL,
  `sDeptName` VARCHAR(128) DEFAULT NULL,
  `iStaffId` DECIMAL(15,0) DEFAULT NULL,
  `sStaffName` VARCHAR(32) DEFAULT NULL,
  `dCreatetime` DATETIME NOT NULL,
  `iActorType` SMALLINT(6) NOT NULL,
  `sActorIdValue` VARCHAR(64) NOT NULL,
  `sActorNameValue` VARCHAR(128) NOT NULL,
  `sActorDispName` VARCHAR(128) NOT NULL,
  `iActorDomainId` DECIMAL(15,0) DEFAULT NULL,
  `sActorDomainName` VARCHAR(32) DEFAULT NULL,
  `iActorDeptId` DECIMAL(15,0) DEFAULT NULL,
  `sActorDeptName` VARCHAR(128) DEFAULT NULL,
  `iActorStaffId` DECIMAL(15,0) DEFAULT NULL,
  `sActorStaffName` VARCHAR(32) DEFAULT NULL,
  `sPhone` VARCHAR(64) DEFAULT NULL,
  `iOrderby` INT(11) NOT NULL,
  `iParentId` DECIMAL(15,0) NOT NULL,
   `iModeratorID` DECIMAL(15,0) DEFAULT null,
  `sModeratorName`  varchar(32)  DEFAULT null,
  PRIMARY KEY (`iActorId`),
  KEY `tbWfActorDefinition_iModuleId` (`iModuleId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `tbwfactormodule` (
  `iModuleId` DECIMAL(15,0) NOT NULL,
  `iDomainId` DECIMAL(15,0) DEFAULT NULL,
  `sDomainName` VARCHAR(32) DEFAULT NULL,
  `iDeptId` DECIMAL(15,0) DEFAULT NULL,
  `sDeptName` VARCHAR(128) DEFAULT NULL,
  `iStaffId` DECIMAL(15,0) DEFAULT NULL,
  `sStaffName` VARCHAR(32) DEFAULT NULL,
  `dCreatetime` DATETIME NOT NULL,
  `iCataId` DECIMAL(15,0) NOT NULL,
  `sModuleCode` VARCHAR(64) NOT NULL,
  `sModuleName` VARCHAR(64) NOT NULL,
  `sRemark` VARCHAR(255) DEFAULT NULL,
  `iOrderby` INT(11) NOT NULL,
  `iSetType` SMALLINT(6) DEFAULT '1',
  PRIMARY KEY (`iModuleId`),
  KEY `tbWfActorModule_iCataId` (`iCataId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/*IP黑白明单*/
CREATE TABLE tbOsIPRight
(
  iIPId    NUMERIC(15,0) NOT NULL PRIMARY KEY ,
  iObjType  SMALLINT NOT NULL,
  iObjId    NUMERIC(15,0) NOT NULL,
  iListType  SMALLINT NOT NULL,
  sIP      VARCHAR(1024) NOT NULL,
  sRemark    VARCHAR(255)  NULL
);
CREATE INDEX tbOsIPRight_iObjId ON tbOsIPRight (iObjId);

/*账号更新日志*/
CREATE TABLE tbOsOperationNote  (
   iOptId             NUMERIC(15,0)                    NOT NULL PRIMARY KEY, 
   iOptObjId          NUMERIC(15,0)                    NOT NULL,
   iOptObjType        SMALLINT                        NOT NULL,
   iOptType           SMALLINT                        NOT NULL,
   sOptJson           VARCHAR(4000) NULL,
   sOptMsg            VARCHAR(255) NULL,
   sIP          VARCHAR(255) NULL,
   iUserId            NUMERIC(15,0) NULL,
   sUserName          VARCHAR(32) NULL,
   sAccount           VARCHAR(32) NULL,
   iUserDeptId        NUMERIC(15,0) NULL,
   sUserDeptName      VARCHAR(32) NULL,
   iUserDomainId      NUMERIC(15,0) NULL,
   sUserDomainName    VARCHAR(32) NULL,
   dOptDate           DATETIME                          NOT NULL
);
CREATE INDEX tbOsOperationNote_iOptObjId ON tbOsOperationNote (iOptObjId);
CREATE INDEX tbOsOperationNote_dOptDate ON tbOsOperationNote (dOptDate);
CREATE INDEX tbOsON_iUserDomainId ON tbOsOperationNote (iUserDomainId); 

/**基础数据**********************/
/*自定义首页菜单*/
INSERT INTO tbUIMenuGrp ( iMenuGrpId, sMenuGrpName, iPGrpId, iSeq, iType, iStaffId, iDeptId, iDomainId ) 
		VALUES ( 1, '我的根目录', NULL, 1, 1, 1, 1, 1030005 ); 
/*自定义区域*/
INSERT INTO tbOsDomain ( iDomainId, sDomainName, iDomainType, sDomainCode, iParentId ) 
		 VALUES ( 1030005, '省公司', 1, 'CT', 1000000 );
/*部门*/
INSERT INTO tbOsDepartment ( iDeptId, sDeptName, sDispName, sShortName, sDeptCode, iParentId, iDelFlag, dCreateDate, iCreateStaffId, dLastModify, iLastModifyStaffId, iDomainId, sGuid, sPathId, iDeptType, iAgCompanyId, iIsSynch, sUUVOrgID, sDispName_zte, sDataSrc, iDeptId_zte, iIsDutyDept, sCityCode, iRegionId, iSortIndex ) 
		 VALUES (1, '网络监控室', '/网络监控室/', ' ', NULL, 0, 0, '2009-03-24 03:45:07', 1, '2009-03-24 10:44:04', NULL, 1030005, NULL, '/0/1/', 0, NULL, 1, 'OR1500022546', '中国电信广东分公司/省网络操作维护中心/网络监控室', NULL, 103000500000018, 1, NULL, NULL, 0 ) 
;
/*职位*/
INSERT INTO tbOsTitle ( iTitleId, sTitleName, sTitleShortName, sTitleCode, iDeptId, iDomainId, iDelFlag, iSeq, dCreateDate, iCreateStaffId, dLastMofidy, iLastModifyStaffId, sGuid, iIsSynch, sUUVTitleID ) 
		 VALUES ( 1, '网络监控室职位A', 'titleA', '1', 1, 1030005, 0, 1, '2009-03-24 04:32:17', 140466, NULL, NULL, ' ', NULL, ' ' ) 
;

INSERT INTO tbOsStaff ( iStaffId, sStaffName, sStaffNo, sStaffAccount, sPassword, sTelphone, sMobile, cCDMA, sPHS, sOutEmail, sInEmail, sFaxCode, dAvailBeginDate, dAvailEndDate, iDeptId, iDomainId, iTitleId, iDelFlag, dCreateDate, iCreateStaffId, dLastModify, iLastModifyStaffId, sGuid, iKnowledge, dBirthday, dEntryDate, sRemark, sLongevity, sMaintInfo, sWorkLoc, sTrainingInfo, iIsSynch, sUUVUserID, iEiacDeptId, iStaffAccountId, sPasswordId, iPubAccount, dUpdatePassTime, iLeaderId ) 
		 VALUES ( 1, '网络监控室测试', '1', 'nocjktest', 'c4ca4238a0b923820dcc509a6f75849b', '18926239263', '18926239263', '18926239263', '211323', 'bbb@126.com', 'aaa@126.com', ' ', '2009-03-24 12:00:00', '2030-03-24 12:00:00', 1, 1030005, 1, 0, '2010-04-24 12:10:00', -103000500000999, '2010-04-24 10:53:40', 103000500001239, ' ', 1, '1987-04-24', '1900-01-01', ' ', ' ', ' ', ' ', ' ', 0, ' ', NULL, NULL, ' ', 0, '2010-04-24 10:53:40', NULL ) 
;
/*账号*/
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 1, '权限树', 1, NULL, 1, ' ', 'qwerer', '权限树/', ' ', 1, 1, '1', '/1/' ) 
;
/*权限*/
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 61, '安全管理', 15, 16133, 1, ' ', 'safte', 'admin/safeMgr/safeIndex.html', ' ', 1, 1, '61', '/1/16133/61/' ) 
;

INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 72, '部门人员管理', 1, 61, 1, 'admin/safeMgr/dept/index.jsp', ' ', ' ', ' ', 1, 1, '72', '/1/16133/61/72/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 73, '角色管理', 2, 61, 1, 'admin/safeMgr/role/index.jsp', ' ', ' ', ' ', 1, 1, '73', '/1/16133/61/73/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 74, '权限管理', 3, 61, 1, 'admin/safeMgr/right/right_mgr.jsp', ' ', ' ', ' ', 1, 1, '74', '/1/16133/61/74/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 76, '密码修改', 40, 16031, 1, 'admin/safeMgr/reviseM/revise_pword.jsp', ' ', ' ', ' ', 1, 1, '76', '/1/16133/61/76/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 77, '修改个人信息', 40, 16031, 1, 'admin/safeMgr/staff/staffDetail.jsp', ' ', ' ', ' ', 1, 1, '77', '/1/16031/61/77/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 120, '区域管理', 5, 16133, 1, 'admin/safeMgr/domain/domainIndex.jsp', ' ', ' ', ' ', 1, 1, '120', '/1/16133/120/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 246, '新增', 1, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '149fc50d866d4f06810b88b5d4a7cd67', '/1/16133/61/74/246/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 247, '修改', 2, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '0b4d236b753c4cebbbd89f13bb84135d', '/1/16133/61/74/247/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 248, '删除', 3, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '06a9a8ecd17a464b85705642c792a754', '/1/16133/61/74/248/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 249, '移动', 4, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '699bd647c9e04da9893abcc355c86793', '/1/16133/61/74/249/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 250, '人员', 5, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '1a06a7beebb5490db868273dd707744e', '/1/16133/61/74/250/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 251, '查询', 1, 119, 2, ' ', ' ', ' ', ' ', 1, 1, '6696265cc72f4c39b0f72b705ef4cd7e', '/1/16133/16030/119/251/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 252, '删除', 2, 119, 2, ' ', ' ', ' ', ' ', 1, 1, '3174e48c9ee749919bab177d89c621bc', '/1/16133/16030/119/252/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 253, '新增', 1, 120, 2, ' ', ' ', ' ', ' ', 1, 1, 'b2766d428616425a9128529e7c856159', '/1/16133/120/253/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 254, '修改', 2, 120, 2, ' ', ' ', ' ', ' ', 1, 1, 'e41d37f13f09483ab3c1ec7101981843', '/1/16133/120/254/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 255, '删除', 3, 120, 2, ' ', ' ', ' ', ' ', 1, 1, '3f7e0838be694cccbae9a15c2c921c2a', '/1/16133/120/255/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 256, '移动', 4, 120, 2, ' ', ' ', ' ', ' ', 1, 1, '8f13b1b59032402d97b87cf9c00c1040', '/1/16133/120/256/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 258, '部门-新增', 2, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '0f2e8e850e0f4e44b019cb835e9c880e', '/1/16133/61/72/258/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 259, '部门-修改', 3, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '7525e24a9e4c4f3ba22a3a0d32cc4738', '/1/16133/61/72/259/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 260, '部门-删除', 4, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'a13c5a8d35984d87bc713f8baf77922b', '/1/16133/61/72/260/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 261, '职位-新增', 5, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '6b3c2bcf212546f3bbad454267dfd3f2', '/1/16133/61/72/261/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 262, '职位-修改', 6, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '3aa1848c107a4966b4fafa9328bfc2f3', '/1/16133/61/72/262/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 263, '职位-删除', 7, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'c22ee78301f744f894d8b068a02ed5d2', '/1/16133/61/72/263/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 264, '岗位-新增', 8, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'a415b2a3513f451ea78fb81099abaebe', '/1/16133/61/72/264/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 265, '岗位-修改', 9, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '93949f7256a74c3bbbb2cf0994941ebc', '/1/16133/61/72/265/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 266, '岗位-删除', 10, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '49c797fd1fae4dbab6d6f7f2ed439c51', '/1/16133/61/72/266/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 267, '岗位-新增人员', 11, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '9f22db6ed3b245a1be5f6e6c4a18322c', '/1/16133/61/72/267/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 268, '岗位-删除人员', 12, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '7c4f20c67b474c24b88f9bd8414d26a0', '/1/16133/61/72/268/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 269, '岗位-权限编辑', 13, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '5bf3472bb0a0415c9e5dbcfc9a150c4c', '/1/16133/61/72/269/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 270, '人员-查询', 14, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '0f3fb9e474424f9ebafdaae5469dc88b', '/1/16133/61/72/270/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 271, '人员-新增', 15, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'd0551bcaa7974e92af8cf362f4035d13', '/1/16133/61/72/271/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 272, '人员-修改', 16, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '7e4c67cc582242f1ae0977ff280347eb', '/1/16133/61/72/272/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 273, '人员-删除', 17, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '47910220734b47eda340f0e3e61b47db', '/1/16133/61/72/273/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100412, '人员-锁定', 18, 72, 2, ' ', ' ', ' ', ' ', 1, '3fd7254cc07f43ba8e53ec3ca8f5c66a', '/1/16133/61/72/100412/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100413, '人员-解锁', 18, 72, 2, ' ', ' ', ' ', ' ', 1, '738b2bf967e14bcb856748e788c9d8b5', '/1/16133/61/72/100413/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 274, '人员-初始密码', 18, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'cd93e2b3980d430689a71c1587661602', '/1/16133/61/72/274/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 275, '人员-更改部门', 19, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '4250a80beb394f1bbf39fad62e147fc3', '/1/16133/61/72/275/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 276, '人员-设置领导', 20, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '3dc93d0af3db40dc86a28e73087e62c4', '/1/16133/61/72/276/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 277, '人员-职位-保存', 21, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'a7e52a05b1c144dba0c559705deceda1', '/1/16133/61/72/277/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 278, '人员-岗位-保存', 22, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '7a6b5d9688b84cf8b1053924ce9e1410', '/1/16133/61/72/278/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16134, '界面布局', 0, 16132, 1, ' ', ' ', ' ', ' ', 1, 1, '6d4747c0e19942b2b909effa0704b97e', '/1/16130/16132/16134/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16135, '客户端控件', 1, 16132, 1, ' ', ' ', ' ', ' ', 1, 1, 'a9239b070f8a4370b5fa1e1020a317a4', '/1/16130/16132/16135/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16137, 'fastDFS上下载说明', 2, 16034, 1, 'fastdfs/readme.jsp', ' ', ' ', ' ', 1, 1, 'fastDFS_readMe', '/1/46/16034/16137/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 279, '人员-角色-新增', 23, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '2765df5503294b1393c224cbc1a65fef', '/1/16133/61/72/279/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 280, '人员-角色-删除', 24, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'cb636918c2e14af6ad283cc2a93421d2', '/1/16133/61/72/280/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 281, '人员-直接权限-修改', 25, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '6b984f0fc224414a8535b01220c8d617', '/1/16133/61/72/281/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 282, '人员-业务部门-修改', 26, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '298fa69dfadc43d1ac40bb98347cfe0f', '/1/16133/61/72/282/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 283, '权限-修改', 1, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '46af1e4a1052402d8e675f98d1e6ca17', '/1/16133/61/73/283/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 284, '团队-选择人员', 28, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '6806390b334b4581873db8fc17a190fe', '/1/16133/61/72/284/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 285, '团队-选择部门', 29, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'd980b708047f4ae6adf8f491192fc34a', '/1/16133/61/72/285/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 286, '团队-删除人员', 30, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'a296bea93119435b96ee66df16e2947a', '/1/16133/61/72/286/' ) 
;

INSERT INTO tbOsRight  ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor ) 
VALUES (100401, '人员-群组管理', 445, 72, 2, ' ', ' ', ' ', ' ', 1, 'af232fbe3dd849ca849f534ca6772777', '/1/16133/61/72/100401/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100403, '群组-新增目录', 447, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz001', '/1/16133/61/72/100403/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100404, '群组-新增群组', 448, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz002', '/1/16133/61/72/100404/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100405, '群组-修改目录群组', 449, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz003', '/1/16133/61/72/100405/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100406, '群组-删除目录群组', 450, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz004', '/1/16133/61/72/100406/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100407, '群组-新增群组目录', 451, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz005', '/1/16133/61/72/100407/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100408, '群组-新增部门', 452, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz006', '/1/16133/61/72/100408/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100409, '群组-新增人员', 453, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz007', '/1/16133/61/72/100409/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100410, '群组-修改(目录、部门、人员)', 454, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz008', '/1/16133/61/72/100410/', 1)
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, sRightNo, sPathId, iAppFor )
VALUES (100411, '群组-删除(目录、部门、人员)', 455, 72, 2, ' ', ' ', ' ', ' ', 1, 'qz_xzqz009', '/1/16133/61/72/100411/', 1)
;


INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16032, 'excel导出', 3, 119, 2, ' ', ' ', ' ', ' ', 1, 1, '0a6c8101eaf64835b8043144d8f01b4b', '/1/16133/16030/119/16032/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16033, 'HTC控件', 1, 46, 1, ' ', ' ', ' ', ' ', 1, 1, '111', '/1/46/16033/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16034, '上传与下载', 2, 46, 1, ' ', ' ', ' ', ' ', 1, 1, '112', '/1/46/16034/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 287, '团队-删除部门', 31, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'bc5ac0204add455281389267d51a3ddd', '/1/16133/61/72/287/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 288, '角色-新增', 2, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '7838061175ca4e74bbdb3f03b088b0eb', '/1/16133/61/73/288/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 289, '角色-修改', 3, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '17808779ead441de8194e43736aee0fb', '/1/16133/61/73/289/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 290, '角色-删除', 4, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '044b5976d00d40f4b834e96738495910', '/1/16133/61/73/290/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
         VALUES ( 2901, '角色-复制', 4, 73, 2, ' ', ' ', ' ', ' ', 1, 1, 'd55528e364b44c43a6c93f13a5120fc9', '/1/16133/61/73/2901/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16063, '部门-查询', 1, 72, 2, ' ', ' ', ' ', ' ', 1, 1, '789f393ea3b14eba84949f71d0d9ae59', '/1/16133/61/72/16063/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16061, '人员-员工详情', 444, 72, 2, ' ', ' ', ' ', ' ', 1, 1, 'e9c1a11b54eb4159ac66b2525893b063', '/1/16133/61/72/16061/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16041, '日志接口说明', 116, 16036, 1, 'demo/login/logExample.jsp', ' ', ' ', ' ', 1, 1, '1106', '/1/46/16036/16041/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16067, '权限-批量删权', 5, 73, 2, ' ', ' ', ' ', ' ', 1, 1, '5401886cf8f847b58a331ef04e879fda', '/1/16133/61/73/16067/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16070, '菜单-新增', 1, 16008, 2, ' ', 'ss', ' ', ' ', 1, 1, 'bd05883b70d449b5a773b346dfd37f6d', '/1/16133/16008/16070/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16071, '菜单-修改', 2, 16008, 2, ' ', 'edit', ' ', ' ', 1, 1, '3b74a6ef9a6f44fb9f915ae16be64d21', '/1/16133/16008/16071/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16073, '菜单-删除', 3, 16008, 2, ' ', 'delete', ' ', ' ', 1, 1, '3bb34aa2778e4c0a8248148502bf3dd2', '/1/16133/16008/16073/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16074, '菜单-移动', 4, 16008, 2, ' ', 'edit', ' ', ' ', 1, 1, '6c53b9bef858436d95d9059b38fb3c91', '/1/16133/16008/16074/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16076, '我的菜单', 0, 16008, 2, ' ', ' ', ' ', ' ', 1, 1, '293b03dae2b04e0d92311813db63008d', '/1/16133/16008/16076/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16077, '菜单-刷新', 5, 16008, 2, ' ', 'search', ' ', ' ', 1, 1, 'dda01fb6c49b4e298e8bea849865c77e', '/1/16133/16008/16077/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16079, '可选择的菜单', 6766, 16008, 2, ' ', ' ', ' ', ' ', 1, 1, '5836c7c2fb904b5baaf90e222f26f46f', '/1/16133/16008/16079/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16059, '批量赋权', 6, 74, 2, ' ', ' ', ' ', ' ', 1, 1, '105362faef224973805990c8c113153f', '/1/16133/61/74/16059/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16081, '刷新', 65454, 16008, 2, ' ', 'search', ' ', ' ', 1, 1, 'c7c3bb14ecf14458a0b6ccc2b2a2c5b7', '/1/16133/16008/16081/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16086, '模块访问统计', 111, 16030, 1, 'admin/safeMgr/log/moduleTj.jsp', ' ', '模块访问统计', ' ', 1, 1, 'mkfwtj', '/1/16133/16030/16086/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16087, '模块访问查询', 123, 16030, 1, 'admin/safeMgr/log/moduleSearch.jsp', ' ', '模块访问查询', ' ', 1, 1, 'mkfwcx02', '/1/16133/16030/16087/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16088, '用户访问统计', 134, 16030, 1, 'admin/safeMgr/log/userVisit.jsp', ' ', '用户访问统计', ' ', 1, 1, 'yhfwtj', '/1/16133/16030/16088/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16089, '查询', 1, 16086, 2, ' ', ' ', ' ', ' ', 1, 1, 'fe45c53d5e06469998648a7aaafd39ea', '/1/16133/16030/16086/16089/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16090, '导出', 22, 16086, 2, ' ', ' ', ' ', ' ', 1, 1, 'a6c29cb349304afdb20038c139eb0ed7', '/1/16133/16030/16086/16090/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16092, '查询', 1, 16087, 2, ' ', ' ', ' ', ' ', 1, 1, '86d183557a9f44448d1986162dd43981', '/1/16133/16030/16087/16092/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16093, '导出', 2, 16087, 2, ' ', ' ', ' ', ' ', 1, 1, '9d005b5385864b05943ea2c08770c8d4', '/1/16133/16030/16087/16093/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16094, '查询', 1, 16088, 2, ' ', ' ', ' ', ' ', 1, 1, '8c5cbf06695f4ea0a0081d593b013b2a', '/1/16133/16030/16088/16094/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16095, '导出', 2, 16088, 2, ' ', ' ', ' ', ' ', 1, 1, 'e9d0f645db0247feb15bcfd7bebb1a95', '/1/16133/16030/16088/16095/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16097, '部门人员统计', 135, 16030, 1, 'admin/safeMgr/log/depStaffTj.jsp', ' ', '部门人员统计', ' ', 1, 1, 'bmrytj', '/1/16133/16030/16097/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16098, '查询', 1, 16097, 2, ' ', ' ', ' ', ' ', 1, 1, 'f5e2ecf7e3b445359fb233455cfd86eb', '/1/16133/16030/16097/16098/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16099, '导出', 2, 16097, 2, ' ', ' ', ' ', ' ', 1, 1, 'ba4edb5d950a4d1ba7265af775fb6bda', '/1/16133/16030/16097/16099/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16008, '菜单自定义', 125, 16133, 1, 'admin/safeMgr/menu/selfRight.jsp', ' ', ' ', ' ', 1, 1, '121', '/1/16133/16008/' ) 
;
INSERT INTO tbOsRight ( iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId ) 
		 VALUES ( 16133, '系统管理', 4, 1, 1, ' ', 'safte', ' ', ' ', 1, 1, 'safe', '/1/16133/' ) 
;
/*加两个权限菜单*/
INSERT INTO tbOsRight (iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId)
         VALUES(102132, 'IP黑白名单', 9, 61, 1, 'admin/safeMgr/ipRight/index.jsp', ' ', 'IP黑白名单', ' ', 1, 1, '159baf5647964643b53a970f18e79a8d', '/1/61/12634600/')
;
INSERT INTO tbOsRight (iRight, sRightName, iSeq, iParentId, iType, sURL, sIcon, sRemark, sGuid, iStatus, iAppFor, sRightNo, sPathId)
         VALUES(102131, '账号变更日志', 41, 16031, 1, 'admin/safeMgr/log/operateLog.jsp', ' ', '账号变更日志', ' ', 1, 1, '56f5e80670c444659e6e455d9d6f9a7e', '/1/61/16031/12634400/')
;
/*防SQL注入枚举数据*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'drop ', ' ｄｒｏｐ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'create ', ' ｃｒｅａｔｅ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'exec ', ' ｅｘｅｃ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'insert ', ' ｉｎｓｅｒｔ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'select ', ' ｓｅｌｅｃｔ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)  VALUES('Defense_SQL_Injection', 'invalidString', 'delete ', ' ｄｅｌｅｔｅ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)  VALUES('Defense_SQL_Injection', 'invalidString', 'update ', ' ｕｐｄａｔｅ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', ' or ', ' ｏｒ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', ' and ', ' ａｎｄ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'truncate ', ' ｔｒｕｎｃａｔｅ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'execute ', ' ｅｘｅｃｕｔｅ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'grant ', ' ｇｒａｎｔ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'use ', ' ｕｓｅ ', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'invalidString', 'group_concat ', ' ｇｒｏｕｐ＿ｃｏｎｃａｔ ', 1, NULL, 1);
/*防SQL注入放开的URL*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'allow', '1', '/fastDfs/', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'allow', '2', '/commonEnum!', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'allow', '3', 'ctEnumTbl!', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_SQL_Injection', 'allow', '4', '/commonModule/fastDevelop/fastDe', 1, NULL, 1);

/*防Xss攻击枚举数据*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '+', '＋', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '%', '％', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '"', '＂', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '>', '＞', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '(', '（', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '''', '＇', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '<', '＜', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', ')', '）', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', '&', '＆', 1, NULL, 1);

/*防XSS放开的URL*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '1', '/commonModule/fastDevelop/', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '2', '/commonEnum!getEnumMeaning.action', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '3', '/fastDfs/', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '4', '/dgtTableFields!', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '5', '/commonModule/dgt', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'allow', '6', 'enumMgr!', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Defense_Xss_Attack', 'invalidChar', ';', '；', 1, NULL, 1);

/*密码取回问题*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)	VALUES('Retrieve_Password', 'Question', '1', '你读的小学名称？', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Retrieve_Password', 'Question', '2', '你母亲的名字？', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Retrieve_Password', 'Question', '3', '你父亲的名字？', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('Retrieve_Password', 'Question', '4', '自定义问题', 1, NULL, 1);

/*IP黑白名单枚举*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsIpRight', 'iObjType', '1', '账号', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsIpRight', 'iObjType', '2', '权限', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsIpRight', 'iListType', '1', '白名单', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsIpRight', 'iListType', '2', '黑名单', 1, NULL, 1);

/*修改密码、锁定解锁日志对象枚举*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId)	VALUES('tbOsOperateLog', 'iOptObjType', '1', '账号', 1, NULL, 1);
	
/*修改密码、锁定解锁日志类型枚举*/
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '2', '修改密码', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '4', '自动锁定', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '5', '自动解锁', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '6', '手动锁定', 1, NULL, 1);
INSERT INTO tbCtEnumTbl2 (sEnumTblName, sEnumColName, iEnumValue, sEnumName, isEnabled, sRemark, iDomainId) VALUES('tbOsOperateLog', 'iOptLogType', '7', '手动解锁', 1, NULL, 1);
