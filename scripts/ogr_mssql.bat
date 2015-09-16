@echo on
REM ============================================================================================
REM == Upload af spatielle data til MS SQL Server fra vilkålige datakilder                    ==
REM == OGR2OGR ver 1.11 bør benyttes                                                          ==
REM == Programmører: Anette Rosengård Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM =====================================================
REM Inddata check, alle 5 parametre *skal* være angivet
REM =====================================================

REM Parm. 1, OGR inddatakilde, f.eks wfs definition
set xp1="%~1" 

REM Parm. 2, Lag definition for inddatakilde; hvis den ikke benyttes (f.eks tab og shape), anvendes en * i kommandolinien som parameter
if #%~2==#* (set xp2=) else (set xp2="%~2")

REM Parm. 3, Definition af database forbindelse
set xp3="%~3" 

REM Parm. 4, Schema for tabel; angiv en "*" for default
if #%~4==#* (set xp4=dbo) else (set xp4=%~4)

REM Parm. 5, Navn for ny tabel; angiv en "*" hvis lagnavn ønskes benyttet 
if #%~5==#* (set xp5=%xp2%) else (set xp5=%~5)

REM Tabelnavn renses for tumpetegn (Tilføjes efter behov)
set xp5=%xp5: =_% & set xp5=%xp5::=_%

REM Parm. 6, Objekttype, skal være enten PKT, MPKT, LIN, MLIN, POL, MPOL eller *

REM Konvertering af arg 6 til store bogstaver
set xp6=%~6
if not #%xp6%==# (
  set xp6=%xp6:p=P%
  set xp6=%xp6:k=K%
  set xp6=%xp6:t=T%
  set xp6=%xp6:m=M%
  set xp6=%xp6:l=L%
  set xp6=%xp6:i=I%
  set xp6=%xp6:n=N%
  set xp6=%xp6:o=O%
)

REM Generering af kommandolinie stumper til filtrering. xp10 indeholder del af -where filter udtryk og xp9 indeholder -nlt kommando 
set "xp8="
set "xp9="
set "xp10="
if #%xp6%==#PKT  ( set "xp8=OGR_GEOMETRY='POINT'" & set "xp9=")
if #%xp6%==#MPKT ( set "xp8=OGR_GEOMETRY='POINT' OR OGR_GEOMETRY='MULTIPOINT'" & set "xp9=-nlt PROMOTE_TO_MULTI")
if #%xp6%==#LIN  ( set "xp8=OGR_GEOMETRY='LINESTRING'" & set "xp9=")
if #%xp6%==#MLIN ( set "xp8=OGR_GEOMETRY='LINESTRING' OR OGR_GEOMETRY='MULTILINESTRING'" & set "xp9=-nlt PROMOTE_TO_MULTI")
if #%xp6%==#POL  ( set "xp8=OGR_GEOMETRY='POLYGON'" & set "xp9=")
if #%xp6%==#MPOL ( set "xp8=OGR_GEOMETRY='POLYGON' OR OGR_GEOMETRY='MULTIPOLYGON'" & set "xp9=-nlt PROMOTE_TO_MULTI" )

REM =====================================================
REM Opsætning og behandling af semipermanente variable
REM =====================================================

REM -where clause færdiggøres. Tilføjes evt. filter information fra ogr_where
if     "#%ogr_where%#"=="##" if "#%xp8%#"=="##" ( set "xp10=" ) else ( set xp10=-where "%xp8%" ) 
if not "#%ogr_where%#"=="##" if "#%xp8%#"=="##" ( set xp10=-where "%ogr_where%" ) else ( set xp10=-where "(%xp8%) AND (%ogr_where%)" )

REM Der genereres en evt. "bbox" clause
if not "%ogr_bbox%"=="" (set xp7=-spat %ogr_bbox%) else (set xp7=) 

REM Sanitycheck af øvrige parametre
if #%ogr_geom%==# set ogr_geom=geom
if #%ogr_fid%==# set ogr_fid=fid
if #%ogr_epsg%==# set ogr_epsg=25832
if "%ogr_spatial%"=="" set "ogr_spatial=350000,6020000,950000,6450000"

REM =====================================================
REM Upload af data til MS SQL Server
REM =====================================================
ogr2ogr -gt 100000 -skipfailures -overwrite -lco FID="%ogr_fid%" -lco GEOM_NAME="%ogr_geom%" -lco OVERWRITE=YES -lco SCHEMA="%xp4%" -nln "%xp5%" -a_srs "EPSG:%ogr_epsg%"  %xp9% %xp10% -f "MSSQLSpatial" MSSQL:%xp3% %xp1% %xp2% %xp7%
REM =====================================================

REM =====================================================
REM Generer spatielt indeks. Dette trin kan fjernes ved overgang til GDAL ver. 2.n
REM =====================================================
ogrinfo -q -sql "CREATE SPATIAL INDEX  [SPX_%xp5%] ON [%xp4%].[%xp5%] ([%ogr_geom%]) USING GEOMETRY_GRID WITH (BOUNDING_BOX =(%ogr_spatial%))" MSSQL:%xp3%

REM =====================================================
REM Erstat UTF8 repræsentation af æøå o.l. til Latin-1 repræsentation
REM ogr2ogr genererer varchar til tekstfelter. Dette vil få UTF8 baserede data til at
REM blive misrepræsenteret mht. æøå o.l. Nedenstående kommando retter op på dette.
REM **Kræver** installation af stored procedure "ReplaceAccent" i schema dbo
REM Dette trin kan fjernes ved overgang til GDAL ver. 2.n
REM =====================================================
ogrinfo -q -sql "EXEC dbo.ReplaceAccent @schemaname='%xp4%', @tablename='%xp5%'" MSSQL:%xp3%

REM =====================================================
REM Hvis ogr_dato er sat, autogenereres der et nyt felt, som indeholder dato for indlægning af data 
REM =====================================================
if not #%ogr_dato%==# (
  ogrinfo -q -sql "ALTER TABLE [%xp4%].[%xp5%] ADD [%ogr_dato%] varchar(10) NULL CONSTRAINT [DF_%xp4%_%xp5%_%ogr_dato%] DEFAULT (CONVERT ( varchar(10), getdate(), 120))" MSSQL:%xp3%
  ogrinfo -q -sql "UPDATE [%xp4%].[%xp5%]  SET %ogr_dato%=CONVERT ( varchar(10), getdate(), 120)" MSSQL:%xp3%
)
