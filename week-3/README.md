# Nädal 3: SQL JOIN-id – Anna kliendi- ja müügipilt

**Meeskond:** UrbanStyle-ladu  |  **Tegelased:** Anna Mets (turundusjuht), Toomas Kask (IT direktor)

## Ülesanne

Anna Mets: *„Ma tahan teada, millised kliendid pole kunagi midagi ostnud. Ja millised tooted pole kunagi müüdud! Kes on parimad kliendid? Millised tooted müüvad?“*

Andmed on eri tabelites (`sales`, `customers`, `products`, `inventory`). Iga meeskonnaliige vastas ühele Anna küsimusele, ühendades tabeleid JOIN-ide abil. Kõik päringud tehti puhastatud andmetel (sales 10 118 rida, 12 linna).

## Rollid

| Roll | Ülesanne | JOIN | Liige |
|------|----------|------|-------|
| A | Müük + kliendid: TOP kliendid | INNER JOIN | Gertrud Kaupmees |
| B | Kliendid ilma ostudeta | LEFT JOIN + IS NULL | Sten Tomingas |
| C | Tooted + inventuur: müümata tooted ja laoseis | LEFT JOIN + IS NULL | Vaiko Vainola |

## Peamised leiud

### Roll A – TOP kliendid
- **Parimad kliendid** kogumüügi järgi on Tiina Pärn Tartust (27 668 €, 73 ostu), Priit Rand Pärnust (26 286 €) ja Kevin Org Tallinnast (23 467 €); TOP 10 klientidest 4 on Pärnust ja 3 Tallinnast.
- **Kõige rohkem müüki tuleb Tallinnast** (1,01 mln €, 3 601 ostu), järgnevad Tartu (523 tuhat €) ja Pärnu (374 tuhat €); need kolm linna annavad suurema osa kogumüügist.
- **Kogumüügilt on kõige tulusam tase silver** (593 tuhat €), seejärel gold (534 tuhat €) ja bronze (424 tuhat €), kuid kliendi kohta on tugevaim gold (~1 087 €; silver ~1 060 €, bronze ~890 €).
- **1 024 ostnud kliendil puudub loyalty_tier** (suurim grupp) ja nad toovad 1,07 mln € müüki – tasuks nende tase üle vaadata või nad lojaalsusprogrammi kaasata.
- **Lisaanalüüs:** 2 551 ostnud kliendist kulutab üle keskmise 900 (~35,3%); keskmine müük kliendi kohta on 1 028,12 €. Müügid ilma kliendikirjeta (286 446 €) moodustavad 9,8% kogumüügist (2 909 178 €) ja on keskmisest välja jäetud.

### Roll B – Kadunud kliendid
- Kokku 3 150 klienti: **599 pole kunagi ostnud**, 2 551 on ostnud.
- Kõige rohkem kadunud kliente on Tallinnas (231), Tartus (133) ja Pärnus (70).
- Kõige uuem registreerimiskuupäev: 27.02.2025.
- **Järeldus:** 599 kliendi andmed on olemas, kuid nad pole veel ostu sooritanud. Kui turundusnõusolek on olemas, võiks alustada neile esimese ostu sooduspakkumise saatmisega.

### Roll C – Tooted + inventuur
- **12 toodet pole kunagi müüdud** – kõik on nädal 1 leitud duplikaatkirjed (ID 1351–1362), mitte ebapopulaarsed tooted; neil puudub ka laoseis.
- **Müümata tooteid laos ei ole** – kinni olevat raha ei ole.
- **231 toote-asukoha real on laoseis tellimispunktis või alla selle**, neist 7 on täiesti otsas.
- **Laoandmetes on vigu:** 10 real negatiivne laoseis (kuni −46), 40 real ebareaalselt suur (kuni 9 985).
- **Bestseller:** Õhuline sünteetiline sporditossud – 35 müüki, 27 347,04 €.
- **Kõige edukam kategooria:** jalanõud (774 035 €); väikseim müügitulu: lasteriided (305 844 €).

## Suurim üllatus

„Puuduvad“ seosed ei olnud alati päris puudujäägid: kõik 12 müümata toodet ja osa kadunud kliente on tegelikult duplikaatkirjed. Lisaks leidus laos negatiivseid laoseise, mis on füüsiliselt võimatud.

## Soovitus Annale ja Toomasele

**Annale:** saata esimese ostu pakkumine 599 ostuta kliendile (alustades Tallinnast) ja keskenduda lojaalsusprogrammis gold- ja silver-klientidele. **Toomasele:** eemaldada duplikaattooted, kontrollida üle vigased laoseisud ning täita puuduvad loyalty_tier ja customer_id väärtused.

## Puuduvad andmed

1 024 ostnud kliendil puudub lojaalsustase ja 9,8% käibest (286 446 €) on müükidel ilma kliendi ID-ta, mistõttu neid ei saa kliendi tasemel analüüsida. Laoseisu andmetes on negatiivseid ja ebareaalselt suuri väärtusi.

## Demo kokkuvõte

- **Peamine järeldus:** JOIN-idega saime Annale nimed, linnad ja tooted – parimad kliendid, 599 ostuta klienti ja edukaimad kategooriad.
- **Mis otsus muutuks:** Anna saab teha suunatud kampaaniad (esimese ostu pakkumine, gold/silver lojaalsus), mitte ühe üldise kampaania.
- **Mis üllatas:** müümata tooted osutusid duplikaatideks ja laos leidus negatiivseid laoseise.

## Failid

| Fail | Sisu |
|------|------|
| [Google Slides](https://docs.google.com/presentation/d/1tIFRLYS09QJf8webDzAYrYFJGvsdCiUlIwstnK6WABY/edit) | Meeskonna ühine slaid |
| [week3_roll_b_kadunud_kliendid.sql](week3_roll_b_kadunud_kliendid.sql) | Roll B – kadunud kliendid (Sten Tomingas) |
| [week3_roll_c_tooted_inventuur.sql](week3_roll_c_tooted_inventuur.sql) | Roll C – tooted + inventuur (Vaiko Vainola) |
| *week3_roll_a_myyk_kliendid.sql* | Roll A – TOP kliendid (Gertrud Kaupmees) – lisamata |

Iga liikme individuaalsed päringud on tema isiklikus portfoolios.
