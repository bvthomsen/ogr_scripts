@call D:\release-1928-x64-gdal-3-2-mapserver-7-6\SDKShell.bat setenv hideoci >nul

rem MS SQLServer sql staetment without table definition
set "sql_pre=SELECT *, CONVERT(varchar, getdate(), 23) AS ogr_date FROM"
echo on
rem MS SQLServer to shape using username / password ...
rem call :mssql_up2shp #server #database #db-user #db-password #db-schema #shape-directory #db-tablenames
call :mssql_up2shp localhost\sqlexpress geodata ogrusr ogrpassw fot d:\tmp "bassin bygning bykerne"
pause
rem MS SQLServer to shape using integrated security ...
rem call :mssql_is2shp #server #database #db-schema #shape-directory #db-tablenames
call :mssql_is2shp localhost\sqlexpress geodata fot d:\tmp "bassin bygning bykerne"
pause
exit

rem Subroutine: MS SQLServer to shape using username / password
:mssql_up2shp
set srv=%1
set db=%2
set uid=%3
set pwd=%4
set schema=%5
set dir=%6
if "%dir:~-1%" == "\" set dir=%dir:~0,-1%
set files=%7
for %%g in (%files:"=%) do ogr2ogr -f "ESRI Shapefile" "%dir:"=%\%%g.shp" "MSSQL:server=%srv:"=%;database=%db:"=%;uid=%uid:"=%;pwd=%pwd:"=%;" -sql "%sql_pre% [%schema:"=%].[%%g]" -overwrite -a_srs "EPSG:25832"
goto :EOF

rem Subroutine: MS SQLServer to shape using integrated security
:mssql_is2shp
set srv=%1
set db=%2
set schema=%3
set dir=%4
if "%dir:~-1%"=="\" set dir=%dir:~0,-1%
set files=%5
for %%g in (%files:"=%) do ogr2ogr -f "ESRI Shapefile" "%dir:"=%\%%g.shp" "MSSQL:server=%srv:"=%;database=%db:"=%;trusted_connection=yes;" -sql "%sql_pre% [%schema:"=%].[%%g]" -overwrite -a_srs "EPSG:25832"
goto :EOF
