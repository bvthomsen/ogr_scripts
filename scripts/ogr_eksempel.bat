@echo off
REM ============================================================================================
REM sæt CodePage til Latin-1 (Ingen bøvl med ÆØÅ i kommandolinien og filnavne)
REM ============================================================================================
chcp 1252 >nul
REM ============================================================================================
REM 
REM Eksempler på upload til hhv. Postgres og MS SQL Server fra div. inddata typer
REM de enkelte eksempler følger samme metode:
REM
REM .. Først kaldes ogr_envirnment.bat. Denne sætter path til oGDAL samt en række parametre, der sandsynligvis ikke
REM    skal ændres på. Se kommentarer i ogr_environment.bat.
REM .. Herefter sættes en environment variabel med forbindelsesparametre til databasen (pg_conn og/eller ms_conn). Se eksempel i denne fil. 
REM .. For hver indatakilde sættet en variabel (ogr_inp) med hovedinformationen om inddata kilde: Dette inkludere evt brugernavn og adgangskode 
REM    en ekskluderer geografisk, objekttype eller andre filtre.
REM .. For hvertlag, som skal uploades til databasen udføres kommandoprocedure ogr_postgres.bat (for Postgres database) eller ogr_mssql.bat (For ms sql server) 
REM    Begge kommando procedurer har følgende kaldemetode: call <proc> <ogr inddata-definition> <lag fra service eller *> <database forbindelse> <schemanavn> <tabelnavn> <objekttype eller *>
REM    <objekttype> kan være PKT (simpelt punkt), MPKT (Multipunkt), LIN (Simpel linie), MLIN (Multilinie), POL (Simpel polygon), MPOL (Multipolygon) eller *. Med * menes, at der ikke 
REM    genereres filterudtryk for objekttype. Ved angivelse af multi polygon/linie/punkt vil simple objekter automatisk omdannes til multi objekter, således det nye lag kun indeho9lder en objekttype
REM
REM == Programmører: Anette Rosengård Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM ============================================================================================
REM vis start tid (Ikke absolut nødvendig)
REM ============================================================================================
@echo ============================================================================================
@echo Starttid: %date% %time%
@echo ============================================================================================

REM ============================================================================================
REM Sæt "current dir" til opstartsdirectory for script (ikke bydende nødvendigt)
REM ============================================================================================
%~d0
cd "%~p0"

REM ============================================================================================
REM Opsætning at generelle parametre for upload proces (absolut nødvendigt)
REM ============================================================================================
call "%~dp0ogr_environment.bat"

REM ============================================================================================
REM set aktuelle parameter for host, dbname, user og password til *Postgres* database
REM ============================================================================================
set "pg_conn=host='myHost' dbname='myDatabase' user='myUser' password='myPassword' port='5432'"

REM ============================================================================================
REM set aktuelle parameter for server og database til *MS SQL Server* database
REM ============================================================================================
REM set "ms_conn=server=myserver;database=mydatabase;trusted_connection=yes"

REM ============================================================================================
REM ændring af client encoding for *Postgres* fra LATIN1 (standard - værdisat i ogr_environmet.bat) til UTF8
REM ============================================================================================
set PGCLIENTENCODING=UTF8

REM Upload af DAI data fra Miljøportalen (WFS)
REM ============================================================================================
set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/public/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"

REM Eksempel på mssql opsætning 
REM call "%~dp0ogr_mssql.bat" "%ogr_inp%" "dmp:ARTSFUND_FL"              "%ms_conn%" dai artsfund_fl              *

call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:ARTSFUND_FL"              "%pg_conn%" dai artsfund_fl              *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:ARTSFUND_LN"              "%pg_conn%" dai artsfund_ln              *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:ARTSFUND_PKT"             "%pg_conn%" dai artsfund_pkt             *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:BES_NAT_BUFFERZONER"      "%pg_conn%" dai bes_nat_bufferzoner      *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:BES_NATURTYPER"           "%pg_conn%" dai bes_naturtyper           *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:BES_STEN_JORDDIGER"       "%pg_conn%" dai bes_sten_jorddiger       *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:BESIGTIGELSE_FL"          "%pg_conn%" dai besigtigelse_fl          *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:BESIGTIGELSE_LN"          "%pg_conn%" dai besigtigelse_ln          *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:BESIGTIGELSE_PKT"         "%pg_conn%" dai besigtigelse_pkt         *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:BESIGTIGELSE_FL_STAT"     "%pg_conn%" dai besigtigelse_fl_stat     *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:Bnbo"                     "%pg_conn%" dai bnbo                     *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:DEVANO_DOK_FELTER"        "%pg_conn%" dai devano_dok_felter        *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:DEVANO_KORTLAEGNING"      "%pg_conn%" dai devano_kortlaegning      *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:DKJORD_NUANCERING"        "%pg_conn%" dai dkjord_nuancering        *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:Dkjord_projektfaser"      "%pg_conn%" dai dkjord_projektfaser      *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:Dkjord_uek"               "%pg_conn%" dai dkjord_uek               *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:Dkjord_ufk"               "%pg_conn%" dai dkjord_ufk               *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:DKJORD_V1"                "%pg_conn%" dai dkjord_v1                *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:DKJORD_V2"                "%pg_conn%" dai dkjord_v2                *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:DRIKKEVANDS_INTER_SENEST" "%pg_conn%" dai drikkevands_inter_senest *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:EF_FUGLE_BES_OMR"         "%pg_conn%" dai ef_fugle_bes_omr         *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:EF_HABITAT_OMR"           "%pg_conn%" dai ef_habitat_omr           *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:FOSFORKLASSER"            "%pg_conn%" dai fosforklasser            *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:FREDEDE_OMR"              "%pg_conn%" dai fredede_omr              *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:FREDEDE_OMR_FORSLAG"      "%pg_conn%" dai fredede_omr_forslag      *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_FL"     "%pg_conn%" dai fugleovervaagning_fl     *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_LN"     "%pg_conn%" dai fugleovervaagning_ln     *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_PKT"    "%pg_conn%" dai fugleovervaagning_pkt    *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:HABITATNATUR"             "%pg_conn%" dai habitatnatur             *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:INDSATS_NITRAT"           "%pg_conn%" dai indsats_nitrat           *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:Indv_opland_u_osd"        "%pg_conn%" dai indv_opland_u_osd        *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:KATEGORI3_NATUR"          "%pg_conn%" dai kategori3_natur          *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:KIRKEBYGGELINJER"         "%pg_conn%" dai kirkebyggelinjer         *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:KVAELSTOF_RED_POT"        "%pg_conn%" dai kvaelstof_red_pot        *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:KYSTNAERHEDSZONE"         "%pg_conn%" dai kystnaerhedszone         *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:NATUR_VILDT_RESERVAT"     "%pg_conn%" dai natur_vildt_reservat     *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:NATURA2000_OPL"           "%pg_conn%" dai natura2000_opl           *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:Naturregistreringer_FL"   "%pg_conn%" dai naturregistreringer_fl   *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:Naturregistreringer_PKT"  "%pg_conn%" dai naturregistreringer_pkt  *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:NITRATF_INDV_OMR_SENEST"  "%pg_conn%" dai nitratf_indv_omr_senest  *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:NITRATKLASSER"            "%pg_conn%" dai nitratklasser            *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:NOVANA_ARTSFUND_FL"       "%pg_conn%" dai novana_artsfund_fl       *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:NOVANA_ARTSFUND_LN"       "%pg_conn%" dai novana_artsfund_ln       *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:NOVANA_ARTSFUND_PKT"      "%pg_conn%" dai novana_artsfund_pkt      *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:NOVANA_PROEVEFELTER"      "%pg_conn%" dai novana_proevefelter      *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:NOVANA_STATIONER"         "%pg_conn%" dai novana_stationer         *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:OMR_KLASSIFICERING"       "%pg_conn%" dai omr_klassificering       *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:Opr_stationer"            "%pg_conn%" dai opr_stationer            *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:PAABUD_JFL"               "%pg_conn%" dai paabud_jfl               *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:RAASTOFOMR"               "%pg_conn%" dai raastofomr               *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:RAMSAR_OMR"               "%pg_conn%" dai ramsar_omr               *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:SKOVBYGGELINJER"          "%pg_conn%" dai skovbyggelinjer          *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:SOE_BES_LINJER"           "%pg_conn%" dai soe_bes_linjer           *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:AA_BES_LINJER"            "%pg_conn%" dai aa_bes_linjer            *


REM Upload af spildevands data fra Miljøportalen (WFS)
REM ============================================================================================
set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/puls/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"

call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:REGNBET_UDLEDNING"      "%pg_conn%" miljoe regnbet_udledning      *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:REGNBET_UDLEDNING_MAAL" "%pg_conn%" miljoe regnbet_udledning_maal *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:RENSEANLAEG"            "%pg_conn%" miljoe renseanlaeg            *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "dmp:RENSEANLAEG_MAAL"       "%pg_conn%" miljoe renseanlaeg_maal       *


REM Upload af SUT data fra Kortforsyningen (WFS)
REM ============================================================================================
set "ogr_inp=http://kortforsyningen.kms.dk/service?servicename=SutWFS_UTM&client=MapInfo&request=GetCapabilities&service=WFS&login=myUser&password=myPassword&bbox=678577,6178960,702291,6202870"

REM Nulstil midlertidigt ogr_bbox parameter, da service karambolerer med ogr2ogr ved brug af denne parameter. 
REM Boundig box inkorporeret i selve servicekald.
set "xbox=%ogr_bbox%" & set "ogr_bbox="

call "%~dp0ogr_postgres.bat" "%ogr_inp%" "Vej"       "%pg_conn%" sut vej     *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "Skel"      "%pg_conn%" sut skel    *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "Skelpunkt" "%pg_conn%" sut service *

set "ogr_bbox=%xbox%" & set "xbox="


REM Upload af data fra GEUS (WFS)
REM ============================================================================================
set "ogr_inp=http://data.geus.dk/geusmap/ows/25832.jsp?service=WFS&version=1.0.0&request=GetCapabilities&whoami=dummy@dummy.dk"

call "%~dp0ogr_postgres.bat" "%ogr_inp%" "jupiter_boringer_ws"           "%pg_conn%" geus jupiter_boringer_ws           *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "jupiter_bor_vandfors_almen_ws" "%pg_conn%" geus jupiter_bor_vandfors_almen_ws *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "jupiter_bor_vandfors_andre_ws" "%pg_conn%" geus jupiter_bor_vandfors_andre_ws *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "jupiter_anlaeg_ws"             "%pg_conn%" geus jupiter_anlaeg_ws             *


REM Upload af data fra FBB (WFS)
REM ============================================================================================
set "ogr_inp=http://www.kulturarv.dk/geoserver/wfs?service=wfs&version=1.0.0&request=GetCapabilities"

call "%~dp0ogr_postgres.bat" "%ogr_inp%" "fbb:view_bygning_fredede"             "%pg_conn%" fbb fredede_bygninger           *
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "fbb:view_bygning_fredningstatus_hoej" "%pg_conn%" fbb bygning_fredningstatus_hoej *

REM Upload af data fra Fund og fortidsminder ffm (WFS)
REM ============================================================================================
set "ogr_inp=http://www.kulturarv.dk/ffpublic/wfs?service=wfs&version=1.0.0&request=GetCapabilities"

call "%~dp0ogr_postgres.bat" "%ogr_inp%" "public:fundogfortidsminder_punkt_ikkefredet" "%pg_conn%" fbb fundogfortidsminder_punkt_ikkefredet  PKT
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "public:fundogfortidsminder_punkt_fredet"            "%pg_conn%" ffm fundogfortid_punkt_fredet      PKT
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "public:fundogfortidsminder_linie_alle"              "%pg_conn%" ffm fundogfortid_linie_alle        MLIN
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "public:fundogfortidsminder_areal_ka"                "%pg_conn%" ffm fundogfortid_areal_ka          MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "public:fundogfortidsminder_areal_beskyttelse"       "%pg_conn%" ffm fundogfortid_areal_beskyttelse MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "public:fundogfortidsminder_areal_alle"              "%pg_conn%" ffm fundogfortid_areal_alle        MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "public:fundogfortidsminder_areal_adm"               "%pg_conn%" ffm fundogfortid_areal_adm         MPOL


REM Upload af data fra Plansystem.dk plan pdk (WFS)
REM ============================================================================================
set "ogr_inp=WFS:http://geoservice.plansystem.dk/wfs?version=1.0.0"

REM brug where parameter i ogr2ogr .. kun data fra Frederikssund Kommune
set "ogr_where=komnr=250"
REM Fjern midlertidigt bbox parameter< bruges ikke samtidigt med where
set "xbox=%ogr_bbox%" & set "ogr_bbox="

call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_lokalplan_vedtaget_v"                "%pg_conn%" pdk lokalplan_vedtaget                MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_temalokalplan_vedtaget_v"            "%pg_conn%" pdk temalokalplan_vedtaget            MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_temalokalplan_forslag_v"             "%pg_conn%" pdk temalokalplan_forslag             MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_kommuneplanramme_vedtaget_v"         "%pg_conn%" pdk kommuneplanramme_vedtaget         MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_kommuneplanramme_forslag_v"          "%pg_conn%" pdk kommuneplanramme_forslag          MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_kommuneplantillaeg_vedtaget_v"       "%pg_conn%" pdk kommuneplantillaeg_vedtaget       MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_kommuneplantillaeg_forslag_v"        "%pg_conn%" pdk kommuneplantillaeg_forslag        MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_byzonesommerhusomraade_vedtaget_v"   "%pg_conn%" pdk byzonesommerhusomraade_vedtaget   MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_byzonesommerhusomraade_forslag_v"    "%pg_conn%" pdk byzonesommerhusomraade_forslag    MPOL
set "ogr_where="
set "ogr_bbox=%xbox%" & set "xbox="
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_tilslutningspligtomraade_vedtaget_v" "%pg_conn%" pdk tilslutningspligtomraade_vedtaget MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_forsyningomraade_vedtaget_v"         "%pg_conn%" pdk forsyningomraade_vedtaget         MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_kloakopland_vedtaget_v"              "%pg_conn%" pdk kloakopland_vedtaget              MPOL
call "%~dp0ogr_postgres.bat" "%ogr_inp%" "pdk:theme_pdk_forsyningsforbudomraade_forslag_v"   "%pg_conn%" pdk forsyningsforbudomraade_forslag   MPOL

REM Upload af data fra os2geo (GeoJson http)
REM ============================================================================================
REM NB!! Indeholder username snabel-a skal det angives som %%%%%%%%40 (Don't ask why !!)
set "ogr_inp=http://myUser%%%%%%%%40kommune.dk:myPassword@geo.os2geo.dk/api/export"

REM sæt srs til 4326 (longlat/wgs84)
set "ogr_epsg=4326"

call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-0cf16ed01ec89bd988508ebba0261cda" "OGRGeoJSON" "%pg_conn%" rfs badevand                  *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-5577a0a6d7b13f71eb4cebd47fc57374" "OGRGeoJSON" "%pg_conn%" rfs informationer_badevand    *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-2009e194560bd594f7f1e381668e229a" "OGRGeoJSON" "%pg_conn%" rfs afstribning               *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-7329765f31b7939dc2b457f4830586e7" "OGRGeoJSON" "%pg_conn%" rfs skilte_afmaerkning        *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef1508c5" "OGRGeoJSON" "%pg_conn%" rfs kommunale_legepladser     *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef28d5b6" "OGRGeoJSON" "%pg_conn%" rfs vinter                    *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef2df726" "OGRGeoJSON" "%pg_conn%" rfs vejbelysning_trafiksignal *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef2efe1e" "OGRGeoJSON" "%pg_conn%" rfs midlertidige_gravninger   *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef3100c7" "OGRGeoJSON" "%pg_conn%" rfs frederikssund_havn        *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c60971109cd56" "OGRGeoJSON" "%pg_conn%" rfs henkastet_affald          *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c609711b736cf" "OGRGeoJSON" "%pg_conn%" rfs vejudstyr                 *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c609711d79306" "OGRGeoJSON" "%pg_conn%" rfs veje_belaegning           *
call "%~dp0ogr_postgres.bat" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c609711e9af59" "OGRGeoJSON" "%pg_conn%" rfs beplantning               *

REM nulstil SRS til alm. værdi
set "ogr_epsg=25832"

REM ============================================================================================

REM vis sluttid
@echo.
@echo ============================================================================================
@echo Sluttid: %date% %time%
@echo ============================================================================================
