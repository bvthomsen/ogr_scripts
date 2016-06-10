-- Stored Procedures to use for upload-scripts based on ogr2ogr
-- Copyright: Bo Victor Thomsen, Frederikssund Kommune
-- License: GPL ver. 2.
-- The stored procedures has to be installed in the database before using the ogr2ogr scripts

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

---
--- Procedure to empty an existing table and load data from another table. The second table is dropped after the data transfer.
--- Any reference to the second table is deleted fro the geometry_colums table 
--- The two tables has to have a identical structures
---
CREATE PROCEDURE [dbo].[TransferTable] @sourceschema varchar(100), @sourcetable varchar(100), @targetschema varchar(100), @targettable varchar(100) AS

BEGIN

  SET NOCOUNT ON 

  DECLARE @object_id int
  DECLARE @rowCount int
  DECLARE @sql nvarchar(999)
  
  --- Find objectid for source table
    SELECT @object_id = NULL 
    SELECT @object_id = A.OBJECT_ID FROM sys.objects A INNER JOIN sys.schemas B ON A.SCHEMA_ID = B.SCHEMA_ID 
	WHERE TYPE = 'U' AND UPPER(B.NAME) = UPPER(@sourceschema) AND UPPER(A.NAME) = UPPER(@sourcetable)
  IF @object_id IS NULL
  BEGIN 
    RAISERROR ('Source table does not exist', 16,1)
	RETURN 1
  END

  --- Find objectid for target table
  SELECT @object_id = NULL 
  SELECT @object_id = A.OBJECT_ID FROM sys.objects A INNER JOIN sys.schemas B ON A.SCHEMA_ID = B.SCHEMA_ID 
	WHERE TYPE = 'U' AND UPPER(B.NAME) = UPPER(@targetschema) AND UPPER(A.NAME) = UPPER(@targettable)
  IF @object_id IS NULL  
  BEGIN 
--    IF @sourceschema = @targetschema
--    BEGIN
--      -- source and target in same schema -> rename source table
--      SELECT @sql = @sourceschema + '.' + @sourcetable
--      EXEC sp_rename @sql, @targettable;
--      DELETE FROM dbo.geometry_columns where UPPER(f_table_schema) = UPPER(@sourceschema) AND UPPER(f_table_name) = UPPER(@targettable);
--      UPDATE dbo.geometry_columns SET f_table_name = @targettable where UPPER(f_table_schema) = UPPER(@sourceschema) AND UPPER(f_table_name) = UPPER(@sourcetable);

--    END
--    ELSE
--    BEGIN
      -- source and target in different schema -> raise error

      --- Drop source table
      SELECT @sql = 'DROP TABLE ' + @sourceschema + '.' + @sourcetable + ';'
      EXEC (@sql);
      --- Update geometry_columns
      DELETE FROM dbo.geometry_columns where UPPER(f_table_schema) = UPPER(@sourceschema) AND UPPER(f_table_name) = UPPER(@sourcetable);

      RAISERROR ('Target table does not exist', 16,1)
      RETURN 1
--    END
  END
  ELSE
  BEGIN

    SELECT @sql = N'SELECT @rowCount = COUNT(*) FROM ' + @sourceschema + '.' + @sourcetable + ';'
    EXEC sp_executesql @sql, N'@rowCount INT OUTPUT', @rowCount OUTPUT

    IF @rowCount > 0 -- There is rows in the source table
    BEGIN

      --- Truncate target table
      SELECT @sql = 'TRUNCATE TABLE ' + @targetschema + '.' + @targettable + ';'
      EXEC (@sql);
  
      --- Copy rows from source to target
      SELECT @sql = 'INSERT INTO ' + @targetschema + '.' + @targettable + ' SELECT * FROM ' + @sourceschema + '.' + @sourcetable + ';'
      EXEC (@sql);

      --- Drop source table
      SELECT @sql = 'DROP TABLE ' + @sourceschema + '.' + @sourcetable + ';'
      EXEC (@sql);
      --- Update geometry_columns
      DELETE FROM dbo.geometry_columns where UPPER(f_table_schema) = UPPER(@targetschema) AND UPPER(f_table_name) = UPPER(@targettable);
      UPDATE dbo.geometry_columns SET f_table_schema = @targetschema, f_table_name = @targettable where UPPER(f_table_schema) = UPPER(@sourceschema) AND UPPER(f_table_name) = UPPER(@sourcetable);

    END
    ELSE
    BEGIN
      --- Drop source table
      SELECT @sql = 'DROP TABLE ' + @sourceschema + '.' + @sourcetable + ';'
      EXEC (@sql);
      --- Update geometry_columns
      DELETE FROM dbo.geometry_columns where UPPER(f_table_schema) = UPPER(@sourceschema) AND UPPER(f_table_name) = UPPER(@sourcetable);

      RAISERROR ('Source table contains no rows, transfer aborted', 16,1)
      RETURN 1
    END
    
  END
END
GO

---
--- Procedure to change an identity column to an ordinary integer primary key.
---
CREATE PROCEDURE [dbo].[ChangeIdentityColumn] @schema varchar(100), @table varchar(100) AS

BEGIN

  SET NOCOUNT ON 

  DECLARE @object_id int
  DECLARE @column sysname 
  DECLARE @constraint sysname 
  DECLARE @sql nvarchar(999)
  
  --- Find objectid for table
  SELECT @object_id = A.OBJECT_ID FROM sys.objects A INNER JOIN sys.schemas B ON A.SCHEMA_ID = B.SCHEMA_ID 
	WHERE TYPE = 'U' AND UPPER(B.NAME) = UPPER(@schema) AND UPPER(A.NAME) = UPPER(@table)

  --- Find identity column for table
  SELECT @column = name FROM sys.identity_columns WHERE object_id=@object_id
  IF @column IS NULL
  BEGIN 
    RAISERROR ('No Identity column in table', 16,1)
	RETURN 1
  END

  --- Find primary key constraint for table
  SELECT @constraint = name FROM sys.key_constraints WHERE type = 'PK' AND parent_object_id = @object_id
  
  --- add new int column (mister_mxyztplk --> Real ugly hack!!)
  SELECT @sql = 'ALTER TABLE ' + @schema + '.' + @table + ' ADD mister_mxyztplk int not null default -1;'
  EXEC (@sql);

  --- copy values  from identity column to new column
  SELECT @sql = 'UPDATE ' + @schema + '.' + @table + ' SET mister_mxyztplk = ' + @column + ';';
  EXEC (@sql);
  
  --- drop primary key constraint for table
  SELECT @sql = 'ALTER TABLE ' + @schema + '.' + @table + ' DROP CONSTRAINT ' + @constraint + ';' 
  EXEC (@sql);

  --- drop identity column fopr table
  SELECT @sql = 'ALTER TABLE ' + @schema + '.' + @table + ' DROP COLUMN ' + @column + ';' 
  EXEC (@sql);

  --- rename new int column to name for org. identity column
  SELECT @sql = @schema + '.' + @table + '.mister_mxyztplk'
  EXEC sp_rename @sql, @column, 'COLUMN'

  --- add primary key for table
  SELECT @sql = 'ALTER TABLE ' + @schema + '.' + @table + ' ADD CONSTRAINT ' + @constraint + ' PRIMARY KEY CLUSTERED (' + @column + ');'
  EXEC (@sql);

END
GO

---
--- Procedure to create æøå and other accented characters in varchar type columns if the the column has been loaded with UTF8 type data
---
CREATE PROCEDURE [dbo].[ReplaceAccent] @schemaname varchar(100), @tablename varchar(100) AS

BEGIN

  SET NOCOUNT ON 

  DECLARE @object_id INT 
  DECLARE @columnName sysname 
  DECLARE @sqlCommand varchar(999)
    
  SELECT @object_id =A.OBJECT_ID FROM sys.objects A INNER JOIN sys.schemas B ON A.SCHEMA_ID = B.SCHEMA_ID 
	WHERE TYPE = 'U' AND UPPER(B.NAME) = UPPER(@schemaname) AND UPPER(A.NAME) = UPPER(@tablename) 
  
  --PRINT @object_id

  -- Find varchars columns
  DECLARE COL_CURSOR CURSOR FOR 
    SELECT A.NAME FROM sys.columns A INNER JOIN sys.types B ON A.SYSTEM_TYPE_ID = B.SYSTEM_TYPE_ID 
      WHERE  OBJECT_ID = @object_id AND IS_COMPUTED = 0 AND B.NAME ='varchar' 
  
  -- iterate the found columns
  OPEN COL_CURSOR FETCH NEXT FROM COL_CURSOR INTO @columnName
  
  WHILE @@FETCH_STATUS = 0 
  BEGIN 

    -- replace every occurence of a UTF8 accented character with the LATIN1 based equivalent
    SET @sqlCommand =  'UPDATE [' + @schemaname + '].[' + @tablename + '] SET [' + @columnName + '] = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([' + @columnName + '],''Ã¦'',''æ''),''Ã¸'',''ø''),''Ã¥'',''å''),''Ã¼'',''ü''),''Ã©'',''é''),''Ã†'',''Æ''),''Ã˜'',''Ø''),''Ã…'',''Å''),''Ãœ'',''Ü''),''Ã‰'',''É'')  WHERE [' + @columnName + '] LIKE ''%Ã%''' 
    EXEC(@sqlCommand)	
	--PRINT @sqlCommand

    FETCH NEXT FROM COL_CURSOR INTO @columnName 

  END 
       
  CLOSE COL_CURSOR 
  DEALLOCATE COL_CURSOR 
       
END
GO

---
--- Procedure to create æøå and other accented characters in varchar type columns if the the column has been loaded 
--  with UTF8 type data in every table and varchar column in the database. USE WITH CARE!!
---
CREATE PROCEDURE [dbo].[procFindReplace]
AS

BEGIN
  SET NOCOUNT ON 

  DECLARE @schema sysname 
  DECLARE @table sysname 

  DECLARE TAB_CURSOR CURSOR  FOR 

    SELECT B.NAME AS SCHEMANAME, A.NAME AS TABLENAME FROM sys.objects A 
      INNER JOIN sys.schemas B ON A.SCHEMA_ID = B.SCHEMA_ID 
    WHERE TYPE = 'U' ORDER BY 1 
          
  OPEN TAB_CURSOR 

  FETCH NEXT FROM TAB_CURSOR INTO @schema, @table
      
  WHILE @@FETCH_STATUS = 0 
    BEGIN 

      EXEC dbo.ReplaceAccent @schema, @table;
      FETCH NEXT FROM TAB_CURSOR INTO @schema, @table

    END 
   
  CLOSE TAB_CURSOR 
  DEALLOCATE TAB_CURSOR
END
GO
