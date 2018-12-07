# Pong Ultimate

Pong Ultimate är ett utvecklingsprojekt av ett enklare spel med samma namn. Huvudfokus i detta projekt är att lära sig och få mer kunskap om hur program kan konstrueras med hjälp av programmering, samt hur detta påverkar en dators prestanda i form av användning av minne och processorns beräkningshastighet. Projektet pågår under höstterminen 2018.

# Projektmål och kravställning
Målet med projektet har varit att utveckla ett spel där två spelare möts och tävlar om vem som kan slå ut bollen bakom den andre spelarens planhalva. Lyckas ena spelaren med det, får spelaren poäng. Första spelaren att nå 3 poäng vinner. För att slå till bollen har spelaren en stolpe eller ”bar” till hjälp som går att sänka eller höja för att kunna träffa bollen. Spelaren kan också ta hjälp av toppen och botten på spelplanen för att valla bollen, och göra det svårare för motståndaren att slå tillbaka bollen. Hastigheten för bollen går också att sänka eller öka om spelaren skulle önska att ändra på svårighetsgraden.

Huvudkrav för spelet har varit att ha

1. Flerspelarläge 1 mot 1
2. Svårighetsgrad med hjälp av spakarna.
3. Styrfunktionerna ska ske med knapparna.

# Implementation
För att implementera programmet har vi använts oss av programmeringsspråket C, och programfilerna bygger på kod ifrån Laboration 3 ur kursen för Datorteknik och komponenter. Programmet installeras eller kompileras och körs sedan på en PIC32 processor och ett ChipKit Uno32 board. Denna komponent har bland annat en display, fyra knappar och fyra spakar som används för att kunna spela.
Koden består huvudsakligen av att manipulera den bitkarta som används för att visualisera displayen. Displayen består av 4096 pixlar där varje pixel representeras av en bit. För att tända en pixel så ska biten vara 1 och för att släcka en pixel så ska biten vara 0.
Spelets design är enkel. Spelplanen består av en svart bakgrund med en vit rektangulär ram runt spelplanen som ska föreställa sidor, tak och botten. Slutligen är det spelarnas spelredskap som även de är av vit färg.

# Verifiering och testning
För att säkerställa att programmet gör det programmet ska göra så har vi kört programmet ett antal gånger för att testa funktionaliteten. I testen utsatte vi programmet för de centrala extremfall som sker under spelets gång. När det blir mål så ska spelet starta om, och spelaren som gjorde mål ska få poäng. När spelstolparna träffar toppen eller botten så ska de stoppas på ett korrekt sätt. När bollen träffar någon av spelstolparna så ska de ändra riktning, samt även när bollen träffar botten eller toppen av spelplanen så ska bollen även där ändra riktning på ett korrekt sätt.

För att verifiera att spelet faktiskt ökar eller sänker hastigheten har vi också gjort test där vi testar alla sorters kombinationer och ser hur bollens hastighet antingen ökar eller sjunker.


# Samarbete
Inledningsvis arbetade vi på varsin dator för att försöka förstå koden i sin helhet ifrån laboration 3, speciellt hur displayen fungerade. När vi började få en bättre förståelse så arbetade vi mer och mer enbart på en av datorerna av praktiska själ. Vi försökte använda gitHub för att kunna arbeta parallellt men eftersom vi så gott som alltid arbetade tillsammans fungerade det bättre med att jobba på en dator i taget.


# Reflektion
Projektet har varit lärorikt och kul att göra, men har också varit fyllt med utmaningar. Vi hade till en början svårt att förstå hur bitkartan som visualiserar displayen fungerar. För att förstå funktionaliteten gjorde vi en rad test med den gamla koden ifrån laboration 3 för att se hur displayen påverkades. När vi väl förstått hur displayen fungerar kom utmaningen med att konstruera och manipulera spelplanen under spelets gång. Eftersom displayen var uppdelad i olika segment och rader blev det komplicerat när bollen till exempel rörde sig över rad 1 till rad 2 i displayen. För att lösa detta så skapade vi en bitkarta som motsvarade ett XY-system där vi kunde manipulera bitarna på ett för oss mycket mer naturligt sätt och sedan konvertera den förenklade kartan till formen som krävs för att kunna visa datan på displayen.
Detta var såklart väldigt kul att göra då det visar hur kreativt kod kan vara och att det verkligen går att göra det enklare för sig.  
