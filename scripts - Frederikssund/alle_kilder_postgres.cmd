@echo off
call "%~dp0ogr_environment.cmd"

REM PostgreSQL
set "ogr_command=%~dp0ogr_postgres.cmd"
set "PGCLIENTENCODING=UTF8"
set "ogr_conn=host='f-gis03' port='5432' dbname='gis' user='postgres' password='ukulemy'"
set "ogr_load=OVERWRITE"


REM ============================================================================================
REM Upload af SUT data fra Kortforsyningen (WFS) .. Erstat **login** og **password** med korrekte værdier
REM ============================================================================================
REM Bounding box skal indlejres i connection streng; ogr_bbox-værdi "tal1 tal2 tal3 tal4" ændres til "tal1,tal2,tal3,tal4" on-the-fly
::????set "ogr_inp=http://kortforsyningen.kms.dk/service?servicename=SutWFS_UTM&client=MapInfo&request=GetCapabilities&service=WFS&login=**login**&password=**password**&bbox=%ogr_bbox: =,%"
set "ogr_inp=http://kortforsyningen.kms.dk/service?servicename=SutWFS_UTM&client=MapInfo&request=GetCapabilities&service=WFS&login=Kommune250&password=Dfghjkl10&bbox=%ogr_bbox: =,%"
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

REM SUT skal have BBOX som indlejret værdi i connection streng, derfor nulstilles ogr_bbox midlertidigt
set "xbox=%ogr_bbox%" & set "ogr_bbox="

call "%ogr_command%" "%ogr_inp%" "Vej"       "%ogr_conn%" sut vej       MLIN
call "%ogr_command%" "%ogr_inp%" "Skel"      "%ogr_conn%" sut skel      MLIN
call "%ogr_command%" "%ogr_inp%" "Skelpunkt" "%ogr_conn%" sut skelpunkt PKT

REM Reset ogr_bbox
set "ogr_bbox=%xbox%" & set "xbox="


REM ============================================================================================
REM Upload af data fra FBB (WFS)
REM ============================================================================================
set "ogr_inp=http://www.kulturarv.dk/geoserver/wfs?service=wfs&version=1.0.0&request=GetCapabilities"
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

call "%ogr_command%" "%ogr_inp%" "fbb:view_bygning_fredede"             "%ogr_conn%" fbb frededebygninger            *
call "%ogr_command%" "%ogr_inp%" "fbb:view_bygning_fredningstatus_hoej" "%ogr_conn%" fbb bygning_fredningstatus_hoej *


REM ============================================================================================
REM Upload af data fra Kulturarv (WFS)
REM ============================================================================================
set "ogr_inp=http://www.kulturarv.dk/ffpublic/wfs?service=wfs&version=1.0.0&request=GetCapabilities"
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_punkt_ikkefredet"   "%ogr_conn%" ffm fundogfortid_punkt_ikkefredet  PKT
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_punkt_fredet"       "%ogr_conn%" ffm fundogfortid_punkt_fredet      PKT
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_linie_alle"         "%ogr_conn%" ffm fundogfortid_linie_alle        MLIN
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_areal_ka"           "%ogr_conn%" ffm fundogfortid_areal_ka          MPOL
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_areal_beskyttelse"  "%ogr_conn%" ffm fundogfortid_areal_beskyttelse MPOL
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_areal_alle"         "%ogr_conn%" ffm fundogfortid_areal_alle        MPOL
call "%ogr_command%" "%ogr_inp%" "public:fundogfortidsminder_areal_adm"          "%ogr_conn%" ffm fundogfortid_areal_adm         MPOL


REM ============================================================================================
REM Upload af data fra GEUS (WFS) - udskift dummy@dummy.dk til relevant mail adresse
REM ============================================================================================
set "ogr_inp=http://data.geus.dk/geusmap/ows/25832.jsp?service=WFS&version=1.0.0&request=GetCapabilities&whoami=dummy@dummy.dk"
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

call "%ogr_command%" "%ogr_inp%" "jupiter_boringer_ws"           "%ogr_conn%" geus jupiter_boringer_ws           *
call "%ogr_command%" "%ogr_inp%" "jupiter_bor_vandfors_almen_ws" "%ogr_conn%" geus jupiter_bor_vandfors_almen_ws *
call "%ogr_command%" "%ogr_inp%" "jupiter_bor_vandfors_andre_ws" "%ogr_conn%" geus jupiter_bor_vandfors_andre_ws *
call "%ogr_command%" "%ogr_inp%" "jupiter_anlaeg_ws"             "%ogr_conn%" geus jupiter_anlaeg_ws             *

REM ============================================================================================
REM Upload af DAI data fra Miljøportalen (WFS)
REM ============================================================================================
set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/public/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

call "%ogr_command%" "%ogr_inp%" "dmp:AA_BES_LINJER"            "%ogr_conn%" dai aa_bes_linjer            *
call "%ogr_command%" "%ogr_inp%" "dmp:ARTSFUND_FL"              "%ogr_conn%" dai artsfund_fl              MPOL
call "%ogr_command%" "%ogr_inp%" "dmp:ARTSFUND_LN"              "%ogr_conn%" dai artsfund_ln              MLIN
call "%ogr_command%" "%ogr_inp%" "dmp:ARTSFUND_PKT"             "%ogr_conn%" dai artsfund_pkt             PKT
call "%ogr_command%" "%ogr_inp%" "dmp:BES_NAT_BUFFERZONER"      "%ogr_conn%" dai bes_nat_bufferzoner      *
call "%ogr_command%" "%ogr_inp%" "dmp:BES_NATURTYPER"           "%ogr_conn%" dai bes_naturtyper           *
call "%ogr_command%" "%ogr_inp%" "dmp:BES_STEN_JORDDIGER"       "%ogr_conn%" dai bes_sten_jorddiger       *
call "%ogr_command%" "%ogr_inp%" "dmp:BES_VANDLOEB"             "%ogr_conn%" dai bes_vandloeb             MLIN
call "%ogr_command%" "%ogr_inp%" "dmp:BESIGTIGELSE_FL"          "%ogr_conn%" dai besigtigelse_fl          *
call "%ogr_command%" "%ogr_inp%" "dmp:BESIGTIGELSE_FL_STAT"     "%ogr_conn%" dai besigtigelse_fl_stat     *
call "%ogr_command%" "%ogr_inp%" "dmp:BESIGTIGELSE_LN"          "%ogr_conn%" dai besigtigelse_ln          *
call "%ogr_command%" "%ogr_inp%" "dmp:BESIGTIGELSE_PKT"         "%ogr_conn%" dai besigtigelse_pkt         *
call "%ogr_command%" "%ogr_inp%" "dmp:Bnbo"                     "%ogr_conn%" dai bnbo                     *
call "%ogr_command%" "%ogr_inp%" "dmp:DEVANO_DOK_FELTER"        "%ogr_conn%" dai devano_dok_felter        *
call "%ogr_command%" "%ogr_inp%" "dmp:DEVANO_KORTLAEGNING"      "%ogr_conn%" dai devano_kortlaegning      *
call "%ogr_command%" "%ogr_inp%" "dmp:DKJORD_NUANCERING"        "%ogr_conn%" dai dkjord_nuancering        *
call "%ogr_command%" "%ogr_inp%" "dmp:Dkjord_projektfaser"      "%ogr_conn%" dai dkjord_projektfaser      *
call "%ogr_command%" "%ogr_inp%" "dmp:Dkjord_uek"               "%ogr_conn%" dai dkjord_uek               *
call "%ogr_command%" "%ogr_inp%" "dmp:Dkjord_ufk"               "%ogr_conn%" dai dkjord_ufk               *
call "%ogr_command%" "%ogr_inp%" "dmp:DKJORD_V1"                "%ogr_conn%" dai dkjord_v1                *
call "%ogr_command%" "%ogr_inp%" "dmp:DKJORD_V2"                "%ogr_conn%" dai dkjord_v2                *
call "%ogr_command%" "%ogr_inp%" "dmp:DRIKKEVANDS_INTER"        "%ogr_conn%" dai drikkevands_inter        *
call "%ogr_command%" "%ogr_inp%" "dmp:FOELS_INDV_OMR"           "%ogr_conn%" dai foels_indv_omr           *
call "%ogr_command%" "%ogr_inp%" "dmp:FOSFORKLASSER"            "%ogr_conn%" dai fosforklasser            *
call "%ogr_command%" "%ogr_inp%" "dmp:FREDEDE_OMR"              "%ogr_conn%" dai fredede_omr              *
call "%ogr_command%" "%ogr_inp%" "dmp:FREDEDE_OMR_FORSLAG"      "%ogr_conn%" dai fredede_omr_forslag      *
call "%ogr_command%" "%ogr_inp%" "dmp:FUGLE_BES_OMR"            "%ogr_conn%" dai fugle_bes_omr            *
call "%ogr_command%" "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_FL"     "%ogr_conn%" dai fugleovervaagning_fl     *
call "%ogr_command%" "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_LN"     "%ogr_conn%" dai fugleovervaagning_ln     *
call "%ogr_command%" "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_PKT"    "%ogr_conn%" dai fugleovervaagning_pkt    *
call "%ogr_command%" "%ogr_inp%" "dmp:HABITAT_OMR"              "%ogr_conn%" dai habitat_omr              *
call "%ogr_command%" "%ogr_inp%" "dmp:HABITATNATUR"             "%ogr_conn%" dai habitatnatur             *
call "%ogr_command%" "%ogr_inp%" "dmp:HNV"                      "%ogr_conn%" dai hnv                      *
call "%ogr_command%" "%ogr_inp%" "dmp:INDSATSOMR"               "%ogr_conn%" dai indsatsomr               *
call "%ogr_command%" "%ogr_inp%" "dmp:Indv_opland_u_osd"        "%ogr_conn%" dai indv_opland_u_osd        *
call "%ogr_command%" "%ogr_inp%" "dmp:KATEGORI3_NATUR"          "%ogr_conn%" dai kategori3_natur          *
call "%ogr_command%" "%ogr_inp%" "dmp:KIRKEBYGGELINJER"         "%ogr_conn%" dai kirkebyggelinjer         *
call "%ogr_command%" "%ogr_inp%" "dmp:KVAELSTOF_RED_POT"        "%ogr_conn%" dai kvaelstof_red_pot        *
call "%ogr_command%" "%ogr_inp%" "dmp:KYSTNAERHEDSZONE"         "%ogr_conn%" dai kystnaerhedszone         *
call "%ogr_command%" "%ogr_inp%" "dmp:NATUR_VILDT_RESERVAT"     "%ogr_conn%" dai natur_vildt_reservat     *
call "%ogr_command%" "%ogr_inp%" "dmp:NATURA2000_OPL"           "%ogr_conn%" dai natura2000_opl           *
call "%ogr_command%" "%ogr_inp%" "dmp:Naturregistreringer_FL"   "%ogr_conn%" dai naturregistreringer_fl   *
call "%ogr_command%" "%ogr_inp%" "dmp:Naturregistreringer_PKT"  "%ogr_conn%" dai naturregistreringer_pkt  *
call "%ogr_command%" "%ogr_inp%" "dmp:NITRATKLASSER"            "%ogr_conn%" dai nitratklasser            *
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_ARTSFUND_FL"       "%ogr_conn%" dai novana_artsfund_fl       MPOL
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_ARTSFUND_LN"       "%ogr_conn%" dai novana_artsfund_ln       MLIN
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_ARTSFUND_PKT"      "%ogr_conn%" dai novana_artsfund_pkt      PKT
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_PROEVEFELTER"      "%ogr_conn%" dai novana_proevefelter      *
call "%ogr_command%" "%ogr_inp%" "dmp:NOVANA_STATIONER"         "%ogr_conn%" dai novana_stationer         *
call "%ogr_command%" "%ogr_inp%" "dmp:OMR_KLASSIFICERING"       "%ogr_conn%" dai omr_klassificering       *
call "%ogr_command%" "%ogr_inp%" "dmp:PAABUD_JFL"               "%ogr_conn%" dai paabud_jfl               *
call "%ogr_command%" "%ogr_inp%" "dmp:RAASTOFOMR"               "%ogr_conn%" dai raastofomr               *
call "%ogr_command%" "%ogr_inp%" "dmp:RAMSAR_OMR"               "%ogr_conn%" dai ramsar_omr               *
call "%ogr_command%" "%ogr_inp%" "dmp:SKOVBYGGELINJER"          "%ogr_conn%" dai skovbyggelinjer          *
call "%ogr_command%" "%ogr_inp%" "dmp:SOE_BES_LINJER"           "%ogr_conn%" dai soe_bes_linjer           *


REM ============================================================================================
REM Upload af Spildevandsdata, Miljøportal (WFS)
REM ============================================================================================
set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/puls/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetCapabilities"
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

call "%ogr_command%" "%ogr_inp%" "dmp:AKVAKULTUR_MAAL"        "%ogr_conn%" miljo akvakultur_maal        *
call "%ogr_command%" "%ogr_inp%" "dmp:AKVAKULTUR_UDL"         "%ogr_conn%" miljo akvakultur_udl         *
call "%ogr_command%" "%ogr_inp%" "dmp:REGNBET_UDLEDNING"      "%ogr_conn%" miljo regnbet_udledning      *
call "%ogr_command%" "%ogr_inp%" "dmp:REGNBET_UDLEDNING_MAAL" "%ogr_conn%" miljo regnbet_udledning_maal *
call "%ogr_command%" "%ogr_inp%" "dmp:RENSEANLAEG"            "%ogr_conn%" miljo renseanlaeg            *
call "%ogr_command%" "%ogr_inp%" "dmp:RENSEANLAEG_MAAL"       "%ogr_conn%" miljo renseanlaeg_maal       *


REM ============================================================================================
REM Upload af data fra Plansystem.dk plan pdk (WFS)
REM ============================================================================================
set "ogr_inp=WFS:http://geoservice.plansystem.dk/wfs?version=1.0.0"
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

REM Fjern midlertidigt BBOX parameter; bruges ikke samtidigt med where..
set "xbox=%ogr_bbox%" & set "ogr_bbox=" 

REM Kun data fra Frederikssund Kommune
set "ogr_where=komnr=250"

call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_lokalplan_vedtaget_v"                "%ogr_conn%" pdk lokalplan_vedtaget                MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_lokalplan_forslag_v"                 "%ogr_conn%" pdk lokalplan_forslag                 MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_temalokalplan_vedtaget_v"            "%ogr_conn%" pdk temalokalplan_vedtaget            MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_temalokalplan_forslag_v"             "%ogr_conn%" pdk temalokalplan_forslag             MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kommuneplanramme_vedtaget_v"         "%ogr_conn%" pdk kommuneplanramme_vedtaget         MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kommuneplanramme_forslag_v"          "%ogr_conn%" pdk kommuneplanramme_forslag          MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kommuneplantillaeg_vedtaget_v"       "%ogr_conn%" pdk kommuneplantillaeg_vedtaget       MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kommuneplantillaeg_forslag_v"        "%ogr_conn%" pdk kommuneplantillaeg_forslag        MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_byzonesommerhusomraade_vedtaget_v"   "%ogr_conn%" pdk byzonesommerhusomraade_vedtaget   MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_byzonesommerhusomraade_forslag_v"    "%ogr_conn%" pdk byzonesommerhusomraade_forslag    MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_zonekort_v"                          "%ogr_conn%" pdk zonekort_v                        MPOL

REM Kun data fra bestemt CVR nummer
set "ogr_where=cvr_kode='29189129'"

call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_tilslutningspligtomraade_vedtaget_v" "%ogr_conn%" pdk tilslutningspligtomraade_vedtaget MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_forsyningomraade_vedtaget_v"         "%ogr_conn%" pdk forsyningomraade_vedtaget         MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kloakopland_vedtaget_v"              "%ogr_conn%" pdk kloakopland_vedtaget              MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kloakopland_forslag_v"               "%ogr_conn%" pdk kloakopland_forslag               MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_kloakopland_aflyst_v"                "%ogr_conn%" pdk kloakopland_aflyst                MPOL

call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_forsyningomraade_forslag_v"          "%ogr_conn%" pdk forsyningomraade_forslag          MPOL
call "%ogr_command%" "%ogr_inp%" "pdk:theme_pdk_forsyningsforbudomraade_forslag_v"   "%ogr_conn%" pdk forsyningsforbudomraade_forslag   MPOL

REM Reset bbox parameter og nulstil where..
set "ogr_where="
set "ogr_bbox=%xbox%" & set "xbox="

goto slut

REM ============================================================================================
REM Upload af data fra os2geo - Rapport fra stedet (GeoJson http) Estat dummy@dummy.dk og **password** med rigtige værdier 
REM ============================================================================================

REM NB!! Indeholder username snabel-a skal det angives som %%%%%%%%40 (Don't ask why !!)
set "ogr_inp=http://dummy%%%%%%%%40dummy.dk:**password**@geo.os2geo.dk/api/export"
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

REM Nultstil boundin box midlertidigt
set "x_bbox=%ogr_bbox%" & set "ogr_bbox=" 

REM sæt source srs til 4326 (longlat/wgs84), da data modtages i denne srs. ogr_epsgt forbliver den normale 25832; data bliver 
REM herved konverteret til normal srs samtidigt med upload til databasen.
set "x_epsgs=%ogr_epsgs%" & set "ogr_epsgs=4326"

call "%ogr_command%" "%ogr_inp%/db-0cf16ed01ec89bd988508ebba0261cda" "OGRGeoJSON" "%ogr_conn%" rfs badevand                  *
call "%ogr_command%" "%ogr_inp%/db-5577a0a6d7b13f71eb4cebd47fc57374" "OGRGeoJSON" "%ogr_conn%" rfs informationer_badevand    *
call "%ogr_command%" "%ogr_inp%/db-2009e194560bd594f7f1e381668e229a" "OGRGeoJSON" "%ogr_conn%" rfs afstribning               *
call "%ogr_command%" "%ogr_inp%/db-7329765f31b7939dc2b457f4830586e7" "OGRGeoJSON" "%ogr_conn%" rfs skilte_afmaerkning        *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef1508c5" "OGRGeoJSON" "%ogr_conn%" rfs kommunale_legepladser     *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef28d5b6" "OGRGeoJSON" "%ogr_conn%" rfs vinter                    *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef2df726" "OGRGeoJSON" "%ogr_conn%" rfs vejbelysning_trafiksignal *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef2efe1e" "OGRGeoJSON" "%ogr_conn%" rfs midlertidige_gravninger   *
call "%ogr_command%" "%ogr_inp%/db-9e9b674ee499b4ff06bfe3cbef3100c7" "OGRGeoJSON" "%ogr_conn%" rfs frederikssund_havn        *
call "%ogr_command%" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c60971109cd56" "OGRGeoJSON" "%ogr_conn%" rfs henkastet_affald          *
call "%ogr_command%" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c609711b736cf" "OGRGeoJSON" "%ogr_conn%" rfs vejudstyr                 *
call "%ogr_command%" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c609711d79306" "OGRGeoJSON" "%ogr_conn%" rfs veje_belaegning           *
call "%ogr_command%" "%ogr_inp%/db-ac3d5b62ebb8d7ce847c609711e9af59" "OGRGeoJSON" "%ogr_conn%" rfs beplantning               *

REM nulstil SRS til alm. værdi
set "ogr_epsgs=%x_epsgs%" & set "x_epsgs="

REM Reset bbox parameter
set "ogr_bbox=%x_bbox%" & set "x_bbox="


REM ==============================================================================================
REM DAGI . Erstat **login** og **password** med korrekte værdier
REM ==============================================================================================
set "ogr_inp=http://kortforsyningen.kms.dk/service?servicename=dagi_gml2&client=QGIS&request=GetCapabilities&service=WFS&version=1.1.1&LOGIN=**login**&PASSWORD=**password**
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

call "%ogr_command%" "%ogr_inp%" "kms:KOMMUNE10"          "%ogr_conn%" dagi kommune          *
call "%ogr_command%" "%ogr_inp%" "kms:OPSTILLINGSKREDS10" "%ogr_conn%" dagi opstillingskreds *
call "%ogr_command%" "%ogr_inp%" "kms:SOGN10"             "%ogr_conn%" dagi sogn             *
call "%ogr_command%" "%ogr_inp%" "kms:POLITIKREDS10"      "%ogr_conn%" dagi politikreds      *
call "%ogr_command%" "%ogr_inp%" "kms:REGION10"           "%ogr_conn%" dagi region           *
call "%ogr_command%" "%ogr_inp%" "kms:RETSKREDS10"        "%ogr_conn%" dagi retskreds        *
call "%ogr_command%" "%ogr_inp%" "kms:POSTDISTRIKT10"     "%ogr_conn%" dagi postdistrikt     *


REM ==============================================================================================
REM Byggesager
REM ==============================================================================================

REM bør udkommenteres hvis data skal indlæses i Postgres: Genererer for store varchar felter
REM Snak med Dansk Scanning om deres tumpede  WFS server opsætning
set "ogr_inp=wfs:http://geoserver.danskscanning.dk/geoserver/ows?request=getcapabilities&version=1.0.0"
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

REM bbox parameter overflødig
set "x_bbox=%ogr_bbox%" & set "ogr_bbox=" 
REM For at få lange varchar med over 
set "ogr_xtra=-unsetFieldWidth"

call "%ogr_command%" "%ogr_inp%" "bs:frederikssund_intern" "%ogr_conn%" byg frederikssund_intern *

REM reset
set "ogr_bbox=%x_bbox%" & set "x_bbox="
set "ogr_xtra="

REM ==============================================================================================
REM Energinet
REM ==============================================================================================
set "ogr_inp=https://arcgis.energinet.dk/ArcGIS/services/Inspire/el_inspire/MapServer/WFSServer?service=WFS&REQUEST=GetCapabilities 
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

call "%ogr_command%" "%ogr_inp%" "EnerginetDK:kabler_line_tab"    "%ogr_conn%" energinet kabler_line_tab     MLIN
call "%ogr_command%" "%ogr_inp%" "EnerginetDK:hovedkort_line_tab" "%ogr_conn%" energinet hovedkort_line_tab  MLIN

REM ============================================================================================
REM Upload af tab - filer 
REM ============================================================================================

::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"

REM Vandmiljø... 
set "ogr_inp=W:\MapInfo\Temaer\Natur_Miljø\Vandmiljø\"
call "%ogr_command%" "%ogr_inp%DVFI_2000.tab"       * "%ogr_conn%" natur dvfi_2000  *
call "%ogr_command%" "%ogr_inp%DVFI_kort.tab"       * "%ogr_conn%" natur dvfi_kort  *

REM Ynglende fugle ..... inddata er i UTM32/ED50 urgghh... 
set "x_epsgs=%ogr_epsgs%" & set "ogr_epsgs=23032"
call "%ogr_command%" "%ogr_inp%Ynglende_fugle.tab"  * "%ogr_conn%" natur ynglende_fugle  *
REM Reset inddata projektion
set "ogr_epsgs=%x_epsgs%" & set "x_epsgs="

REM - genopdyrkningsret
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"
set "ogr_inp=W:\MapInfo\Temaer\Natur_Miljø\Natur_Miljø_data\"
call "%ogr_command%" "%ogr_inp%Genopdyrkningsret.tab"     * "%ogr_conn%" natur genopdyrkningsret     *

REM - Prognoser
::set "ogr_conn=server=f-sql12;database=gis_test;trusted_connection=yes"
set "ogr_inp=D:\prognose\"

REM set load til OVERWRITE uanset hvad
set "x_load=%ogr_load%" & set "ogr_load=OVERWRITE"

call "%ogr_command%" "%ogr_inp%omraader2.shp" * "%ogr_conn%" prognose prognoseomraader_2016     *

REM Reset load
set "ogr_load=%x_load%" & set "x_load="

:slut
echo.
echo ============================================================================================
echo Sluttid: %date% %time%
echo ============================================================================================
pause
