use ONLINE_STORE

show tables
CREATE TABLE Categories 
(
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    Name_ VARCHAR(100) NOT NULL UNIQUE
);
select * from categories


CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(255) NOT NULL,
    description_ TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image_url VARCHAR(255),
    category_id INT,
    shopping_cart INT NOT NULL DEFAULT 0,
    stock_quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
select * from products

drop table products

CREATE TABLE users 
(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_ VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from users

CREATE TABLE addresses (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    address_line_1 VARCHAR(255) NOT NULL,
    address_line_2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    zip_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    is_billing_default BOOLEAN DEFAULT FALSE,
    is_shipping_default BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
select * from addresses


CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipping_address_id INT,
    billing_address_id INT,
    order_status VARCHAR(50) DEFAULT 'Pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (shipping_address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (billing_address_id) REFERENCES addresses(address_id)
);
select * from orders

CREATE TABLE order_items (
    order_id INT not null,
    product_id INT,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL
);
select * from order_items

drop table order_items

CREATE TABLE shopping_cart (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY user_product (user_id, product_id)
);
select * from shopping_cart

drop table shopping_cart

INSERT INTO categories (name_) VALUES
    ('Electronics'),
    ('Clothing'),
    ('Home & Kitchen'),
    ('Books');
    
    INSERT INTO products (name_, description_, price, image_url, category_id, stock_quantity) VALUES
    ('Laptop', 'Powerful laptop for work and play', 1200.00, 'laptop.jpg', 1, 50),
    ('T-Shirt', 'Comfortable cotton T-shirt', 25.00, 'tshirt.jpg', 2, 100),
    ('Coffee Maker', 'Automatic coffee maker', 75.00, 'coffeemaker.jpg', 3, 30),
    ('The Great Novel', 'A classic novel', 15.00, 'novel.jpg', 4, 20),
    ('Smartphone', 'Latest smartphone model', 1000.00, 'smartphone.jpg', 1, 40),
    ('Jeans', 'Classic blue jeans', 50.00, 'jeans.jpg', 2, 80),
    ('Blender', 'High-speed blender', 150.00, 'blender.jpg', 3, 20),
    ('Database Design', 'Book about database systems', 40.00, 'databasebook.jpg', 4, 15);


INSERT INTO users (username, password_, email, first_name, last_name) VALUES
    ('john_doe', '$2y$10$abcdefghijklmnopqrstuvwx', 'john.doe@example.com', 'John', 'Doe'),  --  Use a hashed password!
    ('jane_smith', '$2y$10$zyxwvutsrqponmlkjihgfed', 'jane.smith@example.com', 'Jane', 'Smith'),
    ('bob_johnson', '$2y$10$1234567890abcdefghijklmn', 'bob.johnson@example.com', 'Bob', 'Johnson');
    
INSERT INTO addresses (user_id, address_line_1, address_line_2, city, state, zip_code, country, is_billing_default, is_shipping_default) VALUES
    (1, '123 Main St', '', 'Anytown', 'CA', '12345', 'USA', TRUE, TRUE),
    (1, '456 Oak Ave', 'Apt 2B', 'Anytown', 'CA', '12345', 'USA', FALSE, FALSE),
    (2, '789 Pine Ln', '', 'Sometown', 'NY', '67890', 'USA', TRUE, TRUE),
    (3, '111 Elm St', '', 'Othertown', 'TX', '24680', 'USA', TRUE, TRUE);
    
    INSERT INTO orders (user_id, shipping_address_id, billing_address_id, order_status, total_amount) VALUES
    (1, 1, 1, 'Pending', 1225.00),  -- John Doe ordered a laptop and t-shirt
    (2, 3, 3, 'Shipped', 75.00),    -- Jane Smith ordered a coffee maker
    (1, 2, 2, 'Delivered', 65.00);  -- John Doe ordered jeans and t-shirt
    
    INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    (1, 9, 2, 1200.00), -- Order 1: Laptop
    (2, 10, 4, 25.00),   -- Order 2: T-Shirt
    (3, 11, 2, 75.00),   -- Order 3: Coffee Maker
    (4, 14, 2, 50.00),   -- Order 4: Jeans
    (5, 16, 1, 40.00);    -- Order 4: Database Design
    
    INSERT INTO shopping_cart (cart_item_id, user_id, product_id, quantity) VALUES
    (1, 1, 4, 2),  -- John Doe has 2 "The Great Novel" in his cart
    (2, 2, 5, 1),  -- Jane Smith has 1 Smartphone in her cart
    (3, 3, 7, 1);  -- Bob Johnson has 1 Blender in his cart


