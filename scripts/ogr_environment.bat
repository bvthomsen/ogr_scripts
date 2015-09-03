@echo on
REM ============================================================================================
REM == Opsætning af generelle environment vars til behandling af spatielle data vha OGR2OGR   ==
REM == OGR2OGR ver 1.11 bør benyttes                                                          ==
REM == Programmører: Anette Rosengård Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM Hovedmappe for OSGEO4W (OGR, GDAL og Python)
REM =====================================================
REM set OSGEO4W_ROOT=C:\OSGeo4w64
set OSGEO4W_ROOT=C:\OSGeo4w
REM =====================================================

REM ============== Nix Pille ============================
set PATH=%OSGEO4W_ROOT%\bin;%PATH%
for %%f in ("%OSGEO4W_ROOT%\etc\ini\*.bat") do call "%%f"
REM =====================================================

REM *Kun* aktuel ved upload af data til Postgres; sætter character-encoding for inddata
REM =====================================================
set "PGCLIENTENCODING=LATIN1"
REM set "PGCLIENTENCODING=UTF8"
REM =====================================================

REM Navn på geometri felt oprettet af OGR i database tabeller
REM =====================================================
set ogr_geom=geom
REM =====================================================

REM Navn på primary key felt oprettet af OGR i database tabeller
REM =====================================================
set ogr_fid=fid
REM =====================================================

REM Navn på administartivt dato felt (hvis det er lig med .ingenting.
REM oprettes og populeres feltet ikke
REM =====================================================
set ogr_dato=hent_dato
REM =====================================================

REM EPSG værdi for projektion (normalt 25832 aka. UTM32/ETRS89
REM =====================================================
set ogr_epsg=25832
REM =====================================================


REM Område definition minx..maxy til generering af spatielt indeks
REM angives med koordinatsæt i ogr_epsg defineret projektion
REM =====================================================

REM Frederikssund Kommune....
set "ogr_bbox=678577,6178960,702291,6202870"

REM Danmark.. (får ikke hele søterritoriet med)
REM SET "ogr_bbox=350000,6020000,950000,6450000"
REM =====================================================

