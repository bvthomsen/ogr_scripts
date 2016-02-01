@set "echostate=off"
@echo %echostate%
@chcp 1252 >nul

%~d0
cd "%~p0"

REM GDAL v. 2.x fra netværk
::call Y:\GDAL\release-1800-x64-gdal-mapserver\SDKShell.bat setenv hideoci

REM GDAL v. 2.x fra f-gis02
::call D:\Scripts\GDAL\release-1800-x64-gdal-mapserver\SDKShell.bat setenv hideoci

REM GDAL v. 1.x fra netværk
call Y:\GDAL\release-1800-x64-gdal-1-11-mapserver-6-4\SDKShell.bat setenv hideoci

REM GDAL v. 1.x fra f-gis02
::call D:\Scripts\GDAL\release-1800-x64-gdal-1-11-mapserver-6-4\SDKShell.bat setenv hideoci

@echo %echostate%

@echo ============================================================================================
@echo Starttid: %date% %time%
@echo ============================================================================================

REM ms sql - ogr v. 1.x
set "ogr_command=%~dp0ogr_mssql.bat"
REM ms sql - ogr v. 2.x
::set "ogr_command=%~dp0ogr2_mssql.bat"

set "ogr_schema=dbo"
set "ogr_geom=geom"
set "ogr_fid=fid"
set "ogr_dato=hent_dato"
set "ogr_epsgs=25832"
set "ogr_epsgt=25832"
set "ogr_spatial=350000,6020000,950000,6450000"
set "ogr_bbox=678577 6178960 702291 6202870"
set "ogr_where="

REM ==============================================================================================
REM DAGI (komplet)
REM ==============================================================================================

REM drift
::set "ogr_conn=server=f-sql12;database=gis;trusted_connection=yes"
REM test
set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"
set "ogr_inp=http://kortforsyningen.kms.dk/service?servicename=dagi_gml2&client=QGIS&request=GetCapabilities&service=WFS&version=1.1.1&LOGIN=Kommune250&PASSWORD=Dfghjkl10

call "%ogr_command%" "%ogr_inp%" "kms:KOMMUNE10"          "%ogr_conn%" dbo dagi_kommune          *
call "%ogr_command%" "%ogr_inp%" "kms:OPSTILLINGSKREDS10" "%ogr_conn%" dbo dagi_opstillingskreds *
call "%ogr_command%" "%ogr_inp%" "kms:SOGN10"             "%ogr_conn%" dbo dagi_sogn             *
call "%ogr_command%" "%ogr_inp%" "kms:POLITIKREDS10"      "%ogr_conn%" dbo dagi_politikreds      *
call "%ogr_command%" "%ogr_inp%" "kms:REGION10"           "%ogr_conn%" dbo dagi_region           *
call "%ogr_command%" "%ogr_inp%" "kms:RETSKREDS10"        "%ogr_conn%" dbo dagi_retskreds        *
call "%ogr_command%" "%ogr_inp%" "kms:POSTDISTRIKT10"     "%ogr_conn%" dbo dagi_postdistrikt     *

REM ==============================================================================================
REM DAI (ikke komplet)
REM ==============================================================================================

set "ogr_conn=server=f-sql12;database=dai;trusted_connection=yes"
set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/public/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"

call "%ogr_command%" "%ogr_inp%" "dmp:BES_VANDLOEB" "%ogr_conn%" dbo bes_vandloeb MLIN

pause
