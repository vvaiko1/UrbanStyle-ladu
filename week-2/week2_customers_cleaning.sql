-- Loo test tabel
DROP TABLE IF EXISTS customers_test;
CREATE TABLE customers_test AS SELECT * FROM customers;
SELECT COUNT(*) AS ridade_arv FROM customers_test; -- 3150 rida

-- Duplikaat emailid
SELECT email, COUNT(*) AS koopiate_arv
FROM customers_test
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC; -- 128 duplikaat emaili, ridu kokku 130 kuna üks email on 3x

-- Leia puuduvad nimed
SELECT
    COUNT(*) FILTER (WHERE first_name IS NULL OR first_name = '') AS null_eesnimi,
    COUNT(*) FILTER (WHERE last_name IS NULL OR last_name = '') AS null_perenimi
FROM customers_test; -- 0 ja 0

-- Kontrolli linnade nimekujusid — kas on ebajärjekindlusi?
SELECT city, COUNT(*) AS arv
FROM customers_test
GROUP BY city
ORDER BY city; -- 12 linna kirjutatud 54 erimoel

SELECT COUNT(*) AS vale_kirjapildiga
FROM customers_test
WHERE city != INITCAP(TRIM(city)); -- 252 klienti vale kirjapildiga linna kirjutanud

-- Kontrolli kontaktandmeid — puuduvad telefoninumbrid ja e-mailid:
SELECT
    COUNT(*) FILTER (WHERE phone IS NULL OR phone = '') AS null_telefon,
    COUNT(*) FILTER (WHERE email IS NULL OR email = '') AS null_email
FROM customers_test; -- 0 telefoninumbrit puudu ja 380 email_optional

SELECT INITCAP(TRIM('pÄrnu'))     AS test1,
       INITCAP(TRIM('  PÄRNU '))  AS test2,
       INITCAP(TRIM('jÕHVI'))     AS test3;
-- Oodatav: Pärnu, Pärnu, Jõhvi

SELECT city, COUNT(*) FROM customers_test
GROUP BY city HAVING COUNT(*) > 1;

-- Asenda NULL nimed
UPDATE customers_test
SET first_name = 'Tundmatu'
WHERE first_name IS NULL OR first_name = ''; -- UPDATE käivitati, muudeti 0 rida, sest eesnimed olid kõigil olemas.

-- Kontroll
SELECT
    COUNT(*) FILTER (WHERE first_name IS NULL OR first_name = '') AS veel_puudu,
    COUNT(*) FILTER (WHERE first_name = 'Tundmatu') AS tundmatu
FROM customers_test;

-- Vale kirjapildiga linnasid
SELECT COUNT(*) AS vale_kirjapilt,
       COUNT(DISTINCT city) AS erinevaid_linnu
FROM customers_test
WHERE city IS NOT NULL; -- 3150 vale kirjapilt; 54 erinevalt kirjutatud linna

-- vale_kirjapilt: kasuta eraldi päringut allpool
SELECT COUNT(*) AS vale_kirjapilt FROM customers_test WHERE city != INITCAP(TRIM(city)); --252

-- Ühtlusta linnanimed INITCAP + TRIM abil
UPDATE customers_test
SET city = INITCAP(TRIM(city))
WHERE city != INITCAP(TRIM(city));

-- Kontroll
SELECT COUNT(*) AS vale_kirjapilt FROM customers_test WHERE city != INITCAP(TRIM(city));
-- Oodatav: 0

SELECT city, COUNT(*) AS arv
FROM customers_test
GROUP BY city ORDER BY arv DESC;
-- Oodatav: 12 rida/linna, Tallinn 1238, Tartu 658, Pärnu 346 ...

SELECT COUNT(*) AS vajab_parandust
FROM customers_test
WHERE email != LOWER(TRIM(email)); -- 0, emailid on korras

UPDATE customers_test
SET email = LOWER(TRIM(email))
WHERE email != LOWER(TRIM(email));

-- Kontroll
SELECT COUNT(*) FROM (
    SELECT email FROM customers_test
    WHERE email IS NOT NULL
    GROUP BY email HAVING COUNT(*) > 1
) t;
-- Oodatav: 128 (sama mis enne)

-- Näide: standardiseeri telefoninumbrid
SELECT phone,
    CASE
        WHEN phone LIKE '+372%' THEN phone
        WHEN phone LIKE '372%' THEN '+' || phone
        WHEN LENGTH(phone) = 7 THEN '+372' || phone
        ELSE phone
    END AS standardne_telefon
FROM customers_test
WHERE phone IS NOT NULL
LIMIT 10;

-- Kontroll, palju muutuks
SELECT COUNT(*) AS muutuks
FROM customers_test
WHERE phone NOT LIKE '+372%';
-- 0, kõik 3150 numbrit on +372 formaadiga

-- Võrdlus puhta tabeliga võrreldes test tabeliga
SELECT
    (SELECT COUNT(DISTINCT city) FROM customers)      AS originaal_linnad,
    (SELECT COUNT(DISTINCT city) FROM customers_test) AS test_linnad;
-- Oodatav: 54 ja 12