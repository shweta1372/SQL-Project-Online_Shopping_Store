-- Database: OnlineBookStore

DROP DATABASE IF EXISTS "OnlineBookStore";

SELECT current_database();

DROP TABLE IF EXISTS Books;

CREATE Table Books (
  Book_Id SERIAL PRIMARY KEY,
  Title Varchar(100),
  Author Varchar(100),
  Genre Varchar(50),
  Published_Year INT ,
  Price Numeric(10,2),
  Stock INT
 );

DROP TABLE IF EXISTS customers;

CREATE TABLE Customers(
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country Varchar(150)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
 	 Order_ID SERIAL PRIMARY KEY,
	 Customer_ID INT REFERENCES Customers(Customer_ID),
	 Book_ID INT REFERENCES Books(Book_ID),
	 Order_Date DATE,
	 Quantity INT,
	 Total_Amount NUMERIC(10,2)
);	

SELECT * FROM Books;
SELECT * FROM Orders;
SELECT * FROM Customers;


-- 1.RETRIVE ALL THE BOOKS IN THE FICTION GENRE
SELECT * FROM books WHERE genre = 'Fiction';

-- 2.FIND BOOK PUBLISH AFTER THE YEAR 1950
SELECT title, published_year from books where published_year > 1950;

-- 3.list all customers from canada
SELECT * FROM Customers where lower(country) = 'canada';

-- 4.SHOW ORDER PLACED IN NOVEMBER 2023
SELECT * FROM orders where order_date >= '2023-11-1' and order_date < '2023-12-1' order by order_date;
SELECT * FROM orders WHERE order_date BETWEEN '2023-11-1' and '2023-12-1';

-- 5.Retrive total stock of books available
SELECT SUM(stock) AS Total_stock from books
SELECT * FROM books 

--Find the details of most expensive books
SELECT MAX(price) AS Expensive_book from books


-- SHOW ALL CUSTOMER WHO ORDERED MORE THAN 1 QUANTITY OF BOOK
SELECT * FROM orders where quantity > 1 limit 5 ;

-- RETRIVE ALL THE ORDER WHERE TOTAL AMMOUNT EXCEEDS $20
SELECT * FROM orders where total_amount > 20 ;

-- LIST ALL GENRE AVALABLE IN BOOK TABLE
SELECT DISTINCT(genre) from books

-- FIND THE BOOK WITH LOWEST STOCK
SELECT * from books ORDER BY stock limit 1;

-- CALCULATE THE TOTAL REVENUE GENRATED FROM ALL ORDERS
SELECT SUM(total_amount) as REVENUE from orders

-- ADVANCED QUESTIONS:


-- 1.RETRIVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACH GENRE
SELECT b.genre , SUM(o.quantity) AS total_book_sold
FROM orders o
join books b
ON o.order_id = b.book_id
group by b.genre;

-- 2.FIND THE AVERAGE PRICE OF BOOKS IN THE FANTANCY GENRE
SELECT AVG(price) AS Average_price
FROM books
WHERE genre = 'Fantasy'


-- 3.List of customers who have place atleast two orders
SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.customer_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY 
    c.customer_id,
    c.name
HAVING COUNT(o.customer_id) > 1;


-- Find the most frequently orederd book
SELECT o.book_id ,b.title, count(o.customer_id) as Total_Count
from orders o
JOIN books b ON b.book_id = o.customer_id
group by o.book_id ,b.title
Order by Total_count DESC;

-- -Show the top 3 most expensive books of 'fantasy'
SELECT * from books where genre = 'Fantasy' 
order by price desc
limit 3;

-- retrive the total quantity of books sold by each author
Select b.author, sum(o.Quantity) as Total_quantity
from orders o
join books b
on b.book_id = o.order_id
GROUP BY  b.author;

SELECT * from books
SELECT * FROM orders
SELECT * FROM Customers

-- list the cities where customers who spent over 30 are located
SELECT DISTINCT c.city , o.total_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
where o.total_amount > 30;


-- find the customer who spend most on the order
SELECT 
    c.customer_id,
    c.name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY 
    c.customer_id,
    c.name
ORDER BY total_spent DESC
LIMIT 1;







