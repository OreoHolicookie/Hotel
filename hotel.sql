-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 02, 2024 at 09:42 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel`
--
CREATE DATABASE IF NOT EXISTS `hotel` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hotel`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `GetPaymentInfo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPaymentInfo` (IN `payment_id` INT)   BEGIN
    SELECT
        id AS payment_id,
        title,
        fname AS first_name,
        lname AS last_name,
        troom AS room,
        tbed AS bed_type,
        nroom,
        cin AS checkin,
        cout AS checkout,
        ttot AS room_paid_amount,
        fintot AS total_payment
    FROM
        payment
    WHERE
        id = payment_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `audit_booking`
--

DROP TABLE IF EXISTS `audit_booking`;
CREATE TABLE IF NOT EXISTS `audit_booking` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_type` varchar(10) NOT NULL,
  `event_description` varchar(255) NOT NULL,
  `event_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_booking`
--

INSERT INTO `audit_booking` (`event_id`, `event_type`, `event_description`, `event_timestamp`) VALUES
(1, 'INSERT', 'New booking added for Room ID 5', '2024-01-02 08:38:43');

-- --------------------------------------------------------

--
-- Stand-in structure for view `booking_information`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `booking_information`;
CREATE TABLE IF NOT EXISTS `booking_information` (
`booking_id` int(10) unsigned
,`title` varchar(5)
,`customer_name` mediumtext
,`email` varchar(50)
,`national` varchar(30)
,`country` varchar(30)
,`phone` text
,`room_type` varchar(20)
,`bedding_type` varchar(10)
,`meal_type` varchar(15)
,`checkin_date` date
,`checkout_date` date
,`booking_status` varchar(15)
,`number_of_days` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  `phoneno` int(10) NOT NULL,
  `email` text NOT NULL,
  `cdate` date NOT NULL,
  `approval` varchar(12) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_contact_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `fullname`, `phoneno`, `email`, `cdate`, `approval`) VALUES
(1, 'Christine Sapra', 2147483647, 'christine@gmail.com', '2023-12-29', 'Allowed');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `usname` varchar(30) NOT NULL,
  `pass` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `usname`, `pass`) VALUES
(1, 'Admin', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `newsletterlog`
--

DROP TABLE IF EXISTS `newsletterlog`;
CREATE TABLE IF NOT EXISTS `newsletterlog` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(52) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `news` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(5) NOT NULL,
  `fname` varchar(30) NOT NULL,
  `lname` varchar(30) NOT NULL,
  `troom` varchar(30) NOT NULL,
  `tbed` varchar(30) DEFAULT NULL,
  `nroom` int(11) NOT NULL,
  `cin` date NOT NULL,
  `cout` date NOT NULL,
  `ttot` double(8,2) NOT NULL,
  `fintot` double(8,2) NOT NULL,
  `mepr` double(8,2) NOT NULL,
  `meal` varchar(30) DEFAULT NULL,
  `btot` double(8,2) DEFAULT NULL,
  `noofdays` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `title`, `fname`, `lname`, `troom`, `tbed`, `nroom`, `cin`, `cout`, `ttot`, `fintot`, `mepr`, `meal`, `btot`, `noofdays`) VALUES
(2, 'Ms.', 'Christine Joy', 'Sapra', 'Superior Room', 'Single', 1, '2023-12-29', '2023-12-30', 16700.00, 16867.00, 0.00, 'Room only', 167.00, 1),
(3, 'Mr.', 'Nana', 'Sy', 'Deluxe Room', 'Single', 1, '2023-12-29', '2023-12-31', 24366.00, 24609.66, 0.00, 'Room only', 243.66, 2),
(4, 'Ms.', 'Anne', 'Smith', 'Superior Room', 'Single', 1, '2023-12-29', '2023-12-30', 16700.00, 16867.00, 0.00, 'Room only', 167.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(15) NOT NULL,
  `bedding` varchar(10) NOT NULL,
  `place` varchar(10) NOT NULL,
  `cusid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `type`, `bedding`, `place`, `cusid`) VALUES
(1, 'Superior Room', 'Single', 'NotFree', 4),
(2, 'Superior Room', 'Double', 'Free', 0),
(3, 'Superior Room', 'Triple', 'Free', 0),
(4, 'Single Room', 'Quad', 'Free', 0),
(5, 'Superior Room', 'Quad', 'Free', 0),
(6, 'Deluxe Room', 'Single', 'Free', 0),
(7, 'Deluxe Room', 'Double', 'Free', 0),
(8, 'Deluxe Room', 'Triple', 'Free', 0),
(9, 'Deluxe Room', 'Quad', 'Free', 0),
(10, 'Guest House', 'Single', 'Free', 0),
(11, 'Guest House', 'Double', 'Free', 0),
(12, 'Guest House', 'Quad', 'Free', 0),
(13, 'Single Room', 'Single', 'Free', 0),
(14, 'Single Room', 'Double', 'Free', 0),
(15, 'Single Room', 'Triple', 'Free', 0);

-- --------------------------------------------------------

--
-- Table structure for table `roombook`
--

DROP TABLE IF EXISTS `roombook`;
CREATE TABLE IF NOT EXISTS `roombook` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Title` varchar(5) NOT NULL,
  `FName` text NOT NULL,
  `LName` text NOT NULL,
  `Email` varchar(50) NOT NULL,
  `National` varchar(30) NOT NULL,
  `Country` varchar(30) NOT NULL,
  `Phone` text NOT NULL,
  `TRoom` varchar(20) NOT NULL,
  `Bed` varchar(10) NOT NULL,
  `NRoom` varchar(2) NOT NULL,
  `Meal` varchar(15) DEFAULT NULL,
  `cin` date NOT NULL,
  `cout` date NOT NULL,
  `stat` varchar(15) NOT NULL,
  `nodays` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `roombook`
--

INSERT INTO `roombook` (`id`, `Title`, `FName`, `LName`, `Email`, `National`, `Country`, `Phone`, `TRoom`, `Bed`, `NRoom`, `Meal`, `cin`, `cout`, `stat`, `nodays`) VALUES
(4, 'Ms.', 'Anne', 'Smith', 'anne@gmail.com', 'International', 'United States', '12345678901', 'Superior Room', 'Single', '1', 'Room only', '2023-12-29', '2023-12-30', 'Confirm', 1),
(5, 'Mr.', 'Josie', 'Rizal', 'josierizal@gmail.com', 'Filipino', 'Philippines', '+63912345678', 'Superior Room', 'Single', '1', 'Room only', '2024-01-02', '2024-01-04', 'Not Confirm', 2);

--
-- Triggers `roombook`
--
DROP TRIGGER IF EXISTS `after_insert_roombook`;
DELIMITER $$
CREATE TRIGGER `after_insert_roombook` AFTER INSERT ON `roombook` FOR EACH ROW BEGIN
    INSERT INTO audit_booking (event_type, event_description)
    VALUES ('INSERT', CONCAT('New booking added for Room ID ', NEW.id));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `booking_information`
--
DROP TABLE IF EXISTS `booking_information`;

DROP VIEW IF EXISTS `booking_information`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `booking_information`  AS SELECT `roombook`.`id` AS `booking_id`, `roombook`.`Title` AS `title`, concat(`roombook`.`FName`,' ',`roombook`.`LName`) AS `customer_name`, `roombook`.`Email` AS `email`, `roombook`.`National` AS `national`, `roombook`.`Country` AS `country`, `roombook`.`Phone` AS `phone`, `roombook`.`TRoom` AS `room_type`, `roombook`.`Bed` AS `bedding_type`, `roombook`.`Meal` AS `meal_type`, `roombook`.`cin` AS `checkin_date`, `roombook`.`cout` AS `checkout_date`, `roombook`.`stat` AS `booking_status`, `roombook`.`nodays` AS `number_of_days` FROM `roombook` ;

DELIMITER $$
--
-- Events
--
DROP EVENT IF EXISTS `update_booking_status`$$
CREATE DEFINER=`root`@`localhost` EVENT `update_booking_status` ON SCHEDULE EVERY 1 DAY STARTS '2023-12-29 22:52:54' ENDS '2023-12-30 23:02:25' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    UPDATE roombook
    SET stat = 'Completed'
    WHERE stat = 'Booked' AND cout <= CURDATE();
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
