REM ============================================================================================
REM == Opsætning af generelle environment vars til behandling af spatielle data vha OGR2OGR   ==
REM == Programmør:   Bo Victor Thomsen, Frederikssund Kommune                                 ==
REM ============================================================================================
@set "echostate=off"
@echo %echostate%
@chcp 1252 >nul
%~d0
cd "%~p0"

REM ============================================================================================
REM Opsætning af GDAL miljø - Kald af opsætningsfil mht. path og andre env var.
REM ============================================================================================

REM GDAL v. 1.x fra netværk (Hentet fra http://gisinternals.com)
call Q:\Scripts\GDAL\release-1800-x64-gdal-1-11-mapserver-6-4\SDKShell.bat setenv hideoci >NUL

REM GDAL v. 2.x fra netværk (Hentet fra http://gisinternals.com)
::call Q:\Scripts\GDAL\release-1800-x64-gdal-mapserver\SDKShell.bat setenv hideoci >NUL
@echo %echostate%

REM ============================================================================================
REM Opsætning af database type
REM Upload kan konfigureres til enten PostgreS/PostGIS eller MS-SQLServer
REM ============================================================================================

REM ============================================================================================
REM Hvis MS-SQLServer......
REM ============================================================================================

REM MS-SQLServer og GDAL v. 1.x
set "ogr_command=%~dp0ogr_mssql.cmd"

::REM MS-SQLServer og GDAL v. 2.x
::set "ogr_command=%~dp0ogr2_mssql.cmd"

REM =====================================================
REM Parametre til generering af spatielt indeks for MS SQL Server...
REM Område definition: minx,miny,maxx,maxy  - koordinatværdier
REM angives i ogr_epsgt defineret projektion 
REM *Kun* nødvendig ved MS-SQLServer i forbindelse med GDAL 1.x
REM TIP: Ha' styr på placering af anførselstegn
REM =====================================================

REM Eksempel Danmark.. (får ikke hele søterritoriet med)
set "ogr_spatial=350000,6020000,950000,6450000"

REM Eksempel: Kun Frederikssund Kommune....
::set "ogr_spatial=678577,6178960,702291,6202870"

::REM ============================================================================================
::REM Hvis Postgres/PostGIS ...
::REM ============================================================================================
::
::REM PostgreSQL
::set "ogr_command=%~dp0ogr_postgres.cmd"
::
::REM =====================================================
::REM *Kun* aktuel ved upload af data til Postgres
::REM Sætter character-encoding for inddata
::REM =====================================================
::::set "PGCLIENTENCODING=LATIN1"
::set "PGCLIENTENCODING=UTF8"

REM ============================================================================================
REM SLUT på database opsætning
REM ============================================================================================


REM =====================================================
REM Navn på geometri felt oprettet af OGR i database tabeller
REM =====================================================
set "ogr_geom=sp_geometry"

REM =====================================================
REM Navn på primary key felt oprettet af OGR i database tabeller
REM =====================================================
set "ogr_fid=ogr_fid"

REM =====================================================
REM Navn på administrativt dato felt (varchar (10), indeholder åååå-mm-dd)
REM Hvis sat til <ingenting> oprettes feltet ikke
REM =====================================================
::set ogr_dato=
set ogr_dato=hent_dato

REM =====================================================
REM EPSG værdier for projektioner (normalt 25832 aka. UTM32/ETRS89
REM ogr_epsgs: inddataprojektion (source)
REM ogr_epsgt: projektion i database (target)
REM =====================================================
::set "ogr_epsgs=4326"
::set "ogr_epsgt=25833"
set "ogr_epsgs=25832"
set "ogr_epsgt=25832"

REM =====================================================
REM where part til ogr2ogr kommando; sættes efter behov; normalt ingenting
REM =====================================================
set "ogr_where="

REM =====================================================
REM Geografisk afgræsning ved indlæsning af data
REM Område definition: minx miny maxx maxy - koordinatværdier 
REM angives i *ogr_epsgs* defineret projektion
REM Defintion benytets til geografisk at afgrænse inddata
REM TIP: Ha' styr på placering af anførselstegn
REM =====================================================

REM Frederikssund Kommune i UTM32/ETRS89 (EPSG:25832)
set "ogr_bbox=678577 6178960 702291 6202870"

REM Ingen geografisk begræsning....
::set "ogr_bbox="

REM =====================================================
REM Behandling af tabel i database:
REM OVERWRITE: (Overskriv) Evt. eksisterende tabel med samme navn slettes og der genereres en ny tabel 
REM TRUNCATE:  (Nulstil/append) Eks. tabel bevares, men tømmes for data. Nye data indlægges efterfølgende i eks. tabel
REM            Bruges hvis der er oprettet views, som inkluderer tabellen. 
REM =====================================================
set "ogr_load=OVERWRITE"
::set "ogr_load=TRUNCATE"

REM =====================================================
REM Ekstra parametre til ogr2ogr kommando; sættes efter behov; normalt ingenting
REM =====================================================
set "ogr_xtra="

@echo ============================================================================================
@echo Starttid: %date% %time%
@echo ============================================================================================
