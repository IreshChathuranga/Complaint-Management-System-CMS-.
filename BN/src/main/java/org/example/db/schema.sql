create database cms;
use cms;

CREATE TABLE User (    id INT AUTO_INCREMENT PRIMARY KEY,    role VARCHAR(20) NOT NULL,    name VARCHAR(50) NOT NULL,    address VARCHAR(500),    phone int,              email VARCHAR(105) UNIQUE NOT NULL,    password VARCHAR(100) NOT NULL);

CREATE TABLE Complains (    id INT AUTO_INCREMENT PRIMARY KEY,    name VARCHAR(50) NOT NULL,    complain VARCHAR(1500) NOT NULL,status VARCHAR(20) NOT NULL);