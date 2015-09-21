REM ============================================================================================
REM == Opsætning af generelle environment vars til behandling af spatielle data vha OGR2OGR   ==
REM == OGR2OGR ver 1.11 bør benyttes                                                          ==
REM == Programmører: Anette Rosengård Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM sæt CodePage til Latin-1 (Ingen bøvl med ÆØÅ i kommandolinien og filnavne)
REM ============================================================================================
chcp 1252 >nul

REM Sæt "current dir" til opstartsdirectory for script (ikke bydende nødvendigt)
REM ============================================================================================
%~d0
cd "%~p0"

REM =====================================================
REM Hovedmappe for OSGEO4W (OGR, GDAL og Python)
REM =====================================================
REM set OSGEO4W_ROOT=C:\OSGeo4w64
set OSGEO4W_ROOT=C:\OSGeo4w

REM =====================================================
REM                N I X  P I L L E
REM =====================================================
set PATH=%OSGEO4W_ROOT%\bin;%PATH%
for %%f in ("%OSGEO4W_ROOT%\etc\ini\*.bat") do call "%%f"


REM =====================================================
REM Opsætning om upload foregår til ms-sqlserver eller postgres
REM =====================================================

REM Postgres - Skift myHost, myDatabase, myUSer og myPassword til relevante værdier
set "ogr_command=%~dp0ogr_postgres.bat"
rem set "db_conn=host='myHost' dbname='myDatabase' user='myUser' password='myPassword' port='5432'"
set "db_conn=host='f-gis03' dbname='gis_test' user='postgres' password='ukulemy' port='5432'"

REM MS Sqlserver - Skift myServer, myDatabase til relevante værdier
REM set "ogr_command=%~dp0ogr_mssql.bat"
REM set "db_conn=server=myServer;database=myDatabase;trusted_connection=yes"

REM =====================================================
REM Sætter character-encoding for inddata til *Postgres*
REM =====================================================
REM set "PGCLIENTENCODING=LATIN1"
set "PGCLIENTENCODING=UTF8"

REM =====================================================
REM Standard schema navn
REM =====================================================
REM Postgres
set "ogr_schema=public"
REM MS SQL Server
REM set "ogr_schema=dbo"

REM =====================================================
REM Navn på geometri felt oprettet af OGR i database tabeller
REM =====================================================
set ogr_geom=geom

REM =====================================================
REM Navn på primary key felt oprettet af OGR i database tabeller
REM =====================================================
set ogr_fid=fid

REM =====================================================
REM Navn på dato felt (varchar (10), indeholder åååå-mm-dd)
REM Hvis det er lig med <ingenting> oprettes og populeres feltet ikke
REM =====================================================
REM set ogr_dato=
set ogr_dato=hent_dato

REM =====================================================
REM EPSG værdi for projektion (normalt 25832 aka. UTM32/ETRS89
REM =====================================================
REM set ogr_epsg=4326
REM set ogr_epsg=25833
set ogr_epsg=25832

REM =====================================================
REM Parametre til generering af spatielt indeks for *MS SQL Server*
REM Område definition: minx,miny,maxx,maxy  - koordinatværdier angives i ogr_epsg defineret projektion
REM =====================================================
REM Eksempel Danmark.. (får ikke hele søterritoriet med)
set "ogr_spatial=350000,6020000,950000,6450000"
REM Eksempel: Frederikssund Kommune....
REM set "ogr_spatial=678577,6178960,702291,6202870"

REM =====================================================
REM Geografisk afgræsning ved upload af data
REM Område definition: minx miny maxx maxy - koordinatværdier angives i ogr_epsg defineret projektion
REM =====================================================
REM Eksempel: Frederikssund Kommune....
set "ogr_bbox=678577 6178960 702291 6202870"
REM Eksempel: ingen geografisk begræsning....
REM set "ogr_bbox="


