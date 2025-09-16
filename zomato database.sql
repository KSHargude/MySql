#MySQL Project: Zomato Database
#Step 1: Database Schema Design

#Create a database named zomato:

CREATE DATABASE zomato;

USE zomato;

#Step 2: Creating Tables

#1. Users Table
#Stores information about the users of the app.

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

#2. Restaurants Table
#Stores details of the restaurants listed on the platform.

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    rating FLOAT CHECK (rating >= 0 AND rating <= 5),
    cuisine VARCHAR(50),
    contact VARCHAR(15)
);

#3. Menu_Items Table
#Stores information about the menu items offered by each restaurant.

CREATE TABLE Menu_Items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    description TEXT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
);

#4. Orders Table
#Manages information about customer orders.

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    restaurant_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    total_price DECIMAL(8, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
);

#5. Order_Items Table
#Manages individual items in an order (many-to-many relationship between Orders and Menu_Items).

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    quantity INT DEFAULT 1,
    price DECIMAL(8, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES Menu_Items(item_id) ON DELETE CASCADE
);

SELECT * FROM Order_Items;

#6. Reviews Table
#Stores reviews from users for restaurants.

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    restaurant_id INT,
    rating INT CHECK (rating >= 0 AND rating <= 5),
    comments TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
);

SELECT * FROM Reviews;

#Step 3: Inserting Sample Data
#Add sample data to the tables to test functionality.
#Users Table

INSERT INTO Users (username, email, phone, address) VALUES 
('John Doe', 'john@example.com', '1234567890', '123 Main St'),
('Jane Smith', 'jane@example.com', '0987654321', '456 Elm St');

#Restaurants Table

INSERT INTO Restaurants (name, location, rating, cuisine, contact) VALUES 
('Pizza Palace', 'Downtown', 4.5, 'Italian', '1112223333'),
('Sushi World', 'Uptown', 4.8, 'Japanese', '2223334444');

#Menu_Items Table

INSERT INTO Menu_Items (restaurant_id, item_name, price, description) VALUES 
(1, 'Margherita Pizza', 9.99, 'Classic cheese and tomato pizza'),
(1, 'Pepperoni Pizza', 12.99, 'Pepperoni pizza with mozzarella'),
(2, 'Salmon Sushi', 15.99, 'Fresh salmon nigiri sushi'),
(2, 'Tuna Sushi', 14.99, 'Fresh tuna nigiri sushi');

#Orders Table

INSERT INTO Orders (user_id, restaurant_id, total_price, status) VALUES 
(1, 1, 22.98, 'Completed'),
(2, 2, 30.98, 'Pending');

#Order_Items Table

INSERT INTO Order_Items (order_id, item_id, quantity, price) VALUES 
(1, 1, 1, 9.99),
(1, 2, 1, 12.99),
(2, 3, 2, 15.99);

#Reviews Table

INSERT INTO Reviews (user_id, restaurant_id, rating, comments) VALUES 
(1, 1, 5, 'Amazing pizza! Highly recommend.'),
(2, 2, 4, 'Great sushi, but a bit pricey.');

#Step 4: Writing Queries

#1. Get all restaurants and their average rating:

SELECT name, location, AVG(rating) AS average_rating
FROM Restaurants
JOIN Reviews ON Restaurants.restaurant_id = Reviews.restaurant_id
GROUP BY Restaurants.restaurant_id;

#2. Find all menu items of a restaurant:

SELECT item_name, price, description 
FROM Menu_Items 
WHERE restaurant_id = 1;

#3. Retrieve all orders by a user:

SELECT Orders.order_id, Restaurants.name AS restaurant_name, Orders.total_price, Orders.status
FROM Orders
JOIN Restaurants ON Orders.restaurant_id = Restaurants.restaurant_id
WHERE Orders.user_id = 1;

#4. Display all reviews for a restaurant:

SELECT Users.username, Reviews.rating, Reviews.comments
FROM Reviews
JOIN Users ON Reviews.user_id = Users.user_id
WHERE restaurant_id = 2;

#5. Calculate total earnings for each restaurant:

SELECT Restaurants.name, SUM(Orders.total_price) AS total_earnings
FROM Orders
JOIN Restaurants ON Orders.restaurant_id = Restaurants.restaurant_id
WHERE Orders.status = 'Completed'
GROUP BY Restaurants.restaurant_id;
