CREATE DATABASE assessment_1;
USE assessment_1;

CREATE TABLE authors(
author_id int auto_increment primary key,
name varchar(20),
country varchar(10));
INSERT INTO authors VALUES 
(101,'J.KRowling','UK'),
(102,'gorge.R.R.Martin','USA'),
(103,'Dan Brown','USA'),
(104,'Agatha Christie','UK');
SELECT * FROM authors;

CREATE TABLE books(
book_id int auto_increment primary key, 
title varchar(50),
author_id int,
price decimal(10,2),
stock int,
FOREIGN KEY (author_id) references authors(author_id));
INSERT INTO books VALUES
(1,'Harry Potter_1',101,20.99,50),
(2,'Harry Potter_2',101,22.99,40),
(3,'Game of Thrones_1',102,25.5,30),
(4,'Inferno',103,18.75,20),
(5,'Murder on the Orient Express',104,15.0,35);
SELECT * FROM books;

CREATE TABLE customers(
customer_id int auto_increment primary key,
name varchar(50),
email varchar(50));
INSERT INTO customers VALUES
(201,'Alice','alice@gmail.com'),
(202,'Bob','bob2gmail.com'),
(203,'Carol','carol@gmail.com'),
(204,'Dave','dave@gmail.com'),
(205,'Eve','eve@gmail.com');
SELECT * FROM customers;

CREATE TABLE orders(
order_id int auto_increment primary key,
customer_id int,
order_date date,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id));
INSERT INTO orders VALUES
(301,201,'2025-12-01'),
(302,202,'2025-12-03'),
(303,201,'2025-12-04'),
(304,203,'2025-12-05');
SELECT * FROM orders;

CREATE TABLE orderDetails(
order_detail_id int auto_increment primary key,
order_id int, 
book_id int,
quantity int,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (book_id) REFERENCES books(book_id));
INSERT INTO orderDetails VALUES
(401,301,1,2),
(402,301,3,1),
(403,302,2,1),
(404,303,5,2),
(405,304,4,1);
SELECT * FROM orderDetails;

-- CRUD OPERATIONS
-- 1. Insert a new book: 'The Hobbit', author J.R.R. Tolkien, price 19.99, stock 25.
INSERT INTO authors(name) VALUES ('J.R.R. Tolkien');
INSERT INTO books(title,author_id,price,stock) VALUES('The Hobbit',105,19.99,25);

-- 2. Update the stock of 'Harry Potter 1' to 60.
UPDATE books SET stock=60 WHERE title = 'Happry Potter_1';

-- 3.Delete the customer 'Eve' from the Customers table.
DELETE FROM customers WHERE name = 'Eve';

-- 4.Add a new order for Bob (customer_id 202) for 1 copy of 'Inferno'.
INSERT INTO orders (customer_id, order_date) VALUES (202, '2026-01-23');

-- 2. JOIN Queries
-- 5. List all books with their authors’ names. (INNER JOIN)
SELECT B.title AS book_title, A.name AS author FROM books B
INNER JOIN authors A ON B.author_id = A.author_id;

-- 6.List all customers and their orders, including customers with no orders. (LEFT JOIN)
SELECT C.customer_id, C.name AS Customer_Name, O.order_id FROM customers C
LEFT JOIN orders O ON C.customer_id = O.customer_id;

-- 7. List all orders and customer info, even if an order doesn’t have a customer. (RIGHT JOIN)
SELECT C.customer_id, C.name as Customer_Name, C.email, O.order_id FROM customers C 
RIGHT JOIN orders O on C.customer_id = O.customer_id;

-- 8. Show all orders with book titles and quantity ordered. (JOIN multiple tables)
SELECT O.order_id, O.order_date, B.title AS book_title, OD.quantity FROM orders O 
JOIN orderDetails OD ON O.order_id = OD.order_id
JOIN books B ON OD.book_id = B.book_id
ORDER BY O.order_id;

-- 3. Aggregations
-- 9. Count how many books each author has in the store.
SELECT a.name, COUNT(book_id) AS book_count FROM authors a inner join books b on a.author_id = b.author_id GROUP BY a.name;

-- 10. Find total revenue for each book.
SELECT SUM(price*stock) AS total_revenue, title FROM books GROUP BY title;

-- 11. Calculate the average price of books.
SELECT AVG(price) AS avarage_price FROM books;

-- 12. Count the number of orders placed by each customer.
SELECT customer_id,COUNT(*) AS number_of_orders FROM orders GROUP BY customer_id;

-- 4. Filtering
-- 13. List all books priced under $20.
SELECT * FROM books WHERE price<20;

-- 14. Find authors with more than 1 book in the store.
SELECT author_id, COUNT(*) FROM books GROUP BY author_id HAVING COUNT(*)>1;

-- 15. Show customers with more than 1 order.
SELECT customer_id, COUNT(*) FROM orders GROUP BY customer_id HAVING COUNT(*)>1;

-- 16. List all orders placed after 2025-12-02.
SELECT * FROM orders WHERE order_date<'2025-12-02';

-- 5. Sorting
-- 17. List all books sorted by price (high to low).
SELECT * FROM books ORDER BY price DESC;

-- 18. Show the top 3 customers with the most orders.
SELECT customer_id, COUNT(*) AS order_count FROM orders GROUP BY customer_id ORDER BY customer_id LIMIT 3;

-- 19. List books alphabetically by title.
SELECT title FROM books ORDER BY title ASC;

-- 20. Show orders sorted by order date descending.
SELECT * FROM orders ORDER BY order_date DESC;

-- 6. Bonus / Advanced
-- 21. Find the customer who spent the most money.
SELECT O.customer_id, C.name AS customer_name, SUM(B.price * OD.quantity) AS total_spent
FROM orders O
JOIN orderDetails OD ON O.order_id = OD.order_id
JOIN books B ON OD.book_id = B.book_id
JOIN customers C ON O.customer_id = C.customer_id
GROUP BY O.customer_id, C.name
ORDER BY total_spent DESC
LIMIT 1;
/*select C.name, O.order_id FROM customers C
JOIN orders O ON C.customer_id=O.customer_id
JOIN orderDetails OD ON O.order_id=OD.order_id
WHERE OD.book_id=(SELECT (OD.quantity*b.price) as total_cost,c.customer_id from orderDetailels OD, books b,customers c
                  join b on b.book_id=od.book_id);*/
                  
-- 22. Show authors whose books generated total revenue > $50.
SELECT A.author_id, A.name AS author_name, SUM(B.price * OD.quantity) AS total_revenue
FROM authors A
JOIN books B ON A.author_id = B.author_id
JOIN orderDetails OD ON B.book_id = OD.book_id
GROUP BY A.author_id, A.name
HAVING SUM(B.price * OD.quantity) > 50;
/*select a.name, SUM(od.quantity*b.price) as revenue FROM orders O
JOIN orderDetails OD ON O.order_id = OD.order_id
JOIN books b ON OD.book_id = b.book_id
Join authors a ON a.author_id = b.author_id
group by b.book_id,od.order_id
order by revenue desc limit 1;*/

-- 23. List books never ordered.
select b.book_id, b.title from books b left join orderDetails od on b.book_id = od.book_id where od.order_detail_id is null;

-- 24. Find customers who ordered more than one book from the same author.
SELECT O.customer_id, C.name AS customer_name, B.author_id, A.name AS author_name, COUNT(OD.book_id) AS book_count
FROM orders O
JOIN orderDetails OD ON O.order_id = OD.order_id
JOIN books B ON OD.book_id = B.book_id
JOIN authors A ON B.author_id = A.author_id
JOIN customers C ON O.customer_id = C.customer_id
GROUP BY O.customer_id, C.name, B.author_id, A.name
HAVING COUNT(OD.book_id) > 1;
select * from orders;