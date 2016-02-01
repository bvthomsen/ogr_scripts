REM ============================================================================================
REM == Upload af spatielle data til MS SQL Server fra vilkålige datakilder                    ==
REM == OGR2OGR ver 1.11 bør benyttes                                                          ==
REM == Programmører: Anette Rosengård Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM =====================================================
REM Inddata check, alle 6 parametre *skal* være angivet
REM =====================================================
call "%~dp0ogr_prep_arg.bat" %*

REM =====================================================
REM Upload af data til MS SQL Server
REM =====================================================
@echo Kommando.. ogr2ogr -gt 100000 -skipfailures -overwrite -lco FID="%ogr_fid%" -lco GEOM_NAME="%ogr_geom%" -lco OVERWRITE=YES -lco SCHEMA="%xp4%" -nln "%xp5%" %xp11% %xp9% %xp10% -f "MSSQLSpatial" MSSQL:%xp3% %xp1% %xp2% %xp7%
ogr2ogr -gt 100000 -skipfailures -overwrite -lco FID="%ogr_fid%" -lco GEOM_NAME="%ogr_geom%" -lco OVERWRITE=YES -lco SCHEMA="%xp4%" -nln "%xp5%" %xp11% %xp9% %xp10% -f "MSSQLSpatial" MSSQL:%xp3% %xp1% %xp2% %xp7%

REM =====================================================
REM Hvis ogr_dato er sat, autogenereres der et nyt felt, som indeholder dato for indlægning af data 
REM =====================================================
if not #%ogr_dato%==# (
  @echo Kommando.. ogrinfo -q -sql "ALTER TABLE [%xp4%].[%xp5%] ADD [%ogr_dato%] varchar(10) NULL CONSTRAINT [DF_%xp4%_%xp5%_%ogr_dato%] DEFAULT (CONVERT ( varchar(10), getdate(), 120))" MSSQL:%xp3%
  ogrinfo -q -sql "ALTER TABLE [%xp4%].[%xp5%] ADD [%ogr_dato%] varchar(10) NULL CONSTRAINT [DF_%xp4%_%xp5%_%ogr_dato%] DEFAULT (CONVERT ( varchar(10), getdate(), 120))" MSSQL:%xp3%
  @echo Kommando.. ogrinfo -q -sql "UPDATE [%xp4%].[%xp5%]  SET %ogr_dato%=CONVERT ( varchar(10), getdate(), 120)" MSSQL:%xp3%
  ogrinfo -q -sql "UPDATE [%xp4%].[%xp5%]  SET %ogr_dato%=CONVERT ( varchar(10), getdate(), 120)" MSSQL:%xp3%
)
