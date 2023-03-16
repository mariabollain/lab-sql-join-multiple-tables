use sakila;

# 1 Write a query to display for each store its store ID, city, and country.

SELECT S.store_id, CI.city, CO.country
FROM store AS S
JOIN address A 
ON S.address_id = A.address_id
JOIN city CI
ON A.city_id = CI.city_id
JOIN country CO
ON CI.country_id = CO.country_id;

# 2 Write a query to display how much business, in dollars, each store brought in.

SELECT S.store_id, SUM(P.amount) AS total_amount
FROM store AS S
JOIN staff SA 
ON S.store_id = SA.store_id
JOIN payment P 
ON SA.staff_id = P.staff_id
GROUP BY store_id;

# 3 What is the average running time of films by category?

SELECT C.name, AVG(F.length) as avg_length
FROM category C 
LEFT JOIN film_category FC
ON C.category_id = FC.category_id
JOIN film F 
ON FC.film_id = F.film_id
GROUP BY C.name;

# 4 Which film categories are longest?

SELECT C.name, AVG(F.length) as avg_length
FROM category C 
LEFT JOIN film_category FC
ON C.category_id = FC.category_id
JOIN film F 
ON FC.film_id = F.film_id
GROUP BY C.name
ORDER BY avg_length DESC;

# 5 Display the most frequently rented movies in descending order.

SELECT F.title, COUNT(R.rental_id) as num_rentals
FROM film F
LEFT JOIN inventory I 
ON F.film_id = I.film_id
JOIN rental R 
ON I.inventory_id = R.inventory_id
GROUP BY F.title
ORDER BY num_rentals DESC;

# 6 List the top five genres in gross revenue in descending order.

SELECT C.name, SUM(P.amount) AS gross_revenue
FROM category C 
LEFT JOIN film_category FC
ON C.category_id = FC.category_id
JOIN inventory I ON FC.film_id = I.film_id
JOIN rental R ON I.inventory_id = R.inventory_id
JOIN payment P ON R.rental_id = P.rental_id
GROUP BY C.name
ORDER BY gross_revenue DESC
LIMIT 5;

# 7 Is "Academy Dinosaur" available for rent from Store 1?

SELECT F.title, R.inventory_id, I.store_id, R.rental_date, R.return_date
FROM film F 
JOIN inventory I ON F.film_id = I.film_id
JOIN rental R ON I.inventory_id = R.inventory_id
WHERE title = "Academy Dinosaur" AND store_id = 1
ORDER BY inventory_id;

# with the rental and return date I can see that the 4 copies of this movie are available for renting (all of them have been returned)