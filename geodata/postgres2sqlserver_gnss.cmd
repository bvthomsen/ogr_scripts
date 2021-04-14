REM - Kopiering af spordata fra original Postgres database til ny SQL Server database vha. OGR2OGR
@echo on
chcp 65001
set OSGEO4W_ROOT=C:\nst_sporimport-master\gdal
set path=%OSGEO4W_ROOT%\bin;%OSGEO4W_ROOT%\apps\proj-dev\bin;%OSGEO4W_ROOT%\apps\gdal-dev\bin;%WINDIR%\system32;%WINDIR%;%WINDIR%\system32\WBem
set JPEGMEM=1000000
SET PROJ_LIB=%OSGEO4W_ROOT%\share\proj
SET PGCLIENTENCODING=WIN-1252
ogr2ogr.exe --config MSSQLSPATIAL_USE_BCP false -append -update -a_srs EPSG:25832 -nlt PROMOTE_TO_MULTI -nln transit.test_data -dialect SQLITE -sql "SELECT '-1' AS id, typenavn, kategori, registre AS registrering, kommentar, created AS oprettet, initials AS ini, 'nst_spor_final' AS filepath from spordata_pol" -f "MSSQLSpatial" "MSSQL:server=nst-gis-sql01p.prod.sitad.dk;database=drc-spor;trusted_connection=yes;" PG:"host=localhost port=5432 user=postgres password=ukulemy dbname=nst_spor_final active_schema=data"                  
ogr2ogr.exe --config MSSQLSPATIAL_USE_BCP false -append -update -a_srs EPSG:25832 -nlt PROMOTE_TO_MULTI -nln transit.test_data -dialect SQLITE -sql "SELECT '-1' AS id, typenavn, kategori, registre AS registrering, kommentar, created AS oprettet, initials AS ini, 'nst_spor_final' AS filepath from spordata_pkt" -f "MSSQLSpatial" "MSSQL:server=nst-gis-sql01p.prod.sitad.dk;database=drc-spor;trusted_connection=yes;" PG:"host=localhost port=5432 user=postgres password=ukulemy dbname=nst_spor_final active_schema=data"                  
ogr2ogr.exe --config MSSQLSPATIAL_USE_BCP false -append -update -a_srs EPSG:25832 -nlt PROMOTE_TO_MULTI -nln transit.test_data -dialect SQLITE -sql "SELECT '-1' AS id, typenavn, kategori, registre AS registrering, kommentar, created AS oprettet, initials AS ini, 'nst_spor_final' AS filepath from spordata_lin" -f "MSSQLSpatial" "MSSQL:server=nst-gis-sql01p.prod.sitad.dk;database=drc-spor;trusted_connection=yes;" PG:"host=localhost port=5432 user=postgres password=ukulemy dbname=nst_spor_final active_schema=data"                  
pause



