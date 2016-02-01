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
set "ogr_conn=server=f-sql12;database=dai;trusted_connection=yes"
set "ogr_schema=dbo"
set "ogr_geom=geom"
set "ogr_fid=fid"
set "ogr_dato=hent_dato"
set "ogr_epsgs=25832"
set "ogr_epsgt=25832"
set "ogr_spatial=350000,6020000,950000,6450000"
set "ogr_bbox=678577 6178960 702291 6202870"
set "ogr_where="

set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/public/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"

call "%ogr_command%" "%ogr_inp%" "dmp:BES_VANDLOEB" "%ogr_conn%" dbo bes_vandloeb MLIN


:afslutning

@echo.
@echo ============================================================================================
@echo Sluttid: %date% %time%
@echo ============================================================================================
pause
