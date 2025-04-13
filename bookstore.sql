-- Create the database
CREATE DATABASE IF NOT EXISTS BookStore;
USE BookStore;

-- Create tables in proper order to avoid reference issues

-- Address status table
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Country table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- Address table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    county VARCHAR(50),
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Publisher table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(150) NOT NULL,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Book language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(45) NOT NULL
);

-- Author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(75) NOT NULL,
    last_name VARCHAR(75) NOT NULL
);

-- Book table (main entity)
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20),
    language_id INT NOT NULL,
    publisher_id INT NOT NULL,
    publication_year YEAR,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Book-author many-to-many relationship
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(75) NOT NULL,
    last_name VARCHAR(75) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    registration_date DATE NOT NULL
);

-- Customer-address many-to-many relationship with status
CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Order status table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Shipping method table
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);

-- Customer order table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    shipping_method_id INT,
    status_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id)
);

-- Order line items
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Order history tracking
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- =============================================
-- INSERT SAMPLE DATA
-- =============================================

-- Address statuses
INSERT INTO address_status (status_name) VALUES 
('Primary'), ('Secondary'), ('Inactive'), ('Business');

-- Countries
INSERT INTO country (country_name) VALUES 
('United States'), ('United Kingdom'), ('Canada'), ('Germany'), ('France'), ('Kenya');

-- Addresses
INSERT INTO address (street, city, county, country_id) VALUES
('123 Main St', 'Nairobi', 'Nairobi County', 6),
('456 Elm St', 'Mombasa', 'Mombasa County', 6),
('789 Oak Ave', 'New York', 'NY', 1),
('321 Maple Rd', 'London', 'Greater London', 2),
('555 Pine Blvd', 'Toronto', 'Ontario', 3),
('100 Book Lane', 'Nairobi', 'Nairobi County', 6);

-- Publishers
INSERT INTO publisher (publisher_name, address_id) VALUES
('East African Publishers', 1),
('Longhorn Publishers', 2),
('Penguin Random House', 3),
('Macmillan Publishers', 4),
('Jomo Kenyatta Foundation', 6);

-- Languages
INSERT INTO book_language (language_name) VALUES
('English'), ('Swahili'), ('French'), ('German'), ('Kikuyu'), ('Luo');

-- Authors
INSERT INTO author (first_name, last_name) VALUES
('Ngugi', 'wa Thiong''o'),
('Meja', 'Mwangi'),
('Grace', 'Ogot'),
('Chinua', 'Achebe'),
('Margaret', 'Ogola'),
('John', 'Kiriamiti');

-- Books
INSERT INTO book (title, isbn, language_id, publisher_id, publication_year, price, stock_quantity) VALUES
('Petals of Blood', '978-0143105424', 1, 1, 1977, 1200.00, 50),
('Weep Not, Child', '978-0143105462', 1, 1, 1964, 950.00, 30),
('Going Down River Road', '978-9966466296', 1, 2, 1976, 1100.00, 40),
('The River Between', '978-0435905484', 1, 1, 1965, 1000.00, 25),
('The Promised Land', '978-9966251564', 1, 5, 2010, 850.00, 35),
('My Life in Crime', '978-9966251236', 1, 2, 1984, 900.00, 20);

-- Book authors
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), (2, 1), (3, 2), (4, 1), (5, 5), (6, 6);

-- Customers
INSERT INTO customer (first_name, last_name, email, phone, registration_date) VALUES
('James', 'Mwangi', 'james.mwangi@example.com', '254712345678', '2023-01-15'),
('Wanjiru', 'Kamau', 'wanjiru.kamau@example.com', '254723456789', '2023-02-20'),
('Paul', 'Ochieng', 'paul.ochieng@example.com', '254734567890', '2023-03-10'),
('Amina', 'Mohamed', 'amina.mohamed@example.com', '254745678901', '2023-04-05'),
('David', 'Kipchoge', 'david.kipchoge@example.com', '254756789012', '2023-05-12');

-- Customer addresses
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1), (1, 3, 2),
(2, 2, 1),
(3, 4, 1),
(4, 5, 1),
(5, 6, 1);

-- Order statuses
INSERT INTO order_status (status_name) VALUES
('Pending'), ('Processing'), ('Shipped'), ('Delivered'), ('Cancelled'), ('Returned');

-- Shipping methods
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard Delivery', 200.00),
('Express Delivery', 400.00),
('Same Day Delivery', 600.00),
('Pickup In-Store', 0.00);

-- Customer orders
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, status_id, shipping_address_id) VALUES
(1, '2024-01-10 09:15:00', 1, 4, 1),
(2, '2024-01-15 14:30:00', 2, 4, 2),
(3, '2024-02-05 11:45:00', 4, 4, 4),
(4, '2024-02-20 16:20:00', 1, 3, 5),
(5, '2024-03-01 10:00:00', 3, 2, 6),
(1, '2024-03-15 13:10:00', 1, 1, 3);

-- Order lines
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 1, 1200.00),
(1, 2, 2, 950.00),
(2, 3, 1, 1100.00),
(3, 4, 1, 1000.00),
(3, 5, 1, 850.00),
(4, 6, 3, 900.00),
(5, 1, 1, 1200.00),
(5, 3, 1, 1100.00),
(6, 2, 1, 950.00);

-- Order history
INSERT INTO order_history (order_id, status_id, status_date, notes) VALUES
(1, 1, '2024-01-10 09:15:00', 'Order placed'),
(1, 2, '2024-01-10 11:30:00', 'Processing started'),
(1, 3, '2024-01-12 08:45:00', 'Shipped via Standard Delivery'),
(1, 4, '2024-01-15 14:00:00', 'Delivered to customer'),
(2, 1, '2024-01-15 14:30:00', 'Order placed'),
(2, 2, '2024-01-15 15:45:00', 'Processing started'),
(2, 3, '2024-01-16 09:30:00', 'Shipped via Express Delivery'),
(2, 4, '2024-01-17 16:20:00', 'Delivered to customer'),
(3, 1, '2024-02-05 11:45:00', 'Order placed for in-store pickup'),
(3, 4, '2024-02-05 15:30:00', 'Picked up by customer'),
(4, 1, '2024-02-20 16:20:00', 'Order placed'),
(4, 2, '2024-02-21 09:15:00', 'Processing started'),
(4, 3, '2024-02-22 10:45:00', 'Shipped via Standard Delivery'),
(5, 1, '2024-03-01 10:00:00', 'Order placed'),
(5, 2, '2024-03-01 11:30:00', 'Processing started'),
(6, 1, '2024-03-15 13:10:00', 'Order placed');

-- =============================================
-- USER MANAGEMENT
-- =============================================

-- Admin user with full privileges
CREATE USER IF NOT EXISTS 'bookstore_admin'@'localhost' IDENTIFIED BY 'SecureAdmin123!';
GRANT ALL PRIVILEGES ON BookStore.* TO 'bookstore_admin'@'localhost';

-- Read-only user for reports
CREATE USER IF NOT EXISTS 'bookstore_report'@'localhost' IDENTIFIED BY 'ReadOnly456!';
GRANT SELECT ON BookStore.* TO 'bookstore_report'@'localhost';

-- Staff user with limited privileges
CREATE USER IF NOT EXISTS 'bookstore_staff'@'localhost' IDENTIFIED BY 'StaffPass789!';
GRANT SELECT, INSERT, UPDATE ON BookStore.customer TO 'bookstore_staff'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BookStore.cust_order TO 'bookstore_staff'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BookStore.order_line TO 'bookstore_staff'@'localhost';
GRANT SELECT, INSERT, UPDATE ON BookStore.order_history TO 'bookstore_staff'@'localhost';
GRANT SELECT ON BookStore.book TO 'bookstore_staff'@'localhost';
GRANT SELECT ON BookStore.author TO 'bookstore_staff'@'localhost';

-- Flush privileges to apply changes
FLUSH PRIVILEGES;