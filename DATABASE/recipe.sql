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
-- Table structure for table `recipe`
--

CREATE TABLE `recipe` (
  `id` int(11) NOT NULL,
  `auth` varchar(30) NOT NULL,
  `title` varchar(30) NOT NULL,
  `steps` text DEFAULT NULL,
  `isVeg` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipe`
--

INSERT INTO `recipe` (`id`, `auth`, `title`, `steps`, `isVeg`) VALUES
(1071, 'mohil@mail.com', 'demo 1', 'sadjhkk ', 1),
(1072, 'mohil@mail.com', 'demo 2', 'jsdk kc\r\ndsf\r\nsf\r\nfv\r\ne\r\nvfe\r\nrv', 0),
(1073, 'mohil@mail.com', 'DEMO 3', '-start boiling water\r\n-when its heated add all masalas\r\n-then add maggie to it mix it well\r\n-boil water as much needed', 1),
(1074, 'mohil@mokaria.com', 'Spaghetti Carbonara', '1. Cook spaghetti according to package instructions. 2. In a separate pan, fry bacon until crispy. 3. Beat eggs in a bowl and mix in grated Parmesan cheese. 4. Drain spaghetti and toss with bacon. 5. Quickly stir in egg and cheese mixture until well combined. 6. Serve immediately.', 0),
(1075, 'mohil@mail.com', 'Chicken Alfredo Pasta', 'Cook the fettuccine pasta according to package instructions until al dente.\r\nSeason the chicken breasts with salt and pepper. In a skillet over medium heat, cook the chicken breasts until fully cooked and browned on both sides. Remove from skillet and let it rest for a few minutes. Then, slice the chicken into strips.\r\nIn the same skillet, add the heavy cream and bring it to a simmer. Stir in the grated Parmesan cheese until it melts and the sauce thickens.\r\nAdd the cooked pasta and sliced chicken to the sauce. Toss everything together until well coated.\r\nServe the chicken Alfredo pasta hot, garnished with additional grated Parmesan cheese and chopped parsley if desired.', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `recipe`
--
ALTER TABLE `recipe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1076;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
