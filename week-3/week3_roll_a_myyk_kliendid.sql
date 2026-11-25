--GT W3 Gertrud roll A Müük + Kliendid + Turundus
-- 1. Kustuta müügi duplikaadid
DELETE FROM sales
WHERE id NOT IN (
    SELECT MIN(id) FROM sales GROUP BY sale_id
);
-- 2. Ühtlusta linnanimed
UPDATE customers
SET city = INITCAP(TRIM(city))
WHERE city IS NOT NULL;
-- 3. Kontrolli
SELECT COUNT(*) AS sales_ridu FROM sales;           -- ~10 118
SELECT COUNT(DISTINCT city) AS linnu FROM customers; -- 12


 -- Lihtne INNER JOIN: kliendid, kes on ostnud    
 SELECT        c.first_name,        c.last_name,        c.email,        c.city,        s.sale_id,        s.sale_date,        s.total_price    FROM sales s    INNER JOIN customers c ON s.customer_id = c.customer_id    LIMIT 20;    `

--Leia TOP 10 klienti kogumüügi järgi
SELECT        c.first_name || ' ' || c.last_name AS klient,        c.city,        COUNT(DISTINCT s.sale_id) AS ostude_arv,        SUM(s.total_price) AS kogumüük    FROM sales s    INNER JOIN customers c ON s.customer_id = c.customer_id    GROUP BY c.customer_id, c.first_name, c.last_name, c.city    ORDER BY kogumüük DESC    LIMIT 10;    
--kontroll duplikaatide osas: tulemid samad seega ok
SELECT COUNT(*) AS ridu, COUNT(DISTINCT sale_id) AS unikaalseid
FROM sales;

-- Müük linnade kaupa    
SELECT        c.city,        COUNT(DISTINCT c.customer_id) AS kliente,        COUNT(s.sale_id) AS oste,        SUM(s.total_price) AS kogumüük    FROM sales s    INNER JOIN customers c ON s.customer_id = c.customer_id    GROUP BY c.city    ORDER BY kogumüük DESC;    

-- Müük lojaalsustasemete kaupa    
SELECT        c.loyalty_tier,        COUNT(DISTINCT c.customer_id) AS kliente,        SUM(s.total_price) AS kogumüük    FROM sales s    INNER JOIN customers c ON s.customer_id = c.customer_id    GROUP BY c.loyalty_tier    ORDER BY kogumüük DESC;

--Edasijõudnute tase: alamjärjepäring (subquery): leia kliendid, kelle kogumüük on üle keskmise
SELECT       c.first_name || ' ' || c.last_name AS klient,       SUM(s.total_price) AS kogumüük   FROM sales s   INNER JOIN customers c ON s.customer_id = c.customer_id   GROUP BY c.customer_id, c.first_name, c.last_name   HAVING SUM(s.total_price) > (       SELECT AVG(kliendi_müük)       FROM (           SELECT SUM(total_price) AS kliendi_müük           FROM sales           GROUP BY customer_id       ) AS keskmised   )   ORDER BY kogumüük DESC; 
--	Äriline järeldus: mitu protsenti klientidest moodustavad üle keskmise kulutajad? Mida see UrbanStyle jaoks tähendab? 762 klienti on üle keskmise kulutajad.kliente kokku oli 
--Lisapäring
WITH kliendi_muuk AS (
    SELECT customer_id, SUM(total_price) AS kogumuuk
    FROM sales
    GROUP BY customer_id
),
keskmine AS (
    SELECT AVG(kogumuuk) AS keskmine_muuk
    FROM kliendi_muuk
)
SELECT
    COUNT(*)                                                      AS ostnud_kliente,
    COUNT(*) FILTER (WHERE k.kogumuuk > m.keskmine_muuk)          AS ule_keskmise,
    ROUND(100.0 * COUNT(*) FILTER (WHERE k.kogumuuk > m.keskmine_muuk) / COUNT(*), 1) AS ule_keskmise_protsent,
    ROUND(m.keskmine_muuk, 2)                                     AS keskmine_muuk
FROM kliendi_muuk k
CROSS JOIN keskmine m
GROUP BY m.keskmine_muuk;
-- Müügid, mille kliendil puudub customers tabelis vaste, või customer_id on NULL - need ei ole tegelikult 1 kllient ja seega ei arvesta, ok
SELECT s.customer_id, COUNT(*) AS muuke, SUM(s.total_price) AS kogumuuk
FROM sales s
LEFT JOIN customers c ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL
GROUP BY s.customer_id;


--Lisapäring - 900 on õigem, sest keskmine arvutatakse samade klientide peal, keda hiljem võrreldakse (ainult päris kliendid customers tabelis).  762 võrdleb päris kliente keskmisega, mida on moonutanud "tundmatu klient".
WITH kliendi_muuk AS (
    SELECT s.customer_id, SUM(s.total_price) AS kogumuuk
    FROM sales s
    INNER JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY s.customer_id
),
keskmine AS (
    SELECT AVG(kogumuuk) AS keskmine_muuk FROM kliendi_muuk
)
SELECT
    (SELECT COUNT(*) FROM kliendi_muuk)                                    AS ostnud_kliente,
    ROUND(m.keskmine_muuk, 2)                                              AS keskmine_joinitud,
    (SELECT ROUND(AVG(x), 2) FROM (SELECT SUM(total_price) AS x
                                   FROM sales GROUP BY customer_id) t)     AS keskmine_sales_ainult,
    COUNT(*) FILTER (WHERE k.kogumuuk > m.keskmine_muuk)                   AS ule_keskmise
FROM kliendi_muuk k
CROSS JOIN keskmine m
GROUP BY m.keskmine_muuk;

--tundmatud müügid:
SELECT
    SUM(s.total_price) FILTER (WHERE c.customer_id IS NULL) AS tundmatu_muuk,
    SUM(s.total_price)                                      AS kogumuuk,
    ROUND(100.0 * SUM(s.total_price) FILTER (WHERE c.customer_id IS NULL)
          / SUM(s.total_price), 1)                          AS tundmatu_protsent
FROM sales s
LEFT JOIN customers c ON s.customer_id = c.customer_id;
