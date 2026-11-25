-- Roll B: Kadunud klientide tuvastamine
-- Eesmärk: leida kliendid, kes pole kunagi ostnud.
-- Andmed: customers ja sales
-- Andmeid on puhastatud: sales duplikaadid eemaldatud,
-- klientide linnanimed ühtlustatud.

-- 1. Leia kõik kliendid, kellel pole ühtegi ostu
SELECT
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    c.registration_date,
    s.sale_id
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;


-- 2. Loe kokku kadunud klientide arv
SELECT COUNT(*) AS kadunud_kliente
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;


-- 3. Kadunud kliendid linnade kaupa
SELECT
    c.city,
    COUNT(*) AS kadunud_kliente
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
GROUP BY c.city
ORDER BY kadunud_kliente DESC;


-- 4. Millal kadunud kliendid registreerusid?
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.registration_date,
    c.city,
    c.loyalty_tier
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
ORDER BY c.registration_date DESC;


-- 5. Võrdle kadunud ja aktiivsete klientide arvu
SELECT
    CASE
        WHEN s.sale_id IS NULL THEN 'Kadunud (pole ostnud)'
        ELSE 'Aktiivne (on ostnud)'
    END AS staatus,
    COUNT(DISTINCT c.customer_id) AS kliente
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id
GROUP BY
    CASE
        WHEN s.sale_id IS NULL THEN 'Kadunud (pole ostnud)'
        ELSE 'Aktiivne (on ostnud)'
    END;
