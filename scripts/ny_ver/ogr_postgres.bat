REM ============================================================================================
REM == Upload af spatielle data til Postgres fra vilkålige datakilder                    ==
REM == OGR2OGR ver 1.11 bør benyttes                                                          ==
REM == Programmører: Anette Rosengård Poulsen & Bo Victor Thomsen, Frederikssund Kommune      ==
REM ============================================================================================

REM =====================================================
REM Inddata check, alle 6 parametre *skal* være angivet
REM =====================================================

call "%~dp0ogr_prep_arg.bat" %*

REM =====================================================
REM Opretter relevant schema i database hvis dette ikke eksisterer i forvejen
REM =====================================================
@echo Kommando.. ogrinfo -q -sql "CREATE SCHEMA IF NOT EXISTS %xp4%" PG:%xp3%
ogrinfo -q -sql "CREATE SCHEMA IF NOT EXISTS %xp4%" PG:%xp3%

REM =====================================================
REM Upload af data til Postgres Server
REM =====================================================
@echo Kommando.. ogr2ogr -skipfailures --config PG_USE_COPY YES -gt 100000 -overwrite -lco SPATIAL_INDEX=FALSE -lco FID="%ogr_fid%" -lco GEOMETRY_NAME="%ogr_geom%" -lco OVERWRITE=YES -nln "%xp4%.%xp5%" %xp11% %xp10% %xp9% -f "PostgreSQL" PG:%xp3% %xp1% %xp2% %XP7%
ogr2ogr -skipfailures --config PG_USE_COPY YES -gt 100000 -overwrite -lco SPATIAL_INDEX=FALSE -lco FID="%ogr_fid%" -lco GEOMETRY_NAME="%ogr_geom%" -lco OVERWRITE=YES -nln "%xp4%.%xp5%" %xp11% %xp10% %xp9% -f "PostgreSQL" PG:%xp3% %xp1% %xp2% %XP7%

REM =====================================================
REM Opretter spatiel index efter generering af tabel
REM =====================================================
@echo Kommando.. ogrinfo -q -sql "CREATE INDEX ON %xp4%.%xp5% USING GIST (%ogr_geom%);" PG:%xp3%
ogrinfo -q -sql "CREATE INDEX ON %xp4%.%xp5% USING GIST (%ogr_geom%);" PG:%xp3%

REM =====================================================
REM Hvis var ogr_dato er sat, autogenereres der et nyt felt, som indeholder dato for indlægning af data 
REM =====================================================
if not #%ogr_dato%==# (
  @echo Kommando.. ogrinfo -q -sql "CREATE INDEX ON %xp4%.%xp5% USING GIST (%ogr_geom%);" PG:%xp3%
  ogrinfo -q -sql "ALTER TABLE %xp4%.%xp5% ADD %ogr_dato% varchar(10) NULL DEFAULT current_date::character varying" PG:%xp3%
  @echo Kommando.. ogrinfo -q -sql "UPDATE %xp4%.%xp5%  SET %ogr_dato%=current_date::character varying" PG:%xp3%
  ogrinfo -q -sql "UPDATE %xp4%.%xp5%  SET %ogr_dato%=current_date::character varying" PG:%xp3%
)

