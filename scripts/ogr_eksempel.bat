REM ============================================================================================
REM vis start tid (Ikke absolut nødvendig)
REM ============================================================================================
@echo %time%

REM ============================================================================================
REM sæt CodePage til Latin-1 (Ingen bøvl med ÆØÅ i kommandolinien og filnavne)
REM ============================================================================================
chcp 1252

REM ============================================================================================
REM Sæt "current dir" til opstartsdirectory for sript (ikke bydende nødvendigt)
REM ============================================================================================
%~d0
cd %~p0

REM ============================================================================================
REM Opsætning at generelle parametre for upload proces (absolut nødvendigt)
REM ============================================================================================
call %~dp0ogr_environment.bat

REM ============================================================================================
REM ændring af client encoding for *Postgres* fra LATIN1 (standard - værdisat i ogr_environmet.bat) til UTF8
REM ============================================================================================
set PGCLIENTENCODING=UTF8

REM ============================================================================================
REM set aktuelle parameter for host, dbname, user og password til *Postgres* database
REM ============================================================================================
set "pg_conn=host='f-gis03' dbname='gis_test' user='postgres' password='ukulemy' port='5432'"

REM ============================================================================================
REM set aktuelle parameter for server og database til *MS SQL Server* database
REM ============================================================================================
REM set "ms_conn=server=myserver;database=mydatabase;trusted_connection=yes"
set "ms_conn=server=f-sql12;database=gis_test;trusted_connection=yes"


REM ============================================================================================
REM Eksempler på upload til hhv. Postgres (linie 1) og MS SQL Server (linie 2) fra div. inddata typer
REM Alle procedurer har følgende kaldemetode: call <proc> <ogr inddata-definition> <lag fra service eller *> <database forbindelse> <schemanavn> <tabelnavn>
REM ============================================================================================

REM ============================================================================================
REM Eksempel på upload af DAI data fra Miljøportalen (WFS)
REM ============================================================================================
set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/public/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"

REM <proc>                 <ogr inddata-definition> <lag fra service eller *> <database forbindelse> <schemanavn> <tabelnavn> <objekttype>
call %~dp0ogr_postgres.bat "%ogr_inp%"              "dmp:ARTSFUND_FL"         "%pg_conn%"            dai          artsfund_fl *
call %~dp0ogr_mssql.bat    "%ogr_inp%"              "dmp:ARTSFUND_FL"         "%ms_conn%"            dai          artsfund_fl


REM ============================================================================================
REM Eksempel på upload af spildevands data fra Miljøportalen (WFS)
REM ============================================================================================
set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/puls/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"

call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:REGNBET_UDLEDNING" "%pg_conn%" dai    regnbet_udledning
call %~dp0ogr_mssql.bat    "%ogr_inp%" "dmp:REGNBET_UDLEDNING" "%ms_conn%" dai    regnbet_udledning

REM ============================================================================================
REM Eksempel på upload af SUT data fra Kortforsyningen (WFS)
REM ============================================================================================

set "ogr_inp=http://kortforsyningen.kms.dk/service?servicename=SutWFS_UTM&client=MapInfo&service=WFS&login=demo&password=demo&request=GetCapabilities"

call %~dp0ogr_postgres.bat "%ogr_inp%" "Skel" "%pg_conn%" sut skel
call %~dp0ogr_mssql.bat    "%ogr_inp%" "Skel" "%ms_conn%" sut skel

REM ============================================================================================
REM Eksempel på upload af data fra GEUS (WFS)
REM ============================================================================================
set "ogr_inp=http://data.geus.dk/geusmap/ows/25832.jsp?service=WFS&version=1.0.0&request=GetCapabilities"

call %~dp0ogr_postgres.bat "%ogr_inp%" "jupiter_boringer_ws" "%pg_conn%" geus jupiter_boringer_ws
call %~dp0ogr_mssql.bat    "%ogr_inp%" "jupiter_boringer_ws" "%ms_conn%" geus jupiter_boringer_ws

REM ============================================================================================
REM Eksempel på upload af data fra FBB (WFS)
REM ============================================================================================
set "ogr_inp=http://www.kulturarv.dk/geoserver/wfs?service=wfs&version=1.0.0&request=GetCapabilities"

call %~dp0ogr_postgres.bat "%ogr_inp%" "fbb:view_bygning_fredede" "%pg_conn%" fbb fredede_bygninger
call %~dp0ogr_mssql.bat    "%ogr_inp%" "fbb:view_bygning_fredede" "%ms_conn%" fbb fredede_bygninger


REM ============================================================================================
REM Eksempel på upload af data fra Fund og Fortidsminder ffm (WFS)
REM ============================================================================================
set "ogr_inp=http://www.kulturarv.dk/ffpublic/wfs?service=wfs&version=1.0.0&request=GetCapabilities"

REM  Kommandoprocedure     Indata def. Lag def.                                      Database    Schema Tabel
call %~dp0ogr_postgres.bat "%ogr_inp%" "public:fundogfortidsminder_punkt_ikkefredet" "%pg_conn%" ffm fundogfortidsminder_punkt_ikkefredet
call %~dp0ogr_mssql.bat    "%ogr_inp%" "public:fundogfortidsminder_punkt_ikkefredet" "%ms_conn%" ffm fundogfortidsminder_punkt_ikkefredet


REM ============================================================================================
REM Eksempel på upload af data fra Plansystem.dk plan pdk (WFS)
REM ============================================================================================
set "ogr_inp=WFS:http://geoservice.plansystem.dk/wfs?version=1.0.0"

REM Eksempel på brug "where" parameter i ogr2ogr; henter kun data fra Frederikssund Kommune
set "ogr_where=komnr=250"

call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_lokalplan_vedtaget_v" "%pg_conn%" pdk lokalplan_vedtaget
call %~dp0ogr_mssql.bat    "%ogr_inp%" "pdk:theme_pdk_lokalplan_vedtaget_v" "%ms_conn%" pdk lokalplan_vedtaget

REM Nulstil where...
set ogr_where=


REM ============================================================================================
REM Eksempel på upload af data fra os2geo server (GeoJson http)
REM ============================================================================================
REM NB! Hvis myuser er en mail adresse i stil med: bruger@kommune.dk skrives det: bruger%%%%40kommune.dk, dvs. @ == %%%%40
set "ogr_inp=http://bruger%%%%40kommune.dk:brugerPassword@geo.os2geo.dk/api/export"

REM Data fra os2geo kommer i SRS LongLat/wgs84, så skift standard SRS fra 25832 (UTM32/ETRS89) til 4326 
set ogr_epsg=4326

call %~dp0ogr_postgres.bat "%ogr_inp%/db-0cf16ed01ec89bd988508ebba0261cda" "OGRGeoJSON" "%pg_conn%" rfs badevand
call %~dp0ogr_mssql.bat    "%ogr_inp%/db-0cf16ed01ec89bd988508ebba0261cda" "OGRGeoJSON" "%ms_conn%" rfs badevand

REM nulstil SRS til standard værdi
set ogr_epsg=25832


REM ============================================================================================
REM Eksempel på upload af shape filer
REM ============================================================================================
set "data_dir=H:\GitHub\ogr_scripts\testdata\1084_SHAPE_UTM32-EUREF89\MINIMAKS\BASIS

REM ændring af client encoding for *Postgres* tilbage til LATIN1
set PGCLIENTENCODING=LATIN1

call %~dp0ogr_postgres.bat "%data_dir%\ADMN_GR.shp" "*" "%pg_conn%" matrikel admin_grp
call %~dp0ogr_mssql.bat    "%data_dir%\ADMN_GR.shp" "*" "%ms_conn%" matrikel admin_grp


REM ============================================================================================
REM vis sluttid (ikke strengt nødvendigt)
REM ============================================================================================
:slut
@echo %time%
pause
