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
set "db_conn=server=f-gis03;database=gis_test;trusted_connection=yes"

call %~dp0ogr_mssql.bat "%data_dir%ADMN_GR.shp" "*" "%db_conn%" matrikel admin_grp
call %~dp0ogr_mssql.bat "%data_dir%CENTROIDE.shp" "*" "%db_conn%" matrikel centroide
call %~dp0ogr_mssql.bat "%data_dir%JORDSTYKKE.shp" "*" "%db_conn%" matrikel jordstykke
call %~dp0ogr_mssql.bat "%data_dir%OPTAGETVEJ.shp" "*" "%db_conn%" matrikel optagetvej
call %~dp0ogr_mssql.bat "%data_dir%SKEL.shp" "*" "%db_conn%" matrikel skel
call %~dp0ogr_mssql.bat "%data_dir%SKELKREDS.shp" "*" "%db_conn%" matrikel skelkreds
call %~dp0ogr_mssql.bat "%data_dir%SKELPKT.shp" "*" "%db_conn%" matrikel skelpkt

REM ============================================================================================
pause