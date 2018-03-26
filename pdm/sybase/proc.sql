--ȡ�����洢����----------------------------------------------------------------------------------------

/*********************************************** 
   Purpose: Generator object ID for new one. 
   Author : ��־�
   Date   : 2003.11.20 
   Note   : ��һ������ΪID���к���������
   cachePrimaryKeys:ÿ�λ��������ĸ���
***********************************************/ 
IF OBJECT_ID('SP_GET_ID_EX2') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_GET_ID_EX2
END
go
CREATE PROCEDURE SP_GET_ID_EX2 
@cachePrimaryKeys int = 100
AS 
BEGIN 
    declare @Id numeric(15)
    
    begin tran  @cachePrimaryKeys
	select @Id = iCurSquence from tbPubSequence where sTblName = 'Global2'
        update tbPubSequence set iCurSquence = iCurSquence + @cachePrimaryKeys where sTblName = 'Global2'        
    commit tran  @cachePrimaryKeys
    
    select @Id  as Id
    return @Id
     
END
go


/*********************************************** 
   Purpose: Sybase��ҳ��ȡ����� 
   Author : ��־� 
   Date   : 2008.11.17
   Note   : sybase��֧�ַ�ҳ��ֻ���ô洢����ʵ�֣��������Ż�� @start + 1 ��ʼȡ��
   	    �洢���������˲�ѯ������¼����Ϊ5��
   	    ���ؽ��������һ���Ǽ�¼�������ڶ�������ţ�����ļ�¼�ӵ����п�ʼ��
***********************************************/ 
IF OBJECT_ID('dbo.GetDataByPageEoms') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetDataByPageEoms
    IF OBJECT_ID('dbo.GetDataByPageEoms') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.GetDataByPageEoms >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.GetDataByPageEoms >>>'
END
go
create procedure GetDataByPageEoms
(

 @SqlStr   varchar(8000),
 @start    int,
 @limit    int
)
AS
DECLARE @FirstRec int, @LastRec int, @dt varchar(10), @SelectStr varchar(4000)
BEGIN

 SELECT @FirstRec = @start
 SELECT @LastRec = @start + @limit + 1

 SELECT @dt= substring(convert(varchar,rand()),3,10)
       
 set @SqlStr = stuff(@SqlStr, charindex(' FROM ',upper(@SqlStr)), 6 ,' INTO #Paging FROM ')
 if  charindex('SELECT DISTINCT',upper(@SqlStr)) >0  
     set @SqlStr = stuff(@SqlStr, charindex('SELECT DISTINCT',upper(@SqlStr)), 15 ,'SELECT DISTINCT iRowId =identity(10),')
 else 
     set @SqlStr = stuff(@SqlStr, charindex('SELECT',upper(@SqlStr)), 6 ,'SELECT iRowId =identity(10),')
  
 set @SqlStr = 'set rowcount 50000 declare @RecCount  int ' + @SqlStr 
    + ' select @RecCount = @@rowcount  '

    + ' SELECT @RecCount as iRecCount,@RecCount as totalCount, * FROM #Paging  WHERE iRowId > '+convert(varchar,@FirstRec)+' and iRowId < '+convert(varchar,@LastRec)
    +' set rowcount 0'
    +' drop table #Paging '
   EXECUTE (@SqlStr) 
   print @SqlStr   
END
go
EXEC sp_procxmode 'dbo.GetDataByPageEoms','anymode'
go

/*********************************************** 
   Purpose: �ɰ�ȡ�������� 
   Author : ��־� 
   Date   : 2008.11.17
   Note   : 
***********************************************/ 

IF OBJECT_ID('dbo.SP_GET_ID_EX') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.SP_GET_ID_EX
    IF OBJECT_ID('dbo.SP_GET_ID_EX') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.SP_GET_ID_EX >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.SP_GET_ID_EX >>>'
END
go
CREATE PROCEDURE dbo.SP_GET_ID_EX 
@tbl varchar(32) = null
AS 
BEGIN 
    if rtrim(@tbl) is null
       select @tbl = 'Global'
    
    declare @Id numeric(15)
    declare @i int
    
    begin tran  @tbl
    
        update tbPubSequence set iCurSquence = iCurSquence + 1 where sTblName = @tbl    
        select @Id = iCurSquence from tbPubSequence where sTblName = @tbl
        
    commit tran  @tbl
    
    select @Id  as Id
    return @Id
     
END
go
EXEC sp_procxmode 'dbo.SP_GET_ID_EX','unchained'
go
