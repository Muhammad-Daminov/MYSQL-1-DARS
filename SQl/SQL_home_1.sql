create database Laptop;
create table computers(Brand VARCHAR(50), model VARCHAR(50), cpu VARCHAR(50), frequency int, ram int, os VARCHAR(50), price int);
INSERT INTO computers (brand, model, cpu, frequency, ram, os, price) VALUES
('Apple', 'MacBook Pro', 'Intel Core i7', 2.5, 16, 'macOS', 2500),
('Apple', 'MacBook Air', 'Intel Core i5', 1.8, 8, 'macOS', 1500),

('ASUS', 'ZenBook', 'Intel Core i7', 3.0, 16, 'Windows 10', 1800),
('ASUS', 'VivoBook', 'AMD Ryzen 5', 2.5, 8, 'Windows 10', 900),

('HP', 'Pavilion', 'Intel Core i5', 2.3, 8, 'Windows 10', 800),
('HP', 'Envy', 'Intel Core i7', 3.5, 16, 'Windows 10', 2000),

('Dell', 'XPS 13', 'Intel Core i7', 3.2, 16, 'Windows 10', 2200),
('Dell', 'Inspiron', 'AMD Ryzen 5', 2.5, 8, 'Windows 10', 700),

('Lenovo', 'ThinkPad', 'Intel Core i7', 3.1, 16, 'Windows 10', 2100),
('Lenovo', 'IdeaPad', 'AMD Ryzen 5', 2.4, 8, 'Windows 10', 750),

('Acer', 'Aspire', 'Intel Core i5', 2.2, 8, 'Windows 10', 650),
('Acer', 'Swift', 'Intel Core i7', 3.3, 16, 'Windows 10', 1700),

('MSI', 'GF63', 'Intel Core i7', 3.4, 16, 'Windows 10', 1900),
('MSI', 'Modern', 'Intel Core i5', 2.1, 8, 'Windows 10', 1000),

('Samsung', 'Galaxy Book', 'Intel Core i5', 2.0, 8, 'Windows 10', 1100),
('Samsung', 'Notebook 9', 'Intel Core i7', 3.2, 16, 'Windows 10', 1600),

('Huawei', 'MateBook D', 'AMD Ryzen 5', 2.5, 8, 'Windows 10', 850),
('Huawei', 'MateBook X', 'Intel Core i7', 3.1, 16, 'Windows 10', 2000),

('LG', 'Gram', 'Intel Core i7', 3.0, 16, 'Windows 10', 2100),
('LG', 'UltraPC', 'Intel Core i5', 2.3, 8, 'Windows 10', 950);

SELECT * FROM computers
ORDER BY price DESC
LIMIT 1;

SELECT * FROM computers
ORDER BY price ASC
LIMIT 1;


SELECT frequency FROM computers
WHERE price BETWEEN 400 AND 1000
AND cpu LIKE '%Intel%';

SELECT COUNT(*) FROM computers
WHERE brand = 'Apple';

SELECT * FROM computers
WHERE brand = 'ASUS'
AND os LIKE '%Windows%'
AND ram = 8
ORDER BY price ASC;
