CREATE DATABASE `invoicing`;
USE `invoicing`;

-- SET NAMES utf8 ;
-- SET character_set_client = utf8mb4 ;

CREATE TABLE `payment_methods` (
  `id` INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(50) NOT NULL
  ); 
-- ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payment_methods` (name)
      VALUES ('Credit card'),
             ('Cash'),
	         ('PayPal'),
             ('Wire Transfer');

CREATE TABLE `customers` (
  `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `phone` VARCHAR(50) DEFAULT NULL
  
); 
-- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `customers` (name, address, city, state, phone) 
      VALUES ('Vinte','3 Nevada Parkway','Syracuse','NY','315-252-7305'),
             ('Myworks','34267 Glendale Parkway','Huntington','WV','304-659-1170'),
             ('Yadel','096 Pawling Parkway','San Francisco','CA','415-144-6037'),
             ('Kwideo','81674 Westerfield Circle','Waco','TX','254-750-0784'),
             ('Topiclounge','0863 Farmco Road','Portland','OR','971-888-9129');

CREATE TABLE `invoices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `invoice_number` VARCHAR(50) NOT NULL,
  `invoice_total` DECIMAL(9,2) NOT NULL,
  `payment_total`DECIMAL(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` DATE NOT NULL,
  `due_date` DATE NOT NULL,
  `payment_date` DATE DEFAULT NULL,
  `customer_id` INT(11) NOT NULL,
  -- KEY `FK_client_id` (`client_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
  );
 -- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8b4_0900_ai_ci;
INSERT INTO `invoices`(invoice_number,invoice_total,payment_total,invoice_date, due_date, payment_date, customer_id)
		VALUES('3396',101.79,0.00,'2019-03-09','2019-03-29',NULL,2),
				('6735',175.32,8.18,'2019-06-11','2019-07-01','2019-02-12',5),
				('0335',147.99,0.00,'2019-07-31','2019-08-20',NULL, 5),
				('0748',152.21,0.00,'2019-03-08','2019-03-28',NULL,3),
				('3121',169.36,0.00,'2019-07-18','2019-08-07',NULL,5),
				('6626',157.78,74.55,'2019-01-29','2019-02-18','2019-01-03',1),
				('9863',133.87,0.00,'2019-09-04','2019-09-24',NULL,3),
				('1093',189.12,0.00,'2019-05-20','2019-06-09',NULL,1),
				('0081',172.17,0.00,'2019-07-09','2019-07-29',NULL,5),
                ('0145',149.25,50.00,'2019-05-31','2019-12-28',NULL,4),
				('1517',159.50,0.00,'2019-06-30','2019-07-20',NULL,1),
				('0181',126.15,0.03,'2019-01-07','2019-01-27','2019-01-11',3),
				('1035',135.01,87.44,'2019-06-25','2019-07-15','2019-01-26',5),
				('9605',167.29,80.31,'2019-11-25','2019-12-15','2019-01-15',3),
				('8824',162.02,0.00,'2019-03-30','2019-04-19',NULL,1),
				('3694',126.38,68.10,'2019-07-30','2019-08-19','2019-01-15',3),
				('9803',180.17,42.77,'2019-05-23','2019-06-12','2019-01-08',5),
				('4105',134.47,0.00,'2019-11-23','2019-12-13',NULL,1);

CREATE TABLE `payments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `payment_date` DATE NOT NULL,
  `amount` DECIMAL(9,2) NOT NULL,
  `payment_method_id` INT(4) NOT NULL,
  `customer_id` INT(11) NOT NULL,
  `invoice_id` INT(11) NOT NULL,
   FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON UPDATE CASCADE,
   FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON UPDATE CASCADE,
   FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) 
);
-- ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payments` (payment_date, amount, payment_method_id, customer_id, invoice_id)
              VALUES ('2019-02-12',8.18,1,5,2),
                     ('2019-01-03',74.55,1,1,6),
                     ('2019-01-11',0.03,1,3,11),
                     ('2019-01-26',87.44,1,5,13),
                     ('2019-01-15',80.31,1,3,15),
                     ('2019-01-15',68.10,1,3,17),
                     ('2019-01-08',32.77,1,5,18),
					 ('2019-01-08',10.00,2,5,18);


CREATE TABLE `products` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `product_name` VARCHAR(255) NOT NULL,
  `quantity_in_stock` INT NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL
  ); -- ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `products` (product_name,quantity_in_stock, unit_price)
           VALUES ('Foam Dinner Plate',70,1.21),
                  ('Pork - Bacon,back Peameal',49,4.65),
                  ('Lettuce - Romaine, Heart',38,3.35),
                  ('Brocolinni - Gaylan, Chinese',90,4.53),
				  ('Sauce - Ranch Dressing',94,1.63),
                  ('Petit Baguette',14,2.39), 
                  ('Sweet Pea Sprouts',98,3.29),
                  ('Island Oasis - Raspberry',26,0.74),
                  ('Longan',67,2.26),
				  ('Broom - Push',6,1.09);

CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT  PRIMARY KEY,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
 FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON UPDATE CASCADE
 );
-- ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `orders`  (customer_id,order_date)
      VALUES (2,'2019-01-30'),
            (1,'2018-08-02'),
            (4,'2017-12-01'),
            (2,'2017-01-22'),
            (3,'2017-08-25'),
            (5,'2018-11-18'),
            (2,'2018-09-22'),
            (1,'2018-06-08'),
		    (4,'2017-07-05'),
            (3,'2018-04-22');


CREATE TABLE `order_items` (
  `order_id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON UPDATE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE
);
 -- ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 INSERT INTO `order_items` (order_id, product_id, quantity, unit_price)
	VALUES (1,4,4,3.74),
		   (2,1,2,9.10),
           (2,4,4,1.66),
           (2,6,2,2.94),
           (3,3,10,9.12),
		   (4,3,7,6.99),
           (4,10,7,6.40),
           (5,2,3,9.89),
           (6,1,4,8.65),
           (6,2,4,3.28),
           (6,3,4,7.46),
           (6,5,1,3.45),
           (7,3,7,9.17),
           (8,5,2,6.94),
           (8,8,2,8.59),
           (9,6,5,7.28),
           (10,1,10,6.01),
           (10,9,9,4.28);












