CREATE TABLE authors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);


INSERT INTO authors (name) VALUES
('Alisher Navoiy'),
('Abdulla Qodiriy'),
('Cho''lpon'),
('J.K. Rowling'),
('George Orwell'),
('Dan Brown'),
('Yuval Noah Harari'),
('J.R.R. Tolkien');


CREATE TABLE janrlar (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

INSERT INTO janrlar (name) VALUES
('She''riyat'),
('Roman'),
('Tarixiy'),
('Fantasy'),
('Triller'),
('Dystopia'),
('Satira');


CREATE TABLE books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    price INT,
    sales INT,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);



INSERT INTO books (title, price, sales, author_id, genre_id) VALUES
('Xamsa', 10, 8000, 1, 1),
('Layli va Majnun', 8, 7500, 1, 1),

('O''tgan kunlar', 12, 5000, 2, 2),
('Mehrobdan chayon', 11, 4200, 2, 2),

('Kecha va kunduz', 9, 3800, 3, 2),

('Harry Potter 1', 20, 12000, 4, 4),
('Harry Potter 2', 20, 11500, 4, 4),
('Harry Potter 3', 20, 11000, 4, 4),

('1984', 15, 8500, 5, 6),
('Animal Farm', 12, 7000, 5, 7),

('Da Vinci Code', 18, 9800, 6, 5),
('Inferno', 18, 9200, 6, 5),

('Sapiens', 25, 11000, 7, 3),
('Homo Deus', 25, 10500, 7, 3),

('The Hobbit', 22, 9500, 8, 4);


-- 1 

SELECT authors.name,
JSON_ARRAYAGG(janrlar.name) AS janrlar
FROM books
INNER JOIN authors ON books.author_id = authors.id
INNER JOIN janrlar ON books.genre_id = janrlar.id
WHERE authors.name = 'Alisher Navoiy'
GROUP BY authors.name;
-- +----------------+----------------------------+
-- | name           | janrlar                    |
-- +----------------+----------------------------+
-- | Alisher Navoiy | ["She'riyat", "She'riyat"] |
-- +----------------+----------------------------+


-- 2

SELECT authors.name,
JSON_ARRAYAGG(janrlar.name) AS janrlar
FROM books
INNER JOIN authors ON books.author_id = authors.id
INNER JOIN janrlar ON books.genre_id = janrlar.id
GROUP BY authors.name;


-- +-------------------+-----------------------------------+
-- | name              | janrlar                           |
-- +-------------------+-----------------------------------+
-- | Abdulla Qodiriy   | ["Roman", "Roman"]                |
-- | Alisher Navoiy    | ["She'riyat", "She'riyat"]        |
-- | Cho'lpon          | ["Roman"]                         |
-- | Dan Brown         | ["Triller", "Triller"]            |
-- | George Orwell     | ["Dystopia", "Satira"]            |
-- | J.K. Rowling      | ["Fantasy", "Fantasy", "Fantasy"] |
-- | J.R.R. Tolkien    | ["Fantasy"]                       |
-- | Yuval Noah Harari | ["Tarixiy", "Tarixiy"]            |
-- +-------------------+-----------------------------------+


--3

SELECT authors.name AS author,
janrlar.name AS janr,
COUNT(*) AS soni
FROM books
JOIN authors ON books.author_id = authors.id
JOIN janrlar ON books.genre_id = janrlar.id
GROUP BY authors.name, janrlar.name;


-- +-------------------+-----------+------+
-- | author            | janr      | soni |
-- +-------------------+-----------+------+
-- | Alisher Navoiy    | She'riyat |    2 |
-- | Abdulla Qodiriy   | Roman     |    2 |
-- | Cho'lpon          | Roman     |    1 |
-- | Yuval Noah Harari | Tarixiy   |    2 |
-- | J.K. Rowling      | Fantasy   |    3 |
-- | J.R.R. Tolkien    | Fantasy   |    1 |
-- | Dan Brown         | Triller   |    2 |
-- | George Orwell     | Dystopia  |    1 |
-- | George Orwell     | Satira    |    1 |
-- +-------------------+-----------+------+


--4

SELECT janrlar.name,
COUNT(*) as soni 
from books
JOIN janrlar on books.genre_id = janrlar.id
GROUP BY janrlar.name
ORDER BY soni  DESC
LIMIT 1;


-- +---------+------+
-- | name    | soni |
-- +---------+------+
-- | Fantasy |    4 |
-- +---------+------+


--5


SELECT 
a.id,
a.name AS author,
j.name AS janr,
COUNT(*) AS soni
FROM books b
INNER JOIN authors a ON b.author_id = a.id
INNER JOIN janrlar j ON b.genre_id = j.id
GROUP BY a.id, a.name, j.name;

-- +----+-------------------+-----------+------+
-- | id | author            | janr      | soni |
-- +----+-------------------+-----------+------+
-- |  1 | Alisher Navoiy    | She'riyat |    2 |
-- |  2 | Abdulla Qodiriy   | Roman     |    2 |
-- |  3 | Cho'lpon          | Roman     |    1 |
-- |  7 | Yuval Noah Harari | Tarixiy   |    2 |
-- |  4 | J.K. Rowling      | Fantasy   |    3 |
-- |  8 | J.R.R. Tolkien    | Fantasy   |    1 |
-- |  6 | Dan Brown         | Triller   |    2 |
-- |  5 | George Orwell     | Dystopia  |    1 |
-- |  5 | George Orwell     | Satira    |    1 |
-- +----+-------------------+-----------+------+


--6 


SELECT a.name,
       SUM(b.sales) AS jami_sotuv
FROM books b
INNER JOIN authors a ON b.author_id = a.id
GROUP BY a.name
ORDER BY jami_sotuv DESC
LIMIT 1;


-- +--------------+------------+
-- | name         | jami_sotuv |
-- +--------------+------------+
-- | J.K. Rowling |      34500 |
-- +--------------+------------+