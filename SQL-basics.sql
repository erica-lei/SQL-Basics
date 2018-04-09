 USE  sakila;
 
 -- *Display the first and last names of all actors from the table `actor`. 
 SELECT first_name, last_name FROM actor;
 
 -- *Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name*
 SELECT first_name, last_name, CONCAT(first_name," ", last_name) AS full_name FROM actor;
 SELECT * FROM actor;
 
 ALTER TABLE actor
 DROP actorName;
  
 -- * You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?*

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- Find all actors whose last name contain the letters `GEN`: - 
SELECT * FROM actor
WHERE last_name LIKE '%gen%'; 

-- Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order: -- 
SELECT * FROM actor
WHERE last_name LIKE '%li%' 
ORDER BY last_name, first_name;

-- * Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China -- 

SELECT country_id, country
FROM country
WHERE country IN ( 'Afghanistan', 'Bangladesh', 'China');

 -- Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. Hint: you will need to specify the data type.

 ALTER TABLE actor
 ADD middle_name VARCHAR(30) AFTER first_name; 
 
 -- You realize that some of these actors have tremendously long last names. Change the data type of the `middle_name` column to `blobs`.
 
ALTER TABLE actor 
DROP middle_name;


ALTER TABLE actor
ADD middle_name BLOB AFTER first_name;

SELECT * FROM actor;

-- Now delete the `middle_name` column. 

ALTER TABLE actor
DROP middle_name;

 -- List the last names of actors, as well as how many actors have that last name.
SELECT last_name, count(last_name) 
FROM actor
GROUP BY last_name;

 -- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
 
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name, first_name
HAVING COUNT(first_name) > 1; 

-- Oh, no! The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS` Write a query to fix the record.
UPDATE actor 
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

SELECT * FROM actor
WHERE first_name = "Harpo";

-- Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! 
-- In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`. 
-- Otherwise, change the first name to `MUCHO GROUCHO`, as that is exactly what the actor will be with the grievous error. 
-- BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO `MUCHO GROUCHO`, HOWEVER! (Hint: update the record using a unique identifier.)

UPDATE actor
SET first_name = "GROUCHO" 
WHERE first_name = "Harpo" AND last_name = "WILLIAMS";

 --  You cannot locate the schema of the `address` table. Which query would you use to re-create it? 
SHOW CREATE TABLE address;

-- Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address
SELECT * FROM address;
SELECT * FROM staff;

 
SELECT address.* , staff.*
FROM address
INNER JOIN staff ON address.address_id  = staff.address_id; 

-- with alias
SELECT a.* , s.*
FROM address a
INNER JOIN staff s ON a.address_id = s.address_id;

-- with selected columns
SELECT a.address, a.address_id, a.district, a.city_id , a.postal_code , a.phone , a.location , a.last_update , s.first_name, s.last_name, s.staff_id , s.last_update
FROM address a 
INNER JOIN staff s ON a.address_id = s.address_id;

--  Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`. 

 -- DOO !!! -- 
SELECT * FROM payment;
SELECT * FROM staff; 

SELECT s.* , p.*
FROM staff s
INNER JOIN payment p ON s.staff_id = p.staff_id;

SELECT staff.*, payment.*
FROM staff
LEFT JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment_date BETWEEN '2005-08-01%' AND '2005-08-31';

 --  List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
 SELECT * FROM film; 
 SELECT * FROM film_actor;
 
 SELECT film.title, COUNT(film_actor.actor_id) AS 'Actor Count'
 FROM film 
 INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY title; -- need to count the titles -- 



-- How many copies of the film Hunchback Impossible exist in the inventory system? (film id _ 439 ) -- 
SELECT * FROM inventory; 
SELECT * FROM film_text;

SELECT film_text.title , COUNT(film_text.title)
FROM film_text
INNER JOIN inventory ON film_text.film_id = inventory.film_id
WHERE title = 'Hunchback Impossible';


-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. -- 
-- List the customers alphabetically by last name -- 
SELECT * FROM payment;
SELECT * FROM customer;


SELECT payment.customer_id , customer.first_name, customer.last_name, SUM(payment.amount) as 'Total'
FROM payment
INNER JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY customer.last_name;




