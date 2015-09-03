@echo on
REM ============================================================================================
REM == Upload af spatielle data til MS SQL Server fra vilk�lige datakilder                    ==
REM == OGR2OGR ver 1.11 b�r benyttes                                                          ==
REM == Programm�rer: Anette Roseng�rd Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM Inddata check, alle 5 parametre *skal* v�re angivet
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

REM Parm. 5, Navn for ny tabel; angiv en "*" hvis lagnavn �nskes benyttet 
if #%5==# goto fejl
if #%~5==#* (set xp5=%xp2%) else (set xp5=%~5)

REM Tabelnavn renses for tumpetegn (Tilf�jes efter behov)
set set xp5=%xp5: =_%
set set xp5=%xp5::=_%
REM =====================================================

REM Sanity check om globale variable er sat (bitter erfaring)
REM =====================================================
if #%ogr_geom%==# set ogr_geom=geom
if #%ogr_fid%==# set ogr_fid=fid
if #%ogr_epsg%==# set ogr_epsg=25832
if "%ogr_bbox%"=="" set "ogr_bbox=350000,6020000,950000,6450000"
REM =====================================================

REM Upload af data til MS SQL Server
REM =====================================================
ogr2ogr -gt 100000 -overwrite -lco FID="%ogr_fid%" -lco GEOM_NAME="%ogr_geom%" -lco OVERWRITE=YES -lco SCHEMA="%xp4%" -nln "%xp5%" -a_srs "EPSG:%ogr_epsg%" -f "MSSQLSpatial" %xp3% %xp1% %xp2%
REM =====================================================

REM Generer spatielt indeks. Dette trin kan fjernes ved overgang til GDAL ver. 2.n
REM =====================================================
ogrinfo -q -sql "CREATE SPATIAL INDEX  [SPX_%xp5%] ON [%xp4%].[%xp5%] ([%ogr_geom%]) USING GEOMETRY_GRID WITH (BOUNDING_BOX =(%ogr_bbox%))" %xp3%
REM =====================================================

REM Erstat UTF8 repr�sentation af ��� o.l. til Latin-1 repr�sentation
REM **Kr�ver** installation af stored procedure "ReplaceAccent" i schema dbo
REM Dette trin kan fjernes ved overgang til GDAL ver. 2.n
REM =====================================================
ogrinfo -q -sql "EXEC dbo.ReplaceAccent @schemaname='%xp4%', @tablename='%xp5%'" %xp3%
REM =====================================================

goto slut

:fejl
echo en eller flere parametre mangler. Der skal v�re i alt 5 parametre...
echo "Inddata-definition" "lag-identifikation" "database-forbindelse" "schema-navn" "tabel-navn"

:slut