SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ReplaceAccent] @schemaname varchar(100), @tablename varchar(100)  
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @object_id INT 
  DECLARE @columnName sysname 
  DECLARE @sqlCommand varchar(999)
    
  SELECT @object_id =A.OBJECT_ID FROM sys.objects A INNER JOIN sys.schemas B ON A.SCHEMA_ID = B.SCHEMA_ID 
	WHERE TYPE = 'U' AND UPPER(B.NAME) = UPPER(@schemaname) AND UPPER(A.NAME) = UPPER(@tablename) 
  
  --PRINT @object_id

  DECLARE COL_CURSOR CURSOR FOR 
    SELECT A.NAME FROM sys.columns A INNER JOIN sys.types B ON A.SYSTEM_TYPE_ID = B.SYSTEM_TYPE_ID 
      WHERE  OBJECT_ID = @object_id AND IS_COMPUTED = 0 AND B.NAME ='varchar' 
  
  OPEN COL_CURSOR FETCH NEXT FROM COL_CURSOR INTO @columnName
  
  WHILE @@FETCH_STATUS = 0 
  BEGIN 

    SET @sqlCommand =  'UPDATE [' + @schemaname + '].[' + @tablename + '] SET [' + @columnName + '] = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([' + @columnName + '],''Ã¦'',''æ''),''Ã¸'',''ø''),''Ã¥'',''å''),''Ã¼'',''ü''),''Ã©'',''é''),''Ã†'',''Æ''),''Ã˜'',''Ø''),''Ã…'',''Å''),''Ãœ'',''Ü''),''Ã‰'',''É'')  WHERE [' + @columnName + '] LIKE ''%Ã%''' 
    EXEC(@sqlCommand)	

	--PRINT @sqlCommand

    FETCH NEXT FROM COL_CURSOR INTO @columnName 

  END 
       
  CLOSE COL_CURSOR 
  DEALLOCATE COL_CURSOR 
       
END

GO


