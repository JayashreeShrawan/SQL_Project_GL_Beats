-- [1] How to retrieve all the rows of data present in our table album?
SELECT * from album
FROM GL_BEATS.ALBUM


-- [2] How many rows of data are present in our table customers?
SELECT COUNT(DISTINCT CUSTOMER_ID)
FROM GL_BEATS.CUSTOMERS


-- [3] In order to show sample rows to the top management, write a query to show only 5 rows from the table artist.
SELECT *
FROM GL_BEATS.ARTIST
LIMIT 5


-- [4] Write a query to retrieve the unique playlist in our database.
SELECT COUNT(DISTINCT PLAYLIST_ID) 
FROM GL_BEATS.PLAYLIST

-- [5]  Write a query to fetch the unique artists present in our database?SELECT COUNT(DISTINCT ARTIST_ID) 
SELECT COUNT(DISTINCT ARTIST_ID) 
FROM GL_BEATS.ARTIST


-- [6] Write a query to count the customers in the country of Brazil?
SELECT count*
FROM GL_BEATS.CUSTOMERS
WHERE CUSTOMER_COUNTRY = 'BRAZIL'



-- [7] Write a query to count the number of artists?
SELECT COUNT(DISTINCT ARTIST_NAME)
FROM GL_BEATS.ARTIST

-- [8] Write a query to count the number of customers in the countries of Brazil, Germany, and Canada.
SELECT *
FROM GL_BEATS.CUSTOMERS
WHERE CUSTOMER_COUNTRY IN ('BRAZIL','GERMANY', 'CANADA')

-- [9] Write a query to retrieve information about customers with customer IDs ranging from 1 to 10.
SELECT *
FROM GL_BEATS.CUSTOMERS
WHERE CUSTOMER_ID BETWEEN 1 AND 10


-- [10] Write a query to fetch the details of the tracks whose duration is between 100000 and 500000 and whose price is 0.99.
SELECT *
FROM GL_BEATS.TRACKS
WHERE MILLISECONDS BETWEEN 100000 AND 500000
AND UNIT_PRICE = 0.99

-- [11] Write a query to fetch the details of the tracks whose duration is in between 100000 and 500000 or whose price is 0.99?
SELECT *
FROM GL_BEATS.TRACKS
WHERE MILLISECONDS BETWEEN 100000 AND 500000
OR UNIT_PRICE = 0.99

-- [12] Write a query to get all the details for the customers whose first name starts with L?
SELECT *
FROM GL_BEATS.CUSTOMERS
WHERE FIRST_NAME LIKE 'L%'

-- [13] Write a query to get all the details for the customers whose first name ends with L?
SELECT *
FROM GL_BEATS.CUSTOMERS
WHERE FIRST_NAME LIKE '%L'

-- [14] Write a query to fetch the details of the customer whose first name is Dan.
SELECT *
FROM GL_BEATS.CUSTOMERS
WHERE FIRST_NAME = 'DAN'


-- [15] Write a query to fetch the details of the tracks whose unit price should not be equal to $0.99 and also the genre ID should not be equal to 18.
SELECT *
FROM GL_BEATS.TRACKS
WHERE UNIT_PRICE != '0.99' AND GENRE_ID != '18'


-- [16] Write a query to fetch the details of the tracks where the unit price is greater than 0.99 $?
SELECT *
FROM GL_BEATS.TRACKS
WHERE UNIT_PRICE >0.99

-- [17] Write a query to fetch the details of the tracks whose genre id is 18.
SELECT *
FROM GL_BEATS.TRACKS
WHERE GENRE_ID = 18

-- [18] Write a query to fetch the details of the tracks for the genre id greater than 18?
SELECT *
FROM GL_BEATS.TRACKS
WHERE GENRE_ID > 18

-- [19]  Write a query to fetch the invoices for the billing city of Edmonton, and also the billing price should be greater than 8 dollars.
SELECT *
FROM GL_BEATS.INVOICE
WHERE BILLING_CITY = 'EDMONTON' AND TOTAL_PRICE > 8


-- [20] Write a query to fetch the invoices whose billing city is Berlin or Paris and the invoice date is 2009-02-01.
SELECT *
FROM GL_BEATS.INVOICE
WHERE BILLING_CITY = 'BERLIN' OR 'PARIS' AND INVOICE_DATE = '2009-02-01'


-- [21] Write a query to retrieve number of unique composers from tracks table
SELECT COUNT(DISTINCT COMPOSER)
FROM GL_BEATS.TRACKS

-- [22] Write a query to retrieve number of invoices in each city from invoice table in descending order.
SELECT *
FROM GL_BEATS.INVOICE
ORDER BY BILLING_CITY DESC

-- [23] Write a query to get the revenue generated in each city from invoice table in descending order of cities.
SELECT *
FROM GL_BEATS.INVOICE
ORDER BY TOTAL_PRICE DESC

-- [24] Write a query to get the number of customers in each country that have number of customers more than 5 from customers table.
use gl_beats ;
select count(customer_id) as number_of_customers, customer_country
from customers
group by customer_country
having number_of_customers > 5
order by number_of_customers desc


