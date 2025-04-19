-- Create customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

-- Create products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price INT
);

-- Create orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    order_date DATE,
    quantity INT
);

-- Insert sample data into customers
INSERT INTO customers (name, city) VALUES
('Raj Sharma', 'Mumbai'),
('Anjali Mehta', 'Delhi'),
('Vikram Patel', 'Ahmedabad'),
('Sneha Reddy', 'Hyderabad');

-- Insert sample data into products
INSERT INTO products (product_name, category, price) VALUES
('T-Shirt', 'Clothing', 500),
('Headphones', 'Electronics', 1500),
('Shoes', 'Footwear', 2000),
('Notebook', 'Stationery', 100),
('Water Bottle', 'Accessories', 300);

-- Insert sample data into orders
INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES
(1, 1, '2024-01-10', 2),
(1, 2, '2024-01-15', 1),
(2, 3, '2024-02-05', 1),
(2, 4, '2024-02-08', 5),
(3, 2, '2024-03-12', 2),
(4, 1, '2024-03-20', 3),
(4, 5, '2024-03-25', 4);
