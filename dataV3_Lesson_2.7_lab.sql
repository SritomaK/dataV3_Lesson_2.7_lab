use sakila;

-- Lab | SQL Join (Part I)

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT * FROM category;

SELECT category.name AS category, COUNT(film_category.film_id) AS num_of_films
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name;

-- 2. Display the total amount rung up by each staff member in August of 2005.

SELECT staff.first_name AS staff_first_name, staff.last_name AS staff_last_name, SUM(payment.amount) AS total_amount
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
WHERE EXTRACT(YEAR FROM payment_date) = 2005 AND EXTRACT(MONTH FROM payment_date) = 08
GROUP BY staff.staff_id;

-- 3. Which actor has appeared in the most films?

SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS num_of_films
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY num_of_films DESC
LIMIT 1;


-- 4. Most active customer (the customer that has rented the most number of films)

SELECT * FROM customer;
SELECT * FROM rental;

SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS rental_num
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY rental_num DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON staff.address_id = address.address_id;

-- 6. List each film and the number of actors who are listed for that film.

SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT film.title AS film_title, COUNT(film_actor.actor_id) AS num_of_actors
FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id -- 
GROUP BY film.title;


-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT * FROM payment;
SELECT * FROM customer;

SELECT customer.first_name, customer.last_name, customer.customer_id, SUM(payment.amount) AS total_paid
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id,customer.first_name, customer.last_name
ORDER BY customer.last_name;



-- 8. List the titles of films per category.

SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT category.name AS category_name, film.title AS film_title
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name, film.title;