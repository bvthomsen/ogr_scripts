@echo on
rem call c:\regionsyd\release-1911-x64-gdal-2-4-mapserver-7-2\SDKShell.bat setenv hideoci
call D:\Projekter\geodata\release-1911-x64-gdal-3-0-mapserver-7-4\SDKShell.bat setenv hideoci
@echo on
set pgclientencoding=UTF-8
d:
cd D:\Projekter\geodata\DK_MAPINFO_UTM32-EUREF89\DK_MAPINFO_UTM32-EUREF89\FOT
for /R %%f in (*.tab) do ogr2ogr --config PG_USE_COPY yes -progress -lco OVERWRITE=YES -lco SCHEMA=fot      -a_srs EPSG:25832 -nlt PROMOTE_TO_MULTI -f "PostgreSQL" PG:"host=localhost port=5435 user=postgres password=ukulemy dbname=geodata" "%%f"

cd D:\Projekter\geodata\DK_MAPINFO_UTM32-EUREF89(1)\DK_MAPINFO_UTM32-EUREF89\MINIMAKS
for /R %%f in (*.tab) do ogr2ogr --config PG_USE_COPY yes -progress -lco OVERWRITE=YES -lco SCHEMA=matrikel -a_srs EPSG:25832 -nlt PROMOTE_TO_MULTI -f "PostgreSQL" PG:"host=localhost port=5435 user=postgres password=ukulemy dbname=geodata" "%%f"
