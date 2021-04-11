Brug af kommando procedure


... Kommandoer ovenfor skal ikke ændres, undtaget definition af GDAL mappe placering

call :ogr localhost\sqlexpress geodata ogrusr ogrusr fot d:\tmp "bassin bygning bykerne"



Linjen består af noget fast tekst plus 7 parametre; parametrene adskilles af blanktegn:

    Fast tekst, skal ikke ændres: call :ogr
    Parameter 1, Servernavn (localhost\sqlexpress) : Ændres til navnet på din server
    Parameter 2, Databasenavn (geodata) : Ændres til navnet på din database
    Parameter 3, DB-user (ogruser) : Ændres til dit database username
    Parameter 4, DB-password (ogrpassw) : Ændres til dit database password
    Parameter 5, Schemanavn (fot) : Ændres til navnet på dit schema med eksport tabeller
    Parameter 6, Directory til shapefiles (d:\tmp) : Ændres til navnet for dit directory til shapefiles
    Parameter 7, Liste med tabeller, som skal eksporteres ("bassin bygning bykerne") : Ændres til liste over dine tabeller i schemaet, som skal eksporteres. Listen skal starte og slutte med " (anførselstegn). Tabelnavne adskilles af blanktegn.

Den ovenstående kommandolinje vil eksportere tabellerne "bassin", "bygning" og "bykerne" fra database "geodata", schema "fot" til mappe "d:\tmp" som shapefilerne "bassin.shp", "bygning.shp" og "bykerne.shp"

Der er ikke noget performance at hente; slutresultatet er blot en mere overskuelig kommando procedure.

Hvis du har tabeller fra andre servere, databaser, schemaer eller skal de placeres i andre mapper, kan man gentage kommandolinjen med de ændrede parametre.


