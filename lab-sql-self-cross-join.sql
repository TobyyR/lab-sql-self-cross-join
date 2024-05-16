use sakila;

SELECT DISTINCT a1.actor_id AS actor1_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
                a2.actor_id AS actor2_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY a1.actor_id, a2.actor_id;


WITH rental_counts AS (
    SELECT r1.customer_id AS customer1_id, r2.customer_id AS customer2_id, r1.inventory_id
    FROM rental r1
    JOIN rental r2 ON r1.inventory_id = r2.inventory_id AND r1.customer_id <> r2.customer_id
    GROUP BY r1.customer_id, r2.customer_id, r1.inventory_id
    HAVING COUNT(*) > 3
)
SELECT DISTINCT c1.customer_id AS customer1_id, c1.first_name AS customer1_first_name, c1.last_name AS customer1_last_name,
                c2.customer_id AS customer2_id, c2.first_name AS customer2_first_name, c2.last_name AS customer2_last_name
FROM rental_counts rc
JOIN customer c1 ON rc.customer1_id = c1.customer_id
JOIN customer c2 ON rc.customer2_id = c2.customer_id
ORDER BY customer1_id, customer2_id;


SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title
FROM actor a
CROSS JOIN film f
ORDER BY a.actor_id, f.film_id;

