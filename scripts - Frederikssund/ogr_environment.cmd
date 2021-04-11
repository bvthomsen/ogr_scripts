REM ============================================================================================
REM == Ops�tning af generelle environment vars til behandling af spatielle data vha OGR2OGR   ==
REM == Programm�r:   Bo Victor Thomsen, Frederikssund Kommune                                 ==
REM ============================================================================================
@set "echostate=off"
@echo %echostate%
@chcp 1252 >nul
%~d0
cd "%~p0"

REM ============================================================================================
REM Ops�tning af GDAL milj� - Kald af ops�tningsfil mht. path og andre env var.
REM ============================================================================================

REM GDAL v. 1.x fra netv�rk (Hentet fra http://gisinternals.com)
call "Q:\Program Files\GDAL\release-1800-x64-gdal-1-11-4-mapserver-6-4-3\SDKShell.bat" setenv hideoci >NUL

REM GDAL v. 2.x fra netv�rk (Hentet fra http://gisinternals.com)
::call "Q:\Program Files\GDAL\release-1800-x64-gdal-2-1-0-mapserver-7-0-1\SDKShell.bat" setenv hideoci >NUL
@echo %echostate%

REM ============================================================================================
REM Ops�tning af database type
REM Upload kan konfigureres til enten PostgreS/PostGIS eller MS-SQLServer
REM ============================================================================================

REM ============================================================================================
REM Hvis MS-SQLServer......
REM ============================================================================================

REM MS-SQLServer og GDAL v. 1.x
set "ogr_command=%~dp0ogr_mssql.cmd"

REM MS-SQLServer og GDAL v. 2.x
::set "ogr_command=%~dp0ogr2_mssql.cmd"

REM =====================================================
REM Parametre til generering af spatielt indeks for MS SQL Server...
REM Omr�de definition: minx,miny,maxx,maxy  - koordinatv�rdier
REM angives i ogr_epsgt defineret projektion 
REM *Kun* n�dvendig ved MS-SQLServer i forbindelse med GDAL 1.x
REM TIP: Ha' styr p� placering af anf�rselstegn
REM =====================================================

REM Eksempel Danmark.. (f�r ikke hele s�territoriet med)
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
::REM S�tter character-encoding for inddata
::REM =====================================================
::::set "PGCLIENTENCODING=LATIN1"
::set "PGCLIENTENCODING=UTF8"

REM ============================================================================================
REM SLUT p� database ops�tning
REM ============================================================================================


REM =====================================================
REM Navn p� geometri felt oprettet af OGR i database tabeller
REM =====================================================
set "ogr_geom=sp_geometry"

REM =====================================================
REM Navn p� primary key felt oprettet af OGR i database tabeller
REM =====================================================
set "ogr_fid=ogr_fid"

REM =====================================================
REM Navn p� administrativt dato felt (varchar (10), indeholder ����-mm-dd)
REM Hvis sat til <ingenting> oprettes feltet ikke
REM =====================================================
::set ogr_dato=
set ogr_dato=hent_dato

REM =====================================================
REM EPSG v�rdier for projektioner (normalt 25832 aka. UTM32/ETRS89
REM ogr_epsgs: inddataprojektion (source)
REM ogr_epsgt: projektion i database (target)
REM =====================================================
::set "ogr_epsgs=4326"
::set "ogr_epsgt=25833"
set "ogr_epsgs=25832"
set "ogr_epsgt=25832"

REM =====================================================
REM where part til ogr2ogr kommando; s�ttes efter behov; normalt ingenting
REM =====================================================
set "ogr_where="

REM =====================================================
REM Geografisk afgr�sning ved indl�sning af data
REM Omr�de definition: minx miny maxx maxy - koordinatv�rdier 
REM angives i *ogr_epsgs* defineret projektion
REM Defintion benytets til geografisk at afgr�nse inddata
REM TIP: Ha' styr p� placering af anf�rselstegn
REM =====================================================

REM Frederikssund Kommune i UTM32/ETRS89 (EPSG:25832)
set "ogr_bbox=678577 6178960 702291 6202870"

REM Ingen geografisk begr�sning....
::set "ogr_bbox="

REM =====================================================
REM Behandling af tabel i database:
REM OVERWRITE: (Overskriv) Evt. eksisterende tabel med samme navn slettes og der genereres en ny tabel 
REM TRUNCATE:  (Nulstil/append) Eks. tabel bevares, men t�mmes for data. Nye data indl�gges efterf�lgende i eks. tabel
REM            Bruges hvis der er oprettet views, som inkluderer tabellen. 
REM =====================================================
set "ogr_load=OVERWRITE"
::set "ogr_load=TRUNCATE"

REM =====================================================
REM Ekstra parametre til ogr2ogr kommando; s�ttes efter behov; normalt ingenting
REM =====================================================
set "ogr_xtra="

@echo ============================================================================================
@echo Starttid: %date% %time%
@echo ============================================================================================
