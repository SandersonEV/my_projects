-- This database is the exercise number 1 from Meta Database Enginner Course - 1 Module, Week 4 (1)

-- Obs1: The table and the primary key of the table must be created before of the assignment of the foreign key in another table.
-- Tip1: First create the tables that don't have any foreign keys.

DROP DATABASE IF EXISTS meta_restaurant;

CREATE DATABASE meta_restaurant;

USE meta_restaurant;

CREATE TABLE tbl( 

    table_id INT PRIMARY KEY, /* 1- I can define the primary key when i'm assigning the data type of table_id */

    location VARCHAR(255) 

); 

CREATE TABLE menu( 

    menu_id INT, 

    description VARCHAR(255), 

    availability INT, 

    PRIMARY KEY (menu_id) /* 2- Or i assign the primary key after everything */

); 

CREATE TABLE waiter( 

    waiter_id INT, 

    name VARCHAR(150), 

    contact_no VARCHAR(10), 

    shift VARCHAR(10), 

    CONSTRAINT PK_waiter PRIMARY KEY (waiter_id) /* 3- In this case i wrote just to show the possibilite but if you write like this maybe you want to create a composite primary key like (ID,Name) */ 

); 

CREATE TABLE table_order( 

    order_id INT, 

    date_time DATETIME, 

    table_id INT, 

    waiter_id INT, 

    PRIMARY KEY (order_id), 

    FOREIGN KEY (table_id) REFERENCES tbl(table_id), /* The foreign key (table_id) in this table references the primary key (table_id) in the tbl table */

    FOREIGN KEY (waiter_id) REFERENCES waiter(waiter_id) /* The foreign key (waiter_id) in this table references the primary key (waiter_id) in the waiter table */

); 

CREATE TABLE customer( 

    customer_id INT, 

    name VARCHAR(100), 

    NIC_no VARCHAR(12), 

    contact_no VARCHAR(10), 

    PRIMARY KEY (customer_id) 

); 

CREATE TABLE reservation( 

    reservation_id INT, 

    date_time DATETIME, 

    no_of_pax INT, 

    order_id INT, 

    table_id INT, 

    customer_id INT, 

    PRIMARY KEY (reservation_id), 

    FOREIGN KEY (order_id) REFERENCES table_order(table_id), 

    FOREIGN KEY (table_id) REFERENCES tbl(table_id), 

    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) 

); 

CREATE TABLE menu_item( 

    menu_item_id INT, 

    description VARCHAR(255), 

    price FLOAT, 

    availability INT, 

    menu_id INT, 

    PRIMARY KEY (menu_item_id), 

    FOREIGN KEY (menu_id) REFERENCES menu(menu_id) 

); 

CREATE TABLE order_menu_item( 

    order_id INT, 

    menu_item_id INT, 

    quantity INT, 

    PRIMARY KEY (order_id,menu_item_id), 

    FOREIGN KEY (order_id) REFERENCES table_order(order_id), 

    FOREIGN KEY (menu_item_id) REFERENCES menu_item(menu_item_id) 

);