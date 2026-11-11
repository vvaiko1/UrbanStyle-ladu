--ALAÜLESANDE KAART B: Kliendiandmed Grupitöö raames

--Sisendi kontroll
SELECT COUNT(*) FROM customers;
-- Mitu klienti on kokku?
SELECT COUNT(*) AS klientide_arv FROM customers; --3150 so arvestades lisatud andmeid, arvestamata duplikaate
--(lisapäring duplikaatide tuvastamiseks emaili alusel)
SELECT email, COUNT(*) AS mitu_korda
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;
--(v2 lisapäring duplikaatide tuvastamiseks)
SELECT
COUNT(email) AS kokku,
COUNT(DISTINCT email) AS unikaalseid,
COUNT(email) - COUNT(DISTINCT email) AS duplikaate
FROM customers;
-- pärin tvastab emaili alusel 130 duplikaati.

-- Millised veerud ja andmed tabelis on? 
SELECT * FROM customers LIMIT 10;

-- Millised linnad on esindatud? 
SELECT DISTINCT city FROM customers;
-- (Lisa päring eelmisele)
SELECT DISTINCT lower(city) AS city
FROM customers
ORDER BY city;

--(lisapäring 2 kuna nimedes tühikud lisaks suur ja väiketähtede erinevusele)
SELECT DISTINCT initcap(lower(trim(city))) AS city
FROM customers
ORDER BY city;
-- lõplik päringu vastus:
--| Haapsalu   |
--| Jõhvi      |
--| Kuressaare |
--| Narva      |
--| Paide      |
--| Pärnu      |
--| Rakvere    |
--| Tallinn    |
--| Tartu      |
--| Valga      |
--| Viljandi   |
--| Võru       |

-- Tallinna kliendid, sorteeritud nime järgi
SELECT * FROM customers
WHERE city = 'Tallinn'
ORDER BY last_name ASC
LIMIT 15;
-- Vanim ja uusim registreerimine
SELECT MIN(registration_date) AS vanim, --2020-01-02
       MAX(registration_date) AS uusim --2025-02-27
FROM customers;
-- Mitu klienti, kus eesnimi on puudu? -- 0
SELECT COUNT(*) - COUNT(first_name) AS puuduvad_eesnimed
FROM customers;

-- Mitu klienti, kus e-mail on puudu? -380
SELECT COUNT(*) - COUNT(email) AS puuduvad_emailid
FROM customers;
