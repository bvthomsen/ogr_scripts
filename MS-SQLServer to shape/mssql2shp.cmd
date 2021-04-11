@call D:\release-1928-x64-gdal-3-2-mapserver-7-6\SDKShell.bat setenv hideoci >nul
echo on

rem .. Selve kommandolinjen ..
call :ogr localhost\sqlexpress geodata ogrusr ogrpassw fot d:\tmp "bassin bygning bykerne"
rem Evt. flere kommandoer som ovenstaaende med andre parametre
rem call :ogr #server #database #db-user #db-password #db-schema #shape-directory #db-tablenames
exit

:ogr
set dir=%6
set files=%7
for %%g in (%files:"=%) do ogr2ogr -f "ESRI Shapefile" "%dir:"=%\%%g.shp" "MSSQL:server=%1;database=%2;uid=%3;pwd=%4;" -sql "SELECT *, CONVERT(varchar, getdate(), 23) AS ogr_date FROM [%5].[%%g]" -overwrite -a_srs "EPSG:25832"