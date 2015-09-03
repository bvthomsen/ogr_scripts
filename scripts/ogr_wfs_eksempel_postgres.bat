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

REM Upload af data fra Miljøportalen (WFS)
REM ============================================================================================

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


REM Upload af data fra Miljøportalen (WFS)
REM ============================================================================================

set "ogr_inp=http://arealinformation.miljoeportal.dk/gis/services/puls/MapServer/WFSServer?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&bbox=678577,6178960,702291,6202870"

call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:REGNBET_UDLEDNING" "%db_conn%" flubber REGNBET_UDLEDNING
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:REGNBET_UDLEDNING_MAAL" "%db_conn%" flubber REGNBET_UDLEDNING_MAAL
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:RENSEANLAEG" "%db_conn%" flubber RENSEANLAEG
call %~dp0ogr_postgres.bat "%ogr_inp%" "dmp:RENSEANLAEG_MAAL" "%db_conn%" flubber RENSEANLAEG_MAAL
REM ============================================================================================
