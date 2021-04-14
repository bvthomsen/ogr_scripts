@echo on
rem call c:\regionsyd\release-1911-x64-gdal-2-4-mapserver-7-2\SDKShell.bat setenv hideoci
call D:\Projekter\geodata\release-1911-x64-gdal-3-0-mapserver-7-4\SDKShell.bat setenv hideoci
@echo on
set pgclientencoding=UTF-8
d:
cd D:\Projekter\geodata\DK_SHAPE_UTM32-EUREF89(1)\DK_SHAPE_UTM32-EUREF89\FOT
for /R %%f in (*.shp) do ogr2ogr -overwrite -progress -dim 2 -nlt PROMOTE_TO_MULTI -a_srs EPSG:25832 -lco "SCHEMA=fot" -lco "OVERWRITE=YES" -f MSSQLSpatial "MSSQL:DRIVER={SQL Server Native Client 11.0};server=localhost\SQLEXPRESS;database=geodata;trusted_connection=yes" "%%f"
cd D:\Projekter\geodata\DK_SHAPE_UTM32-EUREF89\DK_SHAPE_UTM32-EUREF89\MINIMAKS
for /R %%f in (*.shp) do ogr2ogr -overwrite -progress -dim 2 -nlt PROMOTE_TO_MULTI -a_srs EPSG:25832 -lco "SCHEMA=matrikel" -lco "OVERWRITE=YES" -f MSSQLSpatial "MSSQL:DRIVER={SQL Server Native Client 11.0};server=localhost\SQLEXPRESS;database=geodata;trusted_connection=yes" "%%f"
:: --config GDAL_DRIVER_PATH C:\OSGeo4W64\apps\gdal-dev\bin\gdalplugins
::c:\regionsyd\release-1911-x64-gdal-2-4-mapserver-7-2\