REM sæt CodePage til Latin-1 (Ingen bøvl med ÆØÅ i kommandolinien)
REM ============================================================================================
chcp 1252
REM ============================================================================================

REM Sæt "current dir" til opstartsdirectory (ikke bydende nødvendigt)
REM ============================================================================================
%~d0
cd %~p0
REM ============================================================================================

REM Opsætning at generelle parametre for upload proces (absolut nødvendigt)
REM ============================================================================================
call %~dp0ogr_environment.bat
REM ============================================================================================

REM Upload af shape filer fra h-drev
REM ============================================================================================

set "data_dir=H:\GitHub\ogr_scripts\testdata\1084_SHAPE_UTM32-EUREF89\MINIMAKS\BASIS\
set "db_conn=host='f-gis03' dbname='gis_test' user='postgres' password='ukulemy' port='5432'"

call %~dp0ogr_postgres.bat "%data_dir%SKEL.shp" "*" "%db_conn%" matrikel skel
REM ============================================================================================
pause