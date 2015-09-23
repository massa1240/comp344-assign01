-- -----------------------------------------------------
-- Table `book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `author` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publisher` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_edition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_edition` (
  `isbn` BIGINT NOT NULL,
  `publisher_id` INT NOT NULL,
  `book_id` INT UNSIGNED NOT NULL,
  `year` INT UNSIGNED NOT NULL,
  `price` DECIMAL(5,2) UNSIGNED NOT NULL,
  `picture` VARCHAR(45) NULL,
  `pages` INT UNSIGNED NOT NULL,
  `edition` INT UNSIGNED NOT NULL,
  `stock` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`isbn`),
  CONSTRAINT `fk_book_edition_publisher1`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `publisher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_edition_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_book_edition_publisher1_idx` ON `book_edition` (`publisher_id` ASC);

CREATE INDEX `fk_book_edition_book1_idx` ON `book_edition` (`book_id` ASC);

CREATE UNIQUE INDEX `picture_UNIQUE` ON `book_edition` (`picture` ASC);


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer` (
  `email` VARCHAR(70) NOT NULL,
  `password` VARCHAR(255) NULL,
  `type` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `mq_staffid` INT NULL,
  `mq_studentid` INT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer_wishes_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer_wishes_book` (
  `customer_email` VARCHAR(70) NOT NULL,
  `book_edition_isbn` BIGINT NOT NULL,
  `last_price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`customer_email`, `book_edition_isbn`),
  CONSTRAINT `fk_cust_h_bedt_cust1`
    FOREIGN KEY (`customer_email`)
    REFERENCES `customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cust_h_bedt_bedt1`
    FOREIGN KEY (`book_edition_isbn`)
    REFERENCES `book_edition` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_cust_h_bedt_bedt1_idx` ON `customer_wishes_book` (`book_edition_isbn` ASC);

CREATE INDEX `fk_cust_h_bedt_cust1_idx` ON `customer_wishes_book` (`customer_email` ASC);


-- -----------------------------------------------------
-- Table `customer_has_cart_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer_has_cart_item` (
  `customer_email` VARCHAR(70) NOT NULL,
  `book_edition_isbn` BIGINT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`customer_email`, `book_edition_isbn`),
  CONSTRAINT `fk_cust_h_bedt_cust2`
    FOREIGN KEY (`customer_email`)
    REFERENCES `customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cust_h_bedt_bedt2`
    FOREIGN KEY (`book_edition_isbn`)
    REFERENCES `book_edition` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_cust_h_bedt_bedt2_idx` ON `customer_has_cart_item` (`book_edition_isbn` ASC);

CREATE INDEX `fk_cust_h_bedt_cust2_idx` ON `customer_has_cart_item` (`customer_email` ASC);


-- -----------------------------------------------------
-- Table `order_head`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_head` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `order_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_line` (
  `order_id` INT NOT NULL,
  `book_edition_isbn` BIGINT NOT NULL,
  `price` DECIMAL(5,2) UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`, `book_edition_isbn`),
  CONSTRAINT `fk_o_h_bedt_o1`
    FOREIGN KEY (`order_id`)
    REFERENCES `order_head` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_o_h_bedt_bedt1`
    FOREIGN KEY (`book_edition_isbn`)
    REFERENCES `book_edition` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_o_h_bedt_bedt1_idx` ON `order_line` (`book_edition_isbn` ASC);

CREATE INDEX `fk_o_h_bedt1_idx` ON `order_line` (`order_id` ASC);


-- -----------------------------------------------------
-- Table `customer_has_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer_has_order` (
  `customer_email` VARCHAR(70) NOT NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`customer_email`, `order_id`),
  CONSTRAINT `fk_cust_h_o_cust1`
    FOREIGN KEY (`customer_email`)
    REFERENCES `customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cust_h_o_o1`
    FOREIGN KEY (`order_id`)
    REFERENCES `order_head` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_cust_h_o_o1_idx` ON `customer_has_order` (`order_id` ASC);

CREATE INDEX `fk_cust_h_o_cust1_idx` ON `customer_has_order` (`customer_email` ASC);

CREATE UNIQUE INDEX `order_id_UNIQUE` ON `customer_has_order` (`order_id` ASC);


-- -----------------------------------------------------
-- Table `state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `state` (
  `acronym` VARCHAR(3) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`acronym`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postcode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postcode` (
  `postcode` MEDIUMINT UNSIGNED NOT NULL,
  `state_acronym` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`postcode`),
  CONSTRAINT `fk_postcode_state1`
    FOREIGN KEY (`state_acronym`)
    REFERENCES `state` (`acronym`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_postcode_state1_idx` ON `postcode` (`state_acronym` ASC);


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `address` (
  `customer_email` VARCHAR(70) NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  `postcode` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`customer_email`),
  CONSTRAINT `fk_address_customer1`
    FOREIGN KEY (`customer_email`)
    REFERENCES `customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_postcode1`
    FOREIGN KEY (`postcode`)
    REFERENCES `postcode` (`postcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_address_postcode1_idx` ON `address` (`postcode` ASC);


-- -----------------------------------------------------
-- Table `unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `unit` (
  `code` VARCHAR(10) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unit_has_book_edition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `unit_has_book_edition` (
  `unit_code` VARCHAR(10) NOT NULL,
  `book_edition_isbn` BIGINT NOT NULL,
  PRIMARY KEY (`unit_code`, `book_edition_isbn`),
  CONSTRAINT `fk_u_h_bedt_u1`
    FOREIGN KEY (`unit_code`)
    REFERENCES `unit` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_u_h_bedt_bedt1`
    FOREIGN KEY (`book_edition_isbn`)
    REFERENCES `book_edition` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_u_h_bedt_bedt1_idx` ON `unit_has_book_edition` (`book_edition_isbn` ASC);

CREATE INDEX `fk_u_h_bedt_u1_idx` ON `unit_has_book_edition` (`unit_code` ASC);


-- -----------------------------------------------------
-- Table `book_has_author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_has_author` (
  `book_id` INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`, `author_id`),
  CONSTRAINT `fk_book_has_author_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_author_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_book_has_author_author1_idx` ON `book_has_author` (`author_id` ASC);

CREATE INDEX `fk_book_has_author_book1_idx` ON `book_has_author` (`book_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `author`
-- -----------------------------------------------------
START TRANSACTION;
USE `comp344`;
INSERT INTO author (id, name) VALUES (1, 'Elias M. Awad');
INSERT INTO author (id, name) VALUES (2, 'Michael Wooldridge');
INSERT INTO author (id, name) VALUES (3, 'R.E. Bryant');
INSERT INTO author (id, name) VALUES (4, 'D.R. O\'Hallaron');
INSERT INTO author (id, name) VALUES (5, 'Brian W Kernighan');
INSERT INTO author (id, name) VALUES (6, 'Dennis M Ritchie');
INSERT INTO author (id, name) VALUES (7, 'Michael P. Papazoglou');
INSERT INTO author (id, name) VALUES (8, 'Pieter Ribbers');
INSERT INTO author (id, name) VALUES (9, 'Eric T Freeman');
INSERT INTO author (id, name) VALUES (10, 'Bert Bates');
INSERT INTO author (id, name) VALUES (11, 'Kathy Sierra');
INSERT INTO author (id, name) VALUES (12, 'Elisabeth Robson');
INSERT INTO author (id, name) VALUES (13, 'Michael Kiffer');
INSERT INTO author (id, name) VALUES (14, 'Arthur Bernstein');
INSERT INTO author (id, name) VALUES (15, 'Philip M. Lewis');
INSERT INTO author (id, name) VALUES (16, 'Robert Lafore');
INSERT INTO author (id, name) VALUES (17, 'Thomas H. Cormen');
INSERT INTO author (id, name) VALUES (18, 'Charles E. Leiserson');
INSERT INTO author (id, name) VALUES (19, 'Ronald L. Rivest');
INSERT INTO author (id, name) VALUES (20, 'Clifford Stein');
INSERT INTO author (id, name) VALUES (21, 'Michael L. Scott');
INSERT INTO author (id, name) VALUES (22, 'Bruce J. MacLennan');
INSERT INTO author (id, name) VALUES (23, 'Terrence W. Pratt');
INSERT INTO author (id, name) VALUES (24, 'Marvin V. Zelkowitts');

COMMIT;


-- -----------------------------------------------------
-- Data for table `publisher`
-- -----------------------------------------------------
START TRANSACTION;
USE `comp344`;
INSERT INTO publisher (id, name) VALUES (1, 'Prentice Hall');
INSERT INTO publisher (id, name) VALUES (2, 'John Wiley and Sons Ltd');
INSERT INTO publisher (id, name) VALUES (3, 'Pearson');
INSERT INTO publisher (id, name) VALUES (4, 'O`Reilly');
INSERT INTO publisher (id, name) VALUES (5, 'Addison-Wesley');
INSERT INTO publisher (id, name) VALUES (6, 'Sams Publishing');
INSERT INTO publisher (id, name) VALUES (7, 'The MIT Press');
INSERT INTO publisher (id, name) VALUES (8, 'Morgan Kaufmann');
INSERT INTO publisher (id, name) VALUES (9, 'Oxford University Press');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `comp344`;
INSERT INTO book (id, title) VALUES (1, 'E-Commerce: From Vision to Fulfilment');
INSERT INTO book (id, title) VALUES (2, 'An Introduction to MultiAgent Systems');
INSERT INTO book (id, title) VALUES (3, 'Computer Systems: A Programmer`s Perspective');
INSERT INTO book (id, title) VALUES (4, 'The C Programming Language');
INSERT INTO book (id, title) VALUES (5, 'e-Business: Organizational and Technical Foundations');
INSERT INTO book (id, title) VALUES (6, 'Head First Design Patterns');
INSERT INTO book (id, title) VALUES (7, 'Database Systems. An Application-Oriented Approach');
INSERT INTO book (id, title) VALUES (8, 'Data Structures and Algorithms in Java');
INSERT INTO book (id, title) VALUES (9, 'Introduction to Algorithms');
INSERT INTO book (id, title) VALUES (10, 'Programming Language Pragmatics');
INSERT INTO book (id, title) VALUES (11, 'Principles of programming languages: design, evaluation, and implementation');
INSERT INTO book (id, title) VALUES (12, 'Programming languages: design and implementation');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_edition`
-- -----------------------------------------------------
START TRANSACTION;
USE `comp344`;
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780131735217, 1, 1, 2007, 120.00, '91-Vv51SbeL.jpg', 555, 3, 2);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780470519462, 2, 2, 2009, 100.00, '516vqqUUcHL.jpg', 484, 1, 2);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780136108047, 3, 3, 2011, 125.25, NULL, 1080, 2, 5);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780131103627, 1, 4, 1988, 50.00, '71RwRPoFKL.jpg', 274, 2, 1);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780470843765, 2, 5, 2006, 70.99, '412GzMdIL6L.jpg', 750, 1, 5);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780596007126, 4, 6, 2004, 30.01, NULL, 694, 1, 2);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780321268457, 5, 7, 2005, 150.32, '51HwO5x3WZL.jpg', 1272, 2, 3);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780672324536, 6, 8, 2002, 35.34, NULL, 800, 2, 4);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780262033848, 7, 9, 2009, 80.55, '41u4nFsBWrL.jpg', 1312, 3, 1);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780123745149, 8, 10, 2009, 60.34, '81zfeemkslL.jpg', 944, 3, 2);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780195113068, 9, 11, 1999, 250.55, '51kZJ4y3AgL.jpg', 528, 3, 3);
INSERT INTO book_edition (isbn, publisher_id, book_id, year, price, picture, pages, edition, stock) VALUES (9780130276780, 1, 12, 2000, 110.00, '51DZSTY1XPL.jpg', 649, 4, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `comp344`;
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('joshua.baxter9@students.mq.edu.au', NULL, 2, 'Joshua', 'Baxter', NULL, 12345670);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('bassel.butter9@students.mq.edu.au', NULL, 2, 'Bassel', 'Butler', NULL, 12345671);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('laurel.mare9@students.mq.edu.au', NULL, 2, 'Laurel', 'Mare', NULL, 12345672);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('peter.hao9@students.mq.edu.au', NULL, 2, 'Peter', 'Hao', NULL, 12345673);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('luke.schelle9@students.mq.edu.au', NULL, 2, 'Luke', 'Schelle', NULL, 12345674);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('xianyang.huang9@students.mq.edu.au', NULL, 2, 'Xianyang', 'Huang', NULL, 12345675);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('brian.howard7@students.mq.edu.au', NULL, 2, 'Brian', 'Howard', NULL, 12345676);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('sheng.shi6@students.mq.edu.au', NULL, 2, 'Sheng', 'Shi', NULL, 12345677);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('xiang.wu8@students.mq.edu.au', NULL, 2, 'Xiang', 'Wu', NULL, 12345678);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('robert.smit11@students.mq.edu.au', NULL, 2, 'Robert', 'Smit', NULL, 12345679);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('jose-erima.fernandes-junior@students.mq.edu.au', NULL, 2, 'Jose Erima', 'Fernandes junior', NULL, 43413846);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('qu.lie@mq.edu.au', NULL, 1, 'Lie', 'Qu', 10000001, NULL);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('yan.wang@mq.edu.au', NULL, 1, 'Yan', 'Wang', 10000002, NULL);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('arun.neelakandan@mq.edu.au', NULL, 1, 'Arun', 'Neelakandan', 10000003, NULL);
INSERT INTO customer (email, password, type, name, surname, mq_staffid, mq_studentid) VALUES ('haibin.zhang@mq.edu.au', NULL, 1, 'Haibin', 'Zhang', 10000004, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `state`
-- -----------------------------------------------------
START TRANSACTION;
USE `comp344`;
INSERT INTO state (acronym, name) VALUES ('NSW', 'New South Wales');
INSERT INTO state (acronym, name) VALUES ('WA', 'Western Australia');
INSERT INTO state (acronym, name) VALUES ('TAS', 'Tasmania');
INSERT INTO state (acronym, name) VALUES ('VIC', 'Victoria');
INSERT INTO state (acronym, name) VALUES ('QLD', 'Queensland');
INSERT INTO state (acronym, name) VALUES ('SA', 'South Australia');
INSERT INTO state (acronym, name) VALUES ('NT', 'Northern Territory');
INSERT INTO state (acronym, name) VALUES ('ACT', 'Australian Capial Territory');

COMMIT;


-- -----------------------------------------------------
-- Data for table `unit`
-- -----------------------------------------------------
START TRANSACTION;
USE `comp344`;
INSERT INTO unit (code, name) VALUES ('COMP344', 'E-commerce technology');
INSERT INTO unit (code, name) VALUES ('COMP202', 'Systems programming');
INSERT INTO unit (code, name) VALUES ('ISYS301', 'Enterprise systems integration');
INSERT INTO unit (code, name) VALUES ('COMP229', 'Object-oriented programming practices');
INSERT INTO unit (code, name) VALUES ('ISYS326', 'Advanced databases and enterprise systems');
INSERT INTO unit (code, name) VALUES ('COMP332', 'Programming languages');
INSERT INTO unit (code, name) VALUES ('COMP225', 'Algorithms and data structures');
INSERT INTO unit (code, name) VALUES ('COMP333', 'Algorithm theory and design');

COMMIT;


-- -----------------------------------------------------
-- Data for table `unit_has_book_edition`
-- -----------------------------------------------------
START TRANSACTION;
USE `comp344`;
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP344', 9780131735217);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP344', 9780470519462);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP202', 9780136108047);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP202', 9780131103627);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('ISYS301', 9780470843765);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP229', 9780596007126);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('ISYS326', 9780321268457);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP225', 9780672324536);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP333', 9780262033848);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP332', 9780123745149);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP332', 9780195113068);
INSERT INTO unit_has_book_edition (unit_code, book_edition_isbn) VALUES ('COMP332', 9780130276780);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_has_author`
-- -----------------------------------------------------
START TRANSACTION;
USE `comp344`;
INSERT INTO book_has_author (book_id, author_id) VALUES (1, 1);
INSERT INTO book_has_author (book_id, author_id) VALUES (2, 2);
INSERT INTO book_has_author (book_id, author_id) VALUES (3, 3);
INSERT INTO book_has_author (book_id, author_id) VALUES (3, 4);
INSERT INTO book_has_author (book_id, author_id) VALUES (4, 5);
INSERT INTO book_has_author (book_id, author_id) VALUES (4, 6);
INSERT INTO book_has_author (book_id, author_id) VALUES (5, 7);
INSERT INTO book_has_author (book_id, author_id) VALUES (5, 8);
INSERT INTO book_has_author (book_id, author_id) VALUES (6, 9);
INSERT INTO book_has_author (book_id, author_id) VALUES (6, 10);
INSERT INTO book_has_author (book_id, author_id) VALUES (6, 11);
INSERT INTO book_has_author (book_id, author_id) VALUES (6, 12);
INSERT INTO book_has_author (book_id, author_id) VALUES (7, 13);
INSERT INTO book_has_author (book_id, author_id) VALUES (7, 14);
INSERT INTO book_has_author (book_id, author_id) VALUES (7, 15);
INSERT INTO book_has_author (book_id, author_id) VALUES (8, 16);
INSERT INTO book_has_author (book_id, author_id) VALUES (9, 17);
INSERT INTO book_has_author (book_id, author_id) VALUES (9, 18);
INSERT INTO book_has_author (book_id, author_id) VALUES (9, 19);
INSERT INTO book_has_author (book_id, author_id) VALUES (9, 20);
INSERT INTO book_has_author (book_id, author_id) VALUES (10, 21);
INSERT INTO book_has_author (book_id, author_id) VALUES (11, 22);
INSERT INTO book_has_author (book_id, author_id) VALUES (12, 23);
INSERT INTO book_has_author (book_id, author_id) VALUES (12, 24);

COMMIT;

