@echo off
REM Opsætning at generelle parametre for upload proces (absolut nødvendigt)
REM ============================================================================================
call "%~dp0ogr_environment.bat"

REM vis start tid (Ikke absolut nødvendig)
REM ============================================================================================
@echo ============================================================================================
@echo Starttid: %date% %time%
@echo ============================================================================================

REM ============================================================================================
REM    Eksempler på upload til enten Postgres elller MS SQL Server fra div. inddata typer
REM    De enkelte eksempler følger samme metode:
REM
REM .. Først kaldes ogr_environment.bat. Denne procedure sætter bl.a. path til GDAL mappen samt en 
REM    række parametre der sjældent skal ændres (De kan dog ændres on-the-fly i nærværende procedure)
REM    Se kommentarer i ogr_environment.bat for de enkelte parametre.
REM .. Alle kommando procedurer har følgende kaldemetode: 
REM    call <proc> <ogr inddata-definition> <lag fra service eller *> <database forbindelse> <schemanavn> <tabelnavn> <objekttype eller *>
REM .. <objekttype> kan være PKT (simpelt punkt), MPKT (Multipunkt), LIN (Simpel linie), MLIN 
REM   (Multilinie), POL (Simpel polygon), MPOL (Multipolygon) eller *. Med * menes, at der ikke 
REM    genereres filterudtryk for objekttype. 
REM    Ved angivelse af multi polygon/linie/punkt vil simple objekter automatisk omdannes til 
REM    multi objekter, således det nye lag kun indeholder en objekttype
REM
REM == Programmører: Anette Rosengård Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM Upload af DAI data fra Miljøportalen (WFS)
REM ============================================================================================
set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/public/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"

call "%ogr_command%" "%ogr_inp%" "dmp:ARTSFUND_FL"              "%db_conn%" dai artsfund_fl              MPOL
call "%ogr_command%" "%ogr_inp%" "dmp:ARTSFUND_LN"              "%db_conn%" dai artsfund_ln              MLIN
call "%ogr_command%" "%ogr_inp%" "dmp:ARTSFUND_PKT"             "%db_conn%" dai artsfund_pkt             PKT
call "%ogr_command%" "%ogr_inp%" "dmp:BES_NAT_BUFFERZONER"      "%db_conn%" dai bes_nat_bufferzoner      *
call "%ogr_command%" "%ogr_inp%" "dmp:BES_NATURTYPER"           "%db_conn%" dai bes_naturtyper           *
call "%ogr_command%" "%ogr_inp%" "dmp:BES_STEN_JORDDIGER"       "%db_conn%" dai bes_sten_jorddiger       *
call "%ogr_command%" "%ogr_inp%" "dmp:BESIGTIGELSE_FL"          "%db_conn%" dai besigtigelse_fl          *
call "%ogr_command%" "%ogr_inp%" "dmp:BESIGTIGELSE_LN"          "%db_conn%" dai besigtigelse_ln          *
call "%ogr_command%" "%ogr_inp%" "dmp:BESIGTIGELSE_PKT"         "%db_conn%" dai besigtigelse_pkt         *
call "%ogr_command%" "%ogr_inp%" "dmp:BESIGTIGELSE_FL_STAT"     "%db_conn%" dai besigtigelse_fl_stat     *
call "%ogr_command%" "%ogr_inp%" "dmp:Bnbo"                     "%db_conn%" dai bnbo                     *
call "%ogr_command%" "%ogr_inp%" "dmp:DEVANO_DOK_FELTER"        "%db_conn%" dai devano_dok_felter        *
call "%ogr_command%" "%ogr_inp%" "dmp:DEVANO_KORTLAEGNING"      "%db_conn%" dai devano_kortlaegning      *
call "%ogr_command%" "%ogr_inp%" "dmp:DKJORD_NUANCERING"        "%db_conn%" dai dkjord_nuancering        *
call "%ogr_command%" "%ogr_inp%" "dmp:Dkjord_projektfaser"      "%db_conn%" dai dkjord_projektfaser      *
call "%ogr_command%" "%ogr_inp%" "dmp:Dkjord_uek"               "%db_conn%" dai dkjord_uek               *
call "%ogr_command%" "%ogr_inp%" "dmp:Dkjord_ufk"               "%db_conn%" dai dkjord_ufk               *
call "%ogr_command%" "%ogr_inp%" "dmp:DKJORD_V1"                "%db_conn%" dai dkjord_v1                *
call "%ogr_command%" "%ogr_inp%" "dmp:DKJORD_V2"                "%db_conn%" dai dkjord_v2                *
call "%ogr_command%" "%ogr_inp%" "dmp:DRIKKEVANDS_INTER_SENEST" "%db_conn%" dai drikkevands_inter_senest *
call "%ogr_command%" "%ogr_inp%" "dmp:EF_FUGLE_BES_OMR"         "%db_conn%" dai ef_fugle_bes_omr         *
call "%ogr_command%" "%ogr_inp%" "dmp:EF_HABITAT_OMR"           "%db_conn%" dai ef_habitat_omr           *
call "%ogr_command%" "%ogr_inp%" "dmp:FOSFORKLASSER"            "%db_conn%" dai fosforklasser            *
call "%ogr_command%" "%ogr_inp%" "dmp:FREDEDE_OMR"              "%db_conn%" dai fredede_omr              *
call "%ogr_command%" "%ogr_inp%" "dmp:FREDEDE_OMR_FORSLAG"      "%db_conn%" dai fredede_omr_forslag      *
call "%ogr_command%" "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_FL"     "%db_conn%" dai fugleovervaagning_fl     *
call "%ogr_command%" "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_LN"     "%db_conn%" dai fugleovervaagning_ln     *
call "%ogr_command%" "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_PKT"    "%db_conn%" dai fugleovervaagning_pkt    *
call "%ogr_command%" "%ogr_inp%" "dmp:HABITATNATUR"             "%db_conn%" dai habitatnatur             *
call "%ogr_command%" "%ogr_inp%" "dmp:INDSATS_NITRAT"           "%db_conn%" dai indsats_nitrat           *
call "%ogr_command%" "%ogr_inp%" "dmp:Indv_opland_u_osd"        "%db_conn%" dai indv_opland_u_osd        *
call "%ogr_command%" "%ogr_inp%" "dmp:KATEGORI3_NATUR"          "%db_conn%" dai kategori3_natur          *
call "%ogr_command%" "%ogr_inp%" "dmp:KIRKEBYGGELINJER"         "%db_conn%" dai kirkebyggelinjer         *
call "%ogr_command%" "%ogr_inp%" "dmp:KVAELSTOF_RED_POT"        "%db_conn%" dai kvaelstof_red_pot        *
call "%ogr_command%" "%ogr_inp%" "dmp:KYSTNAERHEDSZONE"         "%db_conn%" dai kystnaerhedszone         *
call "%ogr_command%" "%ogr_inp%" "dmp:NATUR_VILDT_RESERVAT"     "%db_conn%" dai natur_vildt_reservat     *
call "%ogr_command%" "%ogr_inp%" "dmp:NATURA2000_OPL"           "%db_conn%" dai natura2000_opl           *
call "%ogr_command%" "%ogr_inp%" "dmp:Naturregistreringer_FL"   "%db_conn%" dai naturregistreringer_fl   *
call "%ogr_command%" "%ogr_inp%" "dmp:Naturregistreringer_PKT"  "%db_conn%" dai naturregistreringer_pkt  *
call "%ogr_command%" "%ogr_inp%" "dmp:NITRATF_INDV_OMR_SENEST"  "%db_conn%" dai nitratf_indv_omr_senest  *
call "%ogr_command%" "%ogr_inp%" "dmp:NITRATKLASSER"            "%db_conn%" dai nitratklasser            *
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_ARTSFUND_FL"       "%db_conn%" dai novana_artsfund_fl       *
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_ARTSFUND_LN"       "%db_conn%" dai novana_artsfund_ln       *
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_ARTSFUND_PKT"      "%db_conn%" dai novana_artsfund_pkt      *
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_PROEVEFELTER"      "%db_conn%" dai novana_proevefelter      *
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_STATIONER"         "%db_conn%" dai novana_stationer         *
call "%ogr_command%" "%ogr_inp%" "dmp:OMR_KLASSIFICERING"       "%db_conn%" dai omr_klassificering       *
call "%ogr_command%" "%ogr_inp%" "dmp:Opr_stationer"            "%db_conn%" dai opr_stationer            *
call "%ogr_command%" "%ogr_inp%" "dmp:PAABUD_JFL"               "%db_conn%" dai paabud_jfl               *
call "%ogr_command%" "%ogr_inp%" "dmp:RAASTOFOMR"               "%db_conn%" dai raastofomr               *
call "%ogr_command%" "%ogr_inp%" "dmp:RAMSAR_OMR"               "%db_conn%" dai ramsar_omr               *
call "%ogr_command%" "%ogr_inp%" "dmp:SKOVBYGGELINJER"          "%db_conn%" dai skovbyggelinjer          *
call "%ogr_command%" "%ogr_inp%" "dmp:SOE_BES_LINJER"           "%db_conn%" dai soe_bes_linjer           *
call "%ogr_command%" "%ogr_inp%" "dmp:AA_BES_LINJER"            "%db_conn%" dai aa_bes_linjer            *

REM Upload af spildevands data fra Miljøportalen (WFS)
REM ============================================================================================
set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/puls/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"

call "%ogr_command%" "%ogr_inp%" "dmp:REGNBET_UDLEDNING"      "%db_conn%" miljoe regnbet_udledning      *
call "%ogr_command%" "%ogr_inp%" "dmp:REGNBET_UDLEDNING_MAAL" "%db_conn%" miljoe regnbet_udledning_maal *
call "%ogr_command%" "%ogr_inp%" "dmp:RENSEANLAEG"            "%db_conn%" miljoe renseanlaeg            *
call "%ogr_command%" "%ogr_inp%" "dmp:RENSEANLAEG_MAAL"       "%db_conn%" miljoe renseanlaeg_maal       *

REM Upload af SUT data fra Kortforsyningen (WFS) - udskift myUser og myPassword til rel. værdier
REM ============================================================================================
set "ogr_inp=http://kortforsyningen.kms.dk/service?servicename=SutWFS_UTM&client=MapInfo&request=GetCapabilities&service=WFS&login=myUser&password=myPassword&bbox=678577,6178960,702291,6202870"

REM Nulstil midlertidigt ogr_bbox parameter, da service karambolerer med ogr2ogr ved brug af denne parameter. 
REM I stedet er Bounding-Box inkorporeret i selve servicekaldet.
set "xbox=%ogr_bbox%" & set "ogr_bbox="

call "%ogr_command%" "%ogr_inp%" "Vej"       "%db_conn%" sut vej     *
call "%ogr_command%" "%ogr_inp%" "Skel"      "%db_conn%" sut skel    *
call "%ogr_command%" "%ogr_inp%" "Skelpunkt" "%db_conn%" sut service *

set "ogr_bbox=%xbox%" & set "xbox="

REM Upload af data fra GEUS (WFS) - udskift dummy@dummy.dk til relevant mail adresse
REM ============================================================================================

set "ogr_inp=http://data.geus.dk/geusmap/ows/25832.jsp?service=WFS&version=1.0.0&request=GetCapabilities&whoami=dummy@dummy.dk"

call "%ogr_command%" "%ogr_inp%" "jupiter_boringer_ws"           "%db_conn%" geus jupiter_boringer_ws           *
call "%ogr_command%" "%ogr_inp%" "jupiter_bor_vandfors_almen_ws" "%db_conn%" geus jupiter_bor_vandfors_almen_ws *
call "%ogr_command%" "%ogr_inp%" "jupiter_bor_vandfors_andre_ws" "%db_conn%" geus jupiter_bor_vandfors_andre_ws *
call "%ogr_command%" "%ogr_inp%" "jupiter_anlaeg_ws"             "%db_conn%" geus jupiter_anlaeg_ws             *


REM Upload af data fra FBB (WFS)
REM ============================================================================================
set "ogr_inp=http://www.kulturarv.dk/geoserver/wfs?service=wfs&version=1.0.0&request=GetCapabilities"

call "%ogr_command%" "%ogr_inp%" "fbb:view_bygning_fredede"             "%db_conn%" fbb fredede_bygninger           *
call "%ogr_command%" "%ogr_inp%" "fbb:view_bygning_fredningstatus_hoej" "%db_conn%" fbb bygning_fredningstatus_hoej *

REM Upload af data fra Fund og fortidsminder ffm (WFS)
REM ============================================================================================
set "ogr_inp=http://www.kulturarv.dk/ffpublic/wfs?service=wfs&version=1.0.0&request=GetCapabilities"

call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_punkt_ikkefredet"   "%db_conn%" fbb fundogfortidsminder_punkt_ikkefredet  PKT
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_punkt_fredet"       "%db_conn%" ffm fundogfortid_punkt_fredet             PKT
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_linie_alle"         "%db_conn%" ffm fundogfortid_linie_alle               MLIN
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_areal_ka"           "%db_conn%" ffm fundogfortid_areal_ka                 MPOL
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_areal_beskyttelse"  "%db_conn%" ffm fundogfortid_areal_beskyttelse        MPOL
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_areal_alle"         "%db_conn%" ffm fundogfortid_areal_alle               MPOL
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_areal_adm"          "%db_conn%" ffm fundogfortid_areal_adm                MPOL

REM Upload af data fra Plansystem.dk plan pdk (WFS)
REM ============================================================================================
set "ogr_inp=WFS:http://geoservice.plansystem.dk/wfs?version=1.0.0"

REM Eksempel på brug af where parameter i ogr2ogr .. kun data fra Frederikssund Kommune
set "ogr_where=komnr=250"
REM Fjern midlertidigt bbox parameter; bruges ikke samtidigt med where..
set "xbox=%ogr_bbox%" & set "ogr_bbox="

call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_lokalplan_vedtaget_v"                "%db_conn%" pdk lokalplan_vedtaget                MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_temalokalplan_vedtaget_v"            "%db_conn%" pdk temalokalplan_vedtaget            MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_temalokalplan_forslag_v"             "%db_conn%" pdk temalokalplan_forslag             MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kommuneplanramme_vedtaget_v"         "%db_conn%" pdk kommuneplanramme_vedtaget         MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kommuneplanramme_forslag_v"          "%db_conn%" pdk kommuneplanramme_forslag          MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kommuneplantillaeg_vedtaget_v"       "%db_conn%" pdk kommuneplantillaeg_vedtaget       MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kommuneplantillaeg_forslag_v"        "%db_conn%" pdk kommuneplantillaeg_forslag        MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_byzonesommerhusomraade_vedtaget_v"   "%db_conn%" pdk byzonesommerhusomraade_vedtaget   MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_byzonesommerhusomraade_forslag_v"    "%db_conn%" pdk byzonesommerhusomraade_forslag    MPOL

REM Reset bbox parameter og nulstil where..
set "ogr_where="
set "ogr_bbox=%xbox%" & set "xbox="

call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_tilslutningspligtomraade_vedtaget_v" "%db_conn%" pdk tilslutningspligtomraade_vedtaget MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_forsyningomraade_vedtaget_v"         "%db_conn%" pdk forsyningomraade_vedtaget         MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kloakopland_vedtaget_v"              "%db_conn%" pdk kloakopland_vedtaget              MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_forsyningsforbudomraade_forslag_v"   "%db_conn%" pdk forsyningsforbudomraade_forslag   MPOL

REM Upload af data fra os2geo (GeoJson http)
REM ============================================================================================
REM NB!! Indeholder username snabel-a skal det angives som %%%%%%%%40 (Don't ask why !!)
REM      http://myUser@kommune.dk:myPassword@geo.os2geo.dk/api/export" virker *ikke*, men nedenstående gør:
set "ogr_inp=http://myUser%%%%%%%%40kommune.dk:myPassword@geo.os2geo.dk/api/export"

REM sæt srs til 4326 (longlat/wgs84), da data modtages i denne SRS
set "ogr_epsg=4326"

call "%ogr_command%" "%ogr_inp%/db-0cf16ed01ec89bd988508ebba0261cda" "OGRGeoJSON" "%db_conn%" rfs badevand                  *
call "%ogr_command%" "%ogr_inp%/db-5577a0a6d7b13f71eb4cebd47fc57374" "OGRGeoJSON" "%db_conn%" rfs informationer_badevand    *
call "%ogr_command%" "%ogr_inp%/db-2009e194560bd594f7f1e381668e229a" "OGRGeoJSON" "%db_conn%" rfs afstribning               *
call "%ogr_command%" "%ogr_inp%/db-7329765f31b7939dc2b457f4830586e7" "OGRGeoJSON" "%db_conn%" rfs skilte_afmaerkning        *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef1508c5" "OGRGeoJSON" "%db_conn%" rfs kommunale_legepladser     *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef28d5b6" "OGRGeoJSON" "%db_conn%" rfs vinter                    *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef2df726" "OGRGeoJSON" "%db_conn%" rfs vejbelysning_trafiksignal *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef2efe1e" "OGRGeoJSON" "%db_conn%" rfs midlertidige_gravninger   *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef3100c7" "OGRGeoJSON" "%db_conn%" rfs frederikssund_havn        *
call "%ogr_command%" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c60971109cd56" "OGRGeoJSON" "%db_conn%" rfs henkastet_affald          *
call "%ogr_command%" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c609711b736cf" "OGRGeoJSON" "%db_conn%" rfs vejudstyr                 *
call "%ogr_command%" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c609711d79306" "OGRGeoJSON" "%db_conn%" rfs veje_belaegning           *
call "%ogr_command%" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c609711e9af59" "OGRGeoJSON" "%db_conn%" rfs beplantning               *

REM nulstil SRS til alm. værdi
set "ogr_epsg=25832"

REM Upload af tab - filer (DAGI zip data downloadet fra Kortfosyningen)
REM ============================================================================================
set "ogr_inp=C:\temp\DAGIREF_MAPINFO_UTM32-EUREF89\ADM\"

call "%ogr_command%" "%ogr_inp%SOGN.tab       * "%db_conn%" dagi sogn       *
call "%ogr_command%" "%ogr_inp%RETSKR.tab     * "%db_conn%" dagi retskr     *
call "%ogr_command%" "%ogr_inp%REGION.tab     * "%db_conn%" dagi region     *
call "%ogr_command%" "%ogr_inp%POSTNUMMER.tab * "%db_conn%" dagi postnummer *
call "%ogr_command%" "%ogr_inp%RETSKR.tab     * "%db_conn%" dagi retskr     *
call "%ogr_command%" "%ogr_inp%OPSTILKR.tab   * "%db_conn%" dagi opstilkr   *
call "%ogr_command%" "%ogr_inp%KOMMUNE.tab    * "%db_conn%" dagi kommune    *

REM Upload af shape - filer (Matrikel zip data downloadet fra Kortfosyningen)
REM ============================================================================================
set "ogr_inp=C:\temp\1084_SHAPE_UTM32-EUREF89\1084_SHAPE_UTM32-EUREF89\MINIMAKS\BASIS\"

REM Eksempel på brug af where parameter i ogr2ogr .. kun data fra Frederikssund Kommune
set "ogr_where=KOMKODE=250" & set "xbox=%ogr_bbox%" & set "ogr_bbox="

call "%ogr_command%" "%ogr_inp%CENTROIDE.shp  * "%db_conn%" matrikel centroide  *
call "%ogr_command%" "%ogr_inp%JORDSTYKKE.shp * "%db_conn%" matrikel jordstykke *

REM Reset bbox parameter og nulstil where..
set "ogr_where=" & set "ogr_bbox=%xbox%" & set "xbox="

REM vis sluttid
@echo.
@echo ============================================================================================
@echo Sluttid: %date% %time%
@echo ============================================================================================

   