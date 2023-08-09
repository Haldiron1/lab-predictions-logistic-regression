USE sakila;

#Create a query or queries to extract the information you think may be relevant for building the prediction model. 
#It should include some film features and some rental features.

DROP TABLE IF EXISTS rentals_june;
DROP TABLE IF EXISTS rentals_may;


SELECT
    f.film_id,
    f.title,
    f.release_year,
    f.rental_rate,
    f.length,
    f.replacement_cost,
    f.rating,
    COUNT(r.rental_id) AS rentals_last_month,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_period,
    SUM(IF(r.return_date IS NULL, 1, 0)) AS currently_rented
FROM
    film f
LEFT JOIN
    inventory i ON f.film_id = i.film_id
LEFT JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id, f.title, f.release_year, f.rental_rate, f.length, f.replacement_cost, f.rating
LIMIT 0, 1000;


