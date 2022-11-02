-- This database is the exercise number 2 from Meta Database Enginner Course - 1 Module, Week 4

DROP DATABASE IF EXISTS automobile;

CREATE DATABASE automobile;

USE automobile;

CREATE TABLE vehicle(
vehicleID VARCHAR(10) PRIMARY KEY,
ownerID VARCHAR(10),
plateNumber VARCHAR(10),
phoneNumber INT
);