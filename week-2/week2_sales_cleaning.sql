
-- =====================================================
-- DACA Week 2
-- Role: Sales Data Cleaner
-- Project: UrbanStyle
-- Purpose: Identify duplicates, NULL values and invalid
-- dates in the sales table and document the findings.
-- NOTE: The original sales table is not modified.
-- =====================================================


-- STEP 1: Create a test copy of the sales table

-- Remove the previous test copy, if it exists
DROP TABLE IF EXISTS sales_test;

-- Create a new copy containing all sales records
CREATE TABLE sales_test AS
SELECT *
FROM sales;

-- Add a unique row ID if it does not already exist
ALTER TABLE sales_test
ADD COLUMN IF NOT EXISTS id SERIAL;

-- Check the number of rows in the test copy
SELECT COUNT(*) AS total_rows
FROM sales_test;


-- STEP 2: Find duplicate invoices

-- Group records by invoice_id
-- Show only invoices that appear more than once
SELECT
    invoice_id,
    COUNT(*) AS copy_count
FROM sales_test
GROUP BY invoice_id
HAVING COUNT(*) > 1
ORDER BY copy_count DESC;


-- STEP 3: Count extra duplicate rows

-- Keep the row with the smallest ID for each invoice
-- Count all remaining rows as duplicate rows
SELECT COUNT(*) AS duplicate_rows
FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
);


-- STEP 4: Find NULL values in important columns

-- Check for missing customer IDs, dates and prices
SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE sale_date IS NULL) AS null_sale_date,
    COUNT(*) FILTER (WHERE total_price IS NULL) AS null_total_price
FROM sales_test;


-- STEP 5A: Check for invalid dates

-- Find dates in the future or before the company was founded
SELECT COUNT(*) AS invalid_dates
FROM sales_test
WHERE sale_date > CURRENT_DATE
   OR sale_date < DATE '2020-01-01';


-- STEP 5B: Check dates after the expected dataset end date

-- Sales data is expected to end on 28 February 2025
-- These records are documented, not deleted
SELECT COUNT(*) AS dates_after_dataset_end
FROM sales_test
WHERE sale_date > DATE '2025-02-28';


-- STEP 6: Summarise the data quality findings

-- Combine the main data quality checks into one report
SELECT
    'Duplicate rows' AS issue,
    COUNT(*) AS quantity
FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
)

UNION ALL

SELECT
    'NULL customer_id',
    COUNT(*)
FROM sales_test
WHERE customer_id IS NULL

UNION ALL

SELECT
    'NULL sale_date',
    COUNT(*)
FROM sales_test
WHERE sale_date IS NULL

UNION ALL

SELECT
    'NULL total_price',
    COUNT(*)
FROM sales_test
WHERE total_price IS NULL

UNION ALL

SELECT
    'Dates after 2025-02-28',
    COUNT(*)
FROM sales_test
WHERE sale_date > DATE '2025-02-28';
