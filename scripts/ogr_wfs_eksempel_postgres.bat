REM sæt CodePage til Latin-1 (Ingen bøvl med ÆØÅ i kommandolinien)
REM ============================================================================================
chcp 1252
REM ============================================================================================

REM Sæt "current dir" til opstartsdirectory (ikke bydende nødvendigt)
REM ============================================================================================
%~d0
cd %~p0
REM ============================================================================================

REM Opsætning at generelle parametre for upload proces (absolut nødvendigt)
REM ============================================================================================
call %~dp0ogr_environment.bat
REM ============================================================================================

REM Upload af DAI data fra Miljøportalen (WFS)
REM ============================================================================================

REM ændring af client encoding fra LATIN1 (standard - værdisat i ogr_environmet.bat) til UTF8
set PGCLIENTENCODING=UTF8

set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/public/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&bbox=678577,6178960,702291,6202870"
set "db_conn=host='f-gis03' dbname='gis_test' user='postgres' password='ukulemy' port='5432'"

call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:ARTSFUND_FL" "%db_conn%" flubber artsfund_fl
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:ARTSFUND_LN" "%db_conn%" flubber artsfund_ln
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:ARTSFUND_PKT" "%db_conn%" flubber artsfund_pkt
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:BES_NAT_BUFFERZONER" "%db_conn%" flubber BES_NAT_BUFFERZONER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:BES_NATURTYPER" "%db_conn%" flubber BES_NATURTYPER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:BES_STEN_JORDDIGER" "%db_conn%" flubber BES_STEN_JORDDIGER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:BESIGTIGELSE_FL" "%db_conn%" flubber BESIGTIGELSE_FL
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:BESIGTIGELSE_LN" "%db_conn%" flubber BESIGTIGELSE_LN
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:BESIGTIGELSE_PKT" "%db_conn%" flubber BESIGTIGELSE_PKT
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:BESIGTIGELSE_FL_STAT" "%db_conn%" flubber BESIGTIGELSE_FL_STAT
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:Bnbo" "%db_conn%" flubber Bnbo
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:DEVANO_DOK_FELTER" "%db_conn%" flubber DEVANO_DOK_FELTER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:DEVANO_KORTLAEGNING" "%db_conn%" flubber DEVANO_KORTLAEGNING
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:DKJORD_NUANCERING" "%db_conn%" flubber DKJORD_NUANCERING
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:Dkjord_projektfaser" "%db_conn%" flubber Dkjord_projektfaser
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:Dkjord_uek" "%db_conn%" flubber Dkjord_uek
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:Dkjord_ufk" "%db_conn%" flubber Dkjord_ufk
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:DKJORD_V1" "%db_conn%" flubber DKJORD_V1
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:DKJORD_V2" "%db_conn%" flubber DKJORD_V2
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:DRIKKEVANDS_INTER_SENEST" "%db_conn%" flubber DRIKKEVANDS_INTER_SENEST
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:EF_FUGLE_BES_OMR" "%db_conn%" flubber EF_FUGLE_BES_OMR
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:EF_HABITAT_OMR" "%db_conn%" flubber EF_HABITAT_OMR
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:FOSFORKLASSER" "%db_conn%" flubber FOSFORKLASSER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:FREDEDE_OMR" "%db_conn%" flubber FREDEDE_OMR
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:FREDEDE_OMR_FORSLAG" "%db_conn%" flubber FREDEDE_OMR_FORSLAG
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_FL" "%db_conn%" flubber FUGLEOVERVAAGNING_FL
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_LN" "%db_conn%" flubber FUGLEOVERVAAGNING_LN
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:FUGLEOVERVAAGNING_PKT" "%db_conn%" flubber FUGLEOVERVAAGNING_PKT
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:HABITATNATUR" "%db_conn%" flubber HABITATNATUR
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:INDSATS_NITRAT" "%db_conn%" flubber INDSATS_NITRAT
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:Indv_opland_u_osd" "%db_conn%" flubber Indv_opland_u_osd
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:KATEGORI3_NATUR" "%db_conn%" flubber KATEGORI3_NATUR
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:KIRKEBYGGELINJER" "%db_conn%" flubber KIRKEBYGGELINJER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:KVAELSTOF_RED_POT" "%db_conn%" flubber KVAELSTOF_RED_POT
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:KYSTNAERHEDSZONE" "%db_conn%" flubber KYSTNAERHEDSZONE
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:NATUR_VILDT_RESERVAT" "%db_conn%" flubber NATUR_VILDT_RESERVAT
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:NATURA2000_OPL" "%db_conn%" flubber NATURA2000_OPL
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:Naturregistreringer_FL" "%db_conn%" flubber Naturregistreringer_FL
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:Naturregistreringer_PKT" "%db_conn%" flubber Naturregistreringer_PKT
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:NITRATF_INDV_OMR_SENEST" "%db_conn%" flubber NITRATF_INDV_OMR_SENEST
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:NITRATKLASSER" "%db_conn%" flubber NITRATKLASSER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:NOVANA_ARTSFUND_FL" "%db_conn%" flubber NOVANA_ARTSFUND_FL
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:NOVANA_ARTSFUND_LN" "%db_conn%" flubber NOVANA_ARTSFUND_LN
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:NOVANA_ARTSFUND_PKT" "%db_conn%" flubber NOVANA_ARTSFUND_PKT
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:NOVANA_PROEVEFELTER" "%db_conn%" flubber NOVANA_PROEVEFELTER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:NOVANA_STATIONER" "%db_conn%" flubber NOVANA_STATIONER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:OMR_KLASSIFICERING" "%db_conn%" flubber OMR_KLASSIFICERING
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:Opr_stationer" "%db_conn%" flubber Opr_stationer
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:PAABUD_JFL" "%db_conn%" flubber PAABUD_JFL
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:RAASTOFOMR" "%db_conn%" flubber RAASTOFOMR
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:RAMSAR_OMR" "%db_conn%" flubber RAMSAR_OMR
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:SKOVBYGGELINJER" "%db_conn%" flubber SKOVBYGGELINJER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:SOE_BES_LINJER" "%db_conn%" flubber SOE_BES_LINJER
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:AA_BES_LINJER" "%db_conn%" flubber AA_BES_LINJER
REM ============================================================================================


REM Upload af spildevands data fra Miljøportalen (WFS)
REM ============================================================================================

set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/puls/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&bbox=678577,6178960,702291,6202870"

call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:REGNBET_UDLEDNING" "%db_conn%" flubber REGNBET_UDLEDNING
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:REGNBET_UDLEDNING_MAAL" "%db_conn%" flubber REGNBET_UDLEDNING_MAAL
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:RENSEANLAEG" "%db_conn%" flubber RENSEANLAEG
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:RENSEANLAEG_MAAL" "%db_conn%" flubber RENSEANLAEG_MAAL
REM ============================================================================================

REM ændring af client encoding fra LATIN1 (standard - værdisat i ogr_environmet.bat) til UTF8
set PGCLIENTENCODING=UTF8

REM Upload af SUT data fra Kortforsyningen (WFS)
REM ============================================================================================

set "ogr_inp=http://kortforsyningen.kms.dk/service?servicename=SutWFS_UTM&client=MapInfo&request=GetCapabilities&service=WFS&login=qgisdk&password=qgisdk&bbox=678577,6178960,702291,6202870"
set "db_conn=host='f-gis03' dbname='gis_test' user='postgres' password='ukulemy' port='5432'"

call %~dp0ogr_postgres.bat "%ogr_inp%" "Vej" "%db_conn%" sut vej
call %~dp0ogr_postgres.bat "%ogr_inp%" "Skel" "%db_conn%" sut skel
call %~dp0ogr_postgres.bat "%ogr_inp%" "Skelpunkt" "%db_conn%" sut service


REM Upload af data fra GEUS (WFS)
REM ============================================================================================

set "ogr_inp=http://data.geus.dk/geusmap/ows/25832.jsp?service=WFS&version=1.0.0&request=GetCapabilities&bbox=678577,6178960,702291,6202870&whoami=gis@frederikssund.dk"

call %~dp0ogr_postgres.bat "%ogr_inp%" "jupiter_boringer_ws" "%db_conn%" geus jupiter_boringer_ws
call %~dp0ogr_postgres.bat "%ogr_inp%" "jupiter_bor_vandfors_almen_ws" "%db_conn%" geus jupiter_bor_vandfors_almen_ws
call %~dp0ogr_postgres.bat "%ogr_inp%" "jupiter_bor_vandfors_andre_ws" "%db_conn%" geus jupiter_bor_vandfors_andre_ws
call %~dp0ogr_postgres.bat "%ogr_inp%" "jupiter_anlaeg_ws" "%db_conn%" geus jupiter_anlaeg_ws


REM Upload af data fra FBB (WFS)
REM ============================================================================================

set "ogr_inp=http://www.kulturarv.dk/geoserver/wfs?service=wfs&version=1.0.0&request=GetCapabilities&bbox=678577,6178960,702291,6202870"

call %~dp0ogr_postgres.bat "%ogr_inp%" "fbb:view_bygning_fredede" "%db_conn%" fbb fredede_bygninger
call %~dp0ogr_postgres.bat "%ogr_inp%" "fbb:view_bygning_fredningstatus_hoej" "%db_conn%" fbb bygning_fredningstatus_hoej

REM Upload af data fra Fund og fortidsminder ffm (WFS)
REM ============================================================================================

set "ogr_inp=http://www.kulturarv.dk/ffpublic/wfs?service=wfs&version=1.0.0&request=GetCapabilities&bbox=678100,6178750,704250,6203480"

call %~dp0ogr_postgres.bat "%ogr_inp%" "public:fundogfortidsminder_punkt_ikkefredet" "%db_conn%" fbb fundogfortidsminder_punkt_ikkefredet
call %~dp0ogr_postgres.bat "%ogr_inp%" "public:fundogfortid_punkt_fredet" "%db_conn%" ffm fundogfortid_punkt_fredet
call %~dp0ogr_postgres.bat "%ogr_inp%" "public:fundogfortid_linie_alle" "%db_conn%" ffm fundogfortid_linie_alle
call %~dp0ogr_postgres.bat "%ogr_inp%" "public:fundogfortid_areal_ka" "%db_conn%" ffm fundogfortid_areal_ka
call %~dp0ogr_postgres.bat "%ogr_inp%" "public:fundogfortid_areal_beskyttelse" "%db_conn%" ffm fundogfortid_areal_beskyttelse
call %~dp0ogr_postgres.bat "%ogr_inp%" "public:fundogfortid_areal_alle" "%db_conn%" ffm fundogfortid_areal_alle
call %~dp0ogr_postgres.bat "%ogr_inp%" "public:fundogfortid_areal_adm" "%db_conn%" ffm fundogfortid_areal_adm

REM Upload af data fra Plansystem.dk plan pdk (WFS)
REM ============================================================================================

set "ogr_inp=WFS:http://geoservice.plansystem.dk/wfs?version=1.0.0&"
set ogr_where="komnr=250"

call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_lokalplan_vedtaget_v" "%db_conn%" pdk pdk_lokalplan_vedtaget
call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_temalokalplan_vedtaget_v" "%db_conn%" pdk pdk_temalokalplan_vedtaget
call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_temalokalplan_forslag_v" "%db_conn%" pdk_temalokalplan_forslag
call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_kommuneplanramme_vedtaget_v" "%db_conn%" pdk pdk_kommuneplanramme_vedtaget
call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_kommuneplanramme_forslag_v" "%db_conn%" pdk pdk_kommuneplanramme_forslag
call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_kommuneplantillaeg_vedtaget_v" "%db_conn%" pdk pdk_kommuneplantillaeg_vedtaget
call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_kommuneplantillaeg_forslag_v" "%db_conn%" pdk pdk_kommuneplantillaeg_forslag
call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_byzonesommerhusomraade_vedtaget_v" "%db_conn%" pdk pdk_byzonesommerhusomraade_vedtaget
call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_byzonesommerhusomraade_forslag_v" "%db_conn%" pdk pdk_byzonesommerhusomraade_forslag
call %~dp0ogr_postgres.bat "%ogr_inp%" "pdk:theme_pdk_zonekort_v" "%db_conn%" pdk pdk:theme_pdk_zonekort_v

REM henter WFS for tilslutningspligtomraade_vedtaget
REM SET tabel=pdk_tilslutningspligtomraade_vedtaget
REM SET typename=pdk:theme_pdk_tilslutningspligtomraade_vedtaget_v
REM CALL :Indlaes

REM henter WFS for forsyningomraade_vedtaget
REM SET tabel=pdk_forsyningomraade_vedtaget
REM SET typename=pdk:theme_pdk_forsyningomraade_vedtaget_v
REM CALL :Indlaes

REM Spildevandsplan - endnu ikke på plansystemet
REM pdk:theme_pdk_kloakopland_vedtaget_v
REM pdk:theme_pdk_kloakopland_forslag_v
REM CALL :Indlaes

REM pdk:theme_pdk_forsyningsforbudomraade_vedtaget_v
REM pdk:theme_pdk_forsyningsforbudomraade_forslag_v
REM CALL :Indlaes

set ogr_where=

rem *** REM --------------------------------------------------------------------------------------------------------------------------------------
rem *** REM øvrig liste med databaser fra os2geo
rem *** REM --------------------------------------------------------------------------------------------------------------------------------------
rem *** 
rem *** SET tabel=rfs_badevand
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-0cf16ed01ec89bd988508ebba0261cda
rem *** CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_informationer_badevand
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-5577a0a6d7b13f71eb4cebd47fc57374
rem *** CALL :Indlaes
rem *** 
rem *** REM --------------------------------------------------------------------------------------------------------------------------------------
rem *** REM RapportFraStedet emner fra os2geo
rem *** REM --------------------------------------------------------------------------------------------------------------------------------------
rem *** 
rem *** SET tabel=rfs_afstribning
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-2009e194560bd594f7f1e381668e229a
rem *** CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_Skilte_afmaerkning
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-7329765f31b7939dc2b457f4830586e7
rem *** CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_kommunale_legepladser
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-9e9b674ee499b4ff06bfe3cbef1508c5
rem *** REM CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_vinter
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-9e9b674ee499b4ff06bfe3cbef28d5b6
rem *** REM CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_vejbelysning_trafiksignal
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-9e9b674ee499b4ff06bfe3cbef2df726
rem *** CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_midlertidige_gravninger
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-9e9b674ee499b4ff06bfe3cbef2efe1e
rem *** REM CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_frederikssund_havn
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-9e9b674ee499b4ff06bfe3cbef3100c7
rem *** CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_henkastet_afffald
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-ac3d5b62ebb8d7ce847c60971109cd56
rem *** CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_Vejudstyr
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-ac3d5b62ebb8d7ce847c609711b736cf
rem *** CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_Veje_belaegning
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-ac3d5b62ebb8d7ce847c609711d79306
rem *** CALL :Indlaes
rem *** 
rem *** SET tabel=rfs_beplantning
rem *** SET login=anoer%%40frederikssund.dk:Slangerup3550
rem *** SET url=geo.os2geo.dk/api/export/db-ac3d5b62ebb8d7ce847c609711e9af59
rem *** CALL :Indlaes
rem *** 
rem *** GOTO :EOF
rem *** 
rem *** REM --------------------------------------------------------------------------------------------------------------------------------------
rem *** REM indlæsning i database
rem *** REM --------------------------------------------------------------------------------------------------------------------------------------
rem *** 
rem *** :Indlaes
rem *** ogr2ogr -skipfailures -overwrite -a_srs "EPSG:25832" -f MSSQLSpatial "%db_connection%" "http://%login%@%url%" OGRGeoJSON -lco "OVERWRITE=YES" -nln %tabel%
rem *** 



