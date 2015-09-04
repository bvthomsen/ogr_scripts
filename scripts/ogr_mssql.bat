@echo on
REM ============================================================================================
REM == Upload af spatielle data til MS SQL Server fra vilkålige datakilder                    ==
REM == OGR2OGR ver 1.11 bør benyttes                                                          ==
REM == Programmører: Anette Rosengård Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM Inddata check, alle 5 parametre *skal* være angivet
REM =====================================================
REM Parm. 1, OGR inddatakilde, f.eks wfs definition
if #%1==# goto fejl
set xp1="%~1" 

REM Parm. 2, Lag definition for inddatakilde; hvis den ikke benyttes (f.eks tab og shape), anvendes en * i kommandolinien som parameter
if #%2==# goto fejl
if #%~2==#* (set xp2=) else (set xp2="%~2")

REM Parm. 3, Definition af database forbindelse
if #%3==# goto fejl
set xp3="%~3" 

REM Parm. 4, Schema for tabel; angiv en "*" for default
if #%4==# goto fejl
if #%~4==#* (set xp4=dbo) else (set xp4=%~4)

REM Parm. 5, Navn for ny tabel; angiv en "*" hvis lagnavn ønskes benyttet 
if #%5==# goto fejl
if #%~5==#* (set xp5=%xp2%) else (set xp5=%~5)

REM Tabelnavn renses for tumpetegn (Tilføjes efter behov)
set set xp5=%xp5: =_%
set set xp5=%xp5::=_%

REM Der genereres en evt. ""where"" clause
if not #%ogr_where%==# (set xp6=-where "%~ogr_where%") else (set xp6=) 
REM =====================================================

REM Sanity check om øvrige globale variable er sat (bitter erfaring)
REM =====================================================
if #%ogr_geom%==# set ogr_geom=geom
if #%ogr_fid%==# set ogr_fid=fid
if #%ogr_epsg%==# set ogr_epsg=25832
if "%ogr_bbox%"=="" set "ogr_bbox=350000,6020000,950000,6450000"
REM =====================================================

REM Upload af data til MS SQL Server
REM =====================================================
ogr2ogr -progress -gt 100000 -overwrite -lco FID="%ogr_fid%" -lco GEOM_NAME="%ogr_geom%" -lco OVERWRITE=YES -lco SCHEMA="%xp4%" -nln "%xp5%" -a_srs "EPSG:%ogr_epsg%"  %xp6% -f "MSSQLSpatial" MSSQL:%xp3% %xp1% %xp2%
REM =====================================================

REM Generer spatielt indeks. Dette trin kan fjernes ved overgang til GDAL ver. 2.n
REM =====================================================
ogrinfo -q -sql "CREATE SPATIAL INDEX  [SPX_%xp5%] ON [%xp4%].[%xp5%] ([%ogr_geom%]) USING GEOMETRY_GRID WITH (BOUNDING_BOX =(%ogr_bbox%))" MSSQL:%xp3%
REM =====================================================

REM Erstat UTF8 repræsentation af æøå o.l. til Latin-1 repræsentation
REM ogr2ogr genererer varchar til tekstfelter. Dette vil få UTF8 baserede data til at
REM blive misrepræsenteret mht. æøå o.l. Nedenstående kommando retter op på dette.
REM **Kræver** installation af stored procedure "ReplaceAccent" i schema dbo
REM Dette trin kan fjernes ved overgang til GDAL ver. 2.n
REM =====================================================
ogrinfo -q -sql "EXEC dbo.ReplaceAccent @schemaname='%xp4%', @tablename='%xp5%'" MSSQL:%xp3%
REM =====================================================

REM Hvis var ogr_dato er sat, autogenereres der et nyt felt, som indeholder dato for indlægning af data 
REM =====================================================
if not #%ogr_dato%==# (
  ogrinfo -q -sql "ALTER TABLE [%xp4%].[%xp5%] ADD [%ogr_dato%] varchar(10) NULL CONSTRAINT [DF_%xp4%_%xp5%_%ogr_dato%] DEFAULT (CONVERT ( varchar(10, getdate(), 120))" MSSQL:%xp3%
  ogrinfo -q -sql "UPDATE [%xp4%].[%xp5%]  SET %ogr_dato%=CONVERT ( varchar(10), getdate(), 120)" MSSQL:%xp3%
)
REM =====================================================

goto slut

:fejl
echo en eller flere parametre mangler. Der skal være i alt 5 parametre...
echo "Inddata-definition" "lag-identifikation" "database-forbindelse" "schema-navn" "tabel-navn"

:slut
