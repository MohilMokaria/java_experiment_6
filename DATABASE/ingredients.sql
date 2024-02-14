-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 14, 2024 at 08:17 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mysql`
--

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL,
  `recipeId` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `quantity` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`id`, `recipeId`, `name`, `quantity`) VALUES
(1, 1071, 'i1', 'abc'),
(2, 1072, 'a', 'skjdv c'),
(3, 1072, 'b', 'jbkjnk'),
(4, 1072, 'c', 'kjbkj'),
(5, 1073, 'water', '2 cups'),
(6, 1073, 'maggie', '2 packs'),
(7, 1073, 'extra maggie masala', '2 packets'),
(8, 1074, 'Spaghetti', '200 g'),
(9, 1074, 'Bacon', '100 g'),
(10, 1074, 'Eggs', '2'),
(11, 1074, 'Parmesan cheese', '50 g'),
(12, 1075, 'Fettuccine pasta', '8 oz'),
(13, 1075, 'Chicken breast', '2 (boneless, skinless)'),
(14, 1075, 'Heavy cream', '1 cup'),
(15, 1075, 'Parmesan cheese', '1/2 cup (grated)');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recipeId` (`recipeId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`recipeId`) REFERENCES `recipe` (`id`),
  ADD CONSTRAINT `recipeId` FOREIGN KEY (`recipeId`) REFERENCES `recipe` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
