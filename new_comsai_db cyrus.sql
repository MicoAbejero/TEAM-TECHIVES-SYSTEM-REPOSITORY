-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2026 at 09:37 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `new_comsai_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(80) NOT NULL,
  `entity_type` varchar(80) NOT NULL,
  `entity_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `admin_id`, `action`, `entity_type`, `entity_id`, `created_at`) VALUES
(2, 2, 'login', 'admin', 2, '2026-10-16 13:08:22'),
(3, 2, 'change-password', 'admin', 2, '2026-10-16 13:08:53'),
(4, 2, 'login', 'admin', 2, '2026-10-16 15:55:45'),
(5, 2, 'login', 'admin', 2, '2026-10-16 15:56:37'),
(6, 2, 'login', 'admin', 2, '2026-10-16 16:01:25'),
(7, 2, 'login', 'admin', 2, '2026-10-16 16:02:10'),
(8, 2, 'login', 'admin', 2, '2026-10-16 16:05:40'),
(9, 2, 'login', 'admin', 2, '2026-10-16 16:06:00'),
(10, 2, 'login', 'admin', 2, '2026-10-16 16:31:15'),
(11, 2, 'login', 'admin', 2, '2026-10-17 03:50:01'),
(12, 2, 'login', 'admin', 2, '2026-10-17 03:53:04'),
(13, 2, 'login', 'admin', 2, '2026-10-17 09:26:57'),
(14, 2, 'login', 'admin', 2, '2026-10-17 10:32:38'),
(15, 2, 'login', 'admin', 2, '2026-10-25 23:11:22'),
(16, 2, 'login', 'admin', 2, '2026-10-26 07:42:14'),
(17, 2, 'publish', 'knowledge', 28, '2026-10-26 07:49:24'),
(18, 2, 'publish', 'knowledge', 1, '2026-10-26 07:53:15'),
(19, 2, 'unpublish', 'knowledge', 28, '2026-10-26 07:53:17'),
(20, 2, 'publish', 'knowledge', 28, '2026-10-26 07:56:03'),
(21, 2, 'delete', 'knowledge', 1, '2026-10-26 07:57:01'),
(22, 2, 'save', 'knowledge', 28, '2026-10-26 11:22:54'),
(23, 2, 'login', 'admin', 2, '2026-10-27 04:08:00'),
(24, 2, 'save', 'category', 27, '2026-10-27 04:50:05'),
(25, 2, 'save', 'knowledge', 28, '2026-10-27 04:58:05'),
(26, 2, 'change-password', 'admin', 2, '2026-10-27 05:16:16'),
(27, 2, 'change-password', 'admin', 2, '2026-10-27 05:16:32'),
(28, 2, 'login', 'admin', 2, '2026-10-27 05:16:43'),
(29, 2, 'save', 'category', 27, '2026-10-27 05:43:09'),
(30, 2, 'save', 'knowledge', 29, '2026-10-27 05:49:51'),
(31, 2, 'save', 'knowledge', 30, '2026-10-27 08:19:37'),
(32, 2, 'save', 'knowledge', 31, '2026-10-27 08:43:34'),
(33, 2, 'save', 'knowledge', 32, '2026-10-27 08:47:19'),
(34, 2, 'save', 'knowledge', 33, '2026-10-27 08:47:39'),
(35, 2, 'save', 'knowledge', 34, '2026-10-27 08:50:41'),
(36, 2, 'save', 'knowledge', 35, '2026-10-27 09:30:21'),
(37, 2, 'save', 'knowledge', 36, '2026-10-27 09:32:36'),
(38, 2, 'save', 'knowledge', 32, '2026-10-27 09:55:02'),
(39, 2, 'login', 'admin', 2, '2026-10-28 07:22:19'),
(40, 2, 'save', 'knowledge', 34, '2026-10-28 08:07:06'),
(41, 2, 'save', 'knowledge', 28, '2026-10-28 09:54:05'),
(42, 2, 'save', 'knowledge', 28, '2026-10-28 10:05:38'),
(43, 2, 'login', 'admin', 2, '2026-11-05 08:06:47'),
(44, 2, 'save', 'knowledge', 37, '2026-11-05 08:18:37'),
(45, 2, 'save', 'knowledge', 38, '2026-11-05 08:18:54'),
(46, 2, 'save', 'knowledge', 39, '2026-11-05 08:19:21'),
(47, 2, 'save', 'knowledge', 39, '2026-11-05 08:22:57'),
(48, 2, 'save', 'knowledge', 33, '2026-11-05 08:56:16'),
(49, 2, 'save', 'knowledge', 32, '2026-11-05 08:58:23'),
(50, 2, 'save', 'knowledge', 40, '2026-11-05 09:09:07'),
(51, 2, 'save', 'knowledge', 41, '2026-11-05 09:10:01'),
(52, 2, 'save', 'knowledge', 42, '2026-11-05 09:12:27'),
(53, 2, 'save', 'knowledge', 43, '2026-11-05 09:13:05'),
(54, 2, 'save', 'knowledge', 44, '2026-11-05 09:15:09'),
(55, 2, 'save', 'category', 28, '2026-11-05 09:16:48'),
(56, 2, 'save', 'knowledge', 45, '2026-11-05 09:17:26'),
(57, 2, 'save', 'knowledge', 46, '2026-11-05 09:17:48'),
(58, 2, 'save', 'knowledge', 47, '2026-11-05 09:18:13'),
(59, 2, 'save', 'knowledge', 48, '2026-11-05 09:18:33'),
(60, 2, 'login', 'admin', 2, '2026-11-06 07:47:40'),
(61, 2, 'save', 'knowledge', 49, '2026-11-06 08:10:50'),
(62, 2, 'save', 'knowledge', 50, '2026-11-06 08:19:25'),
(63, 2, 'save', 'knowledge', 51, '2026-11-06 08:20:35'),
(64, 2, 'save', 'knowledge', 52, '2026-11-06 08:21:30'),
(65, 2, 'save', 'knowledge', 51, '2026-11-06 08:31:31'),
(66, 2, 'save', 'knowledge', 51, '2026-11-06 11:49:47'),
(67, 2, 'login', 'admin', 2, '2026-11-06 14:21:41'),
(68, 2, 'login', 'admin', 2, '2026-11-07 12:07:13'),
(69, 2, 'save', 'knowledge', 53, '2026-11-07 12:29:44'),
(70, 2, 'save', 'knowledge', 54, '2026-11-07 12:30:25'),
(71, 2, 'save', 'knowledge', 55, '2026-11-07 12:30:55'),
(72, 2, 'save', 'knowledge', 56, '2026-11-07 12:32:36'),
(73, 2, 'save', 'knowledge', 57, '2026-11-07 12:34:08'),
(74, 2, 'login', 'admin', 2, '2026-11-09 00:48:33'),
(75, 2, 'save', 'knowledge', 37, '2026-11-09 01:02:08'),
(76, 2, 'save', 'knowledge', 38, '2026-11-09 01:02:23'),
(77, 2, 'save', 'knowledge', 39, '2026-11-09 01:02:38'),
(78, 2, 'login', 'admin', 2, '2026-11-09 01:44:19'),
(79, 2, 'login', 'admin', 2, '2026-11-09 02:54:27'),
(80, 2, 'login', 'admin', 2, '2026-11-09 05:43:32'),
(81, 2, 'unpublish', 'announcement', 6, '2026-11-09 06:00:36'),
(82, 2, 'publish', 'announcement', 6, '2026-11-09 06:00:38'),
(83, 2, 'unpublish', 'announcement', 6, '2026-11-09 06:27:27'),
(84, 2, 'publish', 'announcement', 6, '2026-11-09 06:27:33'),
(85, 2, 'login', 'admin', 2, '2026-11-09 09:50:09'),
(86, 2, 'save', 'knowledge', 39, '2026-11-09 11:51:42'),
(87, 2, 'save', 'knowledge', 39, '2026-11-09 11:52:25'),
(88, 2, 'save', 'knowledge', 39, '2026-11-09 11:57:49'),
(89, 2, 'save', 'announcement', 7, '2026-11-09 13:06:44'),
(90, 2, 'delete', 'announcement', 7, '2026-11-09 13:07:15'),
(91, 2, 'save', 'knowledge', 28, '2026-11-09 15:56:18'),
(92, 2, 'login', 'admin', 2, '2026-11-10 06:11:43'),
(93, 2, 'login', 'admin', 2, '2026-11-10 08:06:45'),
(94, 2, 'login', 'admin', 2, '2026-11-10 08:06:52'),
(95, 2, 'save', 'announcement', 19, '2026-11-10 09:13:23'),
(96, 2, 'delete', 'category', 8, '2026-11-10 10:48:09'),
(97, 2, 'delete', 'category', 14, '2026-11-10 10:48:09'),
(98, 2, 'delete', 'category', 9, '2026-11-10 10:48:48'),
(99, 2, 'delete', 'announcement', 19, '2026-11-10 11:06:36'),
(100, 2, 'save', 'announcement', 26, '2026-11-10 11:14:48'),
(101, 2, 'delete', 'announcement', 26, '2026-11-10 11:34:10'),
(102, 2, 'publish', 'knowledge', 53, '2026-11-10 13:01:54'),
(103, 2, 'publish', 'knowledge', 54, '2026-11-10 13:01:54'),
(104, 2, 'publish', 'knowledge', 55, '2026-11-10 13:01:54'),
(105, 2, 'publish', 'knowledge', 56, '2026-11-10 13:01:54'),
(106, 2, 'publish', 'knowledge', 57, '2026-11-10 13:01:54'),
(107, 2, 'publish', 'knowledge', 200, '2026-11-10 13:01:54'),
(108, 2, 'publish', 'knowledge', 201, '2026-11-10 13:01:55'),
(109, 2, 'delete', 'category', 13, '2026-11-10 13:03:20'),
(110, 2, 'save', 'knowledge', 37, '2026-11-10 13:51:40'),
(111, 2, 'save', 'knowledge', 38, '2026-11-10 13:51:53'),
(112, 2, 'publish', 'knowledge', 38, '2026-11-10 13:52:10'),
(113, 2, 'publish', 'knowledge', 37, '2026-11-10 13:52:10'),
(114, 2, 'publish', 'knowledge', 39, '2026-11-10 13:52:10'),
(115, 2, 'save', 'knowledge', 134, '2026-11-10 14:18:52'),
(116, 2, 'save', 'knowledge', 43, '2026-11-10 14:23:37'),
(117, 2, 'login', 'admin', 2, '2026-11-11 01:37:49'),
(118, 2, 'save', 'announcement', 27, '2026-11-11 02:53:51'),
(119, 2, 'publish', 'knowledge', 45, '2026-11-11 03:18:07'),
(120, 2, 'publish', 'knowledge', 48, '2026-11-11 03:18:07'),
(121, 2, 'unpublish', 'announcement', 6, '2026-11-11 03:18:27'),
(122, 2, 'publish', 'announcement', 6, '2026-11-11 03:18:36'),
(123, 2, 'save', 'announcement', 6, '2026-11-11 03:18:52'),
(124, 2, 'publish', 'announcement', 6, '2026-11-11 03:18:58'),
(125, 2, 'publish', 'announcement', 6, '2026-11-11 03:22:01'),
(126, 2, 'save', 'announcement', 27, '2026-11-11 03:22:18'),
(127, 2, 'publish', 'announcement', 27, '2026-11-11 03:22:25'),
(128, 2, 'unpublish', 'announcement', 27, '2026-11-11 03:22:30'),
(129, 2, 'publish', 'knowledge', 45, '2026-11-11 03:23:43'),
(130, 2, 'publish', 'knowledge', 48, '2026-11-11 03:23:43'),
(131, 2, 'publish', 'knowledge', 46, '2026-11-11 03:23:43'),
(132, 2, 'save', 'knowledge', 45, '2026-11-11 03:24:06'),
(133, 2, 'save', 'knowledge', 259, '2026-11-11 05:16:16'),
(134, 2, 'save', 'knowledge', 260, '2026-11-11 05:55:48'),
(135, 2, 'save', 'knowledge', 260, '2026-11-11 05:56:35'),
(136, 2, 'save', 'knowledge', 261, '2026-11-11 06:03:49'),
(137, 2, 'save', 'knowledge', 262, '2026-11-11 06:05:50'),
(138, 2, 'save', 'knowledge', 263, '2026-11-11 06:06:31'),
(139, 2, 'save', 'knowledge', 50, '2026-11-11 06:09:56'),
(140, 2, 'save', 'knowledge', 51, '2026-11-11 06:10:30'),
(141, 2, 'save', 'knowledge', 201, '2026-11-11 06:13:52'),
(142, 2, 'publish', 'knowledge', 201, '2026-11-11 06:14:04'),
(143, 2, 'unpublish', 'knowledge', 201, '2026-11-11 06:16:55'),
(144, 2, 'unpublish', 'knowledge', 200, '2026-11-11 06:17:40'),
(145, 2, 'save', 'knowledge', 49, '2026-11-11 06:38:50'),
(146, 2, 'save', 'knowledge', 264, '2026-11-11 07:43:00'),
(147, 2, 'save', 'knowledge', 134, '2026-11-11 07:43:53'),
(148, 2, 'save', 'knowledge', 44, '2026-11-11 07:44:53'),
(149, 2, 'save', 'knowledge', 47, '2026-11-11 07:45:49'),
(150, 2, 'login', 'admin', 2, '2026-11-11 08:46:53'),
(151, 2, 'login', 'admin', 2, '2026-11-11 09:23:36'),
(152, 2, 'login', 'admin', 2, '2026-11-11 11:16:51'),
(153, 4, 'login', 'admin', 4, '2026-11-11 11:24:07'),
(154, 4, 'change-password', 'admin', 4, '2026-11-11 11:28:51'),
(155, 4, 'login', 'admin', 4, '2026-11-11 11:29:24'),
(156, 5, 'login', 'admin', 5, '2026-11-11 11:29:59'),
(157, 5, 'change-password', 'admin', 5, '2026-11-11 11:31:38'),
(158, 2, 'login', 'admin', 2, '2026-11-11 11:31:53'),
(159, 2, 'disable', 'student-interface', NULL, '2026-11-11 12:21:29'),
(160, 2, 'enable', 'student-interface', NULL, '2026-11-11 12:21:58'),
(161, 2, 'disable', 'student-interface', NULL, '2026-11-11 12:24:42'),
(162, 2, 'enable', 'student-interface', NULL, '2026-11-11 12:25:03'),
(163, 2, 'disable', 'student-interface', NULL, '2026-11-11 12:26:21'),
(164, 2, 'enable', 'student-interface', NULL, '2026-11-11 12:26:24'),
(165, 2, 'disable', 'student-interface', NULL, '2026-11-11 13:35:43'),
(166, 2, 'enable', 'student-interface', NULL, '2026-11-11 13:35:47'),
(167, 2, 'disable', 'student-interface', NULL, '2026-11-11 13:35:55'),
(168, 2, 'enable', 'student-interface', NULL, '2026-11-11 13:36:08'),
(169, 2, 'login', 'admin', 2, '2026-11-12 10:12:19'),
(170, 2, 'save', 'knowledge', 132, '2026-11-12 10:23:57'),
(171, 2, 'unpublish', 'knowledge', 132, '2026-11-12 10:24:36'),
(172, 2, 'publish', 'knowledge', 132, '2026-11-12 10:24:45'),
(173, 2, 'publish', 'announcement', 27, '2026-11-12 10:25:16'),
(174, 2, 'unpublish', 'announcement', 27, '2026-11-12 10:25:28'),
(175, 2, 'publish', 'announcement', 27, '2026-11-12 10:36:55'),
(176, 2, 'save', 'announcement', 6, '2026-11-12 10:37:18'),
(177, 2, 'unpublish', 'announcement', 27, '2026-11-12 10:47:15'),
(178, 2, 'publish', 'announcement', 27, '2026-11-12 12:42:51'),
(179, 2, 'save', 'announcement', 28, '2026-11-12 12:44:10'),
(180, 2, 'delete', 'announcement', 28, '2026-11-12 12:44:44'),
(181, 2, 'unpublish', 'announcement', 27, '2026-11-12 12:44:51'),
(182, 2, 'disable', 'student-interface', NULL, '2026-11-12 13:05:14'),
(183, 2, 'enable', 'student-interface', NULL, '2026-11-12 13:05:17'),
(184, 2, 'disable', 'student-interface', NULL, '2026-11-12 13:05:27'),
(185, 2, 'enable', 'student-interface', NULL, '2026-11-12 13:05:28'),
(186, 2, 'save', 'knowledge', 202, '2026-11-12 13:19:21'),
(187, 2, 'save', 'knowledge', 42, '2026-11-12 13:20:36'),
(188, 2, 'save', 'knowledge', 41, '2026-11-12 13:42:16'),
(189, 2, 'save', 'knowledge', 40, '2026-11-12 13:43:13'),
(190, 2, 'save', 'knowledge', 261, '2026-11-12 13:57:34'),
(191, 2, 'save', 'knowledge', 262, '2026-11-12 14:20:45'),
(192, 2, 'save', 'knowledge', 263, '2026-11-12 14:24:11'),
(193, 2, 'save', 'knowledge', 49, '2026-11-12 14:39:23'),
(194, 2, 'save', 'knowledge', 40, '2026-11-12 14:40:38'),
(195, 2, 'save', 'knowledge', 201, '2026-11-12 14:44:56'),
(196, 2, 'save', 'knowledge', 57, '2026-11-12 15:24:08'),
(197, 2, 'save', 'knowledge', 56, '2026-11-12 15:24:43'),
(198, 2, 'save', 'knowledge', 55, '2026-11-12 15:25:32'),
(199, 2, 'save', 'knowledge', 54, '2026-11-12 15:26:45'),
(200, 2, 'save', 'knowledge', 53, '2026-11-12 15:27:31'),
(201, 2, 'login', 'admin', 2, '2026-11-13 06:02:42'),
(202, 2, 'login', 'admin', 2, '2026-11-13 08:25:11'),
(203, 2, 'save', 'knowledge', 265, '2026-11-13 08:25:41'),
(204, 2, 'save', 'knowledge', 265, '2026-11-13 08:36:01'),
(205, 2, 'delete', 'knowledge', 265, '2026-11-13 08:36:29'),
(206, 2, 'save', 'knowledge', 266, '2026-11-13 08:36:42'),
(207, 2, 'delete', 'knowledge', 266, '2026-11-13 08:42:15'),
(208, 2, 'save', 'knowledge', 267, '2026-11-13 08:42:30'),
(209, 2, 'save', 'knowledge', 268, '2026-11-13 08:43:39'),
(210, 2, 'delete', 'knowledge', 268, '2026-11-13 08:46:41'),
(211, 2, 'delete', 'knowledge', 267, '2026-11-13 08:46:41'),
(212, 2, 'save', 'knowledge', 269, '2026-11-13 08:47:45'),
(213, 2, 'delete', 'knowledge', 269, '2026-11-13 08:48:02'),
(214, 2, 'save', 'knowledge', 51, '2026-11-13 09:25:14'),
(215, 2, 'save', 'knowledge', 58, '2026-11-13 09:26:48'),
(216, 2, 'save', 'knowledge', 52, '2026-11-13 09:27:15'),
(217, 2, 'save', 'knowledge', 50, '2026-11-13 09:43:34'),
(218, 2, 'save', 'knowledge', 259, '2026-11-13 09:50:01'),
(219, 2, 'save', 'knowledge', 133, '2026-11-13 09:50:38'),
(220, 2, 'save', 'knowledge', 131, '2026-11-13 09:52:48'),
(221, 2, 'save', 'knowledge', 130, '2026-11-13 09:53:16'),
(222, 2, 'save', 'knowledge', 28, '2026-11-13 09:54:38'),
(223, 2, 'save', 'knowledge', 129, '2026-11-13 09:55:25'),
(224, 2, 'save', 'knowledge', 128, '2026-11-13 09:56:01'),
(225, 2, 'save', 'knowledge', 36, '2026-11-13 09:58:03'),
(226, 2, 'save', 'knowledge', 260, '2026-11-13 09:58:48'),
(227, 2, 'save', 'knowledge', 204, '2026-11-13 10:01:03'),
(228, 2, 'save', 'knowledge', 203, '2026-11-13 10:01:32'),
(229, 2, 'save', 'knowledge', 44, '2026-11-13 10:01:59'),
(230, 2, 'save', 'knowledge', 44, '2026-11-13 10:07:48'),
(231, 2, 'save', 'knowledge', 44, '2026-11-13 10:08:21'),
(232, 2, 'save', 'knowledge', 32, '2026-11-13 10:21:47'),
(233, 2, 'save', 'knowledge', 33, '2026-11-13 10:24:59'),
(234, 2, 'save', 'knowledge', 34, '2026-11-13 10:25:34'),
(235, 2, 'save', 'knowledge', 35, '2026-11-13 10:26:41'),
(236, 2, 'save', 'knowledge', 48, '2026-11-13 10:29:52'),
(237, 2, 'save', 'knowledge', 45, '2026-11-13 10:30:22'),
(238, 2, 'save', 'knowledge', 45, '2026-11-13 10:30:46'),
(239, 2, 'save', 'knowledge', 45, '2026-11-13 10:31:01'),
(240, 2, 'save', 'knowledge', 46, '2026-11-13 10:31:49'),
(241, 2, 'save', 'knowledge', 29, '2026-11-13 10:33:26'),
(242, 2, 'save', 'knowledge', 30, '2026-11-13 10:36:26'),
(243, 2, 'save', 'knowledge', 31, '2026-11-13 10:37:00'),
(244, 2, 'save', 'knowledge', 39, '2026-11-13 10:38:02'),
(245, 2, 'save', 'knowledge', 37, '2026-11-13 10:39:29'),
(246, 2, 'save', 'knowledge', 39, '2026-11-13 10:39:45'),
(247, 2, 'save', 'knowledge', 38, '2026-11-13 10:40:12'),
(248, 2, 'save', 'knowledge', 43, '2026-11-13 10:41:35'),
(249, 2, 'save', 'knowledge', 134, '2026-11-13 10:43:40'),
(250, 2, 'save', 'knowledge', 264, '2026-11-13 10:43:53'),
(251, 2, 'login', 'admin', 2, '2026-11-13 11:12:00'),
(252, 2, 'delete', 'student_feedback', 1, '2026-11-13 11:51:10'),
(253, 2, 'delete', 'student_feedback', 2, '2026-11-13 11:51:10'),
(254, 2, 'delete', 'student_feedback', 3, '2026-11-13 11:51:10'),
(255, 2, 'delete', 'student_feedback', 4, '2026-11-13 11:51:10'),
(256, 2, 'delete', 'student_feedback', 5, '2026-11-13 11:51:10'),
(257, 2, 'delete', 'student_feedback', 6, '2026-11-13 11:51:10'),
(258, 2, 'login', 'admin', 2, '2026-11-16 05:38:49'),
(259, 2, 'login', 'admin', 2, '2026-11-16 06:53:47'),
(260, 2, 'login', 'admin', 2, '2026-11-16 09:48:27'),
(261, 2, 'delete', 'announcement', 27, '2026-11-16 11:20:47'),
(262, 2, 'save', 'announcement', 30, '2026-11-16 11:21:08'),
(263, 2, 'disable', 'student-interface', NULL, '2026-11-16 11:25:56'),
(264, 2, 'enable', 'student-interface', NULL, '2026-11-16 11:26:00'),
(265, 2, 'unpublish', 'announcement', 30, '2026-11-16 11:26:18'),
(266, 2, 'publish', 'announcement', 30, '2026-11-16 11:35:02'),
(267, 2, 'save', 'knowledge', 38, '2026-11-16 11:37:31'),
(268, 2, 'save', 'knowledge', 37, '2026-11-16 11:37:41'),
(269, 2, 'save', 'knowledge', 39, '2026-11-16 11:37:56'),
(270, 2, 'save', 'knowledge', 38, '2026-11-16 11:39:33'),
(271, 2, 'save', 'knowledge', 37, '2026-11-16 11:39:44'),
(272, 2, 'save', 'knowledge', 39, '2026-11-16 11:39:54'),
(273, 2, 'disable', 'student-interface', NULL, '2026-11-16 11:52:33'),
(274, 2, 'enable', 'student-interface', NULL, '2026-11-16 11:53:03'),
(275, 2, 'save', 'category', 51, '2026-11-16 12:55:19'),
(276, 2, 'delete', 'category', 51, '2026-11-16 12:55:37'),
(277, 4, 'login', 'admin', 4, '2026-11-16 15:45:14'),
(278, 2, 'login', 'admin', 2, '2026-11-17 03:24:02'),
(279, 2, 'delete', 'announcement', 30, '2026-11-17 03:24:42'),
(280, 2, 'delete', 'student_feedback', 7, '2026-11-17 03:28:10'),
(281, 2, 'delete', 'student_feedback', 8, '2026-11-17 03:28:10'),
(282, 2, 'delete', 'student_feedback', 9, '2026-11-17 03:28:10'),
(283, 2, 'delete', 'student_feedback', 10, '2026-11-17 03:28:10'),
(284, 2, 'delete', 'student_feedback', 11, '2026-11-17 03:28:10'),
(285, 2, 'delete', 'student_feedback', 12, '2026-11-17 03:28:10'),
(286, 2, 'hide_quick_action', 'category', 28, '2026-11-17 03:53:08'),
(287, 2, 'hide_quick_action', 'category', 6, '2026-11-17 03:53:08'),
(288, 2, 'show_quick_action', 'category', 6, '2026-11-17 03:53:21'),
(289, 2, 'delete', 'chat_message', 454, '2026-11-17 04:21:00'),
(290, 2, 'delete', 'chat_message', 456, '2026-11-17 04:21:00'),
(291, 2, 'delete', 'chat_message', 458, '2026-11-17 04:21:00'),
(292, 2, 'delete', 'chat_message', 460, '2026-11-17 04:21:00'),
(293, 2, 'delete', 'chat_message', 544, '2026-11-17 04:21:00'),
(294, 2, 'delete', 'chat_message', 546, '2026-11-17 04:21:00'),
(295, 2, 'delete', 'chat_message', 548, '2026-11-17 04:21:00'),
(296, 2, 'delete', 'chat_message', 550, '2026-11-17 04:21:00'),
(297, 2, 'delete', 'chat_message', 552, '2026-11-17 04:21:00'),
(298, 2, 'delete', 'chat_message', 554, '2026-11-17 04:21:00'),
(299, 2, 'delete', 'chat_message', 556, '2026-11-17 04:21:00'),
(300, 2, 'delete', 'chat_message', 558, '2026-11-17 04:21:00'),
(301, 2, 'delete', 'chat_message', 560, '2026-11-17 04:21:00'),
(302, 2, 'delete', 'chat_message', 562, '2026-11-17 04:21:00'),
(303, 2, 'delete', 'chat_message', 610, '2026-11-17 04:21:00'),
(304, 2, 'delete', 'chat_message', 612, '2026-11-17 04:21:00'),
(305, 2, 'delete', 'chat_message', 820, '2026-11-17 04:21:00'),
(306, 2, 'delete', 'chat_message', 896, '2026-11-17 04:21:00'),
(307, 2, 'delete', 'chat_message', 898, '2026-11-17 04:21:00'),
(308, 2, 'delete', 'chat_message', 927, '2026-11-17 04:21:00'),
(309, 2, 'delete', 'chat_message', 929, '2026-11-17 04:21:00'),
(310, 2, 'delete', 'chat_message', 931, '2026-11-17 04:21:00'),
(311, 2, 'delete', 'chat_message', 933, '2026-11-17 04:21:00'),
(312, 2, 'delete', 'chat_message', 935, '2026-11-17 04:21:00'),
(313, 2, 'delete', 'chat_message', 937, '2026-11-17 04:21:00'),
(314, 2, 'delete', 'chat_message', 939, '2026-11-17 04:21:00'),
(315, 2, 'delete', 'chat_message', 953, '2026-11-17 04:21:00'),
(316, 2, 'delete', 'chat_message', 955, '2026-11-17 04:21:00'),
(317, 2, 'delete', 'chat_message', 1142, '2026-11-17 04:21:00'),
(318, 2, 'delete', 'chat_message', 1151, '2026-11-17 04:21:00'),
(319, 2, 'delete', 'chat_message', 334, '2026-11-17 04:21:03'),
(320, 2, 'delete', 'chat_message', 336, '2026-11-17 04:21:03'),
(321, 2, 'delete', 'chat_message', 338, '2026-11-17 04:21:03'),
(322, 2, 'delete', 'chat_message', 340, '2026-11-17 04:21:03'),
(323, 2, 'delete', 'chat_message', 366, '2026-11-17 04:21:03'),
(324, 2, 'delete', 'chat_message', 368, '2026-11-17 04:21:03'),
(325, 2, 'delete', 'chat_message', 370, '2026-11-17 04:21:03'),
(326, 2, 'delete', 'chat_message', 372, '2026-11-17 04:21:03'),
(327, 2, 'delete', 'chat_message', 374, '2026-11-17 04:21:03'),
(328, 2, 'delete', 'chat_message', 378, '2026-11-17 04:21:03'),
(329, 2, 'delete', 'chat_message', 380, '2026-11-17 04:21:03'),
(330, 2, 'delete', 'chat_message', 382, '2026-11-17 04:21:03'),
(331, 2, 'delete', 'chat_message', 384, '2026-11-17 04:21:03'),
(332, 2, 'delete', 'chat_message', 386, '2026-11-17 04:21:03'),
(333, 2, 'delete', 'chat_message', 388, '2026-11-17 04:21:03'),
(334, 2, 'delete', 'chat_message', 390, '2026-11-17 04:21:03'),
(335, 2, 'delete', 'chat_message', 392, '2026-11-17 04:21:03'),
(336, 2, 'delete', 'chat_message', 394, '2026-11-17 04:21:03'),
(337, 2, 'delete', 'chat_message', 396, '2026-11-17 04:21:03'),
(338, 2, 'delete', 'chat_message', 398, '2026-11-17 04:21:03'),
(339, 2, 'delete', 'chat_message', 400, '2026-11-17 04:21:03'),
(340, 2, 'delete', 'chat_message', 402, '2026-11-17 04:21:03'),
(341, 2, 'delete', 'chat_message', 404, '2026-11-17 04:21:03'),
(342, 2, 'delete', 'chat_message', 438, '2026-11-17 04:21:03'),
(343, 2, 'delete', 'chat_message', 440, '2026-11-17 04:21:03'),
(344, 2, 'delete', 'chat_message', 444, '2026-11-17 04:21:03'),
(345, 2, 'delete', 'chat_message', 446, '2026-11-17 04:21:03'),
(346, 2, 'delete', 'chat_message', 448, '2026-11-17 04:21:03'),
(347, 2, 'delete', 'chat_message', 450, '2026-11-17 04:21:03'),
(348, 2, 'delete', 'chat_message', 452, '2026-11-17 04:21:03'),
(349, 2, 'delete', 'chat_message', 68, '2026-11-17 04:21:08'),
(350, 2, 'delete', 'chat_message', 70, '2026-11-17 04:21:08'),
(351, 2, 'delete', 'chat_message', 72, '2026-11-17 04:21:08'),
(352, 2, 'delete', 'chat_message', 74, '2026-11-17 04:21:08'),
(353, 2, 'delete', 'chat_message', 76, '2026-11-17 04:21:08'),
(354, 2, 'delete', 'chat_message', 78, '2026-11-17 04:21:08'),
(355, 2, 'delete', 'chat_message', 148, '2026-11-17 04:21:08'),
(356, 2, 'delete', 'chat_message', 150, '2026-11-17 04:21:08'),
(357, 2, 'delete', 'chat_message', 152, '2026-11-17 04:21:08'),
(358, 2, 'delete', 'chat_message', 166, '2026-11-17 04:21:08'),
(359, 2, 'delete', 'chat_message', 168, '2026-11-17 04:21:08'),
(360, 2, 'delete', 'chat_message', 170, '2026-11-17 04:21:08'),
(361, 2, 'delete', 'chat_message', 172, '2026-11-17 04:21:08'),
(362, 2, 'delete', 'chat_message', 174, '2026-11-17 04:21:08'),
(363, 2, 'delete', 'chat_message', 176, '2026-11-17 04:21:08'),
(364, 2, 'delete', 'chat_message', 178, '2026-11-17 04:21:08'),
(365, 2, 'delete', 'chat_message', 180, '2026-11-17 04:21:08'),
(366, 2, 'delete', 'chat_message', 182, '2026-11-17 04:21:08'),
(367, 2, 'delete', 'chat_message', 184, '2026-11-17 04:21:08'),
(368, 2, 'delete', 'chat_message', 186, '2026-11-17 04:21:08'),
(369, 2, 'delete', 'chat_message', 188, '2026-11-17 04:21:08'),
(370, 2, 'delete', 'chat_message', 190, '2026-11-17 04:21:08'),
(371, 2, 'delete', 'chat_message', 216, '2026-11-17 04:21:08'),
(372, 2, 'delete', 'chat_message', 218, '2026-11-17 04:21:08'),
(373, 2, 'delete', 'chat_message', 220, '2026-11-17 04:21:08'),
(374, 2, 'delete', 'chat_message', 222, '2026-11-17 04:21:08'),
(375, 2, 'delete', 'chat_message', 320, '2026-11-17 04:21:08'),
(376, 2, 'delete', 'chat_message', 322, '2026-11-17 04:21:08'),
(377, 2, 'delete', 'chat_message', 324, '2026-11-17 04:21:08'),
(378, 2, 'delete', 'chat_message', 332, '2026-11-17 04:21:08'),
(379, 2, 'delete', 'chat_message', 60, '2026-11-17 04:21:11'),
(380, 2, 'delete', 'chat_message', 62, '2026-11-17 04:21:11'),
(381, 2, 'delete', 'chat_message', 64, '2026-11-17 04:21:11'),
(382, 2, 'delete', 'chat_message', 66, '2026-11-17 04:21:11'),
(383, 2, 'save', 'knowledge', 50, '2026-11-17 04:22:57'),
(384, 2, 'save', 'knowledge', 50, '2026-11-17 04:23:25'),
(385, 2, 'login', 'admin', 2, '2026-11-17 07:38:19'),
(386, 2, 'login', 'admin', 2, '2026-11-17 09:57:38'),
(387, 2, 'login', 'admin', 2, '2026-11-17 14:17:04'),
(388, 2, 'login', 'admin', 2, '2026-11-17 14:43:23'),
(389, 2, 'login', 'admin', 2, '2026-11-17 16:18:15'),
(390, 2, 'login', 'admin', 2, '2026-11-18 06:38:27'),
(391, 2, 'disable', 'student-interface', NULL, '2026-11-18 06:38:34'),
(392, 2, 'enable', 'student-interface', NULL, '2026-11-18 06:39:01'),
(393, 2, 'save', 'knowledge', 30, '2026-11-18 06:57:12'),
(394, 2, 'save', 'knowledge', 30, '2026-11-18 06:58:18'),
(395, 2, 'login', 'admin', 2, '2026-11-18 09:17:56'),
(396, 2, 'login', 'admin', 2, '2026-11-20 06:51:48'),
(397, 2, 'login', 'admin', 2, '2026-11-20 07:24:57');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','editor') NOT NULL DEFAULT 'admin',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password_hash`, `role`, `is_active`, `created_at`, `updated_at`) VALUES
(2, 'Test Administrator', 'test01@gmail.com', '$2y$10$W..cOxZQqTMkB7Yi82kx2O9VT/63ogUmpFyWAgeQ0b9Gru/0NilJW', 'admin', 1, '2026-10-16 13:07:57', '2026-10-27 05:16:32'),
(4, 'Administrator01', 'admin01@gmail.com', '$2y$10$j5Yj/VqKOheSKhJFlAoc/udWfMqi0I3khI1zfHruKEXSqcC4Vq3.C', 'admin', 1, '2026-11-11 11:21:02', '2026-11-11 11:28:51'),
(5, 'Administrator02', 'admin02@gmail.com', '$2y$10$EgdMg6tgNZYJR9OmFxad.OSechFLyQqXxZWZkW4oxxRPof5urO3bu', 'admin', 1, '2026-11-11 11:21:02', '2026-11-11 11:31:38');

-- --------------------------------------------------------

--
-- Table structure for table `admin_activity_state`
--

CREATE TABLE `admin_activity_state` (
  `admin_id` int(10) UNSIGNED NOT NULL,
  `last_seen_chat_message_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_activity_state`
--

INSERT INTO `admin_activity_state` (`admin_id`, `last_seen_chat_message_id`) VALUES
(2, 1381),
(4, 955);

-- --------------------------------------------------------

--
-- Table structure for table `admin_feedback_state`
--

CREATE TABLE `admin_feedback_state` (
  `admin_id` int(10) UNSIGNED NOT NULL,
  `last_seen_feedback_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_feedback_state`
--

INSERT INTO `admin_feedback_state` (`admin_id`, `last_seen_feedback_id`) VALUES
(2, 18),
(4, 12);

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` mediumtext NOT NULL,
  `source_url` varchar(2048) DEFAULT NULL,
  `publish_at` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `status` enum('draft','published') NOT NULL DEFAULT 'draft',
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `content`, `source_url`, `publish_at`, `expiration_date`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(6, 'CCS Department Fee Payment Options - 1,400 pesos', 'The CCS department fee listed in this announcement is 1,400 pesos. To pay the CCS department fee, use one of the authorized CCS Central Council GCash channels below:\r\n\r\nExecutive Treasurer Renalyn Ubalde: 0907 919 2632\r\nDeputy Treasurer Anika Kaye Arjite: 0967 188 7631\r\n\r\nPlease confirm the amount and payment details through the official CCS Facebook page or approved CCS communication channel before sending money.', NULL, '2026-11-11 11:22:00', NULL, 'published', NULL, '2026-11-09 05:59:51', '2026-11-12 10:37:18');

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `setting_key` varchar(80) NOT NULL,
  `setting_value` varchar(255) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES
('student_interface_enabled', '1', '2026-11-18 06:39:01');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `show_in_student_panel` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `show_in_student_panel`, `created_at`, `updated_at`) VALUES
(1, 'Faculty and Staff', 'Verified faculty and department personnel information.', 1, '2026-10-16 10:42:10', '2026-10-16 10:42:10'),
(2, 'CCS Council Officers', 'Verified College of Computer Studies council information.', 1, '2026-10-16 10:42:10', '2026-10-16 10:42:10'),
(3, 'Rooms and Laboratories', 'Verified facilities and room information.', 1, '2026-10-16 10:42:10', '2026-10-16 10:42:10'),
(4, 'Announcements and Activities', 'Current department notices and activities.', 1, '2026-10-16 10:42:10', '2026-10-16 10:42:10'),
(5, 'Academic Requirements', 'Verified academic requirements.', 1, '2026-10-16 10:42:10', '2026-10-16 10:42:10'),
(6, 'Schedules and Important Dates', 'Verified schedules and dates.', 1, '2026-10-16 10:42:10', '2026-11-17 03:53:21'),
(7, 'Academic Procedures', 'Documented academic procedures.', 1, '2026-10-16 10:42:10', '2026-10-16 10:42:10'),
(15, 'Department Policies', 'Approved College of Computer Studies department policies.', 1, '2026-10-16 11:05:09', '2026-10-16 11:05:09'),
(27, 'General Information', 'Verified COMSAI General Information', 1, '2026-10-27 04:50:05', '2026-10-27 05:43:09'),
(28, 'Fallback and Clarifications', 'Verified COMSAI Fallback and Clarifications', 0, '2026-11-05 09:16:48', '2026-11-17 03:53:08');

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `chat_session_id` bigint(20) UNSIGNED NOT NULL,
  `sender` enum('student','assistant') NOT NULL,
  `message` mediumtext NOT NULL,
  `response_mode` varchar(24) DEFAULT NULL,
  `source_references` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`source_references`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`id`, `chat_session_id`, `sender`, `message`, `response_mode`, `source_references`, `created_at`) VALUES
(61, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:38'),
(63, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:40'),
(65, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:40'),
(67, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:40'),
(69, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:40'),
(71, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:41'),
(73, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:41'),
(75, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:41'),
(77, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:42'),
(79, 17, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-16 16:31:42'),
(149, 27, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-17 10:33:35'),
(151, 27, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-17 10:33:39'),
(153, 28, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-25 23:12:32'),
(167, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:24:59'),
(169, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:25:01'),
(171, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:25:07'),
(173, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:28:12'),
(175, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:28:18'),
(177, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:38:24'),
(179, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:38:25'),
(181, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:38:26'),
(183, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:38:27'),
(185, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:38:27'),
(187, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:38:35'),
(189, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:41:51'),
(191, 30, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 07:41:54'),
(217, 34, 'assistant', 'Knowledge-base results (not AI-generated):\n\nCCS Central Council Officers\nGovernor: Selene E. Tychingco\nVice Governor - Internal: Angel Ayessa O. Cacho\nVice Governor - External: Giedhell Ann M. Serrano\nExecutive Secretary: Abiegail T. Rellermo\nAssistant Secretary: Lorren Joyce L. Erandio\nChief Treasurer: Renalyn T. Ubalde\nDeputy Treasurer: Anika Kaye E. Arjite\nAuditor: Renz Darrel O. Gomez\nChief Peace Officer: Justine D. Canaria\nDeputy Peace Officer: Jose Russel M. Cabunias\nDeputy Peace Officer: John Kevin B. Abogado\nChief Communication and Media Officer: John Bernard C. De Leon\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\nCommunication and Media Officer: Shalom Emannuel M. Abiera\nCommunication and Media Officer: Richard A. Boribor\nCommunication and Media Officer: Condrad Jaimar G. Sale\nCommunication and Media Officer: Candice Fine Y. Montemayor\nFourth Year Representative: Eya Mae R. Bana\nThird Year Representative: Gian Carlo D. Bacia\nSecond Year Representative: Chelsey Joelle B. Esguerra\nFirst Year Representative: John Mark N. Molina\nFirst Year Representative: Mark Zedrix Zantua\nCCS Central Council Adviser: Aeron Dave C. Enova\n\n', 'legacy-sourced', '[{\"title\":\"User-provided CCS council officer roster\",\"url\":\"\"}]', '2026-10-26 08:27:38'),
(219, 34, 'assistant', 'Knowledge-base results (not AI-generated):\n\nCCS Central Council Officers\nGovernor: Selene E. Tychingco\nVice Governor - Internal: Angel Ayessa O. Cacho\nVice Governor - External: Giedhell Ann M. Serrano\nExecutive Secretary: Abiegail T. Rellermo\nAssistant Secretary: Lorren Joyce L. Erandio\nChief Treasurer: Renalyn T. Ubalde\nDeputy Treasurer: Anika Kaye E. Arjite\nAuditor: Renz Darrel O. Gomez\nChief Peace Officer: Justine D. Canaria\nDeputy Peace Officer: Jose Russel M. Cabunias\nDeputy Peace Officer: John Kevin B. Abogado\nChief Communication and Media Officer: John Bernard C. De Leon\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\nCommunication and Media Officer: Shalom Emannuel M. Abiera\nCommunication and Media Officer: Richard A. Boribor\nCommunication and Media Officer: Condrad Jaimar G. Sale\nCommunication and Media Officer: Candice Fine Y. Montemayor\nFourth Year Representative: Eya Mae R. Bana\nThird Year Representative: Gian Carlo D. Bacia\nSecond Year Representative: Chelsey Joelle B. Esguerra\nFirst Year Representative: John Mark N. Molina\nFirst Year Representative: Mark Zedrix Zantua\nCCS Central Council Adviser: Aeron Dave C. Enova\n\n', 'legacy-sourced', '[{\"title\":\"User-provided CCS council officer roster\",\"url\":\"\"}]', '2026-10-26 08:33:02'),
(221, 34, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-26 09:40:26'),
(223, 34, 'assistant', 'Knowledge-base results (not AI-generated):\n\nCCS Central Council Officers\nGOVERNOR: Selene E. Tychingco\r\nVICE GOVERNOR - INTERNAL: Angel Ayessa O. Cacho\r\nVICE GOVERNOR - EXTERNAL: Giedhell Ann M. Serrano\r\nEXECUTIVE SECRETARY: Abiegail T. Rellermo\r\nASSISTANT SECRETARY: Lorren Joyce L. Erandio\r\nCHIEF TREASURER: Renalyn T. Ubalde\r\nDEPUTY TREASURER: Anika Kaye E. Arjite\r\nAUDITOR: Renz Darrel O. Gomez\r\nCHIEF PEACE OFFICER: Justine D. Canaria\r\nDEPUTY PEACE OFFICER: Jose Russel M. Cabunias\r\nDEPUTY PEACE OFFICER: John Kevin B. Abogado\r\nCHIEF COMMUNICATION AND MEDIA OFFICER: John Bernard C. De Leon\r\nDEPUTY COMMUNICATION AND MEDIA OFFICER: Francis Kevin Y. Calvario\r\nCOMMUNICATION AND MEDIA OFFICER: Shalom Emannuel M. Abiera\r\nCOMMUNICATION AND MEDIA OFFICER: Richard A. Boribor\r\nCOMMUNICATION AND MEDIA OFFICER: Condrad Jaimar G. Sale\r\nCOMMUNICATION AND MEDIA OFFICER: Candice Fine Y. Montemayor\r\nFOURTH YEAR REPRESENTATIVE: Eya Mae R. Bana\r\nTHIRD YEAR REPRESENTATIVE: Gian Carlo D. Bacia\r\nSECOND YEAR REPRESENTATIVE: Chelsey Joelle B. Esguerra\r\nFIRST YEAR REPRESENTATIVE: John Mark N. Molina\r\nFIRST YEAR REPRESENTATIVE: Mark Zedrix Zantua\r\nCCS CENTRAL COUNCIL ADVISER: Aeron Dave C. Enova\n\n', 'legacy-sourced', '[{\"title\":\"User-provided CCS council officer roster\",\"url\":\"\"}]', '2026-10-26 11:23:14'),
(321, 54, 'assistant', 'Knowledge-base results (not AI-generated):\n\nWho is the CCS Dean?\nThe OIC Dean of the College of Computer Studies is Sir Frank Kiven B. Ablao. He is also the Technical Head of Mabini Colleges, a Licensed Professional Teacher, and a Civil Service Professional.\n\nHow can I contact a CCS faculty member?\nYou can contact [faculty member] through [insert approved school email or official contact method]. COMSAI should only display contact details approved for public student use.\n\nWho are the CCS faculty members?\nFACULTY MEMBERS\r\n\r\nFRANK KIVEN B. ABLAO, LPT, MIS\r\nOIC - DEAN, CCS & MC TECH HEAD\r\nCIVIL SERVICE PROFESSIONAL TRAINER METHODOLOGY LEVEL 1.\r\nCOMPUTER PROGRAMMING NC IV, VISUAL GRAPHICS DESIGN NC III.\r\nAUTOMATIVE SERVICE (ENGINE REPAIR) NC II. ELECTRONIC PRODUCTS ASSEMBLY AND SERVICING NC II.\r\n\r\nCHRISTIAN DRIGON F. AGA, LPT, JD\r\nCCS ADMINISTRATOR, MIT (UNIT EARNER)\r\nBACHELOR OF ARTS IN ECONOMICS - POLYTECHNIC UNIVERSITY OF THE PHILIPPINES. CERTIFICATE IN COMPUTER EDUCATION - DE LA SALLE UNIVERSITY. CERTIFICATE IN TEACHING - PHILIPPINE NORMAL UNIVERSITY - MANILA \r\n\r\nEDCEL S. MARTINEZ\r\nHEAD, COMPUTER INTERNET LAB\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE.\r\nPROFESSIONAL EDUCATION, 2D ANIMATION NC III. \r\nCOMPUTER SYSTEM SERVICING NC II. VISUAL GRAPHICS DESIGN NCIII\r\n\r\nIAN GODWIN G. AGAPITO\r\nCCS INSTRUCTOR\r\nPROFESSIONAL EDUCATION\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\n\r\nAERON DAVE C. ENOVA, LPT, CRS, CAWS\r\nCCS CENTRAL COUNCIL ADVISER / PRACTICUM COORDINATOR / RESEARCH COORDINATOR \r\nMASTER OF SCIENCE IN COMPUTER SCIENCE (ONGOING) MASTERS OF SCIENCE IN INFORMATION TECHNOLOGY (27 UNITS), JURIS DOCTOR (04 UNITS).\r\nCERTIFIED ACADEMIC WRITING SPECIALIST, CERTIFIED RESEARCH SPECIALIST.\r\nCIVIL SERVICE PROFESSIONAL AND DATA ANALYST\r\n\r\nKEVIN-EZER F TANIERLA \r\nCCS INSTRUCTOR / SOFTWARE ENGINEER\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE. PROGRAMMING NC IV. ANIMATION NC III. MC PORTAL ENDEAVORS: DIGITAL ID, DIGITAL PERMIT, ATTENDANCE MONITORING SYSTEM, DIGITAL TICKETS\r\n\r\nJOHN EDDIE  ABLAO\r\nSOFTWARE ENGINEER\r\nBACHELOR SCIENCE IN INFORMATION TECHNOLOGY\r\n\r\nJOHN VIRGEL LO\r\nSYSTEM ADMINISTRATOR\r\nBAACHELOR SCIENCE IN COMPUTER SCIENCE\r\n\r\nFERDINAND O. POSTRE\r\nTECHNICAL SUPPORT ASSISTANT\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nCOMPUTER SYSTEMS SERVICING NC II\r\n\r\n\r\nANNABEL DICHOSO NAGERA, LPT\r\nPART-TIME INSTRUCTOR DEPED -  TEACHER III\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nMASTER IN INFORMATION TECHNOLOGY UNIT EARNER \r\nPROFESSIONAL EDUCATION & MASTER IN EDUCATION UNIT EARNER\n\nWhere can I find the CCS Dean?\nThe CCS Dean may be reached at [insert verified office/location and availability]. If the location or schedule is not listed, please contact the CCS office or CCS Council.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"},{\"title\":\"Faculty and Staff\",\"url\":\"\"},{\"title\":\"Faculty and Staff\",\"url\":\"\"},{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-10-27 11:49:28'),
(323, 54, 'assistant', 'Knowledge-base results (not AI-generated):\n\nWho is the current CCS Governor?\nThe current CCS Governor for Academic Year 2026–2027 is Ms. Selene E. Tychingco.\n\nCCS Central Council Officers\nGOVERNOR: Selene E. Tychingco\r\nVICE GOVERNOR - INTERNAL: Angel Ayessa O. Cacho\r\nVICE GOVERNOR - EXTERNAL: Giedhell Ann M. Serrano\r\nEXECUTIVE SECRETARY: Abiegail T. Rellermo\r\nASSISTANT SECRETARY: Lorren Joyce L. Erandio\r\nCHIEF TREASURER: Renalyn T. Ubalde\r\nDEPUTY TREASURER: Anika Kaye E. Arjite\r\nAUDITOR: Renz Darrel O. Gomez\r\nCHIEF PEACE OFFICER: Justine D. Canaria\r\nDEPUTY PEACE OFFICER: Jose Russel M. Cabunias\r\nDEPUTY PEACE OFFICER: John Kevin B. Abogado\r\nCHIEF COMMUNICATION AND MEDIA OFFICER: John Bernard C. De Leon\r\nDEPUTY COMMUNICATION AND MEDIA OFFICER: Francis Kevin Y. Calvario\r\nCOMMUNICATION AND MEDIA OFFICER: Shalom Emannuel M. Abiera\r\nCOMMUNICATION AND MEDIA OFFICER: Richard A. Boribor\r\nCOMMUNICATION AND MEDIA OFFICER: Condrad Jaimar G. Sale\r\nCOMMUNICATION AND MEDIA OFFICER: Candice Fine Y. Montemayor\r\nFOURTH YEAR REPRESENTATIVE: Eya Mae R. Bana\r\nTHIRD YEAR REPRESENTATIVE: Gian Carlo D. Bacia\r\nSECOND YEAR REPRESENTATIVE: Chelsey Joelle B. Esguerra\r\nFIRST YEAR REPRESENTATIVE: John Mark N. Molina\r\nFIRST YEAR REPRESENTATIVE: Mark Zedrix Zantua\r\nCCS CENTRAL COUNCIL ADVISER: Aeron Dave C. Enova\n\n', 'legacy-sourced', '[{\"title\":\"General Information\",\"url\":\"\"},{\"title\":\"User-provided CCS council officer roster\",\"url\":\"\"}]', '2026-10-27 11:49:40'),
(325, 54, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-10-27 11:49:44'),
(333, 57, 'assistant', 'There is no published information in this category yet. Please check back later or ask about another topic.', 'unverified', '[]', '2026-10-28 11:39:05'),
(335, 57, 'assistant', 'There is no published information in this category yet. Please check back later or ask about another topic.', 'unverified', '[]', '2026-10-28 11:39:08'),
(337, 57, 'assistant', 'There is no published information in this category yet. Please check back later or ask about another topic.', 'unverified', '[]', '2026-10-28 11:39:09'),
(339, 57, 'assistant', 'There is no published information in this category yet. Please check back later or ask about another topic.', 'unverified', '[]', '2026-10-28 11:39:09'),
(341, 57, 'assistant', 'Knowledge-base results (not AI-generated):\n\nCCS Central Council Officers\nThe College of Computer Studies Central Council Officers for Academic Year 2026–2027\r\n\r\nGovernor: Selene E. Tychingco\r\nVice Governor – Internal: Angel Ayessa O. Cacho\r\nVice Governor – External: Giedhell Ann M. Serrano\r\nExecutive Secretary: Abiegail T. Rellermo\r\nAssistant Secretary: Lorren Joyce L. Erandio\r\nChief Treasurer: Renalyn T. Ubalde\r\nDeputy Treasurer: Anika Kaye E. Arjite\r\nAuditor: Renz Darrel O. Gomez\r\nChief Peace Officer: Justine D. Canaria\r\nDeputy Peace Officer: Jose Russel M. Cabunias\r\nDeputy Peace Officer: John Kevin B. Abogado\r\nChief Communication and Media Officer: John Bernard C. De Leon\r\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\r\nCommunication and Media Officer: Shalom Emannuel M. Abiera\r\nCommunication and Media Officer: Richard A. Boribor\r\nCommunication and Media Officer: Condrad Jaimar G. Sale\r\nCommunication and Media Officer: Candice Fine Y. Montemayor\r\nFourth Year Representative: Eya Mae R. Bana\r\nThird Year Representative: Gian Carlo D. Bacia\r\nSecond Year Representative: Chelsey Joelle B. Esguerra\r\nFirst Year Representative: John Mark N. Molina\r\nFirst Year Representative: Mark Zedrix Zantua\n\nWho is the current CCS Governor?\nThe current CCS Governor for Academic Year 2026–2027 is Ms. Selene E. Tychingco.\n\n', 'legacy-sourced', '[{\"title\":\"User-provided CCS council officer roster\",\"url\":\"\"},{\"title\":\"General Information\",\"url\":\"\"}]', '2026-10-28 11:39:17'),
(367, 64, 'assistant', 'Knowledge-base results (not AI-generated):\n\nWhat is COMSAI?\nCOMSAI is an AI-powered student information assistance chatbot designed to help users access information related to the College of Computer Studies (CCS) of Mabini Colleges, Inc.\n\nHow do I comply with an INC grade?\nA: The verified CCS/Mabini Colleges procedure for INC compliance is: \r\n1. Get the INC Form from the Registrar’s Office.\r\n2. Go to your professor and ask for the remaining requirements needed to complete your INC grade.\r\n3.Complete all missing requirements given by your professor.\r\n4.Have your professor sign the INC Form and submit the required grade or completion details.\r\n5.Return the INC Form to the Registrar’s Office for processing and updating of your grade.\n\n', 'legacy-sourced', '[{\"title\":\"General Information\",\"url\":\"\"},{\"title\":\"Academic Procedures\",\"url\":\"\"}]', '2026-11-05 09:54:13'),
(369, 64, 'assistant', 'Knowledge-base results (not AI-generated):\n\nHow do I comply with an INC grade?\nA: The verified CCS/Mabini Colleges procedure for INC compliance is: \r\n1. Get the INC Form from the Registrar’s Office.\r\n2. Go to your professor and ask for the remaining requirements needed to complete your INC grade.\r\n3.Complete all missing requirements given by your professor.\r\n4.Have your professor sign the INC Form and submit the required grade or completion details.\r\n5.Return the INC Form to the Registrar’s Office for processing and updating of your grade.\n\n', 'legacy-sourced', '[{\"title\":\"Academic Procedures\",\"url\":\"\"}]', '2026-11-05 10:03:40'),
(371, 64, 'assistant', 'Knowledge-base results (not AI-generated):\n\nCCS Central Council Officers\nThe College of Computer Studies Central Council Officers for Academic Year 2026–2027\r\n\r\nGovernor: Selene E. Tychingco\r\nVice Governor – Internal: Angel Ayessa O. Cacho\r\nVice Governor – External: Giedhell Ann M. Serrano\r\nExecutive Secretary: Abiegail T. Rellermo\r\nAssistant Secretary: Lorren Joyce L. Erandio\r\nChief Treasurer: Renalyn T. Ubalde\r\nDeputy Treasurer: Anika Kaye E. Arjite\r\nAuditor: Renz Darrel O. Gomez\r\nChief Peace Officer: Justine D. Canaria\r\nDeputy Peace Officer: Jose Russel M. Cabunias\r\nDeputy Peace Officer: John Kevin B. Abogado\r\nChief Communication and Media Officer: John Bernard C. De Leon\r\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\r\nCommunication and Media Officer: Shalom Emannuel M. Abiera\r\nCommunication and Media Officer: Richard A. Boribor\r\nCommunication and Media Officer: Condrad Jaimar G. Sale\r\nCommunication and Media Officer: Candice Fine Y. Montemayor\r\nFourth Year Representative: Eya Mae R. Bana\r\nThird Year Representative: Gian Carlo D. Bacia\r\nSecond Year Representative: Chelsey Joelle B. Esguerra\r\nFirst Year Representative: John Mark N. Molina\r\nFirst Year Representative: Mark Zedrix Zantua\n\n', 'legacy-sourced', '[{\"title\":\"User-provided CCS council officer roster\",\"url\":\"\"}]', '2026-11-05 10:03:57'),
(373, 64, 'assistant', 'Knowledge-base results (not AI-generated):\n\nWho are the CCS faculty members?\nThe current CCS faculty list is: ORGANIZATIONAL CHART FACULTY MEMBERS\r\n\r\nFRANK KIVEN B. ABLAO, LPT, MIS\r\nOIC - DEAN, CCS & MC TECH HEAD\r\nCIVIL SERVICE PROFESSIONAL TRAINER METHODOLOGY LEVEL 1.\r\nCOMPUTER PROGRAMMING NC IV, VISUAL GRAPHICS DESIGN NC III.\r\nAUTOMATIVE SERVICE (ENGINE REPAIR) NC II. ELECTRONIC PRODUCTS ASSEMBLY AND SERVICING NC II.\r\n\r\nCHRISTIAN DRIGON F. AGA, LPT, JD\r\nCCS ADMINISTRATOR, MIT (UNIT EARNER)\r\nBACHELOR OF ARTS IN ECONOMICS - POLYTECHNIC UNIVERSITY OF THE PHILIPPINES. CERTIFICATE IN COMPUTER EDUCATION - DE LA SALLE UNIVERSITY. CERTIFICATE IN TEACHING - PHILIPPINE NORMAL UNIVERSITY - MANILA \r\n\r\nEDCEL S. MARTINEZ\r\nHEAD, COMPUTER INTERNET LAB\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE.\r\nPROFESSIONAL EDUCATION, 2D ANIMATION NC III. \r\nCOMPUTER SYSTEM SERVICING NC II. VISUAL GRAPHICS DESIGN NCIII\r\n\r\nIAN GODWIN G. AGAPITO\r\nCCS INSTRUCTOR\r\nPROFESSIONAL EDUCATION\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\n\r\nAERON DAVE C. ENOVA, LPT, CRS, CAWS\r\nCCS CENTRAL COUNCIL ADVISER / PRACTICUM COORDINATOR / RESEARCH COORDINATOR \r\nMASTER OF SCIENCE IN COMPUTER SCIENCE (ONGOING) MASTERS OF SCIENCE IN INFORMATION TECHNOLOGY (27 UNITS), JURIS DOCTOR (04 UNITS).\r\nCERTIFIED ACADEMIC WRITING SPECIALIST, CERTIFIED RESEARCH SPECIALIST.\r\nCIVIL SERVICE PROFESSIONAL AND DATA ANALYST\r\n\r\nKEVIN-EZER F TANIERLA \r\nCCS INSTRUCTOR / SOFTWARE ENGINEER\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE. PROGRAMMING NC IV. ANIMATION NC III. MC PORTAL ENDEAVORS: DIGITAL ID, DIGITAL PERMIT, ATTENDANCE MONITORING SYSTEM, DIGITAL TICKETS\r\n\r\nJOHN EDDIE ABLAO\r\nSOFTWARE ENGINEER\r\nBACHELOR SCIENCE IN INFORMATION TECHNOLOGY\r\n\r\nJOHN VIRGEL LO\r\nSYSTEM ADMINISTRATOR\r\nBAACHELOR SCIENCE IN COMPUTER SCIENCE\r\n\r\nFERDINAND O. POSTRE\r\nTECHNICAL SUPPORT ASSISTANT\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nCOMPUTER SYSTEMS SERVICING NC II\r\n\r\nANNABEL DICHOSO NAGERA, LPT\r\nPART-TIME INSTRUCTOR DEPED - TEACHER III\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nMASTER IN INFORMATION TECHNOLOGY UNIT EARNER \r\nPROFESSIONAL EDUCATION & MASTER IN EDUCATION UNIT EARNER.\n\nWho is the CCS Dean?\nThe OIC Dean of the College of Computer Studies is Sir Frank Kiven B. Ablao. He is also the Technical Head of Mabini Colleges, a Licensed Professional Teacher, and a Civil Service Professional.\n\nWhere can I find the CCS Dean?\nThe CCS Dean office may be reached at second floor, beside the President’s office . If the location or schedule is not listed, please contact the CCS office or CCS Council.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"},{\"title\":\"Faculty and Staff\",\"url\":\"\"},{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-05 10:04:14'),
(375, 64, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-05 10:04:26'),
(379, 66, 'assistant', 'Knowledge-base results (not AI-generated):\n\nHow do I process a COG (Certificate of Grades)?\nComplete the Request Form: Secure and fill out the official request slip available at the Registrar\'s window. Provide your full name, student ID number, the specific academic year and semester, and the purpose of your request.\r\nInitial Processing: Submit the completed form to the Registrar\'s window for verification and for printing of your Certificate of Grades (COG).\r\nPayment: Proceed to the Cashier’s Office to pay the required processing fee for the COG.\r\nValidation and Stamping: Return to the Registrar’s Office with your printed COG and payment receipt. The staff will verify the document and apply the official school seal.\r\nCollection: Await instructions from the Registrar staff regarding the schedule and releasing process for your validated COG.\n\n', 'legacy-sourced', '[{\"title\":\"Academic Procedures\",\"url\":\"\"}]', '2026-11-06 08:49:59'),
(381, 66, 'assistant', 'Knowledge-base results (not AI-generated):\n\nWhere is the Main Laboratory?\nThe Main Laboratory is located on the second floor, MRI Building, Room 207. If you cannot find it, ask the CCS office or a designated staff member.\n\nWhere is the Annex Laboratory?\nThe Annex Laboratory is located on the second floor, MRI Building, Room 203. If you cannot find it, ask the CCS office or a designated staff member.\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\nWhere can I find the CCS Dean?\nThe CCS Dean office may be reached at second floor, beside the President’s office . If the location or schedule is not listed, please contact the CCS office or CCS Council.\n\nWhere can I find the CCS class schedule?\nThe College of Computer Studies (CCS) class schedule is accessible through the school’s official student portal. Once logged in, students can view their complete course schedule, including the assigned subjects, class dates, times, room assignments, and the corresponding subject instructors.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"},{\"title\":\"Rooms and Laboratories\",\"url\":\"\"},{\"title\":\"Rooms and Laboratories\",\"url\":\"\"},{\"title\":\"Faculty and Staff\",\"url\":\"\"},{\"title\":\"Schedules and Important Dates\",\"url\":\"\"}]', '2026-11-06 08:50:35'),
(383, 66, 'assistant', 'Knowledge-base results (not AI-generated):\n\nHow do I process a COG (Certificate of Grades)?\nComplete the Request Form: Secure and fill out the official request slip available at the Registrar\'s window. Provide your full name, student ID number, the specific academic year and semester, and the purpose of your request.\r\nInitial Processing: Submit the completed form to the Registrar\'s window for verification and for printing of your Certificate of Grades (COG).\r\nPayment: Proceed to the Cashier’s Office to pay the required processing fee for the COG.\r\nValidation and Stamping: Return to the Registrar’s Office with your printed COG and payment receipt. The staff will verify the document and apply the official school seal.\r\nCollection: Await instructions from the Registrar staff regarding the schedule and releasing process for your validated COG.\n\nWhere can I find the CCS class schedule?\nThe College of Computer Studies (CCS) class schedule is accessible through the school’s official student portal. Once logged in, students can view their complete course schedule, including the assigned subjects, class dates, times, room assignments, and the corresponding subject instructors.\n\nHow can I contact a CCS faculty member?\nYou can contact [faculty member] through [insert approved school email or official contact method]. COMSAI should only display contact details approved for public student use.\n\nCCS Central Council Officers\nThe College of Computer Studies Central Council Officers for Academic Year 2026–2027\r\n\r\nGovernor: Selene E. Tychingco\r\nVice Governor – Internal: Angel Ayessa O. Cacho\r\nVice Governor – External: Giedhell Ann M. Serrano\r\nExecutive Secretary: Abiegail T. Rellermo\r\nAssistant Secretary: Lorren Joyce L. Erandio\r\nChief Treasurer: Renalyn T. Ubalde\r\nDeputy Treasurer: Anika Kaye E. Arjite\r\nAuditor: Renz Darrel O. Gomez\r\nChief Peace Officer: Justine D. Canaria\r\nDeputy Peace Officer: Jose Russel M. Cabunias\r\nDeputy Peace Officer: John Kevin B. Abogado\r\nChief Communication and Media Officer: John Bernard C. De Leon\r\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\r\nCommunication and Media Officer: Shalom Emannuel M. Abiera\r\nCommunication and Media Officer: Richard A. Boribor\r\nCommunication and Media Officer: Condrad Jaimar G. Sale\r\nCommunication and Media Officer: Candice Fine Y. Montemayor\r\nFourth Year Representative: Eya Mae R. Bana\r\nThird Year Representative: Gian Carlo D. Bacia\r\nSecond Year Representative: Chelsey Joelle B. Esguerra\r\nFirst Year Representative: John Mark N. Molina\r\nFirst Year Representative: Mark Zedrix Zantua\n\nWho is the current CCS Governor?\nThe current CCS Governor for Academic Year 2026–2027 is Ms. Selene E. Tychingco.\n\n', 'legacy-sourced', '[{\"title\":\"Academic Procedures\",\"url\":\"\"},{\"title\":\"Schedules and Important Dates\",\"url\":\"\"},{\"title\":\"Faculty and Staff\",\"url\":\"\"},{\"title\":\"User-provided CCS council officer roster\",\"url\":\"\"},{\"title\":\"General Information\",\"url\":\"\"}]', '2026-11-06 08:51:52'),
(385, 66, 'assistant', 'Knowledge-base results (not AI-generated):\n\nWhere can I find the CCS Dean?\nThe CCS Dean office may be reached at second floor, beside the President’s office . If the location or schedule is not listed, please contact the CCS office or CCS Council.\n\nCan COMSAI confirm my personal academic or payment records?\nCOMSAI can only provide information that is approved for its knowledge base. It should not disclose private grades, balances, passwords, or other personal records. Please contact the authorized school office for account-specific concerns.\n\nWhere can I report incorrect information in COMSAI?\nPlease report the issue to [insert official CCS Council/admin contact channel]. An authorized administrator should verify the information and update the knowledge base if needed.\n\nHow can I contact a CCS faculty member?\nYou can contact [faculty member] through [insert approved school email or official contact method]. COMSAI should only display contact details approved for public student use.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"},{\"title\":\"Department Policies\",\"url\":\"\"},{\"title\":\"Fallback and Clarifications\",\"url\":\"\"},{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-06 11:47:21'),
(387, 67, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWho are the CCS faculty members?\nThe current CCS faculty list is: ORGANIZATIONAL CHART FACULTY MEMBERS\r\n\r\nFRANK KIVEN B. ABLAO, LPT, MIS\r\nOIC - DEAN, CCS & MC TECH HEAD\r\nCIVIL SERVICE PROFESSIONAL TRAINER METHODOLOGY LEVEL 1.\r\nCOMPUTER PROGRAMMING NC IV, VISUAL GRAPHICS DESIGN NC III.\r\nAUTOMATIVE SERVICE (ENGINE REPAIR) NC II. ELECTRONIC PRODUCTS ASSEMBLY AND SERVICING NC II.\r\n\r\nCHRISTIAN DRIGON F. AGA, LPT, JD\r\nCCS ADMINISTRATOR, MIT (UNIT EARNER)\r\nBACHELOR OF ARTS IN ECONOMICS - POLYTECHNIC UNIVERSITY OF THE PHILIPPINES. CERTIFICATE IN COMPUTER EDUCATION - DE LA SALLE UNIVERSITY. CERTIFICATE IN TEACHING - PHILIPPINE NORMAL UNIVERSITY - MANILA \r\n\r\nEDCEL S. MARTINEZ\r\nHEAD, COMPUTER INTERNET LAB\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE.\r\nPROFESSIONAL EDUCATION, 2D ANIMATION NC III. \r\nCOMPUTER SYSTEM SERVICING NC II. VISUAL GRAPHICS DESIGN NCIII\r\n\r\nIAN GODWIN G. AGAPITO\r\nCCS INSTRUCTOR\r\nPROFESSIONAL EDUCATION\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\n\r\nAERON DAVE C. ENOVA, LPT, CRS, CAWS\r\nCCS CENTRAL COUNCIL ADVISER / PRACTICUM COORDINATOR / RESEARCH COORDINATOR \r\nMASTER OF SCIENCE IN COMPUTER SCIENCE (ONGOING) MASTERS OF SCIENCE IN INFORMATION TECHNOLOGY (27 UNITS), JURIS DOCTOR (04 UNITS).\r\nCERTIFIED ACADEMIC WRITING SPECIALIST, CERTIFIED RESEARCH SPECIALIST.\r\nCIVIL SERVICE PROFESSIONAL AND DATA ANALYST\r\n\r\nKEVIN-EZER F TANIERLA \r\nCCS INSTRUCTOR / SOFTWARE ENGINEER\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE. PROGRAMMING NC IV. ANIMATION NC III. MC PORTAL ENDEAVORS: DIGITAL ID, DIGITAL PERMIT, ATTENDANCE MONITORING SYSTEM, DIGITAL TICKETS\r\n\r\nJOHN EDDIE ABLAO\r\nSOFTWARE ENGINEER\r\nBACHELOR SCIENCE IN INFORMATION TECHNOLOGY\r\n\r\nJOHN VIRGEL LO\r\nSYSTEM ADMINISTRATOR\r\nBAACHELOR SCIENCE IN COMPUTER SCIENCE\r\n\r\nFERDINAND O. POSTRE\r\nTECHNICAL SUPPORT ASSISTANT\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nCOMPUTER SYSTEMS SERVICING NC II\r\n\r\nANNABEL DICHOSO NAGERA, LPT\r\nPART-TIME INSTRUCTOR DEPED - TEACHER III\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nMASTER IN INFORMATION TECHNOLOGY UNIT EARNER \r\nPROFESSIONAL EDUCATION & MASTER IN EDUCATION UNIT EARNER.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-06 15:34:24'),
(389, 67, 'assistant', 'There is no published information in this category yet. Please check back later or ask about another topic.', 'unverified', '[]', '2026-11-06 15:34:32'),
(391, 67, 'assistant', 'There is no published information in this category yet. Please check back later or ask about another topic.', 'unverified', '[]', '2026-11-06 15:34:33'),
(393, 67, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWho are the CCS faculty members?\nThe current CCS faculty list is: ORGANIZATIONAL CHART FACULTY MEMBERS\r\n\r\nFRANK KIVEN B. ABLAO, LPT, MIS\r\nOIC - DEAN, CCS & MC TECH HEAD\r\nCIVIL SERVICE PROFESSIONAL TRAINER METHODOLOGY LEVEL 1.\r\nCOMPUTER PROGRAMMING NC IV, VISUAL GRAPHICS DESIGN NC III.\r\nAUTOMATIVE SERVICE (ENGINE REPAIR) NC II. ELECTRONIC PRODUCTS ASSEMBLY AND SERVICING NC II.\r\n\r\nCHRISTIAN DRIGON F. AGA, LPT, JD\r\nCCS ADMINISTRATOR, MIT (UNIT EARNER)\r\nBACHELOR OF ARTS IN ECONOMICS - POLYTECHNIC UNIVERSITY OF THE PHILIPPINES. CERTIFICATE IN COMPUTER EDUCATION - DE LA SALLE UNIVERSITY. CERTIFICATE IN TEACHING - PHILIPPINE NORMAL UNIVERSITY - MANILA \r\n\r\nEDCEL S. MARTINEZ\r\nHEAD, COMPUTER INTERNET LAB\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE.\r\nPROFESSIONAL EDUCATION, 2D ANIMATION NC III. \r\nCOMPUTER SYSTEM SERVICING NC II. VISUAL GRAPHICS DESIGN NCIII\r\n\r\nIAN GODWIN G. AGAPITO\r\nCCS INSTRUCTOR\r\nPROFESSIONAL EDUCATION\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\n\r\nAERON DAVE C. ENOVA, LPT, CRS, CAWS\r\nCCS CENTRAL COUNCIL ADVISER / PRACTICUM COORDINATOR / RESEARCH COORDINATOR \r\nMASTER OF SCIENCE IN COMPUTER SCIENCE (ONGOING) MASTERS OF SCIENCE IN INFORMATION TECHNOLOGY (27 UNITS), JURIS DOCTOR (04 UNITS).\r\nCERTIFIED ACADEMIC WRITING SPECIALIST, CERTIFIED RESEARCH SPECIALIST.\r\nCIVIL SERVICE PROFESSIONAL AND DATA ANALYST\r\n\r\nKEVIN-EZER F TANIERLA \r\nCCS INSTRUCTOR / SOFTWARE ENGINEER\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE. PROGRAMMING NC IV. ANIMATION NC III. MC PORTAL ENDEAVORS: DIGITAL ID, DIGITAL PERMIT, ATTENDANCE MONITORING SYSTEM, DIGITAL TICKETS\r\n\r\nJOHN EDDIE ABLAO\r\nSOFTWARE ENGINEER\r\nBACHELOR SCIENCE IN INFORMATION TECHNOLOGY\r\n\r\nJOHN VIRGEL LO\r\nSYSTEM ADMINISTRATOR\r\nBAACHELOR SCIENCE IN COMPUTER SCIENCE\r\n\r\nFERDINAND O. POSTRE\r\nTECHNICAL SUPPORT ASSISTANT\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nCOMPUTER SYSTEMS SERVICING NC II\r\n\r\nANNABEL DICHOSO NAGERA, LPT\r\nPART-TIME INSTRUCTOR DEPED - TEACHER III\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nMASTER IN INFORMATION TECHNOLOGY UNIT EARNER \r\nPROFESSIONAL EDUCATION & MASTER IN EDUCATION UNIT EARNER.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-06 15:34:42'),
(395, 67, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhat is COMSAI?\nCOMSAI is an AI-powered student information assistance chatbot designed to help users access information related to the College of Computer Studies (CCS) of Mabini Colleges, Inc.\n\n', 'legacy-sourced', '[{\"title\":\"General Information\",\"url\":\"\"}]', '2026-11-06 15:35:37'),
(397, 67, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nHow do I comply with an INC grade?\nA: The verified CCS/Mabini Colleges procedure for INC compliance is: \r\n1. Get the INC Form from the Registrar’s Office.\r\n2. Go to your professor and ask for the remaining requirements needed to complete your INC grade.\r\n3.Complete all missing requirements given by your professor.\r\n4.Have your professor sign the INC Form and submit the required grade or completion details.\r\n5.Return the INC Form to the Registrar’s Office for processing and updating of your grade.\n\n', 'legacy-sourced', '[{\"title\":\"Academic Procedures\",\"url\":\"\"}]', '2026-11-06 15:36:05'),
(399, 67, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nHow can I contact a CCS faculty member?\nYou can contact [faculty member] through [insert approved school email or official contact method]. COMSAI should only display contact details approved for public student use.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-06 15:37:38'),
(401, 67, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nHow can I contact a CCS faculty member?\nYou can contact [faculty member] through [insert approved school email or official contact method]. COMSAI should only display contact details approved for public student use.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-06 15:38:05'),
(403, 68, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-07 13:20:20'),
(405, 68, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nHow do I process a COG (Certificate of Grades)?\nComplete the Request Form: Secure and fill out the official request slip available at the Registrar\'s window. Provide your full name, student ID number, the specific academic year and semester, and the purpose of your request.\r\nInitial Processing: Submit the completed form to the Registrar\'s window for verification and for printing of your Certificate of Grades (COG).\r\nPayment: Proceed to the Cashier’s Office to pay the required processing fee for the COG.\r\nValidation and Stamping: Return to the Registrar’s Office with your printed COG and payment receipt. The staff will verify the document and apply the official school seal.\r\nCollection: Await instructions from the Registrar staff regarding the schedule and releasing process for your validated COG.\n\n', 'legacy-sourced', '[{\"title\":\"Academic Procedures\",\"url\":\"\"}]', '2026-11-07 13:20:42'),
(439, 71, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere can I find the CCS Dean?\nThe CCS Dean office may be reached at second floor, beside the President’s office . If the location or schedule is not listed, please contact the CCS office or CCS Council.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-09 01:11:48'),
(441, 71, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nHow can I contact a CCS faculty member?\nYou can contact [faculty member] through [insert approved school email or official contact method]. COMSAI should only display contact details approved for public student use.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-09 01:15:15'),
(445, 73, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Main Laboratory?\nThe Main Laboratory is located on the second floor, MRI Building, Room 207. If you cannot find it, ask the CCS office or a designated staff member.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 01:47:44'),
(447, 73, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nHow can I contact a CCS faculty member?\nYou can contact [faculty member] through [insert approved school email or official contact method]. COMSAI should only display contact details approved for public student use.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-09 01:48:10'),
(449, 73, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhat is COMSAI?\nCOMSAI is an AI-powered student information assistance chatbot designed to help users access information related to the College of Computer Studies (CCS) of Mabini Colleges, Inc.\n\n', 'legacy-sourced', '[{\"title\":\"General Information\",\"url\":\"\"}]', '2026-11-09 01:48:13'),
(451, 73, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 01:48:31'),
(453, 74, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-09 02:54:46'),
(455, 74, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 02:55:07'),
(457, 74, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-09 02:55:24'),
(459, 74, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWho are the CCS faculty members?\nThe current CCS faculty list is: ORGANIZATIONAL CHART FACULTY MEMBERS\r\n\r\nFRANK KIVEN B. ABLAO, LPT, MIS\r\nOIC - DEAN, CCS & MC TECH HEAD\r\nCIVIL SERVICE PROFESSIONAL TRAINER METHODOLOGY LEVEL 1.\r\nCOMPUTER PROGRAMMING NC IV, VISUAL GRAPHICS DESIGN NC III.\r\nAUTOMATIVE SERVICE (ENGINE REPAIR) NC II. ELECTRONIC PRODUCTS ASSEMBLY AND SERVICING NC II.\r\n\r\nCHRISTIAN DRIGON F. AGA, LPT, JD\r\nCCS ADMINISTRATOR, MIT (UNIT EARNER)\r\nBACHELOR OF ARTS IN ECONOMICS - POLYTECHNIC UNIVERSITY OF THE PHILIPPINES. CERTIFICATE IN COMPUTER EDUCATION - DE LA SALLE UNIVERSITY. CERTIFICATE IN TEACHING - PHILIPPINE NORMAL UNIVERSITY - MANILA \r\n\r\nEDCEL S. MARTINEZ\r\nHEAD, COMPUTER INTERNET LAB\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE.\r\nPROFESSIONAL EDUCATION, 2D ANIMATION NC III. \r\nCOMPUTER SYSTEM SERVICING NC II. VISUAL GRAPHICS DESIGN NCIII\r\n\r\nIAN GODWIN G. AGAPITO\r\nCCS INSTRUCTOR\r\nPROFESSIONAL EDUCATION\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\n\r\nAERON DAVE C. ENOVA, LPT, CRS, CAWS\r\nCCS CENTRAL COUNCIL ADVISER / PRACTICUM COORDINATOR / RESEARCH COORDINATOR \r\nMASTER OF SCIENCE IN COMPUTER SCIENCE (ONGOING) MASTERS OF SCIENCE IN INFORMATION TECHNOLOGY (27 UNITS), JURIS DOCTOR (04 UNITS).\r\nCERTIFIED ACADEMIC WRITING SPECIALIST, CERTIFIED RESEARCH SPECIALIST.\r\nCIVIL SERVICE PROFESSIONAL AND DATA ANALYST\r\n\r\nKEVIN-EZER F TANIERLA \r\nCCS INSTRUCTOR / SOFTWARE ENGINEER\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE. PROGRAMMING NC IV. ANIMATION NC III. MC PORTAL ENDEAVORS: DIGITAL ID, DIGITAL PERMIT, ATTENDANCE MONITORING SYSTEM, DIGITAL TICKETS\r\n\r\nJOHN EDDIE ABLAO\r\nSOFTWARE ENGINEER\r\nBACHELOR SCIENCE IN INFORMATION TECHNOLOGY\r\n\r\nJOHN VIRGEL LO\r\nSYSTEM ADMINISTRATOR\r\nBAACHELOR SCIENCE IN COMPUTER SCIENCE\r\n\r\nFERDINAND O. POSTRE\r\nTECHNICAL SUPPORT ASSISTANT\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nCOMPUTER SYSTEMS SERVICING NC II\r\n\r\nANNABEL DICHOSO NAGERA, LPT\r\nPART-TIME INSTRUCTOR DEPED - TEACHER III\r\nBACHELOR OF SCIENCE IN COMPUTER SCIENCE\r\nMASTER IN INFORMATION TECHNOLOGY UNIT EARNER \r\nPROFESSIONAL EDUCATION & MASTER IN EDUCATION UNIT EARNER.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-09 02:57:22'),
(461, 75, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nHow can I contact a CCS faculty member?\nYou can contact [faculty member] through [insert approved school email or official contact method]. COMSAI should only display contact details approved for public student use.\n\n', 'legacy-sourced', '[{\"title\":\"Faculty and Staff\",\"url\":\"\"}]', '2026-11-09 05:47:01'),
(545, 94, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 16:08:16'),
(547, 94, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\nWhere is the Main Laboratory?\nThe Main Laboratory is located on the second floor, MRI Building, Room 207. If you cannot find it, ask the CCS office or a designated staff member.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"},{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 16:08:29'),
(549, 94, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\nWhere is the Annex Laboratory?\nThe Annex Laboratory is located on the second floor, MRI Building, Room 203. If you cannot find it, ask the CCS office or a designated staff member.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"},{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 16:08:46'),
(551, 94, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\nWhere is the Annex Laboratory?\nThe Annex Laboratory is located on the second floor, MRI Building, Room 203. If you cannot find it, ask the CCS office or a designated staff member.\n\nWhere is the Main Laboratory?\nThe Main Laboratory is located on the second floor, MRI Building, Room 207. If you cannot find it, ask the CCS office or a designated staff member.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"},{\"title\":\"Rooms and Laboratories\",\"url\":\"\"},{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 16:09:01'),
(553, 94, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 16:09:12'),
(555, 94, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 16:09:27'),
(557, 94, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere is the Key Laboratory?\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\n', 'legacy-sourced', '[{\"title\":\"Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-09 16:09:35'),
(559, 94, 'assistant', 'There is no published information in this category yet. Please check back later or ask about another topic.', 'unverified', '[]', '2026-11-09 16:10:31');
INSERT INTO `chat_messages` (`id`, `chat_session_id`, `sender`, `message`, `response_mode`, `source_references`, `created_at`) VALUES
(561, 94, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere can I find the CCS class schedule?\nThe College of Computer Studies (CCS) class schedule is accessible through the school’s official student portal. Once logged in, students can view their complete course schedule, including the assigned subjects, class dates, times, room assignments, and the corresponding subject instructors.\n\n', 'legacy-sourced', '[{\"title\":\"Schedules and Important Dates\",\"url\":\"\"}]', '2026-11-09 16:10:38'),
(563, 94, 'assistant', 'Best matching knowledge-base result (not AI-generated):\n\nWhere can I find the CCS class schedule?\nThe College of Computer Studies (CCS) class schedule is accessible through the school’s official student portal. Once logged in, students can view their complete course schedule, including the assigned subjects, class dates, times, room assignments, and the corresponding subject instructors.\n\n', 'legacy-sourced', '[{\"title\":\"Schedules and Important Dates\",\"url\":\"\"}]', '2026-11-09 16:11:17'),
(611, 106, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-10 07:15:27'),
(613, 106, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-10 07:15:54'),
(821, 148, 'assistant', 'Here is all currently published information in Academic Procedures:\n\n**Who should I contact about an INC grade?**\nFor requirements or procedures for completing an INC grade, contact the professor handling that subject. See the INC-completion steps in the Academic Procedures information.\n\n**Where can I ask about my grades?**\nYou can view your official grades in the student portal. For concerns, questions, or clarification about a specific subject grade, use either of these options:\n\nInstitutional email: Contact the subject instructor using the official email address in the student portal directory.\n\nIn-person inquiry: Visit your subject instructor during scheduled office hours to discuss the grade.\n\n**How do I process a COG (Certificate of Grades)?**\nTo process a Certificate of Grades (COG):\n\n1. Request Form: Get the official request slip from the Registrar\'s window. Fill it out with your full name, student ID number, academic year, semester, and purpose.\n2. Initial Processing: Submit the completed form to the Registrar\'s window for verification and printing of your COG.\n3. Payment: Pay the required COG processing fee at the Cashier\'s Office.\n4. Validation and Stamping: Return to the Registrar\'s Office with the printed COG and payment receipt. Staff will verify the document and apply the official school seal.\n5. Collection: Follow the Registrar staff\'s instructions about the collection schedule and release of your validated COG.\n\n**How do I comply with an INC grade?**\nThe verified CCS/Mabini Colleges procedure for completing an INC grade is:\n\n1. Get the INC Form from the Registrar\'s Office.\n2. Ask your professor for the remaining requirements needed to complete your INC grade.\n3. Complete all missing requirements given by your professor.\n4. Have your professor sign the INC Form and submit the required grade or completion details.\n5. Return the INC Form to the Registrar\'s Office for processing and updating your grade.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-10 16:19:17'),
(897, 160, 'assistant', 'Hello! I’m COMSAI, your CCS Student Information Assistant. How may I help you today?', 'greeting', '[]', '2026-11-11 13:50:18'),
(899, 160, 'assistant', '**Can COMSAI confirm my personal academic or payment records?**\nCOMSAI can only provide information that is approved for its knowledge base. It should not disclose private grades, balances, passwords, or other personal records. Please contact the authorized school office for account-specific concerns.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Department Policies\",\"url\":\"\"}]', '2026-11-11 13:50:30'),
(928, 163, 'assistant', '**Who should I contact if my concern is not listed?**\nIf your concern is not covered by the available information, you may approach any CCS Central Council officer or contact the CCS Central Council Adviser, Sir Aeron Dave C. Enova, for proper assistance.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-12 13:57:10'),
(930, 163, 'assistant', '**Who should I contact if my concern is not listed?**\nIf your concern is not covered by the available information, you may approach any CCS Central Council officer or contact the CCS Central Council Adviser, Sir Aeron Dave C. Enova, for proper assistance.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-12 13:57:49'),
(932, 163, 'assistant', '**Who should I contact about my grades?**\nFor concerns regarding your grades in a specific subject, you should directly contact the professor handling that subject.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-12 14:19:29'),
(934, 163, 'assistant', '**Who should I contact about an INC grade?**\nFor requirements or procedures for completing an INC grade, contact the professor handling that subject. See the INC-completion steps in the Academic Procedures information.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-12 14:19:52'),
(936, 163, 'assistant', '**Who should I contact about my grades?**\nFor concerns regarding your grades in a specific subject, you should directly contact the professor handling that subject.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-12 14:20:17'),
(938, 163, 'assistant', '**How do I settle my portal balance?**\nIf you need help finding where to settle an outstanding balance shown in the student portal, approach any CCS Central Council officer or the CCS Central Council Adviser for guidance. For account-specific balances or payment issues, contact the authorized school office. Do not share passwords or other sensitive payment details in COMSAI.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-12 14:38:59'),
(940, 163, 'assistant', '**Where can I get the clearance form?**\nThe semester clearance form is available from the Property Custodian. One form is issued for each student.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Requirements\",\"url\":\"\"}]', '2026-11-12 14:44:29'),
(954, 165, 'assistant', '**What information can I ask COMSAI about?**\nYou can ask about CCS faculty and officers, rooms and laboratories, announcements, and department-related academic processes. If information is not available, COMSAI will direct you to the appropriate CCS personnel.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - General Information\",\"url\":\"\"}]', '2026-11-13 11:06:34'),
(956, 165, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-13 11:07:09'),
(1143, 225, 'assistant', 'Hello! I’m COMSAI, your CCS Student Information Assistant. How may I help you today?', 'greeting', '[]', '2026-11-16 15:56:32'),
(1199, 244, 'student', 'can i ask about not ccs department related?', NULL, NULL, '2026-11-17 04:43:18'),
(1200, 244, 'assistant', '**What information can I ask COMSAI about?**\nYou can ask about CCS faculty and officers, rooms and laboratories, announcements, and department-related academic processes. If information is not available, COMSAI will direct you to the appropriate CCS personnel.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - General Information\",\"url\":\"\"}]', '2026-11-17 04:43:18'),
(1201, 244, 'student', 'can i raise a concern in mabini colleges?', NULL, NULL, '2026-11-17 04:43:50'),
(1202, 244, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-17 04:43:50'),
(1203, 244, 'student', 'is the dean available today?', NULL, NULL, '2026-11-17 04:44:13'),
(1204, 244, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-17 04:44:13'),
(1205, 244, 'student', 'where can i locate dean\'s office?', NULL, NULL, '2026-11-17 04:44:35'),
(1206, 244, 'assistant', '**Where can I find the CCS Dean?**\nThe CCS Dean office is on the second floor, beside the President\'s office. Ask the CCS office or CCS Council to confirm the Dean\'s schedule.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Faculty and Staff\",\"url\":\"\"}]', '2026-11-17 04:44:35'),
(1207, 244, 'student', 'how about sir aga\'s office?', NULL, NULL, '2026-11-17 04:46:06'),
(1208, 244, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-17 04:46:06'),
(1209, 244, 'student', 'where is the ccs council office?', NULL, NULL, '2026-11-17 04:46:26'),
(1210, 244, 'assistant', '**Where can I find the CCS Dean?**\nThe CCS Dean office is on the second floor, beside the President\'s office. Ask the CCS office or CCS Council to confirm the Dean\'s schedule.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Faculty and Staff\",\"url\":\"\"}]', '2026-11-17 04:46:26'),
(1211, 244, 'student', 'ccs council officer\'s office', NULL, NULL, '2026-11-17 04:46:54'),
(1212, 244, 'assistant', '**How do I settle my portal balance?**\nIf you need help finding where to settle an outstanding balance shown in the student portal, approach any CCS Central Council officer or the CCS Central Council Adviser for guidance. For account-specific balances or payment issues, contact the authorized school office. Do not share passwords or other sensitive payment details in COMSAI.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-17 04:46:54'),
(1213, 244, 'student', 'Rooms and Laboratories', NULL, NULL, '2026-11-17 04:47:44'),
(1214, 244, 'assistant', 'Here is all currently published information in Rooms and Laboratories:\n\n**Where is the Key Laboratory?**\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\n**Where is the Annex Laboratory?**\nThe Annex Laboratory is located on the second floor, MRI Building, Room 203. If you cannot find it, ask the CCS office or a designated staff member.\n\n**Where is the Main Laboratory?**\nThe Main Laboratory is located on the second floor, MRI Building, Room 207. If you cannot find it, ask the CCS office or a designated staff member.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-17 04:47:44'),
(1215, 244, 'student', 'CCS Council Officers', NULL, NULL, '2026-11-17 04:47:47'),
(1216, 244, 'assistant', 'Here is all currently published information in CCS Council Officers:\n\n**Where can I pay my department fee?**\nYou may pay your department fee through the authorized GCash payment channels of the CCS Central Council:\r\n\r\nGCash – Executive Treasurer\r\nName: Miss Renalyn Ubalde\r\nPosition: Executive Treasurer, CCS Central Council\r\nNumber: 0907 919 2632\r\n\r\nGCash – Deputy Treasurer\r\nName: Miss Anika Kaye Arjite\r\nPosition: Deputy Treasurer, CCS Central Council\r\nNumber: 0967 188 7631\n\n**Who can help with a CCS concern that is not listed?**\nIf your CCS concern is not covered in the available information, approach a CCS Central Council officer or contact the CCS Central Council Adviser, Sir Aeron Dave C. Enova.\n\n**How can I check if my name is on the department shirt list?**\nContact CCS Central Council Secretaries Lorren Joyce L. Erandio or Abiegail T. Rellermo to check whether your name is on the department-shirt list. Their Facebook accounts are https://facebook.com/eljeixcm and https://facebook.com/aviezx.\n\n**Who can I contact about department shirt concerns?**\nFor department-shirt updates, contact the CCS Central Council Secretaries:\r\n\r\nAssistant Secretary Lorren Joyce L. Erandio: https://facebook.com/eljeixcm\r\nExecutive Secretary Abiegail T. Rellermo: https://facebook.com/aviezx\n\n**How can I pay the CCS department fee?**\nThe dataset lists the CCS department fee as 1,400 pesos. It lists these authorized CCS Central Council GCash channels:\r\n\r\nExecutive Treasurer Renalyn Ubalde: 0907 919 2632\r\nDeputy Treasurer Anika Kaye Arjite: 0967 188 7631\r\n\r\nConfirm the amount and payment details through the official CCS announcement channel before sending money.\n\n**Who should I contact about department fee payments?**\nFor department-fee payment questions, contact the CCS Central Council Treasurers through their Facebook accounts:\r\n\r\nChief Treasurer Renalyn T. Ubalde: https://facebook.com/ena.ubalde\r\nDeputy Treasurer Anika Kaye E. Arjite: https://facebook.com/anika.kaye.19\n\n**Who is the current CCS Governor?**\nThe current CCS Governor for Academic Year 2026–2027 is Ms. Selene E. Tychingco.\n\n**CCS Central Council Officers**\nThe College of Computer Studies Central Council Officers for Academic Year 2026–2027\r\n\r\nGovernor: Selene E. Tychingco\r\nVice Governor – Internal: Angel Ayessa O. Cacho\r\nVice Governor – External: Giedhell Ann M. Serrano\r\nExecutive Secretary: Abiegail T. Rellermo\r\nAssistant Secretary: Lorren Joyce L. Erandio\r\nChief Treasurer: Renalyn T. Ubalde\r\nDeputy Treasurer: Anika Kaye E. Arjite\r\nAuditor: Renz Darrel O. Gomez\r\nChief Peace Officer: Justine D. Canaria\r\nDeputy Peace Officer: Jose Russel M. Cabunias\r\nDeputy Peace Officer: John Kevin B. Abogado\r\nChief Communication and Media Officer: John Bernard C. De Leon\r\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\r\nCommunication and Media Officer: Shalom Emannuel M. Abiera\r\nCommunication and Media Officer: Richard A. Boribor\r\nCommunication and Media Officer: Condrad Jaimar G. Sale\r\nCommunication and Media Officer: Candice Fine Y. Montemayor\r\nFourth Year Representative: Eya Mae R. Bana\r\nThird Year Representative: Gian Carlo D. Bacia\r\nSecond Year Representative: Chelsey Joelle B. Esguerra\r\nFirst Year Representative: John Mark N. Molina\r\nFirst Year Representative: Mark Zedrix Zantua\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - CCS Council Officers\",\"url\":\"\"}]', '2026-11-17 04:47:47'),
(1217, 244, 'student', 'Rooms and Laboratories', NULL, NULL, '2026-11-17 04:47:50'),
(1218, 244, 'assistant', 'Here is all currently published information in Rooms and Laboratories:\n\n**Where is the Key Laboratory?**\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\n**Where is the Annex Laboratory?**\nThe Annex Laboratory is located on the second floor, MRI Building, Room 203. If you cannot find it, ask the CCS office or a designated staff member.\n\n**Where is the Main Laboratory?**\nThe Main Laboratory is located on the second floor, MRI Building, Room 207. If you cannot find it, ask the CCS office or a designated staff member.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-17 04:47:50'),
(1219, 244, 'student', 'CCS Council Officers', NULL, NULL, '2026-11-17 04:47:51'),
(1220, 244, 'assistant', 'Here is all currently published information in CCS Council Officers:\n\n**Where can I pay my department fee?**\nYou may pay your department fee through the authorized GCash payment channels of the CCS Central Council:\r\n\r\nGCash – Executive Treasurer\r\nName: Miss Renalyn Ubalde\r\nPosition: Executive Treasurer, CCS Central Council\r\nNumber: 0907 919 2632\r\n\r\nGCash – Deputy Treasurer\r\nName: Miss Anika Kaye Arjite\r\nPosition: Deputy Treasurer, CCS Central Council\r\nNumber: 0967 188 7631\n\n**Who can help with a CCS concern that is not listed?**\nIf your CCS concern is not covered in the available information, approach a CCS Central Council officer or contact the CCS Central Council Adviser, Sir Aeron Dave C. Enova.\n\n**How can I check if my name is on the department shirt list?**\nContact CCS Central Council Secretaries Lorren Joyce L. Erandio or Abiegail T. Rellermo to check whether your name is on the department-shirt list. Their Facebook accounts are https://facebook.com/eljeixcm and https://facebook.com/aviezx.\n\n**Who can I contact about department shirt concerns?**\nFor department-shirt updates, contact the CCS Central Council Secretaries:\r\n\r\nAssistant Secretary Lorren Joyce L. Erandio: https://facebook.com/eljeixcm\r\nExecutive Secretary Abiegail T. Rellermo: https://facebook.com/aviezx\n\n**How can I pay the CCS department fee?**\nThe dataset lists the CCS department fee as 1,400 pesos. It lists these authorized CCS Central Council GCash channels:\r\n\r\nExecutive Treasurer Renalyn Ubalde: 0907 919 2632\r\nDeputy Treasurer Anika Kaye Arjite: 0967 188 7631\r\n\r\nConfirm the amount and payment details through the official CCS announcement channel before sending money.\n\n**Who should I contact about department fee payments?**\nFor department-fee payment questions, contact the CCS Central Council Treasurers through their Facebook accounts:\r\n\r\nChief Treasurer Renalyn T. Ubalde: https://facebook.com/ena.ubalde\r\nDeputy Treasurer Anika Kaye E. Arjite: https://facebook.com/anika.kaye.19\n\n**Who is the current CCS Governor?**\nThe current CCS Governor for Academic Year 2026–2027 is Ms. Selene E. Tychingco.\n\n**CCS Central Council Officers**\nThe College of Computer Studies Central Council Officers for Academic Year 2026–2027\r\n\r\nGovernor: Selene E. Tychingco\r\nVice Governor – Internal: Angel Ayessa O. Cacho\r\nVice Governor – External: Giedhell Ann M. Serrano\r\nExecutive Secretary: Abiegail T. Rellermo\r\nAssistant Secretary: Lorren Joyce L. Erandio\r\nChief Treasurer: Renalyn T. Ubalde\r\nDeputy Treasurer: Anika Kaye E. Arjite\r\nAuditor: Renz Darrel O. Gomez\r\nChief Peace Officer: Justine D. Canaria\r\nDeputy Peace Officer: Jose Russel M. Cabunias\r\nDeputy Peace Officer: John Kevin B. Abogado\r\nChief Communication and Media Officer: John Bernard C. De Leon\r\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\r\nCommunication and Media Officer: Shalom Emannuel M. Abiera\r\nCommunication and Media Officer: Richard A. Boribor\r\nCommunication and Media Officer: Condrad Jaimar G. Sale\r\nCommunication and Media Officer: Candice Fine Y. Montemayor\r\nFourth Year Representative: Eya Mae R. Bana\r\nThird Year Representative: Gian Carlo D. Bacia\r\nSecond Year Representative: Chelsey Joelle B. Esguerra\r\nFirst Year Representative: John Mark N. Molina\r\nFirst Year Representative: Mark Zedrix Zantua\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - CCS Council Officers\",\"url\":\"\"}]', '2026-11-17 04:47:51'),
(1221, 244, 'student', 'who is the ccs dean', NULL, NULL, '2026-11-17 04:48:18'),
(1222, 244, 'assistant', '**Who is the CCS Dean?**\nThe OIC Dean of the College of Computer Studies is Sir Frank Kiven B. Ablao. He is also the Technical Head of Mabini Colleges, a Licensed Professional Teacher, and a Civil Service Professional.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Faculty and Staff\",\"url\":\"\"}]', '2026-11-17 04:48:18'),
(1223, 244, 'student', 'who is the dean of the cbaa department', NULL, NULL, '2026-11-17 04:48:37'),
(1224, 244, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-17 04:48:37'),
(1225, 244, 'student', 'what are the department policies', NULL, NULL, '2026-11-17 05:10:51'),
(1226, 244, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-17 05:10:51'),
(1227, 244, 'student', 'Department Policies', NULL, NULL, '2026-11-17 05:10:53'),
(1228, 244, 'assistant', 'Here is all currently published information in Department Policies:\n\n**Can COMSAI confirm my personal academic or payment records?**\nCOMSAI can only provide information that is approved for its knowledge base. It should not disclose private grades, balances, passwords, or other personal records. Please contact the authorized school office for account-specific concerns.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Department Policies\",\"url\":\"\"}]', '2026-11-17 05:10:53'),
(1229, 244, 'student', 'Announcements and Activities', NULL, NULL, '2026-11-17 05:11:02'),
(1230, 244, 'assistant', '**CCS Department Fee Payment Options - 1,400 pesos**\n\nThe CCS department fee listed in this announcement is 1,400 pesos. To pay the CCS department fee, use one of the authorized CCS Central Council GCash channels below:\r\n\r\nExecutive Treasurer Renalyn Ubalde: 0907 919 2632\r\nDeputy Treasurer Anika Kaye Arjite: 0967 188 7631\r\n\r\nPlease confirm the amount and payment details through the official CCS Facebook page or approved CCS communication channel before sending money.', 'announcement', '[{\"title\":\"Official CCS announcement\",\"url\":\"\"}]', '2026-11-17 05:11:02'),
(1231, 244, 'student', 'Academic Requirements', NULL, NULL, '2026-11-17 05:11:04'),
(1232, 244, 'assistant', 'Here is all currently published information in Academic Requirements:\n\n**Where can I get the clearance form?**\nThe semester clearance form is available from the Property Custodian. One form is issued for each student.\n\n**What are the requirements for the semester clearance?**\nThe dataset lists these semester-clearance requirements: no pending payments, such as the departmental fee, and no pending obligations for activities. Confirm any additional or updated requirements with the office responsible for clearance.\n\n**How many times is clearance done in one academic year?**\nClearance is done twice in one academic year: once for the First Semester and once for the Second Semester.\n\n**When is the clearance processed?**\nSemester clearance is processed at the end of each semester, before the semester officially closes.\n\n**What is the clearance for the end of the semester?**\nSemester clearance is a process completed at the end of each semester. It confirms that a student has no pending obligations or accountabilities with school offices and departments.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Requirements\",\"url\":\"\"}]', '2026-11-17 05:11:04'),
(1233, 244, 'student', 'Academic Requirements', NULL, NULL, '2026-11-17 05:11:12'),
(1234, 244, 'assistant', 'Here is all currently published information in Academic Requirements:\n\n**Where can I get the clearance form?**\nThe semester clearance form is available from the Property Custodian. One form is issued for each student.\n\n**What are the requirements for the semester clearance?**\nThe dataset lists these semester-clearance requirements: no pending payments, such as the departmental fee, and no pending obligations for activities. Confirm any additional or updated requirements with the office responsible for clearance.\n\n**How many times is clearance done in one academic year?**\nClearance is done twice in one academic year: once for the First Semester and once for the Second Semester.\n\n**When is the clearance processed?**\nSemester clearance is processed at the end of each semester, before the semester officially closes.\n\n**What is the clearance for the end of the semester?**\nSemester clearance is a process completed at the end of each semester. It confirms that a student has no pending obligations or accountabilities with school offices and departments.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Requirements\",\"url\":\"\"}]', '2026-11-17 05:11:12'),
(1235, 244, 'student', 'Academic Procedures', NULL, NULL, '2026-11-17 05:11:21'),
(1236, 244, 'assistant', 'Here is all currently published information in Academic Procedures:\n\n**Who should I contact if my concern is not listed?**\nIf your concern is not covered by the available information, you may approach any CCS Central Council officer or contact the CCS Central Council Adviser, Sir Aeron Dave C. Enova, for proper assistance.\n\n**Who should I contact if I have an INC grade?**\nFor concerns regarding an INC grade, contact the professor handling the subject to ask about the requirements and procedures for completing your INC.\n\n**Who should I contact about my grades?**\nFor concerns regarding your grades in a specific subject, you should directly contact the professor handling that subject.\n\n**Who should I contact about an INC grade?**\nFor requirements or procedures for completing an INC grade, contact the professor handling that subject. See the INC-completion steps in the Academic Procedures information.\n\n**How do I settle my portal balance?**\nIf you need help finding where to settle an outstanding balance shown in the student portal, approach any CCS Central Council officer or the CCS Central Council Adviser for guidance. For account-specific balances or payment issues, contact the authorized school office. Do not share passwords or other sensitive payment details in COMSAI.\n\n**Where can I ask about my grades?**\nYou can view your official grades in the student portal. For concerns, questions, or clarification about a specific subject grade, use either of these options:\r\n\r\nInstitutional email: Contact the subject instructor using the official email address in the student portal directory.\r\n\r\nIn-person inquiry: Visit your subject instructor during scheduled office hours to discuss the grade.\n\n**How do I process a COG (Certificate of Grades)?**\nTo process a Certificate of Grades (COG):\r\n\r\n1. Request Form: Get the official request slip from the Registrar\'s window. Fill it out with your full name, student ID number, academic year, semester, and purpose.\r\n2. Initial Processing: Submit the completed form to the Registrar\'s window for verification and printing of your COG.\r\n3. Payment: Pay the required COG processing fee at the Cashier\'s Office.\r\n4. Validation and Stamping: Return to the Registrar\'s Office with the printed COG and payment receipt. Staff will verify the document and apply the official school seal.\r\n5. Collection: Follow the Registrar staff\'s instructions about the collection schedule and release of your validated COG.\n\n**How do I comply with an INC grade?**\nThe verified CCS/Mabini Colleges procedure for completing an INC grade is:\r\n\r\n1. Get the INC Form from the Registrar\'s Office.\r\n2. Ask your professor for the remaining requirements needed to complete your INC grade.\r\n3. Complete all missing requirements given by your professor.\r\n4. Have your professor sign the INC Form and submit the required grade or completion details.\r\n5. Return the INC Form to the Registrar\'s Office for processing and updating your grade.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-17 05:11:21'),
(1237, 244, 'student', 'Department Policies', NULL, NULL, '2026-11-17 05:14:34'),
(1238, 244, 'assistant', 'Here is all currently published information in Department Policies:\n\n**Can COMSAI confirm my personal academic or payment records?**\nCOMSAI can only provide information that is approved for its knowledge base. It should not disclose private grades, balances, passwords, or other personal records. Please contact the authorized school office for account-specific concerns.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Department Policies\",\"url\":\"\"}]', '2026-11-17 05:14:34'),
(1239, 244, 'student', 'okay thank you', NULL, NULL, '2026-11-17 05:15:37'),
(1240, 244, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-17 05:15:37'),
(1241, 244, 'student', 'thank you', NULL, NULL, '2026-11-17 05:30:43'),
(1242, 244, 'assistant', 'You’re welcome! Let me know if you have any other questions.', 'greeting', '[]', '2026-11-17 05:30:43'),
(1246, 247, 'student', 'Who are the CCS faculty members and Council officers?', NULL, NULL, '2026-11-17 09:36:24'),
(1247, 247, 'assistant', '**Who are the CCS faculty members?**\nThe current CCS faculty and staff listed in the COMSAI dataset are:\r\n\r\n1. Frank Kiven B. Ablao, LPT, MIS\r\nPosition: OIC Dean, CCS and MC Technical Head.\r\nQualifications: Civil Service Professional; Trainer Methodology Level 1; Computer Programming NC IV; Visual Graphics Design NC III; Automotive Service (Engine Repair) NC II; Electronic Products Assembly and Servicing NC II.\r\n\r\n2. Christian Drigon F. Aga, LPT, JD\r\nPosition: CCS Administrator, MIT (Unit Earner).\r\nEducation: Bachelor of Arts in Economics, Polytechnic University of the Philippines; Certificate in Computer Education, De La Salle University; Certificate in Teaching, Philippine Normal University - Manila.\r\n\r\n3. Edcel S. Martinez\r\nPosition: Head, Computer Internet Lab.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Professional Education; 2D Animation NC III; Computer Systems Servicing NC II; Visual Graphics Design NC III.\r\n\r\n4. Ian Godwin G. Agapito\r\nPosition: CCS Instructor.\r\nEducation and qualifications: Professional Education; Bachelor of Science in Computer Science.\r\n\r\n5. Aeron Dave C. Enova, LPT, CRS, CAWS\r\nPositions: CCS Central Council Adviser, Practicum Coordinator, and Research Coordinator.\r\nEducation and qualifications: Master of Science in Computer Science (ongoing); Master of Science in Information Technology (27 units); Juris Doctor (64 units); Certified Academic Writing Specialist; Certified Research Specialist; Civil Service Professional; Data Analyst.\r\n\r\n6. Kevin-Ezer F. Tanierla\r\nPosition: CCS Instructor and Software Engineer.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Programming NC IV; Animation NC III.\r\nMC Portal projects: Digital ID, Digital Permit, Attendance Monitoring System, and Digital Tickets.\r\n\r\n7. John Eddie Ablao\r\nPosition: Software Engineer.\r\nEducation: Bachelor of Science in Information Technology.\r\n\r\n8. John Virgel Lo\r\nPosition: System Administrator.\r\nEducation: Bachelor of Science in Computer Science.\r\n\r\n9. Ferdinand O. Postre\r\nPosition: Technical Support Assistant.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Computer Systems Servicing NC II.\r\n\r\n10. Annabel Dichoso Nagera, LPT\r\nPosition: Part-Time Instructor; DepEd Teacher III.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Master in Information Technology (Unit Earner); Professional Education; Master in Education (Unit Earner).\n\n**CCS Central Council Officers**\nThe College of Computer Studies Central Council Officers for Academic Year 2026–2027\r\n\r\nGovernor: Selene E. Tychingco\r\nVice Governor – Internal: Angel Ayessa O. Cacho\r\nVice Governor – External: Giedhell Ann M. Serrano\r\nExecutive Secretary: Abiegail T. Rellermo\r\nAssistant Secretary: Lorren Joyce L. Erandio\r\nChief Treasurer: Renalyn T. Ubalde\r\nDeputy Treasurer: Anika Kaye E. Arjite\r\nAuditor: Renz Darrel O. Gomez\r\nChief Peace Officer: Justine D. Canaria\r\nDeputy Peace Officer: Jose Russel M. Cabunias\r\nDeputy Peace Officer: John Kevin B. Abogado\r\nChief Communication and Media Officer: John Bernard C. De Leon\r\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\r\nCommunication and Media Officer: Shalom Emannuel M. Abiera\r\nCommunication and Media Officer: Richard A. Boribor\r\nCommunication and Media Officer: Condrad Jaimar G. Sale\r\nCommunication and Media Officer: Candice Fine Y. Montemayor\r\nFourth Year Representative: Eya Mae R. Bana\r\nThird Year Representative: Gian Carlo D. Bacia\r\nSecond Year Representative: Chelsey Joelle B. Esguerra\r\nFirst Year Representative: John Mark N. Molina\r\nFirst Year Representative: Mark Zedrix Zantua\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Faculty and Staff\",\"url\":\"\"},{\"title\":\"COMSAI Dataset - CCS Council Officers\",\"url\":\"\"}]', '2026-11-17 09:36:24'),
(1286, 261, 'student', 'hello comsai', NULL, NULL, '2026-11-17 14:42:55'),
(1287, 261, 'assistant', 'Hello! I’m COMSAI, your CCS Student Information Assistant. How may I help you today?', 'greeting', '[]', '2026-11-17 14:42:55'),
(1290, 263, 'student', 'hello', NULL, NULL, '2026-11-17 14:54:05'),
(1291, 263, 'assistant', 'Hello! I’m COMSAI, your CCS Student Information Assistant. How may I help you today?', 'greeting', '[]', '2026-11-17 14:54:05'),
(1316, 266, 'student', 'department policies', NULL, NULL, '2026-11-17 15:30:45'),
(1317, 266, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-17 15:30:45'),
(1318, 266, 'student', 'Department Policies', NULL, NULL, '2026-11-17 15:30:46'),
(1319, 266, 'assistant', 'Here is all currently published information in Department Policies:\n\n**Can COMSAI confirm my personal academic or payment records?**\nCOMSAI can only provide information that is approved for its knowledge base. It should not disclose private grades, balances, passwords, or other personal records. Please contact the authorized school office for account-specific concerns.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Department Policies\",\"url\":\"\"}]', '2026-11-17 15:30:46'),
(1320, 266, 'student', 'what is the latest announcement', NULL, NULL, '2026-11-17 15:30:59'),
(1321, 266, 'assistant', '**CCS Department Fee Payment Options - 1,400 pesos**\n\nThe CCS department fee listed in this announcement is 1,400 pesos. To pay the CCS department fee, use one of the authorized CCS Central Council GCash channels below:\r\n\r\nExecutive Treasurer Renalyn Ubalde: 0907 919 2632\r\nDeputy Treasurer Anika Kaye Arjite: 0967 188 7631\r\n\r\nPlease confirm the amount and payment details through the official CCS Facebook page or approved CCS communication channel before sending money.', 'announcement', '[{\"title\":\"Official CCS announcement\",\"url\":\"\"}]', '2026-11-17 15:30:59'),
(1322, 266, 'student', 'where is the dean office', NULL, NULL, '2026-11-17 15:31:16'),
(1323, 266, 'assistant', '**Where can I find the CCS Dean?**\nThe CCS Dean office is on the second floor, beside the President\'s office. Ask the CCS office or CCS Council to confirm the Dean\'s schedule.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Faculty and Staff\",\"url\":\"\"}]', '2026-11-17 15:31:16'),
(1324, 266, 'student', 'is there an office for ccs council officers?', NULL, NULL, '2026-11-17 15:31:41'),
(1325, 266, 'assistant', '**How do I settle my portal balance?**\nIf you need help finding where to settle an outstanding balance shown in the student portal, approach any CCS Central Council officer or the CCS Central Council Adviser for guidance. For account-specific balances or payment issues, contact the authorized school office. Do not share passwords or other sensitive payment details in COMSAI.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-17 15:31:41'),
(1326, 266, 'student', 'can i ask something', NULL, NULL, '2026-11-17 15:48:49'),
(1327, 266, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-17 15:48:49'),
(1328, 266, 'student', 'who are the faculty and staffs', NULL, NULL, '2026-11-17 15:54:36'),
(1329, 266, 'assistant', '**Who are the CCS faculty members?**\nThe current CCS faculty and staff listed in the COMSAI dataset are:\r\n\r\n1. Frank Kiven B. Ablao, LPT, MIS\r\nPosition: OIC Dean, CCS and MC Technical Head.\r\nQualifications: Civil Service Professional; Trainer Methodology Level 1; Computer Programming NC IV; Visual Graphics Design NC III; Automotive Service (Engine Repair) NC II; Electronic Products Assembly and Servicing NC II.\r\n\r\n2. Christian Drigon F. Aga, LPT, JD\r\nPosition: CCS Administrator, MIT (Unit Earner).\r\nEducation: Bachelor of Arts in Economics, Polytechnic University of the Philippines; Certificate in Computer Education, De La Salle University; Certificate in Teaching, Philippine Normal University - Manila.\r\n\r\n3. Edcel S. Martinez\r\nPosition: Head, Computer Internet Lab.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Professional Education; 2D Animation NC III; Computer Systems Servicing NC II; Visual Graphics Design NC III.\r\n\r\n4. Ian Godwin G. Agapito\r\nPosition: CCS Instructor.\r\nEducation and qualifications: Professional Education; Bachelor of Science in Computer Science.\r\n\r\n5. Aeron Dave C. Enova, LPT, CRS, CAWS\r\nPositions: CCS Central Council Adviser, Practicum Coordinator, and Research Coordinator.\r\nEducation and qualifications: Master of Science in Computer Science (ongoing); Master of Science in Information Technology (27 units); Juris Doctor (64 units); Certified Academic Writing Specialist; Certified Research Specialist; Civil Service Professional; Data Analyst.\r\n\r\n6. Kevin-Ezer F. Tanierla\r\nPosition: CCS Instructor and Software Engineer.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Programming NC IV; Animation NC III.\r\nMC Portal projects: Digital ID, Digital Permit, Attendance Monitoring System, and Digital Tickets.\r\n\r\n7. John Eddie Ablao\r\nPosition: Software Engineer.\r\nEducation: Bachelor of Science in Information Technology.\r\n\r\n8. John Virgel Lo\r\nPosition: System Administrator.\r\nEducation: Bachelor of Science in Computer Science.\r\n\r\n9. Ferdinand O. Postre\r\nPosition: Technical Support Assistant.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Computer Systems Servicing NC II.\r\n\r\n10. Annabel Dichoso Nagera, LPT\r\nPosition: Part-Time Instructor; DepEd Teacher III.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Master in Information Technology (Unit Earner); Professional Education; Master in Education (Unit Earner).\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Faculty and Staff\",\"url\":\"\"}]', '2026-11-17 15:54:36'),
(1330, 266, 'student', 'can i ask about inc grade?', NULL, NULL, '2026-11-17 15:54:57'),
(1331, 266, 'assistant', '**Who should I contact if I have an INC grade?**\nFor concerns regarding an INC grade, contact the professor handling the subject to ask about the requirements and procedures for completing your INC.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-17 15:54:57'),
(1332, 266, 'student', 'how to comply inc grades', NULL, NULL, '2026-11-17 15:55:38'),
(1333, 266, 'assistant', '**How do I comply with an INC grade?**\nThe verified CCS/Mabini Colleges procedure for completing an INC grade is:\r\n\r\n1. Get the INC Form from the Registrar\'s Office.\r\n2. Ask your professor for the remaining requirements needed to complete your INC grade.\r\n3. Complete all missing requirements given by your professor.\r\n4. Have your professor sign the INC Form and submit the required grade or completion details.\r\n5. Return the INC Form to the Registrar\'s Office for processing and updating your grade.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-17 15:55:38'),
(1334, 267, 'student', 'Who are the CCS faculty members and Council officers?', NULL, NULL, '2026-11-17 16:41:32'),
(1335, 267, 'assistant', '**Who are the CCS faculty members?**\nThe current CCS faculty and staff listed in the COMSAI dataset are:\r\n\r\n1. Frank Kiven B. Ablao, LPT, MIS\r\nPosition: OIC Dean, CCS and MC Technical Head.\r\nQualifications: Civil Service Professional; Trainer Methodology Level 1; Computer Programming NC IV; Visual Graphics Design NC III; Automotive Service (Engine Repair) NC II; Electronic Products Assembly and Servicing NC II.\r\n\r\n2. Christian Drigon F. Aga, LPT, JD\r\nPosition: CCS Administrator, MIT (Unit Earner).\r\nEducation: Bachelor of Arts in Economics, Polytechnic University of the Philippines; Certificate in Computer Education, De La Salle University; Certificate in Teaching, Philippine Normal University - Manila.\r\n\r\n3. Edcel S. Martinez\r\nPosition: Head, Computer Internet Lab.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Professional Education; 2D Animation NC III; Computer Systems Servicing NC II; Visual Graphics Design NC III.\r\n\r\n4. Ian Godwin G. Agapito\r\nPosition: CCS Instructor.\r\nEducation and qualifications: Professional Education; Bachelor of Science in Computer Science.\r\n\r\n5. Aeron Dave C. Enova, LPT, CRS, CAWS\r\nPositions: CCS Central Council Adviser, Practicum Coordinator, and Research Coordinator.\r\nEducation and qualifications: Master of Science in Computer Science (ongoing); Master of Science in Information Technology (27 units); Juris Doctor (64 units); Certified Academic Writing Specialist; Certified Research Specialist; Civil Service Professional; Data Analyst.\r\n\r\n6. Kevin-Ezer F. Tanierla\r\nPosition: CCS Instructor and Software Engineer.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Programming NC IV; Animation NC III.\r\nMC Portal projects: Digital ID, Digital Permit, Attendance Monitoring System, and Digital Tickets.\r\n\r\n7. John Eddie Ablao\r\nPosition: Software Engineer.\r\nEducation: Bachelor of Science in Information Technology.\r\n\r\n8. John Virgel Lo\r\nPosition: System Administrator.\r\nEducation: Bachelor of Science in Computer Science.\r\n\r\n9. Ferdinand O. Postre\r\nPosition: Technical Support Assistant.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Computer Systems Servicing NC II.\r\n\r\n10. Annabel Dichoso Nagera, LPT\r\nPosition: Part-Time Instructor; DepEd Teacher III.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Master in Information Technology (Unit Earner); Professional Education; Master in Education (Unit Earner).\n\n**CCS Central Council Officers**\nThe College of Computer Studies Central Council Officers for Academic Year 2026–2027\r\n\r\nGovernor: Selene E. Tychingco\r\nVice Governor – Internal: Angel Ayessa O. Cacho\r\nVice Governor – External: Giedhell Ann M. Serrano\r\nExecutive Secretary: Abiegail T. Rellermo\r\nAssistant Secretary: Lorren Joyce L. Erandio\r\nChief Treasurer: Renalyn T. Ubalde\r\nDeputy Treasurer: Anika Kaye E. Arjite\r\nAuditor: Renz Darrel O. Gomez\r\nChief Peace Officer: Justine D. Canaria\r\nDeputy Peace Officer: Jose Russel M. Cabunias\r\nDeputy Peace Officer: John Kevin B. Abogado\r\nChief Communication and Media Officer: John Bernard C. De Leon\r\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\r\nCommunication and Media Officer: Shalom Emannuel M. Abiera\r\nCommunication and Media Officer: Richard A. Boribor\r\nCommunication and Media Officer: Condrad Jaimar G. Sale\r\nCommunication and Media Officer: Candice Fine Y. Montemayor\r\nFourth Year Representative: Eya Mae R. Bana\r\nThird Year Representative: Gian Carlo D. Bacia\r\nSecond Year Representative: Chelsey Joelle B. Esguerra\r\nFirst Year Representative: John Mark N. Molina\r\nFirst Year Representative: Mark Zedrix Zantua\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Faculty and Staff\",\"url\":\"\"},{\"title\":\"COMSAI Dataset - CCS Council Officers\",\"url\":\"\"}]', '2026-11-17 16:41:32'),
(1336, 267, 'student', 'who is the dean of the ccs and where can i locate the dean?', NULL, NULL, '2026-11-17 16:42:29'),
(1337, 267, 'assistant', '**Who is the CCS Dean?**\nThe OIC Dean of the College of Computer Studies is Sir Frank Kiven B. Ablao. He is also the Technical Head of Mabini Colleges, a Licensed Professional Teacher, and a Civil Service Professional.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Faculty and Staff\",\"url\":\"\"}]', '2026-11-17 16:42:29'),
(1338, 267, 'student', 'who is the dean of the ccs and where can i locate the dean office?', NULL, NULL, '2026-11-17 16:43:04'),
(1339, 267, 'assistant', '**Where can I find the CCS Dean?**\nThe CCS Dean office is on the second floor, beside the President\'s office. Ask the CCS office or CCS Council to confirm the Dean\'s schedule.\n\n**Who is the CCS Dean?**\nThe OIC Dean of the College of Computer Studies is Sir Frank Kiven B. Ablao. He is also the Technical Head of Mabini Colleges, a Licensed Professional Teacher, and a Civil Service Professional.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Faculty and Staff\",\"url\":\"\"}]', '2026-11-17 16:43:04'),
(1367, 272, 'student', 'hello', NULL, NULL, '2026-11-18 07:04:01'),
(1368, 272, 'assistant', 'Hello! I’m COMSAI, your CCS Student Information Assistant. How may I help you today?', 'greeting', '[]', '2026-11-18 07:04:01'),
(1369, 272, 'student', 'ano pwede kong itanong dito', NULL, NULL, '2026-11-18 07:04:16'),
(1370, 272, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-18 07:04:16'),
(1371, 272, 'student', 'sino ang mga ccs council officers', NULL, NULL, '2026-11-18 07:04:49'),
(1372, 272, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-18 07:04:49'),
(1373, 272, 'student', 'saan makikita ang main laboratory?', NULL, NULL, '2026-11-18 07:05:27'),
(1374, 272, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-18 07:05:27'),
(1375, 272, 'student', 'where can i locate main laboratory and key laboratory', NULL, NULL, '2026-11-18 07:07:14'),
(1376, 272, 'assistant', '**Where is the Main Laboratory?**\nThe Main Laboratory is located on the second floor, MRI Building, Room 207. If you cannot find it, ask the CCS office or a designated staff member.\n\n**Where is the Key Laboratory?**\nKey Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Rooms and Laboratories\",\"url\":\"\"}]', '2026-11-18 07:07:14'),
(1377, 272, 'student', 'latest announcement today?', NULL, NULL, '2026-11-18 07:07:30'),
(1378, 272, 'assistant', '**CCS Department Fee Payment Options - 1,400 pesos**\n\nThe CCS department fee listed in this announcement is 1,400 pesos. To pay the CCS department fee, use one of the authorized CCS Central Council GCash channels below:\r\n\r\nExecutive Treasurer Renalyn Ubalde: 0907 919 2632\r\nDeputy Treasurer Anika Kaye Arjite: 0967 188 7631\r\n\r\nPlease confirm the amount and payment details through the official CCS Facebook page or approved CCS communication channel before sending money.', 'announcement', '[{\"title\":\"Official CCS announcement\",\"url\":\"\"}]', '2026-11-18 07:07:30'),
(1379, 272, 'student', 'can i ask about portal problems?', NULL, NULL, '2026-11-18 07:08:14'),
(1380, 272, 'assistant', '**Where can I ask about my grades?**\nYou can view your official grades in the student portal. For concerns, questions, or clarification about a specific subject grade, use either of these options:\r\n\r\nInstitutional email: Contact the subject instructor using the official email address in the student portal directory.\r\n\r\nIn-person inquiry: Visit your subject instructor during scheduled office hours to discuss the grade.\n\n', 'knowledge-base', '[{\"title\":\"COMSAI Dataset - Academic Procedures\",\"url\":\"\"}]', '2026-11-18 07:08:14'),
(1381, 272, 'student', 'when is the academic break?', NULL, NULL, '2026-11-18 07:10:20'),
(1382, 272, 'assistant', 'I\'m sorry, but I couldn\'t find sufficient verified information about that in the COMSAI knowledge base. Please check the official CCS communication channels or contact the appropriate CCS personnel.', 'unverified', '[]', '2026-11-18 07:10:20');

-- --------------------------------------------------------

--
-- Table structure for table `chat_sessions`
--

CREATE TABLE `chat_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `session_token_hash` char(64) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_activity_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_sessions`
--

INSERT INTO `chat_sessions` (`id`, `session_token_hash`, `created_at`, `last_activity_at`) VALUES
(17, '5d6dad3bf89a8aa1221bdbe4aa545b1c9f568a6a17686697246ffdf17b424e9a', '2026-10-16 16:31:38', '2026-10-16 16:31:42'),
(27, '0383267f35d7098f48cc28f9247a327228965eefc1e63529845c9b22d50006b1', '2026-10-17 10:33:35', '2026-10-17 10:33:39'),
(28, '01351f46fd12bb4234c3a00341baa63d2414257f5d4ad032fcd249dfff028da7', '2026-10-25 23:12:32', '2026-10-25 23:12:32'),
(30, '151a0d9dca5f40c7d26e29de045ad3b7bd3151791be3f920691afe711deb81cf', '2026-10-26 07:24:59', '2026-10-26 07:41:54'),
(34, '5224dcfc4e9ca78725a852e5aa79cd975aa28eca3e1c1197f40eadf401f03673', '2026-10-26 08:27:30', '2026-10-26 11:23:07'),
(54, '562c4639685cafa3ce8ad78b003708c870ecaa4fd076dcc9ed86a7e94f7754e1', '2026-10-27 11:49:22', '2026-10-27 11:49:44'),
(57, '99c7bb96585d132c7d4785e5b1baa43bec108886c15605e1fc4d3794ac1fb5f1', '2026-10-28 11:39:05', '2026-10-28 11:39:10'),
(64, '8bdf1fe46cf47adfb0d92d4cab075a2c159248f646df9247b07e554a1211d968', '2026-11-05 09:54:06', '2026-11-05 10:04:26'),
(66, '0ad7ffb642069d5533cc13870fcde255d8b223e4588dd8057dc3c74b1514aab7', '2026-11-06 08:49:49', '2026-11-06 11:47:12'),
(67, '63c97ea4e5ce3962227dc2c3c9678f30c2c4f41708a0a7e7100dbb94c62f5898', '2026-11-06 15:34:17', '2026-11-06 15:37:59'),
(68, 'c7f22fb75b343014fc0e987d8dd1170be3342e7125d779e0fbe1a56316a48a88', '2026-11-07 13:20:20', '2026-11-07 13:20:34'),
(71, '3eab277fa50c288f6e0315e9ef58414d3476c3cbe859927d9fcdf8bb3d83c2fc', '2026-11-09 01:11:48', '2026-11-09 01:15:15'),
(73, 'b2eb547c4052fd7a64cd87c92f6f3a569074bfc61e9b22efc8d3bacd45461ca8', '2026-11-09 01:47:44', '2026-11-09 01:48:31'),
(74, '56336b214a1c2e3a94c7c8b00821ea53a19e31434ec881b387ec05da2f2111c7', '2026-11-09 02:54:46', '2026-11-09 02:57:22'),
(75, '434a0cb21af63ccabf4c7a3acf59dfc6ad1922c8ff601f2e2fe9a7fbd334253e', '2026-11-09 05:46:53', '2026-11-09 05:46:53'),
(94, '3672293ad6ef4419f00cabd94b82f89275c314e06e5c4b8f1eecce7eb279ca03', '2026-11-09 16:08:08', '2026-11-09 16:11:10'),
(106, '3145799df43e92422c43cc3527bd3fd5495f47aacf9e37f2464d0ef5f2e90350', '2026-11-10 07:15:20', '2026-11-10 07:15:49'),
(148, '45dcbf5796dcc1df4a4074ad2d43b01318fe9507717a5a58cf303821c5f48ed3', '2026-11-10 16:19:17', '2026-11-10 16:19:17'),
(160, 'fa17d3630879ab63a4c06fae34624a2e70a59451332f5d68ae0d3f6935e2284a', '2026-11-11 13:50:18', '2026-11-11 13:50:22'),
(163, '17161713f74fdaf771811abc1a210470c3bc8756c49a40a565c9fa6fb37e55a3', '2026-11-12 13:57:01', '2026-11-12 14:44:22'),
(165, 'a60008d4eef11be71433c89c8957d1d4cf7c57d1f8f3290c59eebc32fd120690', '2026-11-13 11:06:27', '2026-11-13 11:07:03'),
(225, '47b2d39824371bdaf55e82b9529d9d368b01a50048371980dfe54329c6fa20e6', '2026-11-16 15:56:32', '2026-11-16 15:56:32'),
(244, '892bd65cc09b59a2c7e6c2ff7d67da14455d28d325337d518bdc6e9419798899', '2026-11-17 04:43:10', '2026-11-17 05:30:43'),
(247, '5b55820658ea3249661e44ef4a16743a1019099bb83ef8c7cf3c59fefa54df88', '2026-11-17 09:36:15', '2026-11-17 09:36:15'),
(261, '37df6dac15a2cae580a8a85b4649060e916b92a31a45c20a6e9f9cd6dd07396e', '2026-11-17 14:42:55', '2026-11-17 14:42:55'),
(263, '2a3cb6437d0b73b95702331d29ece7170e3bc764d93d2fdb92c84db76de04607', '2026-11-17 14:54:05', '2026-11-17 14:54:05'),
(266, '34bc312de14f73c96c39f3cbe9aefb911722e709787a7e72f47bb99dfe116344', '2026-11-17 15:30:38', '2026-11-17 15:55:32'),
(267, 'a9f7dead48c0f1d8c8d0e1ca7ca61944d527fb0d73fe3193f3fa9267cb505f2f', '2026-11-17 16:41:23', '2026-11-17 16:42:59'),
(272, '2c705fca71fd99ac199817a878721919c66127b930ce7491a1c5b9a2be723c78', '2026-11-18 07:04:01', '2026-11-18 07:10:13');

-- --------------------------------------------------------

--
-- Table structure for table `daily_chat_limits`
--

CREATE TABLE `daily_chat_limits` (
  `usage_date` date NOT NULL,
  `visitor_count` smallint(5) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_chat_limits`
--

INSERT INTO `daily_chat_limits` (`usage_date`, `visitor_count`) VALUES
('2026-11-11', 1),
('2026-11-12', 1),
('2026-11-13', 2),
('2026-11-16', 2),
('2026-11-17', 5),
('2026-11-18', 2),
('2026-11-20', 1);

-- --------------------------------------------------------

--
-- Table structure for table `daily_chat_visitors`
--

CREATE TABLE `daily_chat_visitors` (
  `usage_date` date NOT NULL,
  `visitor_hash` char(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_chat_visitors`
--

INSERT INTO `daily_chat_visitors` (`usage_date`, `visitor_hash`) VALUES
('2026-11-11', 'e166ff20421f15c8cb4da7618c2001accb9072d2c91ed37c2a04fe40fb5e8f2c'),
('2026-11-12', '7b30bcdc97ee7448b01e973c2287720d7c4368ab7dfc87a75c785034a89b9299'),
('2026-11-13', '209057a61ecd061351c1a4e4ef8c986f176d70619f21b4035f65a707e47eed78'),
('2026-11-13', '97f6e499043a75208d1daa2d26b600a2454858b0f9b9b63e7f8fb4e2633ca195'),
('2026-11-16', 'd7f331c29619bb88606fe8aa72a37a610f0194137c6628d22c17da12252f4828'),
('2026-11-16', 'eb49c7fcc050c9172bcd591968d8ae902dbe52a619992b490672216d48a6fa7d'),
('2026-11-17', '6a3c360907e64fc13872e7908108fbab2584c3b5533cd40180a4e74d4a38f7e3'),
('2026-11-17', '725aec3c8e2947eb8a4adff7208ebdfcfa61103e8a5014b84960c93495e0b68e'),
('2026-11-17', '9943c1f892d837c66fd7dc5182e4321b087829c0d930c790a668a3d1788111dd'),
('2026-11-17', 'ae7d8203b07138f01b1be30ed8221c64927c1fc178d94c0e59ca68a3be5724ad'),
('2026-11-17', 'f4b45c4d3bd17956a2acf145e768f290537fe6dbecd500c55bed9943f86780de'),
('2026-11-18', '27ae4ff64620ed8182f226007a21c8deb1e5fe73b13a75fdb590247a52b87d9f'),
('2026-11-18', '455d988640777f649a6b5659a52b0c52fa5cd7feb353b9afafd04fab572f48d9'),
('2026-11-20', '3d342cddd7b4a54fe43543f12b0b71081a60f955f3db03be35aa5aae46e1fa94');

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_base`
--

CREATE TABLE `knowledge_base` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` mediumtext NOT NULL,
  `search_terms` text DEFAULT NULL,
  `source_title` varchar(200) DEFAULT NULL,
  `source_url` varchar(2048) DEFAULT NULL,
  `effective_date` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `status` enum('draft','published') NOT NULL DEFAULT 'draft',
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `knowledge_base`
--

INSERT INTO `knowledge_base` (`id`, `category_id`, `title`, `content`, `search_terms`, `source_title`, `source_url`, `effective_date`, `expiration_date`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(28, 2, 'CCS Central Council Officers', 'The College of Computer Studies Central Council Officers for Academic Year 2026–2027\r\n\r\nGovernor: Selene E. Tychingco\r\nVice Governor – Internal: Angel Ayessa O. Cacho\r\nVice Governor – External: Giedhell Ann M. Serrano\r\nExecutive Secretary: Abiegail T. Rellermo\r\nAssistant Secretary: Lorren Joyce L. Erandio\r\nChief Treasurer: Renalyn T. Ubalde\r\nDeputy Treasurer: Anika Kaye E. Arjite\r\nAuditor: Renz Darrel O. Gomez\r\nChief Peace Officer: Justine D. Canaria\r\nDeputy Peace Officer: Jose Russel M. Cabunias\r\nDeputy Peace Officer: John Kevin B. Abogado\r\nChief Communication and Media Officer: John Bernard C. De Leon\r\nDeputy Communication and Media Officer: Francis Kevin Y. Calvario\r\nCommunication and Media Officer: Shalom Emannuel M. Abiera\r\nCommunication and Media Officer: Richard A. Boribor\r\nCommunication and Media Officer: Condrad Jaimar G. Sale\r\nCommunication and Media Officer: Candice Fine Y. Montemayor\r\nFourth Year Representative: Eya Mae R. Bana\r\nThird Year Representative: Gian Carlo D. Bacia\r\nSecond Year Representative: Chelsey Joelle B. Esguerra\r\nFirst Year Representative: John Mark N. Molina\r\nFirst Year Representative: Mark Zedrix Zantua', 'CCS Central Council Officers, CCS council roster, central council members, student council officers, student government, list all officers, council positions, vice governor, peace officer, communications and media officer, year representatives, council adviser, academic year 2026 2027, Selene Tychingco, Angel Cacho', 'COMSAI Dataset - CCS Council Officers', NULL, '2026-11-13 17:53:00', NULL, 'published', NULL, '2026-10-26 07:40:57', '2026-11-16 14:00:44'),
(29, 27, 'What is COMSAI?', 'COMSAI is an AI-powered student information assistance chatbot designed to help users access information related to the College of Computer Studies (CCS) of Mabini Colleges, Inc.', 'What is COMSAI?, COMSAI definition, meaning of COMSAI, what does COMSAI do, AI student assistant, student information chatbot, College of Computer Studies assistant, what is COMSAI', 'COMSAI Dataset - General Information', NULL, '2026-11-13 18:32:00', NULL, 'published', 2, '2026-10-27 05:49:51', '2026-11-16 14:00:44'),
(30, 27, 'What information can I ask COMSAI about?', 'You can ask about CCS faculty and officers, rooms and laboratories, announcements, and department-related academic processes. If information is not available, COMSAI will direct you to the appropriate CCS personnel.', 'What information can I ask COMSAI about?, topics COMSAI can answer, supported student questions, what can I ask, available information, faculty officers rooms labs announcements academic processes, COMSAI capabilities, what information can I ask COMSAI about', 'COMSAI Dataset - General Information', NULL, '2026-11-13 18:33:00', NULL, 'published', 2, '2026-10-27 08:19:37', '2026-11-18 06:58:18'),
(31, 27, 'Is COMSAI an official source of CCS information?', 'COMSAI provides answers based on information approved for its CCS knowledge base. For urgent matters or information that may have changed, confirm with the CCS Council or the appropriate CCS personnel.', 'Is COMSAI an official source of CCS information?, COMSAI official status, can I rely on this answer, verify CCS information, information accuracy, confirm with the college, official authority, urgent official matters, is COMSAI an official source of CCS information', 'COMSAI Dataset - General Information', NULL, '2026-11-13 18:36:00', NULL, 'published', 2, '2026-10-27 08:43:34', '2026-11-16 14:00:44'),
(32, 1, 'Who is the CCS Dean?', 'The OIC Dean of the College of Computer Studies is Sir Frank Kiven B. Ablao. He is also the Technical Head of Mabini Colleges, a Licensed Professional Teacher, and a Civil Service Professional.', 'Who is the CCS Dean?, CCS Dean name, who leads the department, department head, OIC Dean, technical head, Frank Kiven B Ablao, Sir Frank Ablao, the CCS Dean', 'COMSAI Dataset - Faculty and Staff', NULL, '2026-11-13 18:21:00', NULL, 'published', 2, '2026-10-27 08:47:19', '2026-11-16 14:00:44'),
(33, 1, 'Where can I find the CCS Dean?', 'The CCS Dean office is on the second floor, beside the President\'s office. Ask the CCS office or CCS Council to confirm the Dean\'s schedule.', 'Where can I find the CCS Dean?, Dean office location, locate CCS Dean, where is the Dean, CCS office location, second floor, beside the President office, Dean office directions, where can I find the CCS Dean', 'COMSAI Dataset - Faculty and Staff', NULL, '2026-11-13 18:24:00', NULL, 'published', 2, '2026-10-27 08:47:39', '2026-11-16 14:00:44'),
(34, 1, 'Who are the CCS faculty members?', 'The current CCS faculty and staff listed in the COMSAI dataset are:\r\n\r\n1. Frank Kiven B. Ablao, LPT, MIS\r\nPosition: OIC Dean, CCS and MC Technical Head.\r\nQualifications: Civil Service Professional; Trainer Methodology Level 1; Computer Programming NC IV; Visual Graphics Design NC III; Automotive Service (Engine Repair) NC II; Electronic Products Assembly and Servicing NC II.\r\n\r\n2. Christian Drigon F. Aga, LPT, JD\r\nPosition: CCS Administrator, MIT (Unit Earner).\r\nEducation: Bachelor of Arts in Economics, Polytechnic University of the Philippines; Certificate in Computer Education, De La Salle University; Certificate in Teaching, Philippine Normal University - Manila.\r\n\r\n3. Edcel S. Martinez\r\nPosition: Head, Computer Internet Lab.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Professional Education; 2D Animation NC III; Computer Systems Servicing NC II; Visual Graphics Design NC III.\r\n\r\n4. Ian Godwin G. Agapito\r\nPosition: CCS Instructor.\r\nEducation and qualifications: Professional Education; Bachelor of Science in Computer Science.\r\n\r\n5. Aeron Dave C. Enova, LPT, CRS, CAWS\r\nPositions: CCS Central Council Adviser, Practicum Coordinator, and Research Coordinator.\r\nEducation and qualifications: Master of Science in Computer Science (ongoing); Master of Science in Information Technology (27 units); Juris Doctor (64 units); Certified Academic Writing Specialist; Certified Research Specialist; Civil Service Professional; Data Analyst.\r\n\r\n6. Kevin-Ezer F. Tanierla\r\nPosition: CCS Instructor and Software Engineer.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Programming NC IV; Animation NC III.\r\nMC Portal projects: Digital ID, Digital Permit, Attendance Monitoring System, and Digital Tickets.\r\n\r\n7. John Eddie Ablao\r\nPosition: Software Engineer.\r\nEducation: Bachelor of Science in Information Technology.\r\n\r\n8. John Virgel Lo\r\nPosition: System Administrator.\r\nEducation: Bachelor of Science in Computer Science.\r\n\r\n9. Ferdinand O. Postre\r\nPosition: Technical Support Assistant.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Computer Systems Servicing NC II.\r\n\r\n10. Annabel Dichoso Nagera, LPT\r\nPosition: Part-Time Instructor; DepEd Teacher III.\r\nEducation and qualifications: Bachelor of Science in Computer Science; Master in Information Technology (Unit Earner); Professional Education; Master in Education (Unit Earner).', 'Who are the CCS faculty members?, CCS faculty roster, faculty directory, list of instructors, names of teachers, teaching staff, faculty roles and qualifications, OIC Dean, lab head, technical support staff, Frank Kiven Ablao, Christian Drigon Aga, Edcel Martinez, Ian Godwin Agapito, Aeron Dave Enova', 'COMSAI Dataset - Faculty and Staff', NULL, '2026-11-13 18:25:00', NULL, 'published', 2, '2026-10-27 08:50:41', '2026-11-16 14:00:44'),
(35, 1, 'How can I contact a CCS faculty member?', 'You can contact [faculty member] through [insert approved school email or official contact method]. COMSAI should only display contact details approved for public student use.', 'How can I contact a CCS faculty member?, faculty email address, instructor contact details, contact my teacher, reach a professor, faculty directory, CCS instructor email, faculty office hours, how can I contact a CCS faculty member, contact a CCS faculty member', 'COMSAI Dataset - Faculty and Staff', NULL, '2026-11-13 18:25:00', NULL, 'draft', 2, '2026-10-27 09:30:21', '2026-11-16 14:00:44'),
(36, 2, 'Who is the current CCS Governor?', 'The current CCS Governor for Academic Year 2026–2027 is Ms. Selene E. Tychingco.', 'Who is the current CCS Governor?, current student council governor, CCS governor name, council president, student government president, governor for academic year 2026 2027, Selene Tychingco, name of the current CCS council governor, name of the current CCS council president', 'COMSAI Dataset - CCS Council Officers', NULL, '2026-11-13 17:56:00', NULL, 'published', 2, '2026-10-27 09:32:36', '2026-11-16 14:00:44'),
(37, 3, 'Where is the Main Laboratory?', 'The Main Laboratory is located on the second floor, MRI Building, Room 207. If you cannot find it, ask the CCS office or a designated staff member.', 'Where is the Main Laboratory?, main laboratory, Main Lab location, find Main Laboratory, main computer lab room, MRI Building, second floor, room 207, directions to Main lab, where is the main laboratory, where is the main lab', 'COMSAI Dataset - Rooms and Laboratories', NULL, '2026-11-10 00:00:00', NULL, 'published', 2, '2026-11-05 08:18:37', '2026-11-16 14:00:44'),
(38, 3, 'Where is the Annex Laboratory?', 'The Annex Laboratory is located on the second floor, MRI Building, Room 203. If you cannot find it, ask the CCS office or a designated staff member.', 'Where is the Annex Laboratory?, annex laboratory, Annex Lab location, find Annex Laboratory, Annex computer lab room, MRI Building, second floor, room 203, directions to Annex lab, where is the annex laboratory, where is the annex lab', 'COMSAI Dataset - Rooms and Laboratories', NULL, '2026-11-10 00:00:00', NULL, 'published', 2, '2026-11-05 08:18:54', '2026-11-16 14:00:44'),
(39, 3, 'Where is the Key Laboratory?', 'Key Laboratory (Keylab) is located on the second floor, MRI Building, Room 212. Please confirm with CCS personnel if the room assignment has changed.', 'Where is the Key Laboratory?, Key Lab location, Key Lab room, find Key Laboratory, MRI Building, second floor, room 212, directions to Key lab, where is the key laboratory, where is the key lab', 'COMSAI Dataset - Rooms and Laboratories', NULL, '2026-11-09 00:00:00', NULL, 'published', 2, '2026-11-05 08:19:21', '2026-11-16 14:00:44'),
(40, 7, 'How do I comply with an INC grade?', 'The verified CCS/Mabini Colleges procedure for completing an INC grade is:\r\n\r\n1. Get the INC Form from the Registrar\'s Office.\r\n2. Ask your professor for the remaining requirements needed to complete your INC grade.\r\n3. Complete all missing requirements given by your professor.\r\n4. Have your professor sign the INC Form and submit the required grade or completion details.\r\n5. Return the INC Form to the Registrar\'s Office for processing and updating your grade.', 'How do I comply with an INC grade?, INC grade, incomplete grade, remove an INC, complete an incomplete, finish INC requirements, INC form, missing coursework, professor requirements, Registrar submission, comply with an inc grade', 'COMSAI Dataset - Academic Procedures', NULL, NULL, NULL, 'published', 2, '2026-11-05 09:09:07', '2026-11-16 14:00:44'),
(41, 7, 'How do I process a COG (Certificate of Grades)?', 'To process a Certificate of Grades (COG):\r\n\r\n1. Request Form: Get the official request slip from the Registrar\'s window. Fill it out with your full name, student ID number, academic year, semester, and purpose.\r\n2. Initial Processing: Submit the completed form to the Registrar\'s window for verification and printing of your COG.\r\n3. Payment: Pay the required COG processing fee at the Cashier\'s Office.\r\n4. Validation and Stamping: Return to the Registrar\'s Office with the printed COG and payment receipt. Staff will verify the document and apply the official school seal.\r\n5. Collection: Follow the Registrar staff\'s instructions about the collection schedule and release of your validated COG.', 'How do I process a COG (Certificate of Grades)?, certificate of grades, request grades certificate, get my COG, COG application, Registrar request slip, pay COG fee, school seal, collect grades certificate', 'COMSAI Dataset - Academic Procedures', NULL, '2026-11-12 00:00:00', NULL, 'published', 2, '2026-11-05 09:10:01', '2026-11-16 14:00:44'),
(42, 7, 'Where can I ask about my grades?', 'You can view your official grades in the student portal. For concerns, questions, or clarification about a specific subject grade, use either of these options:\r\n\r\nInstitutional email: Contact the subject instructor using the official email address in the student portal directory.\r\n\r\nIn-person inquiry: Visit your subject instructor during scheduled office hours to discuss the grade.', 'Where can I ask about my grades?, check grades, view grades, grade concern, incorrect grade, question about a subject mark, ask my professor, instructor contact, student portal grades, professor office hours, ask about my grades', 'COMSAI Dataset - Academic Procedures', NULL, '2026-11-12 00:00:00', NULL, 'published', 2, '2026-11-05 09:12:27', '2026-11-16 14:00:44'),
(43, 6, 'Where can I find the CCS class schedule?', 'The CCS class schedule is available through the school\'s official student portal. After logging in, students can view their complete course schedule, including assigned subjects, class dates and times, room assignments, and the corresponding subject instructors.', 'Where can I find the CCS class schedule?, view CCS timetable, where to see class schedule, student portal timetable, subject meeting times, course schedule, room assignments in schedule, instructor schedule, where can I find the CCS class schedule', 'COMSAI Dataset - Schedules and Important Dates', NULL, '2026-11-10 00:00:00', NULL, 'published', 2, '2026-11-05 09:13:05', '2026-11-16 14:00:44'),
(44, 15, 'Can COMSAI confirm my personal academic or payment records?', 'COMSAI can only provide information that is approved for its knowledge base. It should not disclose private grades, balances, passwords, or other personal records. Please contact the authorized school office for account-specific concerns.', 'Can COMSAI confirm my personal academic or payment records?, private student records, personal grades, individual account balance, payment record lookup, account-specific information, student privacy, password safety, confidential academic information, can COMSAI confirm my personal academic or payment records', 'COMSAI Dataset - Department Policies', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-05 09:15:09', '2026-11-16 14:00:44'),
(45, 28, 'I don\'t understand the answer. Can you explain it more simply?', 'Of course. Please tell me which part you want clarified, or rephrase your question. I will try to explain using the verified CCS information available.', 'I don\'t understand the answer. Can you explain it more simply?, explain again, simpler explanation, clarify the answer, rephrase in simple words, easier explanation, make the response clearer, i don\'t understand the answer, can you explain it more simply', 'COMSAI Dataset - Fallback and Clarifications', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-05 09:17:26', '2026-11-16 14:00:44'),
(46, 28, 'What if COMSAI does not know the answer?', 'If an answer is not available in the verified knowledge base, COMSAI should say it cannot verify the information and direct the student to the appropriate CCS Council officer, faculty member, or office. COMSAI should not invent an answer.', 'What if COMSAI does not know the answer?, COMSAI cannot answer, no verified answer, unknown CCS question, missing knowledge-base information, ask CCS personnel, official channel, do not guess, what if COMSAI does not know the answer', 'COMSAI Dataset - Fallback and Clarifications', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-05 09:17:48', '2026-11-16 14:00:44'),
(47, 28, 'Can I ask a question in my own words?', 'Yes. You can type your CCS-related question naturally. If the question is unclear, COMSAI may ask you to clarify it.', 'Can I ask a question in my own words?, ask COMSAI naturally, different wording, paraphrase a question, use my own words, how to phrase a question, ask in plain language', 'COMSAI Dataset - Fallback and Clarifications', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-05 09:18:13', '2026-11-16 14:00:44'),
(48, 28, 'Where can I report incorrect information in COMSAI?', 'Please report the issue to [insert official CCS Council/admin contact channel]. An authorized administrator should verify the information and update the knowledge base if needed.', 'Where can I report incorrect information in COMSAI?, report wrong answer, report incorrect CCS information, submit correction, fix knowledge-base entry, COMSAI error report, contact administrator, where can I report incorrect information in COMSAI', 'COMSAI Dataset - Fallback and Clarifications', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-05 09:18:33', '2026-11-16 14:00:44'),
(49, 7, 'How do I settle my portal balance?', 'If you need help finding where to settle an outstanding balance shown in the student portal, approach any CCS Central Council officer or the CCS Central Council Adviser for guidance. For account-specific balances or payment issues, contact the authorized school office. Do not share passwords or other sensitive payment details in COMSAI.', 'How do I settle my portal balance?, pay student portal balance, settle outstanding balance, where to pay school balance, payment help, cashier location, council officer payment guidance, account balance support', 'COMSAI Dataset - Academic Procedures', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-06 08:10:50', '2026-11-16 14:00:44'),
(50, 4, 'Are there any upcoming CCS activities?', 'The dataset does not list verified upcoming CCS activity dates. Check the official CCS announcement channel for updates: https://www.facebook.com/share/196SduubPS/', 'Are there any upcoming CCS activities?, upcoming CCS events, future department activities, event calendar, activity dates, next CCS event, planned activities, scheduled events, upcoming programs, upcoming CCS activities', 'COMSAI Dataset - Announcements and Activities', 'https://www.facebook.com/share/196SduubPS/', '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-06 08:19:25', '2026-11-17 04:23:25'),
(51, 4, 'Where can I view the full details of an announcement?', 'View the full announcement details through the official Facebook page of the College of Computer Studies. COMSAI should provide the source link whenever one is available: https://www.facebook.com/share/196SduubPS/', 'Where can I view the full details of an announcement?, read complete announcement, announcement full text, official announcement post, announcement source link, original CCS notice, view announcement details, view the full details of an announcement', 'COMSAI Dataset - Announcements and Activities', 'https://www.facebook.com/share/196SduubPS/', '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-06 08:20:35', '2026-11-16 14:00:44'),
(52, 4, 'Has the schedule of the event changed?', 'The dataset does not list a verified event schedule change. Check the linked official announcement or contact the event organizer to confirm last-minute changes.', 'Has the schedule of the event changed?, event date changed, schedule update, rescheduled event, postponed activity, cancelled event, delayed event, new start time, changed venue, event postponement, schedule of the event changed', 'COMSAI Dataset - Announcements and Activities', NULL, '2026-11-13 17:26:00', NULL, 'draft', 2, '2026-11-06 08:21:30', '2026-11-16 14:00:44'),
(53, 5, 'What is the clearance for the end of the semester?', 'Semester clearance is a process completed at the end of each semester. It confirms that a student has no pending obligations or accountabilities with school offices and departments.', 'What is the clearance for the end of the semester?, meaning of semester clearance, end of semester clearance, what clearance means, student accountabilities, school obligations, semester closing clearance, clearance for the end of the semester', 'COMSAI Dataset - Academic Requirements', NULL, '2026-11-12 00:00:00', NULL, 'published', 2, '2026-11-07 12:29:44', '2026-11-16 14:00:44'),
(54, 5, 'When is the clearance processed?', 'Semester clearance is processed at the end of each semester, before the semester officially closes.', 'When is the clearance processed?, clearance processing period, clearance schedule, clearance deadline, when to complete semester clearance, end of semester processing, semester closing date, when is the clearance processed', 'COMSAI Dataset - Academic Requirements', NULL, '2026-11-12 00:00:00', NULL, 'published', 2, '2026-11-07 12:30:25', '2026-11-16 14:00:44'),
(55, 5, 'How many times is clearance done in one academic year?', 'Clearance is done twice in one academic year: once for the First Semester and once for the Second Semester.', 'How many times is clearance done in one academic year?, clearance frequency, how often clearance happens, number of clearances per year, first semester clearance, second semester clearance, twice each academic year, how many times is clearance done', 'COMSAI Dataset - Academic Requirements', NULL, '2026-11-12 00:00:00', NULL, 'published', 2, '2026-11-07 12:30:55', '2026-11-16 14:00:44'),
(56, 5, 'What are the requirements for the semester clearance?', 'The dataset lists these semester-clearance requirements: no pending payments, such as the departmental fee, and no pending obligations for activities. Confirm any additional or updated requirements with the office responsible for clearance.', 'What are the requirements for the semester clearance?, semester clearance requirements, clearance checklist, clearance obligations, outstanding payments, departmental fee clearance, pending activity obligations, what must be completed for clearance, requirements for the semester clearance', 'COMSAI Dataset - Academic Requirements', NULL, '2026-11-12 00:00:00', NULL, 'published', 2, '2026-11-07 12:32:36', '2026-11-16 14:00:44'),
(57, 5, 'Where can I get the clearance form?', 'The semester clearance form is available from the Property Custodian. One form is issued for each student.', 'Where can I get the clearance form?, semester clearance form, obtain clearance paperwork, where to request clearance form, Property Custodian, one form per student, clearance form', 'COMSAI Dataset - Academic Requirements', NULL, '2026-11-12 00:00:00', NULL, 'published', 2, '2026-11-07 12:34:08', '2026-11-16 14:00:44'),
(58, 4, 'What is the latest announcement?', 'The latest-announcement question is answered dynamically from the newest currently published, non-expired announcement. Check the Announcements and Activities panel for its details.', 'What is the latest announcement?, latest announcement, newest announcement, most recent CCS notice, current department announcement, recent notice, newest activity update', 'COMSAI Dataset - Announcements and Activities', NULL, '2026-11-13 17:25:00', NULL, 'published', NULL, '2026-11-09 14:12:45', '2026-11-16 14:00:44'),
(128, 2, 'Who should I contact about department fee payments?', 'For department-fee payment questions, contact the CCS Central Council Treasurers through their Facebook accounts:\r\n\r\nChief Treasurer Renalyn T. Ubalde: https://facebook.com/ena.ubalde\r\nDeputy Treasurer Anika Kaye E. Arjite: https://facebook.com/anika.kaye.19', 'Who should I contact about department fee payments?, department fee payment contact, who receives CCS fee, ask about departmental dues, treasurer contact, GCash payment inquiry, payment confirmation, Renalyn Ubalde, Anika Arjite, contact about department fee payments, department fee payments', 'COMSAI Dataset - CCS Council Officers', NULL, '2026-11-13 17:55:00', NULL, 'published', NULL, '2026-11-10 07:10:07', '2026-11-16 14:00:44'),
(129, 2, 'How can I pay the CCS department fee?', 'The dataset lists the CCS department fee as 1,400 pesos. It lists these authorized CCS Central Council GCash channels:\r\n\r\nExecutive Treasurer Renalyn Ubalde: 0907 919 2632\r\nDeputy Treasurer Anika Kaye Arjite: 0967 188 7631\r\n\r\nConfirm the amount and payment details through the official CCS announcement channel before sending money.', 'How can I pay the CCS department fee?, pay CCS departmental fee, department dues payment, fee amount, 1400 pesos, GCash payment number, authorized payment channel, executive treasurer payment, deputy treasurer payment, Renalyn Ubalde, Anika Arjite, pay the CCS department fee, CCS department fee', 'COMSAI Dataset - CCS Council Officers', NULL, '2026-11-13 17:54:00', NULL, 'published', NULL, '2026-11-10 07:10:07', '2026-11-16 14:00:44'),
(130, 2, 'Who can I contact about department shirt concerns?', 'For department-shirt updates, contact the CCS Central Council Secretaries:\r\n\r\nAssistant Secretary Lorren Joyce L. Erandio: https://facebook.com/eljeixcm\r\nExecutive Secretary Abiegail T. Rellermo: https://facebook.com/aviezx', 'Who can I contact about department shirt concerns?, department shirt inquiry, shirt order update, shirt concern contact, shirt availability, shirt distribution, contact council secretary, Lorren Erandio, Abiegail Rellermo, contact about department shirt concerns, department shirt concerns', 'COMSAI Dataset - CCS Council Officers', NULL, '2026-11-13 17:52:00', NULL, 'published', NULL, '2026-11-10 07:10:07', '2026-11-16 14:00:44'),
(131, 2, 'How can I check if my name is on the department shirt list?', 'Contact CCS Central Council Secretaries Lorren Joyce L. Erandio or Abiegail T. Rellermo to check whether your name is on the department-shirt list. Their Facebook accounts are https://facebook.com/eljeixcm and https://facebook.com/aviezx.', 'How can I check if my name is on the department shirt list?, check my name on shirt list, department shirt order list, verify shirt order, shirt sizing list, shirt purchase name, ask council secretaries, shirt order status, Lorren Erandio, Abiegail Rellermo, can I check if my name is on the department shirt list', 'COMSAI Dataset - CCS Council Officers', NULL, '2026-11-13 17:52:00', NULL, 'published', NULL, '2026-11-10 07:10:07', '2026-11-16 14:00:44'),
(132, 7, 'Who should I contact about an INC grade?', 'For requirements or procedures for completing an INC grade, contact the professor handling that subject. See the INC-completion steps in the Academic Procedures information.', 'Who should I contact about an INC grade?, INC grade contact, incomplete grade help, ask instructor about INC, who handles INC grade, incomplete coursework contact', 'COMSAI Dataset - Academic Procedures', NULL, '2026-11-12 00:00:00', NULL, 'published', NULL, '2026-11-10 07:10:07', '2026-11-16 14:00:44'),
(133, 2, 'Who can help with a CCS concern that is not listed?', 'If your CCS concern is not covered in the available information, approach a CCS Central Council officer or contact the CCS Central Council Adviser, Sir Aeron Dave C. Enova.', 'Who can help with a CCS concern that is not listed?, unlisted CCS question, other department concern, who can help me, ask a CCS council officer, council adviser contact, Aeron Enova, help with a CCS issue, help with a CCS concern that is not listed, CCS concern that is not listed', 'COMSAI Dataset - CCS Council Officers', NULL, '2026-11-13 17:50:00', NULL, 'published', NULL, '2026-11-10 07:10:07', '2026-11-16 14:00:44'),
(134, 6, 'What does A or B mean in my class schedule?', 'Schedule ending in A: First meeting day is face-to-face; second meeting day is online. \r\nSchedule ending in B: First meeting day is online; second meeting day is face-to-face. \r\nNo A or B: All scheduled meetings are face-to-face. \r\nOnce-a-week subjects: The A/B arrangement also applies to subjects that meet only once a week.', 'What does A or B mean in my class schedule?, what does A or B mean in my class schedule, A and B class schedule meaning, what is A or B class modality, face to face and online schedule rotation', 'COMSAI Dataset - Schedules and Important Dates', NULL, '2026-11-10 00:00:00', NULL, 'published', NULL, '2026-11-10 07:10:07', '2026-11-16 14:00:44'),
(200, 5, 'What are the requirements for [specific CCS process]?', 'The requirements for [process] are [insert verified checklist]. Please confirm the latest requirements with the office or personnel responsible for the process.', 'What are the requirements for [specific CCS process]?, requirements checklist, documents needed, required documents, admission requirements, enrollment requirements, CCS process requirements, verified process checklist', 'COMSAI Dataset - Academic Requirements', NULL, NULL, NULL, 'draft', NULL, '2026-11-10 10:26:47', '2026-11-16 14:00:44'),
(201, 5, 'Where can I get the form for [specific process]?', 'The form for [process] is available at [insert verified office, official link, or platform]. If no form is listed, contact the office responsible for the process.', 'Where can I get the form for [specific process]?, process application form, request form, where to get a form, official form download, office form, submit process paperwork, specific CCS form', 'COMSAI Dataset - Academic Requirements', NULL, '2026-11-11 00:00:00', NULL, 'draft', NULL, '2026-11-10 10:26:47', '2026-11-16 14:00:44'),
(202, 7, 'When is the student portal available or scheduled?', 'The current student portal schedule is [insert verified days, times, and purpose]. If the schedule is not listed or has changed, contact the office responsible for the student portal.', 'When is the student portal available or scheduled?, student portal operating hours, portal access schedule, portal availability, portal maintenance, portal downtime, portal login hours, student portal timetable, student portal available or scheduled', 'COMSAI Dataset - Academic Procedures', NULL, '2026-11-12 00:00:00', NULL, 'draft', NULL, '2026-11-10 10:26:47', '2026-11-16 14:00:44'),
(203, 15, 'What are the CCS rules for using the laboratories?', 'The approved laboratory rules are [insert verified rules]. Follow posted laboratory instructions and directions from authorized faculty or laboratory personnel.', 'What are the CCS rules for using the laboratories?, computer laboratory rules, lab safety policy, laboratory conduct, rules for using computers, equipment use policy, lab access requirements, classroom computer room rules, what are the CCS rules for using the laboratories, CCS rules for using the laboratories', 'COMSAI Dataset - Department Policies', NULL, '2026-11-13 18:01:00', NULL, 'draft', NULL, '2026-11-10 10:26:47', '2026-11-16 14:00:44'),
(204, 15, 'What should I do if I cannot find the information I need?', 'I could not find a verified answer in the CCS knowledge base. Please contact the CCS Council through [insert official contact channel] or ask the appropriate CCS faculty member or office.', 'What should I do if I cannot find the information I need?, missing CCS information, question has no answer, where to ask an unlisted question, contact CCS office, ask a faculty member, ask council, official contact channel, what should I do if I cannot find the information I need', 'COMSAI Dataset - Department Policies', NULL, '2026-11-13 17:58:00', NULL, 'draft', NULL, '2026-11-10 10:26:47', '2026-11-16 14:00:44'),
(259, 2, 'Who should I contact about portal settlement?', 'If you need assistance regarding where to settle your outstanding balance in the student portal, you may approach any CCS Central Council officer or the CCS Central Council Adviser for guidance.', 'Who should I contact about portal settlement?, contact about portal settlement, student portal balance help, who can help with portal payment, where can I ask about an outstanding balance', 'COMSAI Dataset - CCS Council Officers', NULL, '2026-11-11 00:00:00', NULL, 'draft', 2, '2026-11-11 05:16:16', '2026-11-16 14:00:44'),
(260, 2, 'Where can I pay my department fee?', 'You may pay your department fee through the authorized GCash payment channels of the CCS Central Council:\r\n\r\nGCash – Executive Treasurer\r\nName: Miss Renalyn Ubalde\r\nPosition: Executive Treasurer, CCS Central Council\r\nNumber: 0907 919 2632\r\n\r\nGCash – Deputy Treasurer\r\nName: Miss Anika Kaye Arjite\r\nPosition: Deputy Treasurer, CCS Central Council\r\nNumber: 0967 188 7631', 'Where can I pay my department fee?, pay my department fee, where can I pay my department fee, CCS department fee payment options, where to pay department dues, how to pay the CCS department fee', 'COMSAI Dataset - CCS Council Officers', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-11 05:55:48', '2026-11-16 14:00:44'),
(261, 7, 'Who should I contact about my grades?', 'For concerns regarding your grades in a specific subject, you should directly contact the professor handling that subject.', 'Who should I contact about my grades?, contact about my grades, ask a professor about subject grades, who handles grade questions, contact an instructor about my grade', 'COMSAI Dataset - Academic Procedures', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-11 06:03:49', '2026-11-16 14:00:44'),
(262, 7, 'Who should I contact if I have an INC grade?', 'For concerns regarding an INC grade, contact the professor handling the subject to ask about the requirements and procedures for completing your INC.', 'Who should I contact if I have an INC grade?, contact if i have an inc grade, ask a professor about an incomplete grade, who handles INC completion, contact an instructor about INC requirements', 'COMSAI Dataset - Academic Procedures', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-11 06:05:50', '2026-11-16 14:00:44'),
(263, 7, 'Who should I contact if my concern is not listed?', 'If your concern is not covered by the available information, you may approach any CCS Central Council officer or contact the CCS Central Council Adviser, Sir Aeron Dave C. Enova, for proper assistance.', 'Who should I contact if my concern is not listed?, contact if my concern is not listed, who can help with another CCS concern, ask about an unlisted department issue, contact a CCS council adviser', 'COMSAI Dataset - Academic Procedures', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-11 06:06:31', '2026-11-16 14:00:44'),
(264, 6, 'How do I know my class schedule?', 'The College of Computer Studies (CCS) class schedule is accessible through the school’s official student portal. Once logged in, students can view their complete course schedule, including the assigned subjects, class dates, times, room assignments, and the corresponding subject instructors.', 'How do I know my class schedule?, how do I know my class schedule, view my class timetable, find subject times and room assignments, where to see my schedule in the student portal', 'COMSAI Dataset - Schedules and Important Dates', NULL, '2026-11-11 00:00:00', NULL, 'published', 2, '2026-11-11 07:43:00', '2026-11-16 14:00:44');

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_embeddings`
--

CREATE TABLE `knowledge_embeddings` (
  `knowledge_base_id` int(10) UNSIGNED NOT NULL,
  `embedding_model` varchar(80) NOT NULL,
  `content_hash` char(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `embedding_vector` mediumblob NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rate_limits`
--

CREATE TABLE `rate_limits` (
  `key_hash` char(64) NOT NULL,
  `window_started_at` datetime NOT NULL,
  `request_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rate_limits`
--

INSERT INTO `rate_limits` (`key_hash`, `window_started_at`, `request_count`) VALUES
('199fb9e288eedbc3a171b2cb6115e55b5687534e608744a84195cb9a7ef4d3ba', '2026-10-16 18:57:35', 1),
('1c3290cace680af69a827f79a1ad019f7420d90d1ddccef493ba82db06a903b0', '2026-11-20 15:24:57', 1),
('20900d446e3e55d709d9a7d150bf8cc542b4e4c8ca2b4e7cfb8f4b93648b2155', '2026-11-11 19:29:59', 1),
('7726b5bf05d3d4f7a13b0f93b5dea757c7f25fe356ff4790402b06d074431bab', '2026-10-16 21:08:22', 1),
('77963ee65a67ac0f325be9f6a2413caf86564ec04d862064490009905642d4b3', '2026-10-26 07:11:10', 1),
('7a5e2d316b31ae246bb9d84433f713cfdc6968455289321205009f8356194a26', '2026-11-16 23:44:58', 2),
('894c9534e5154965b7ff139da1183dd4dace1924841333fa286f095ff41d5d07', '2026-11-20 15:24:57', 1),
('9964a0741698ea3291233e275599f8794007d3e2762727d7740d3da4e84c3090', '2026-10-16 20:35:30', 2),
('b171aa63fb3e7f326c0a362ce4edb5a9dbe4acc640286dabb5a9024e843b085e', '2026-11-18 17:17:55', 1),
('c13759cd4d4c01548e8d7d250553012c58caa6f2a8dca3585aeb4b17fb7f5cab', '2026-11-11 19:16:03', 6),
('ca6f3783daabc355a59d2db6770ee01de514f04713dae293bc06d11774937015', '2026-11-20 15:25:06', 1),
('ea6c89f32b31aebc3ddd29fe1dc33081a3bec125769eeff02f20401e1b80f450', '2026-11-18 14:38:51', 1),
('ec32714584d3713ed9edac2681df71c1e8ca6b3059fcd2290b564bb4078da110', '2026-11-18 17:17:55', 1),
('ef04203a388336f4874fc880761d3ea1f9ec1b85f2bbd853bee775ee930457fe', '2026-11-18 15:10:13', 1);

-- --------------------------------------------------------

--
-- Table structure for table `student_feedback`
--

CREATE TABLE `student_feedback` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `feedback` mediumtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_feedback`
--

INSERT INTO `student_feedback` (`id`, `feedback`, `created_at`) VALUES
(13, 'test 1', '2026-11-17 03:37:06'),
(14, 'test 2', '2026-11-17 03:37:18'),
(15, 'test 3', '2026-11-17 03:37:23'),
(16, 'test 4', '2026-11-17 03:40:10'),
(17, 'test 5', '2026-11-17 03:40:16'),
(18, 'under maintenance', '2026-11-18 06:38:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activity_time` (`created_at`),
  ADD KEY `fk_activity_admin` (`admin_id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_admin_email` (`email`);

--
-- Indexes for table `admin_activity_state`
--
ALTER TABLE `admin_activity_state`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `admin_feedback_state`
--
ALTER TABLE `admin_feedback_state`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_announcement_current` (`status`,`publish_at`,`expiration_date`),
  ADD KEY `fk_announcement_admin` (`created_by`);

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_category_name` (`name`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_chat_session_time` (`chat_session_id`,`created_at`);

--
-- Indexes for table `chat_sessions`
--
ALTER TABLE `chat_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_chat_token_hash` (`session_token_hash`);

--
-- Indexes for table `daily_chat_limits`
--
ALTER TABLE `daily_chat_limits`
  ADD PRIMARY KEY (`usage_date`);

--
-- Indexes for table `daily_chat_visitors`
--
ALTER TABLE `daily_chat_visitors`
  ADD PRIMARY KEY (`usage_date`,`visitor_hash`),
  ADD KEY `idx_daily_chat_visitors_date` (`usage_date`);

--
-- Indexes for table `knowledge_base`
--
ALTER TABLE `knowledge_base`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_kb_status_dates` (`status`,`effective_date`,`expiration_date`),
  ADD KEY `fk_kb_category` (`category_id`),
  ADD KEY `fk_kb_admin` (`created_by`);
ALTER TABLE `knowledge_base` ADD FULLTEXT KEY `ft_kb_content` (`title`,`content`);

--
-- Indexes for table `knowledge_embeddings`
--
ALTER TABLE `knowledge_embeddings`
  ADD PRIMARY KEY (`knowledge_base_id`);

--
-- Indexes for table `rate_limits`
--
ALTER TABLE `rate_limits`
  ADD PRIMARY KEY (`key_hash`);

--
-- Indexes for table `student_feedback`
--
ALTER TABLE `student_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_student_feedback_created` (`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=398;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1385;

--
-- AUTO_INCREMENT for table `chat_sessions`
--
ALTER TABLE `chat_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=274;

--
-- AUTO_INCREMENT for table `knowledge_base`
--
ALTER TABLE `knowledge_base`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=664;

--
-- AUTO_INCREMENT for table `student_feedback`
--
ALTER TABLE `student_feedback`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `fk_activity_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `admin_activity_state`
--
ALTER TABLE `admin_activity_state`
  ADD CONSTRAINT `fk_activity_state_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `admin_feedback_state`
--
ALTER TABLE `admin_feedback_state`
  ADD CONSTRAINT `fk_feedback_state_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `fk_announcement_admin` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `fk_chat_message_session` FOREIGN KEY (`chat_session_id`) REFERENCES `chat_sessions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `knowledge_base`
--
ALTER TABLE `knowledge_base`
  ADD CONSTRAINT `fk_kb_admin` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_kb_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `knowledge_embeddings`
--
ALTER TABLE `knowledge_embeddings`
  ADD CONSTRAINT `fk_knowledge_embedding_entry` FOREIGN KEY (`knowledge_base_id`) REFERENCES `knowledge_base` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
