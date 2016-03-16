# ogr_scripts

Forskellige dos scripts som vi benytter i Frederikssund Kommune til upload til / behandling af data i hhv MS SQL Server og Postgres.<br>
Systemet består af en række grund-scripts, som håndterer upload af data til database server på en robust og sikker måde.<br>
Repository indeholder endvidere en række eksempler på upload af data fra hhv. Kortforsyningen og div danske wfs baserede systemer

## Forudsætninger:
En Windows PC ;-) samt download og installation af en GDAL/OGR distribution. Se http://www.gisinternals.com/

## Initiel opsætning:

Script **ogr_environment.cmd** indeholder værdisætning af en lang række parametre til systemet.

- Kald af GDAL opsætnings procedure
- Opsætning hvilken database type, der skal benyttes
- Værdisætning af en lang række ekstra parametre

**Alle** opsætningsparametre er kommenteret i filen, så denne bør læses og tilrettes med omhu. 

NB! Ved ændringer bør man være opmærksom på placeringen af anførselstegn for de enkelte parametre.

## Opsætning af data overførsler

Download af data foretages ved kald af en kommandoprocedure, hvis navn afhænger af hvilken databasesystem, data skal inlæses i. Navnet er fastlagt i føromtalte script: **ogr_environment.cmd**

Hvert kald defineres af 6 parametre:

1. *Kilde definition*: Dette er en tekststreng til ogr2ogr, som bestemmer hvilken datakilde, der skal hentes data fra. 
2. *Lag definition*: Dette er en tekststreng, som bestemmer det specifikke lag fra datakilden, som skal indlæses. Hvis datakilden ikke indeholder flere lag angives denne parameter med en "*"
3. *Database forbindelse*: En tekststreng til ogr2ogr, som definerer databssen, hvor data skal indlæses.
4. *schema navn*: Navnet på schema i database hhvor inddata tabellen skal placeres.
5. *Tabel navn*: Navn på tabel i databasen
6. *Objekttype*: Et nøgleord, som bestemmer hvilken geografisk objekttype, der skal genereres i databasen: **PKT**
for simpelt punkt, **MPKT** for multipunkt, **LIN** for simpel linie, **MLIN** for multilinie, **POL** for simpel polygon, **MPOL** for multipolygon og **<nowiki>*</nowiki>** for alle typer.
Hvis man ikke har valgt **<nowiki>*</nowiki>**, vil scriptet filtre datatyper fra, som ikke er af den valgte type. Har man dog valgt en af *multi* typerne, vil objektet af samme *simple* type også tages med, men vil blive omdannet til et multitype objekt.

I eksempel scriptet **Alle_kilder_x.cmd** er der eksempler på indlæsning fra WFS-, Tab-fils- og HTTP GeoJSON- datakilder. Der er ikke nogen shape-fil eksempler, men import fra shapefiler er understøttet. Benyt et tab-fil eksempel som skabelon

Dette script viser også brugen (best practice) af environment variables til definition af gennemgående parametre

## Opsætning af Stored Procedures i MS-SQLServer

Hvis scriptet skal benyttes i forbindelse med MS-SQLServer er det nødvendigt at installere en række stored procedures først i den relevante database. Disse er placeret i fil: **CreateStoredProcedures.sql**.

## Wrapper script med logning af uddata

Der findes et eksempel på et "wrapper" script, som vil "omdirigere" alt logging uddata fra scriptet:
Hvis selve scriptet hedder "alle_kilder_x.cmd" skal wrapper-script kaldes "alle_kilder_x.log.cmd". Ved start af "alle_kilder_x.log.cmd" autostartes "alle_kilder_x.cmd" og vil producere en logfil ved navn: "alle_kilder_x.log"

Generelt : Hvis scriptet hedder "x.cmd" omdøbes wrapperscript til "x.log.cmd" og vil producere en logfil "x.log" ved udførelse af "x.log.cmd"

## Øvrige scripts

De øvrige scripts indeholder ingen brugerbestemt data eller opsætninger.




