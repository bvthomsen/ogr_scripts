@echo on
call D:\Projekter\geodata\release-1911-x64-gdal-3-0-mapserver-7-4\SDKShell.bat setenv hideoci
@echo on
set SHAPE_ENCODING="ISO-8859-1"
ogr2ogr -progress -dim 2 -f gpkg D:\Projekter\geodata\geodata3.gpkg /vsizip//vsicurl/ftp://qgisdk:qgisdk@ftp.kortforsyningen.dk/matrikeldata/matrikelkort/SHAPE/DK_SHAPE_UTM32-EUREF89.zip/DK_SHAPE_UTM32-EUREF89/MINIMAKS/BASIS
pause
