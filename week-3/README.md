# Nädal 3: SQL JOIN-id – Anna kliendi- ja müügipilt

**Meeskond:** UrbanStyle-ladu  |  **Tegelased:** Anna Mets (turundusjuht), Toomas Kask (IT direktor)

## Ülesanne

Anna Mets: *„Ma tahan teada, millised kliendid pole kunagi midagi ostnud. Ja millised tooted pole kunagi müüdud! Kes on parimad kliendid? Millised tooted müüvad?“*

Andmed on eri tabelites (`sales`, `customers`, `products`, `inventory`). Iga meeskonnaliige vastas ühele Anna küsimusele, ühendades tabeleid JOIN-ide abil. Kõik päringud tehti puhastatud andmetel (sales 10 118 rida, 12 linna).

## Rollid

| Roll | Ülesanne | JOIN | Liige |
|------|----------|------|-------|
| A | Müük + kliendid: TOP kliendid | INNER JOIN | [nimi] |
| B | Kliendid ilma ostudeta | LEFT JOIN + IS NULL | [nimi] |
| C | Tooted + inventuur: müümata tooted ja laoseis | LEFT JOIN + IS NULL | Vaiko Vainola |

## Peamised leiud

### Roll A – TOP kliendid
[3–5 lauset: kes on parimad kliendid, millisest linnast tuleb enim müüke, milline loyalty_tier on kõige kasumlikum]

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
