# Nädal 3: SQL JOIN-id – Anna kliendi- ja müügipilt

**Meeskond:** UrbanStyle-ladu  |  **Tegelased:** Anna Mets (turundusjuht), Toomas Kask (IT direktor)

## Ülesanne

Anna Mets: *„Ma tahan teada, millised kliendid pole kunagi midagi ostnud. Ja millised tooted pole kunagi müüdud! Kes on parimad kliendid? Millised tooted müüvad?“*

Andmed on eri tabelites (`sales`, `customers`, `products`, `inventory`). Iga meeskonnaliige vastas ühele Anna küsimusele, ühendades tabeleid JOIN-ide abil. Kõik päringud tehti puhastatud andmetel (sales 10 118 rida, 12 linna).

## Rollid

| Roll | Ülesanne | JOIN | Liige |
|------|----------|------|-------|
| A | Müük + kliendid: TOP kliendid | INNER JOIN | Gertrud Kaupmees |
| B | Kliendid ilma ostudeta | LEFT JOIN + IS NULL | [nimi] |
| C | Tooted + inventuur: müümata tooted ja laoseis | LEFT JOIN + IS NULL | Vaiko Vainola |

## Peamised leiud

### Roll A – TOP kliendid
- **Parimad kliendid kogumüügi järgi on Tiina Pärn Tartust (27 668 €, 73 ostu), Priit Rand Pärnust (26 286 €) ja Kevin Org Tallinnast (23 467 €), kusjuures TOP 10 klientidest 4 on Pärnust ja 3 Tallinnast.
- **Kõige rohkem müüki tuleb Tallinnast (1,01 mln, 3601 ostu), millele järgnevad Tartu (523 tuhat) ja Pärnu (374 tuhat); need kolm linna annavad kokku suurema osa kogumüügist.
- **Kogumüügi poolest on kõige tulusam tase silver (593 tuhat), seejärel gold (534 tuhat) ja bronze (424 tuhat), kuid kliendi kohta on tugevaim gold (~1087 €, silveril ~1060 € ja bronzel ~890 €).
- **Märkimisväärne on, et 1024 kliendil (suurim grupp) loyalty_tier puudub, ja nad toovad 1,07 mln müüki, mistõttu tasuks nende tase üle vaadata või lojaalsusprogrammi kaasata. Soovitan koondada lojaalsusprogrammi tähelepanu goldile ja silverile ning täita puuduvad tasemed andmetes.
- **Lisaanalüüs - Tuvastatud klientidest (2551 ostnud klienti) kulutab üle keskmise 900 ehk ligikaudu 35,3%; keskmine müük kliendi kohta on 1028,12 €. Müügid ilma kliendikirjeta (286 446 €) moodustavad 9,8% kogumüügist (2 909 178 €) ja on keskmise arvutusest välja jäetud, et see ei moonduks. Soovitan puuduvad customer_id väärtused müügitabelis üle vaadata, sest ligi kümnendikku käibest ei saa praegu kliendi tasemel analüüsida.

### Roll B – Kadunud kliendid
[3–5 lauset: mitu klienti pole kunagi ostnud, millistest linnadest, millal registreerusid, kuidas neid tagasi võita]

### Roll C – Tooted + inventuur
- **12 toodet pole kunagi müüdud** – kõik on nädal 1 leitud duplikaatkirjed (ID 1351–1362), mitte ebapopulaarsed tooted; neil puudub ka laoseis.
- **Müümata tooteid laos ei ole** – kinni olevat raha ei ole.
- **231 toote-asukoha real on laoseis tellimispunktis või alla selle**, neist 7 on täiesti otsas.
- **Bestseller:** Õhuline sünteetiline sporditossud – 35 müüki, 27 347,04 €.
- **Kõige edukam kategooria:** jalanõud (774 035 €); väikseim müügitulu: lasteriided (305 844 €).

## Suurim üllatus

[1–2 lauset – meeskond täidab]

## Soovitus Annale ja Toomasele

[1–2 lauset: prioriteedid ja järgmised sammud]

## Puuduvad andmed

[1–2 lauset: mida me ei teadnud?]

## Demo kokkuvõte

- **Peamine järeldus:** [1 lause]
- **Mis otsus muutuks:** [1 lause]
- **Mis üllatas:** [1 lause]

## Failid

| Fail | Sisu |
|------|------|
| [week3_roll_c_tooted_inventuur.sql](week3_roll_c_tooted_inventuur.sql) | Roll C – tooted + inventuur (Vaiko Vainola) |
| [nimi].sql | Roll A – TOP kliendid ([nimi]) |
| [nimi].sql | Roll B – kadunud kliendid ([nimi]) |

Iga liikme individuaalsed päringud on tema isiklikus portfoolios.
