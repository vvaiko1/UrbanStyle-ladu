# Nädal 1: UrbanStyle andmemaastik

**Meeskond:** UrbanStyle-ladu  |  **Tegelane:** Toomas Kask (IT direktor)

## Ülesanne

Toomas Kask: *"Ma ei usalda neid andmeid. Kas keegi saab mulle öelda, mis tabelites üldse on? Mitu rida? Mis veerud? Mis on puudu?"*

Iga meeskonnaliige uuris ühte andmedomeeni ja tulemused koondati üheks ülevaateks.

## Rollid

| Roll | Andmedomeen | Liige |
|------|-------------|-------|
| A | sales – tehingud (summad, kuupäevad) | Erik Mölder |
| B | customers – kliendid | Gertrud Kaupmees |
| C | products – tooted | Vaiko Vainola |
| D | sales – kanalid ja asukohad | Sten Tomingas |

## Andmemaastik

| Tabel | Read | Peamine leid |
|-------|------|--------------|
| **sales** (tehingud) | 15 234 | Ainult 10 118 unikaalset arvet – 5 116 rida (33,6%) on duplikaadid; 305 müüki summaga 0 või vähem |
| **customers** | 3 150 | 12 linna; 130 potentsiaalset duplikaati; 380 kliendil puudub e-mail ja 1 260 kliendil (40%) lojaalsustase |
| **products** | 362 | 5 kategooriat, hinnad 13.53–434.08 €; hinnad ja kategooriad kõigil olemas – kõige puhtam tabel |
| **sales** (kanalid) | – | 2 kanalit (online, pood), 3 poodi (Tallinn, Tartu, Pärnu), 3 makseviisi; 5 204 tehingul puudub asukoht – kõik on online-ostud, seega see ei ole viga |

## Suurim üllatus

Sisendite ebaühtsus – näiteks linnade kirjapildid (sama linn on kirjutatud mitmel eri viisil) ja kuupäevade vorm (osa kuupäevi kujul DD/MM/YYYY, osa YYYY-MM-DD).

## Soovitus Toomasele

Teha detailsem süvaanalüüs ja andmete korrastamine, et vältida topeltinfot, ning mõelda läbi, milline info on raportite jaoks reaalselt vajalik. Andmed on sisestatud ilma ühtse standardita ning süsteem on lubanud sisestada duplikaate või jätta väljad täitmata – seega vajab täiendamist ka andmete kogumise protsess.

## Puuduvad andmed

380 kliendil puudub e-mail ja 1 260 kliendil (40%) lojaalsustase, mis piirab turundust ja lojaalsusanalüüsi. 1 487 müügil (~10%) puudub kliendi ID, mistõttu neid ei saa kliendiga siduda.

## Lisatähelepanekud

| Leid | Miks see oluline on | Kontrollpäring |
|------|---------------------|----------------|
| **12 linna on kirjutatud 54 eri viisil** (nt `Tallinn`, `tallinn`, `TALLINN`, `Tallinn `) | Linnapõhine raport näitaks 54 "linna" ja Tallinna müük jaguneks 6 reale | `SELECT COUNT(DISTINCT city), COUNT(DISTINCT INITCAP(TRIM(city))) FROM customers;` |
| **Duplikaadid ei ole alati identsed** – sama müük võib esineda 2–4 korda ja koopiad erinevad (nt ühel puudub `customer_id`) | Identsete ridade eemaldamisest ei piisa – tuleb otsustada, milline koopia on õige | `SELECT * FROM sales WHERE sale_id = 2407;` |
| **457 müügi kuupäev on kujul DD/MM/YYYY** | Otse importides katkeb import või loetakse kuupäev valesti (päev ja kuu vahetuses) | teisendati impordi käigus (`TO_DATE(sale_date, 'DD/MM/YYYY')`) |
| **10 toote omahind ≥ müügihind** | UrbanStyle müüb neid kahjumiga või nullmarginaaliga – kas andmeviga või päris hinnastamise probleem? | `SELECT COUNT(*) FROM products WHERE cost_price >= retail_price;` |
| **18 tootel puudub `eco_certified` väärtus** | Jätkusuutlike toodete turundamisel ei saa nende staatust kinnitada | `SELECT COUNT(*) - COUNT(eco_certified) FROM products;` |

## Demo kokkuvõte

- **Peamine järeldus:** Andmed vajavad enne kasutuselevõttu olulist korrastamist.
- **Mis otsus muutuks:** Nende andmete põhjal ei ole soovitatav teha ärilisi otsuseid, kuna tulemused oleksid moonutatud.
- **Mis üllatas:** Sisendite ebaühtsus – linnade kirjapildid ja kuupäevade vorm.

## Järgmised sammud (Nädal 2)

1. **Duplikaadid** – leppida kokku reegel, milline koopia jääb alles (nt kõige täielikum rida), ja eemaldada ülejäänud.
2. **Linnanimed** – ühtlustada kirjapilt (`INITCAP(TRIM(city))`), et linnapõhised raportid oleksid õiged.
3. **Nullsummaga müügid** – selgitada koos Toomasega, kas 305 müüki on tagastused, testkirjed või vead.
4. **Veebi- ja poemüük eraldi** – analüüsida kanaleid eraldi, sest online-müügil ei ole füüsilist asukohta.
5. **Andmesisestuse kontrollid** – soovitada süsteemi kohustuslikud väljad ja duplikaatide kontroll, et probleemid ei tekiks uuesti.

## Failid

| Fail | Sisu |
|------|------|
| [week1_data_landscape.pptx](week1_data_landscape.pptx) | Meeskonna ühine slaid (demo jaoks) |

Iga liikme individuaalsed päringud on tema isiklikus portfoolios.
