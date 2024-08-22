USE gl_beats;

/* -------------------------------------------
SECTION-01: Exploring the tables individually
--------------------------------------------*/

-- SELECT the top 10 rows from each table to understand the data
select *
from album
LIMIT 10;
select *
from artist
LIMIT 10;
select *
from customers
LIMIT 10;
select *
from genre
LIMIT 10;
select *
from invoice
LIMIT 10;
select *
from invoice_items
LIMIT 10;
select *
from mediatypes
LIMIT 10;
select *
from playlist
LIMIT 10;
select *
from playlisttrack
LIMIT 10;
select *
from tracks
LIMIT 10;

-- [1.A] How many Albums per Artist do we offer to our Customers?
select count(album_id) as no_of_albums, artist_id
from album
group by artist_id
-- [1.B] Who are the top Artists based on the number of Albums released?
select count(album_id) as no_of_albums ,  ar.artist_name
from album al
join artist ar on ar.artist_id = al.artist_id
group by  ar.artist_name
order by no_of_albums desc


-- [2.A] How many Customers subscribe to us?
select count(customer_id) as customers_subscribed
from gl_beats.customers
-- [2.B] What is their distribution across Countries?
select count(customer_id) as customer_count, customer_country
from gl_beats.customers
group by 2
order by 2 desc


-- [3.A] How much Revenue have we generated so far?
select sum(total_price) as revenue
from invoice

-- [3.B] What is the % contribution by Country?
select 
billing_country,
round(sum(total_price)/(select sum(total_price) from invoice),2) as Country_contribution
from invoice
group  by billing_country
order by Country_contribution desc


-- [4.A] Who are our top customers by Price?
a)  select inv.customer_id, concat(first_name, '  ', last_name) as full_name , sum(total_price) as tp
from invoice inv
join gl_beats.customers as cus on cus.customer_id = inv.customer_id
group by customer_id, full_name
order by tp desc
b) select total_price, concat(first_name, '  ', last_name), inv.customer_id
from gl_beats.invoice inv
join gl_beats.customers as cus on cus.customer_id = inv.customer_id
order by total_price desc
-- [4.B] Who are our top customers by Orders?
select customer_id, count(invoice_id) as total_order
from invoice
group by customer_id 
order by total_order desc



-- [5.A] How many playlists do we have?
select count(playlist_id)
from playlist 
-- [5.B] How many tracks do we have in each playlist?
select count(t.track_name), pl.playlist_id,pl.playlist_name
from playlist pl
join playlisttrack pt on pt.playlist_id = pl.playlist_id
join tracks t on t.track_id = pt.track_id
group by pl.playlist_id,pl.playlist_name




    
-- [6.A] Find the unique number of tracks, genres, albums, media types, and composers from the tracks table
select  
count(distinct track_id),
count(distinct genre_id),
count(distinct album_id), 
count(distinct media_type_id),
count(distinct composer)
from tracks
-- [6.B] Find the pricing ranges and the average byte size for each range
select unit_price, avg(bytes)
from tracks
group by unit_price 

-- [7.A] What is the distribution of tracks across albums?
select count(track_id) nooftracks, album_id
from tracks
group by 2
order by nooftracks desc


-- [7.B] What is the distribution of tracks across genres?
select  t.genre_id, count(track_id) as no_of_tracks
from tracks t
group by 1
order by no_of_tracks desc


    -- [7.C] What is the distribution of tracks across media types?
    select media_type_id , count(track_id) as no_of_tracks
    from tracks t
    group by 1
    order  by no_of_tracks desc


-- [7.D] How many tracks are priced at $0.99 and $1.99?
select count(track_id) as no_of_tracks , unit_price
from tracks
group by unit_price

 
-- [8.A] How many tracks do we have with unknown composers? 
select count(track_id) as nooftracks, composer
from tracks
where composer = ''

-- [8.B] What is the distribution of tracks by the composer?
select count(track_id) as nocomposer, composer
from tracks
group by composer
order by nocomposer desc

-- [8.C] What is the average size of each track in Megabytes, and the average price across each media type
-- 1 Kilobyte = 1024 Bytes
-- 1 Megabyte = 1024 Kilobytes
-- 1 Megabyte = 1024*1024 Bytes = 1048576 Bytes
select media_type_id, 
round(avg(bytes)/1048576,2) "average_size",
avg(unit_price) as average_price
from tracks
group by media_type_id




/* -----------------------------------
SECTION-02: Giving Recommendations
------------------------------------*/

-- [1] Which are the top 5 genres the customers buy?
select count(g.genre_id) as genre_count, genre_name
from tracks t
join genre g on g.genre_id = t.genre_id
group by genre_name
order by 1 desc
limit 5



-- [2] Who are the top 5 composers that customers prefer to listen to? 
SELECT COUNT(inv.invoice_id), t.composer
FROM tracks t
join invoice_items inv on inv.track_id = t.track_id
group by 2
order by 1 desc
limit 6


-- [3] Are there certain artists preferred more in some countries? 
-- Alternate Question: Are there artists whose tracks are purchased 20% or more out of all invoices in a single country?
-- This will give us insight into which artists the customers in a country prefer to listen to the most?
WITH purchases AS (
SELECT 
	i.billing_country,
    art.artist_name, 
    t.track_id,
	COUNT(*) OVER (PARTITION BY i.billing_country, art.artist_name) purchases_per_artist,
	COUNT(*) OVER (PARTITION BY i.billing_country) total_purchases 
FROM
	artist art
    JOIN album a USING(artist_id)
    JOIN tracks t USING(album_id)
    JOIN invoice_items it USING(track_id)
    JOIN invoice i USING(invoice_id)
GROUP BY artist_name, billing_country, track_id) 

SELECT 
	billing_country,
    artist_name, 
    min(purchases_per_artist) / min(total_purchases) AS ratio
FROM purchases
GROUP BY 1,2
HAVING ratio >= 0.20
ORDER BY billing_country, ratio DESC;
