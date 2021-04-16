@call D:\release-1928-x64-gdal-3-2-mapserver-7-6\SDKShell.bat setenv hideoci >nul
echo on

rem MS SQLServer to shape using username / password ...
rem call :mssql_up2shp #server #database #db-user #db-password #db-schema #shape-directory #db-tablenames
call :mssql_up2shp localhost\sqlexpress geodata ogrusr ogrpassw fot d:\tmp "bassin bygning bykerne"

rem MS SQLServer to shape using integrated security ...
rem call :mssql_is2shp #server #database #db-schema #shape-directory #db-tablenames
call :mssql_is2shp localhost\sqlexpress geodata fot d:\tmp "bassin bygning bykerne"

exit

rem Subroutine: MS SQLServer to shape using username / password
:mssql_up2shp
set srv=%1
set db=%2
set schema=%3
set uid=%4
set pwd=%5
set dir=%6\
set dir=%dir:\\=%
set files=%7
for %%g in (%files:"=%) do ogr2ogr -f "ESRI Shapefile" "%dir:"=%\%%g.shp" "MSSQL:server="%srv:"=%;database="%db:"=%;uid="%uid:"=%;pwd="%pwd:"=%;" -sql "SELECT *, CONVERT(varchar, getdate(), 23) AS ogr_date FROM ["%schema:"=%].[%%g]" -overwrite -a_srs "EPSG:25832"
goto :EOF

rem Subroutine: MS SQLServer to shape using integrated security
:mssql_is2shp
set srv=%1
set db=%2
set schema=%3
set dir=%6\
set dir=%dir:\\=%
set files=%5
for %%g in (%files:"=%) do ogr2ogr -f "ESRI Shapefile" "%dir:"=%\%%g.shp" "MSSQL:server="%srv:"=%;database="%db:"=%;trusted_connection=yes;" -sql "SELECT *, CONVERT(varchar, getdate(), 23) AS ogr_date FROM ["%schema:"=%].[%%g]" -overwrite -a_srs "EPSG:25832"
goto :EOF
