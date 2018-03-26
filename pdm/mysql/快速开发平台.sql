CREATE TABLE `tbdefapplication` (
  `iAppId` decimal(15,0) NOT NULL,
  `sAppName` varchar(255) NOT NULL,
  `iParentAppId` decimal(15,0) DEFAULT NULL,
  `sComment` varchar(255) DEFAULT NULL,
  `sPath` varchar(255) NOT NULL,
  PRIMARY KEY (`iAppId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbdeffield` (
  `iFieldId` decimal(15,0) NOT NULL,
  `iTableId` decimal(15,0) DEFAULT NULL,
  `sFieldName` varchar(128) DEFAULT NULL,
  `sFieldCName` varchar(255) DEFAULT NULL,
  `iIsVisible` smallint(6) DEFAULT NULL,
  `iCanUpdate` smallint(6) DEFAULT NULL,
  `iRequired` smallint(6) DEFAULT NULL,
  `iFieldLength` int(11) DEFAULT NULL,
  `iFloatLength` int(11) DEFAULT NULL,
  `sDefaultValue` varchar(32) DEFAULT NULL,
  `iFieldType` smallint(6) DEFAULT NULL,
  `iIsLimit` smallint(6) DEFAULT NULL,
  `iMinLength` int(11) DEFAULT NULL,
  `iMaxLength` int(11) DEFAULT NULL,
  `iRefType` smallint(6) DEFAULT NULL,
  `sRefFilter` varchar(255) DEFAULT NULL,
  `sRefFunction` varchar(255) DEFAULT NULL,
  `sConstValue` varchar(255) DEFAULT NULL,
  `sVarName` varchar(128) DEFAULT NULL,
  `sFormula` varchar(255) DEFAULT NULL,
  `iIsSqlCond` smallint(6) DEFAULT NULL,
  `sSqlCondType` varchar(32) DEFAULT NULL,
  `iIsSqlSort` smallint(6) DEFAULT NULL,
  `sSqlSortType` varchar(32) DEFAULT NULL,
  `iIsGridHeader` smallint(6) DEFAULT NULL,
  `iIsGridTip` smallint(6) DEFAULT NULL,
  `iIsGridSort` smallint(6) DEFAULT NULL,
  `sReField` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`iFieldId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbdeftable` (
  `iTableId` decimal(15,0) NOT NULL,
  `sTableName` varchar(128) DEFAULT NULL,
  `sTableCName` varchar(255) DEFAULT NULL,
  `sPackageName` varchar(32) DEFAULT NULL,
  `sClassName` varchar(32) DEFAULT NULL,
  `sComment` varchar(128) DEFAULT NULL,
  `sPKField` varchar(128) DEFAULT NULL,
  `sParentTableName` varchar(128) DEFAULT NULL,
  `sParentKeyField` varchar(128) DEFAULT NULL,
  `sKeyField` varchar(128) DEFAULT NULL,
  `iAppId` decimal(15,0) DEFAULT NULL,
  `iQueryColCount` int(11) DEFAULT NULL,
  `iFormColCount` int(11) DEFAULT NULL,
  `iIsPage` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`iTableId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**»ù´¡Êý¾Ý**********************/
INSERT INTO tbPubSequence ( sTblName, iCurSquence ) VALUES ( 'Global', 100 ) ;
INSERT INTO tbPubSequence ( sTblName, iCurSquence ) VALUES ( 'Global2', 100000 ) ;