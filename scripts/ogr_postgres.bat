@echo on
REM ============================================================================================
REM == Upload af spatielle data til Postgres fra vilkålige datakilder                    ==
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


REM =====================================================
REM Opsætning af semipermanente variable
REM =====================================================

REM Der genereres en evt. ""where"" clause
if not #%ogr_where%==# (set xp6=-where %ogr_where%) else (set xp6=) 

REM Der genereres en evt. "bbox" clause
if not "%ogr_bbox%"=="" (set xp7=-spat %ogr_bbox%) else (set xp7=) 

REM Sanitycheck af øvrige parametre
if #%ogr_geom%==# set ogr_geom=geom
if #%ogr_fid%==# set ogr_fid=fid
if #%ogr_epsg%==# set ogr_epsg=25832
if "%PGCLIENTENCODING%"=="" set "PGCLIENTENCODING=LATIN1"

REM =====================================================
REM Opretter relevant schema i database hvis dette ikke eksisterer i forvejen
REM =====================================================
ogrinfo -q -sql "CREATE SCHEMA IF NOT EXISTS %xp4%" PG:%xp3%

REM =====================================================
REM Upload af data til Postgres Server
REM =====================================================
ogr2ogr -skipfailures --config PG_USE_COPY YES -gt 100000 -overwrite -lco SPATIAL_INDEX=FALSE -lco FID="%ogr_fid%" -lco GEOMETRY_NAME="%ogr_geom%" -lco OVERWRITE=YES -nln "%xp4%.%xp5%" -a_srs "EPSG:%ogr_epsg%" %xp6% -f "PostgreSQL" PG:%xp3% %xp1% %xp2% %XP7%

REM =====================================================
REM Opretter spatiel index efter generering af tabel
REM =====================================================
ogrinfo -q -sql "CREATE INDEX ON %xp4%.%xp5% USING GIST (%ogr_geom%);" PG:%xp3%

REM =====================================================
REM Hvis var ogr_dato er sat, autogenereres der et nyt felt, som indeholder dato for indlægning af data 
REM =====================================================
if not #%ogr_dato%==# (
  ogrinfo -q -sql "ALTER TABLE %xp4%.%xp5% ADD %ogr_dato% varchar(10) NULL DEFAULT current_date::character varying" PG:%xp3%
  ogrinfo -q -sql "UPDATE %xp4%.%xp5%  SET %ogr_dato%=current_date::character varying" PG:%xp3%
)

