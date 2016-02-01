@set "echostate=off"
@echo %echostate%
@chcp 1252 >nul

%~d0
cd "%~p0"

call Y:\GDAL\release-1800-x64-gdal-1-11-mapserver-6-4\SDKShell.bat setenv hideoci
@echo %echostate%

@echo ============================================================================================
@echo Starttid: %date% %time%
@echo ============================================================================================

set "ogr_command=%~dp0ogr_mssql.bat"
set "ogr_conn=server=f-sql12;database=gis;trusted_connection=yes"
set "ogr_schema=dbo"
set "ogr_geom=geom"
set "ogr_fid=fid"
set "ogr_dato=hent_dato"
set "ogr_epsgs=25832"
set "ogr_epsgt=25832"
set "ogr_spatial=350000,6020000,950000,6450000"
set "ogr_bbox=678577 6178960 702291 6202870"
set "ogr_where="

set "ogr_inp=http://kortforsyningen.kms.dk/service?servicename=dagi_gml2&client=QGIS&request=GetCapabilities&service=WFS&version=1.1.1&LOGIN=Kommune250&PASSWORD=Dfghjkl10
call "%ogr_command%" "%ogr_inp%" "kms:KOMMUNE10"          "%ogr_conn%" dbo dagi_kommune          *
call "%ogr_command%" "%ogr_inp%" "kms:OPSTILLINGSKREDS10" "%ogr_conn%" dbo dagi_opstillingskreds *
call "%ogr_command%" "%ogr_inp%" "kms:SOGN10"             "%ogr_conn%" dbo dagi_sogn             *
call "%ogr_command%" "%ogr_inp%" "kms:POLITIKREDS10"      "%ogr_conn%" dbo dagi_politikreds      *
call "%ogr_command%" "%ogr_inp%" "kms:REGION10"           "%ogr_conn%" dbo dagi_region           *
call "%ogr_command%" "%ogr_inp%" "kms:RETSKREDS10"        "%ogr_conn%" dbo dagi_retskreds        *
call "%ogr_command%" "%ogr_inp%" "kms:POSTDISTRIKT10"     "%ogr_conn%" dbo dagi_postdistrikt     *

:afslutning

@echo.
@echo ============================================================================================
@echo Sluttid: %date% %time%
@echo ============================================================================================
pause
