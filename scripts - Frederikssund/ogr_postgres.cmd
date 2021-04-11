REM ============================================================================================
REM == Upload af spatielle data til Postgres fra vilk�lige datakilder                         ==
REM == Programm�rer: Bo Victor Thomsen, Frederikssund Kommune                                 ==
REM ============================================================================================

REM =====================================================
REM Inddata check, alle 6 parametre *skal* v�re angivet
REM =====================================================

call "%~dp0ogr_prep_arg.cmd" %*

REM =====================================================
REM Opretter relevant schema i database hvis dette ikke eksisterer i forvejen
REM =====================================================
@echo Kommando.. ogrinfo -q -sql "CREATE SCHEMA IF NOT EXISTS %xp4%" PG:%xp3%
ogrinfo -q -sql "CREATE SCHEMA IF NOT EXISTS %xp4%" PG:%xp3%

REM =====================================================
REM Upload af data til Postgres Server
REM =====================================================
@echo Kommando.. ogr2ogr -skipfailures --config PG_USE_COPY YES -gt 100000 -overwrite %ogr_xtra% -lco SPATIAL_INDEX=FALSE -lco FID="%ogr_fid%" -lco GEOMETRY_NAME="%ogr_geom%" -lco OVERWRITE=YES -nln "%xp4%.%xp5%" %xp11% %xp10% %xp9% -f "PostgreSQL" PG:%xp3% %xp1% %xp2% %XP7%
ogr2ogr -skipfailures --config PG_USE_COPY YES -gt 100000 -overwrite -lco SPATIAL_INDEX=FALSE -lco FID="%ogr_fid%" -lco GEOMETRY_NAME="%ogr_geom%" -lco OVERWRITE=YES -nln "%xp4%.%xp5%" %xp11% %xp10% %xp9% -f "PostgreSQL" PG:%xp3% %xp1% %xp2% %XP7%

REM =====================================================
REM Opretter spatiel index efter generering af tabel
REM =====================================================
@echo Kommando.. ogrinfo -q -sql "CREATE INDEX ON %xp4%.%xp5% USING GIST (%ogr_geom%);" PG:%xp3%
ogrinfo -q -sql "CREATE INDEX ON %xp4%.%xp5% USING GIST (%ogr_geom%);" PG:%xp3%

REM =====================================================
REM Hvis var ogr_dato er sat, autogenereres der et nyt felt, som indeholder dato for indl�gning af data 
REM =====================================================
if not #%ogr_dato%==# (
  @echo Kommando.. ogrinfo -q -sql "ALTER TABLE %xp4%.%xp5% ADD %ogr_dato% varchar(10) NULL DEFAULT current_date::character varying" PG:%xp3%
  ogrinfo -q -sql "ALTER TABLE %xp4%.%xp5% ADD %ogr_dato% varchar(10) NULL DEFAULT current_date::character varying" PG:%xp3%
  @echo Kommando.. ogrinfo -q -sql "UPDATE %xp4%.%xp5%  SET %ogr_dato%=current_date::character varying" PG:%xp3%
  ogrinfo -q -sql "UPDATE %xp4%.%xp5%  SET %ogr_dato%=current_date::character varying" PG:%xp3%
)

REM =====================================================
REM OVERWRITE, TRUNCATE f�rdigbehandling 
REM =====================================================
if not %xp5%==%xp12% (
  @echo Kommando.. ogrinfo -q -sql "TRUNCATE %xp4%.%xp12%;" PG:%xp3%
  ogrinfo -q -sql "TRUNCATE %xp4%.%xp12%;" PG:%xp3%
  @echo Kommando.. ogrinfo -q -sql "INSERT INTO %xp4%.%xp12% (SELECT * FROM %xp4%.%xp5%);" PG:%xp3%
  ogrinfo -q -sql "INSERT INTO %xp4%.%xp12% (SELECT * FROM %xp4%.%xp5%);" PG:%xp3%
  @echo Kommando.. ogrinfo -q -sql "DROP TABLE %xp4%.%xp5%;" PG:%xp3%
  ogrinfo -q -sql "DROP TABLE %xp4%.%xp5%;" PG:%xp3%
)
