# Nädal 2: SQL Puhastamine

**Meeskond:** UrbanStyle-ladu  |  **Tegelane:** Toomas Kask (IT direktor)

## Ülesanne

Toomas Kask: *"Leidsin just 5 116 duplikaatrida! Kui palju neid igas domeenis on?Juhatuse koosolek on 2 nädala pärast — Kristi tahab puhtaid numbreid. Ärge laske mind alt!"*

Iga meeskonnaliige uuris ühte andmedomeeni ja tulemused koondati üheks ülevaateks.

## Rollid

| Roll | Andmedomeen | Liige |
|------|-------------|-------|
| A | Müügiandmete puhastamine | Sten Tomingas |
| B | Kliendiandmete puhastamine| Vaiko Vainola |
| C | Tooteandmete puhastamine | Gertrud Kaupmees |


## ANDMEKVALITEEDI KOONDRAPORT
│  PEAMISED LEIUD:     
│
│  1. Müügiandmed: leitud 5166 probleemi 
5 116 duplikaatrida (4 013 korduvat arvet, 33,6%)
50 kuupäeva pärast andmete lõppu (28.02.2025)
1 487 külalisostu (NULL customer_id) – pole viga

│  2. Kliendiandmed: leitud 760 probleemi
128 duplikaatset e-maili (nimed samad – topeltimport)
380 kliendil puudub e-mail (12%)
252 vale linnanime: 54 kirjapilti → 12 linna

│ 3. Tooteandmed: leitud 0 probleemi
Duplikaate pole – kõik product_id on erinevad
NULL ainult eco_certified veerus
5 kategooriat, nimetused korrektsed


## Suurim üllatus

Kolmandik käibest on duplikaadid: 4,37 M € → 2,91 M €.

## Soovitus Toomasele

Korrastada müügi ja kliendiread. 

## Puuduvad andmed

380 kliendil puudub e-mail ja 1 260 kliendil (40%) lojaalsustase, mis piirab turundust ja lojaalsusanalüüsi. 1 487 müügil (~10%) puudub kliendi ID, mistõttu neid ei saa kliendiga siduda.

380 kliendi e-mail ja 1 487 külalisostu kliendi ID – SQL-iga neid taastada ei saa.

- **Peamine järeldus:** Müügi ja klientide tabel vajavad korrigeerimist, et investorid ja juhtkond saaksid korrektsed sisendid äriliste otsuste tegemiseks.
- **Mis otsus muutuks:** Andmete kvaliteedi parendamine on kriitilise tähtsusega järgneva kuu eelarve kujundamisel. 
- **Mis üllatas:** Suur mõju finantsile ja äri vaatele.

## Juhtkonnale põhisõnum
Kristi, meie tulemused muudavad meie järgmise kvartali eelarvet ja olemasolevad andmed annaksid väärinfo investorile ja maksuametile. Meie müügiraport ja ja kliendiraport sisaldavad olulises osas duplikaate ja üle paisutatud müügi käivet!

## Failid

| Fail | Sisu |
|------|------|
| [Google Slides](https://docs.google.com/presentation/d/1SqgwirUYRVrINoIISpwbw5F_c36T5BGmVnEWv5necPE/edit?slide=id.p1#slide=id.p1) | Meeskonna ühine esitlus |
| [week2_sales_cleaning.sql](https://github.com/vvaiko1/UrbanStyle-ladu/blob/main/week-2/week2_sales_cleaning.sql) | Roll A – müügiandmete puhastamine (Sten Tomingas) | | Roll A – müügiandmete puhastamine (Sten Tomingas) |
| [week2_customers_cleaning.sql](https://github.com/vvaiko1/UrbanStyle-ladu/blob/main/week-2/week2_customers_cleaning.sql) | Roll B – kliendiandmete puhastamine (Vaiko Vainola) |
| [sales_dimensions_explorer.sql](sales_dimensions_explorer.sql)](https://github.com/gertrudkaupmees-lab/DACA-portfolio/blob/main/week-2/GT%20week%202%20products%20table) | Roll C – tooteandmete analüüs (Gertrud Kaupmees) |

Iga liikme individuaalsed päringud on tema isiklikus portfoolios.

