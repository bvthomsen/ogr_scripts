# ogr_scripts

Forskellige dos scripts til upload / behandling af data i hhv MS SQL Server og Postgres.<br>
Systemet består af en række grund-scripts, som håndterer upload af data til database server på en robust og sikker måde.<br>
Repository indeholder endvidere en række eksempler på upload af data fra hhv. Kortforsyningen og div. danske wfs-baserede systemer

## Forudsætninger:
En Windows PC ;-) samt download og installation af en GDAL/OGR distribution. Se http://www.gisinternals.com/. Det anbefales, at man ikke bruger udviklings versioner af GDAL/OGR, men holder sig til "stable releases"

## Initiel opsætning:

Script **ogr_environment.cmd** indeholder værdisætning af en lang række parametre til systemet.

- Kald af GDAL opsætnings procedure. Denne del er et kald af en kommandoprocedure, som følger med GDAL/OGR installationen. Kaldet skal tilpasses GDAL/OGR systemets placering. 
- Opsætning hvilken database type, der skal benyttes. Man kan enten indlæse data til MS-SQLServer eller Postgres/PostGIS. Til hver databasetype er der nogle få ekstra parametre (environment-variable), som skal værdisættes. Disse er grupperet med selve valget af database type
- Værdisætning af en lang række ekstra parametre. Der findes en lang række ekstra parametre (environment-variable), som skal værdisættes for at systemet kører korrekt. Dette kan være f.eks projektionsvalg, geografisk afgrænsning, filtrering på kommenunenummer, indekseringsparametre osv. **Alle** opsætningsparametre er kommenteret i filen, så denne bør læses og tilrettes med **omhu**.

NB! Ved ændringer i parameterværdier bør man være opmærksom på placeringen af anførselstegn for de enkelte parametre.

## Opsætning af data overførsler

Download af data foretages ved kald af en kommandoprocedure, hvis navn afhænger af hvilken databasesystem, data skal inlæses i. Navnet er fastlagt i føromtalte script: **ogr_environment.cmd**

Hvert kald defineres af 6 parametre:

1. *Kilde definition*: Dette er en tekststreng til ogr2ogr, som bestemmer hvilken datakilde, der skal hentes data fra. 
2. *Lag definition*: Dette er en tekststreng, som bestemmer det specifikke lag fra datakilden, som skal indlæses. Hvis datakilden ikke indeholder flere lag skal denne parameter værdisættes til "*"
3. *Database forbindelse*: En tekststreng til ogr2ogr, som definerer databasen, hvor data skal indlæses.
4. *schema navn*: Navnet på schema i database, hvor inddata-tabellen skal placeres. Hvis schema ikke findes i forvejen, oprettes dette automatisk
5. *Tabel navn*: Navn på tabel i databasen
6. *Objekttype*: Et nøgleord, som bestemmer hvilken geografisk objekttype, der skal genereres i databasen: **PKT**
for simpelt punkt, **MPKT** for multipunkt, **LIN** for simpel linie, **MLIN** for multilinie, **POL** for simpel polygon, **MPOL** for multipolygon og **<nowiki>*</nowiki>** for alle typer.
Hvis man ikke har valgt **<nowiki>*</nowiki>**, vil scriptet automatisk frasortere data, som ikke er af den valgte type. Har man dog valgt en af *multi* typerne, vil data af samme *simple* type medtages, men vil automatisk blive omdannet til multitype data.

I eksempel-scriptet **Alle_kilder_x.cmd** er der eksempler på indlæsning fra WFS-, Tab- og HTTP GeoJSON- datakilder. Der er ikke nogen shape-fil eksempler, men import fra shapefiler er understøttet. Benyt et tab-fil eksempel som skabelon

Ud over selve kommando linien benytter scriptet i høj grad at værdisætte paramtre (environment variable), som vil påvirke databehandlingen. Disse environment variable er alle sat til standard værdier i script **ogr_environment.cmd**. De kan dog ændres løbende mellem de forkellige kald an indlæsnings kommandoer i script **Alle_kilder_x.cmd**. Dette script viser også  "best practice" brugen af environment variable til definition af gennemgående parametre

## Opsætning af Stored Procedures i MS-SQLServer

Hvis scriptet skal benyttes i forbindelse med MS-SQLServer er det nødvendigt at installere en række stored procedures først i den relevante database. Disse er placeret i fil: **CreateStoredProcedures.sql**.

## Wrapper script med logning af uddata

Der findes et eksempel på et "wrapper" script, som vil "omdirigere" alt logging uddata fra scriptet:
Hvis selve scriptet hedder "alle_kilder_x.cmd" skal wrapper-scriptet kaldes "alle_kilder_x.log.cmd". Ved start af "alle_kilder_x.log.cmd" autostartes "alle_kilder_x.cmd" og vil producere en logfil ved navn: "alle_kilder_x.log"

Generelt : Hvis scriptet hedder "x.cmd" omdøbes wrapperscript til "x.log.cmd" og vil ved udførelse dels eksekvere x.cmd og producere en logfil "x.log".

## Øvrige scripts

De øvrige scripts indeholder ingen brugerbestemt data eller opsætninger.




