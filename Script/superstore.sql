use clean;

select order_date
from sample
limit 10;
set sql_safe_updates = 0;

select order_id, count(*) as jumlah
from sample
group by order_id
having count(order_id) > 1;

select order_id, customer_name, sales
from sample
where order_id = 'CA-2016-152156';

alter table sample
add column ad_date date after order_date;

alter table sample
drop column order_date;

alter table sample
add column shipping date after ship_date;

alter table sample
drop column ship_date;

SELECT order_date
FROM sample
WHERE order_date IS NOT NULL
  AND TRIM(order_date) <> ''
  AND (
      STR_TO_DATE(order_date, '%d/%m/%Y') IS NULL
      AND STR_TO_DATE(order_date, '%m/%d/%Y') IS NULL
  );
  
UPDATE sample
SET ad_date =
    CASE
        WHEN CAST(SUBSTRING_INDEX(order_date, '/', 1) AS UNSIGNED) > 12
            THEN STR_TO_DATE(order_date, '%d/%m/%Y')
        WHEN CAST(
            SUBSTRING_INDEX(
                SUBSTRING_INDEX(order_date, '/', 2),
                '/',-1) AS UNSIGNED) > 12
            THEN STR_TO_DATE(order_date, '%m/%d/%Y')
        ELSE STR_TO_DATE(order_date, '%d/%m/%Y')
    END;