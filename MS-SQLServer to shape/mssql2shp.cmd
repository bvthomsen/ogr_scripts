@call D:\release-1928-x64-gdal-3-2-mapserver-7-6\SDKShell.bat setenv hideoci >nul
echo on

rem MS SQLServer to shape using username / password ...
rem call :mssql_up2shp #server #database #db-user #db-password #db-schema #shape-directory #db-tablenames
call :mssql_up2shp localhost\sqlexpress geodata ogrusr ogrpassw fot d:\tmp "bassin bygning bykerne"

rem MS SQLServer to shape using integrated security ...
rem call :mssql_is2shp #server #database #db-schema #shape-directory #db-tablenames
call :mssql_is2shp localhost\sqlexpress geodata fot d:\tmp "bassin bygning bykerne"

exit

:mssql_up2shp
set dir=%6
set files=%7
for %%g in (%files:"=%) do ogr2ogr -f "ESRI Shapefile" "%dir:"=%\%%g.shp" "MSSQL:server=%1;database=%2;uid=%3;pwd=%4;" -sql "SELECT *, CONVERT(varchar, getdate(), 23) AS ogr_date FROM [%5].[%%g]" -overwrite -a_srs "EPSG:25832"
goto :EOF

:mssql_is2shp
set dir=%4
set files=%5
for %%g in (%files:"=%) do ogr2ogr -f "ESRI Shapefile" "%dir:"=%\%%g.shp" "MSSQL:server=%1;database=%2;trusted_connection=yes;" -sql "SELECT *, CONVERT(varchar, getdate(), 23) AS ogr_date FROM [%3].[%%g]" -overwrite -a_srs "EPSG:25832"
goto :EOF
