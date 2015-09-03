@echo on
REM ============================================================================================
REM == Upload af spatielle data til Postgres fra vilk�lige datakilder                    ==
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
if #%~4==#* (set xp4=public) else (set xp4=%~4)

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
if "%PGCLIENTENCODING%"=="" set "PGCLIENTENCODING=LATIN1"
REM =====================================================

REM Opretter relevant schema i database hvis dette ikke eksisterer i forvejen
REM =====================================================
ogrinfo -q -sql "CREATE SCHEMA IF NOT EXISTS %xp4%" PG:%xp3%
REM =====================================================

REM Upload af data til Postgres Server
REM =====================================================
ogr2ogr --config PG_USE_COPY YES -gt 100000 -overwrite -lco FID="%ogr_fid%" -lco GEOMETRY_NAME="%ogr_geom%" -lco OVERWRITE=YES -nln "%xp4%.%xp5%" -a_srs "EPSG:%ogr_epsg%" -f "PostgreSQL" PG:%xp3% %xp1% %xp2%
REM =====================================================

goto slut

:fejl
echo en eller flere parametre mangler. Der skal v�re i alt 5 parametre...
echo "Inddata-definition" "lag-identifikation" "database-forbindelse" "schema-navn" "tabel-navn"

:slut