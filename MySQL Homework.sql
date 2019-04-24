-- 1a
SELECT first_name, last_name 
FROM actor;
-- 1b
SELECT concat(first_name, ' ', last_name)
AS 'Actor Name'
FROM actor;
-- 2a 
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';
-- 2b
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';
-- 2C
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;
-- 2d
SELECT country_id, country
FROM country
WHERE country in ('Afghanistan', 'Bangladesh', 'China');
-- 3a
ALTER TABLE actor
ADD COLUMN description BLOB NULL AFTER last_update;
-- 3b
ALTER TABLE actor
DROP COLUMN description;
-- 4a
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name;
-- 4b
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;			
-- 4c
UPDATE actor
set first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = 'WILLIAMS';
-- 4d
UPDATE actor
set first_name = "GROUCHO"
WHERE first_name = "HARPO" AND last_name = 'WILLIAMS';
-- 5a
SHOW CREATE TABLE address;
-- 6a
SELECT s.first_name, s.last_name, address
FROM staff s
Join address a
ON s.address_id = a.address_id;
-- 6b
SELECT s.first_name, s.last_name, sum(p.amount)
FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
WHERE p.payment_date like '2005-08-%'
GROUP BY last_name;
-- 6c
SELECT film.film_id, count(film_actor.actor_id) as "Number of Actors"
FROM film_actor
JOIN film
on film_actor.film_id = film.film_id
group by film.title;
-- 6d
SELECT f.film_id, f.title, count(i.film_id)
FROM inventory i
JOIN film f
ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';
-- 6e
SELECT c.first_name, c.last_name, sum(p.amount) AS 'Total Amount Paid'
FROM customer c
JOIN payment p
ON p.customer_id = c.customer_id
GROUP BY c.last_name;
-- 7a
SELECT title
FROM film
WHERE film_id in (
SELECT language_id
FROM language 
WHERE name = "English")
and title like 'K%' or title like 'Q%';
-- 7b
SELECT first_name, last_name
FROM actor
WHERE actor_id in (
SELECT actor_id
FROM film_actor
WHERE film_id in (
SELECT film_id
FROM film
WHERE title = 'Alone Trip'));
-- 7C
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city on address.city_id = city.city_id
JOIN country on city.country_id = country.country_id
WHERE country = 'Canada';
-- 7d
SELECT title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE name = 'Family';
-- 7e Display the most frequently rented movies in descending order.
SELECT film.title, count(rental.rental_id) as 'Frequency'
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY count(rental.rental_id) DESC;
-- 7f
SELECT store.store_id, sum(payment.amount) as 'Revenue'
FROM payment
JOIN rental on payment.rental_id = rental.rental_id
Join inventory on inventory.inventory_id = rental.inventory_id
JOIN store on store.store_id = inventory.store_id
group by store.store_id;
-- 7g
SELECT store.store_id, city.city, country.country
FROM country
JOIN city ON city.country_id = country.country_id
JOIN address ON address.city_id =  city.city_id
JOIN store on store.address_id = address.address_id;
-- 7h
SELECT c.name as 'Genre', sum(p.amount) as 'Revenue'
FROM category c
JOIN film_category fc on c.category_id = fc.category_id
JOIN inventory i on i.film_id = fc.film_id
JOIN rental r on i.inventory_id= r.inventory_id
JOIN payment p on p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY Revenue desc limit 5;
-- 8a
create view Top_five_genres_by_gross_revenue as
SELECT c.name as 'Genre', sum(p.amount) as 'Revenue'
FROM category c
JOIN film_category fc on c.category_id = fc.category_id
JOIN inventory i on i.film_id = fc.film_id
JOIN rental r on i.inventory_id= r.inventory_id
JOIN payment p on p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY Revenue desc limit 5;
-- 8b
SELECT * FROM Top_five_genres_by_gross_revenue;
DROP VIEW Top_five_genres_by_gross_revenue;
