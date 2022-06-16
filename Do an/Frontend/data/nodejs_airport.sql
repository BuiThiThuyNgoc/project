-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 16, 2022 lúc 06:31 AM
-- Phiên bản máy phục vụ: 10.4.24-MariaDB
-- Phiên bản PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `nodejs_airport`
--
CREATE DATABASE IF NOT EXISTS `nodejs_airport` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `nodejs_airport`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `accounts`
--

CREATE TABLE `accounts` (
  `acc_id` varchar(10) NOT NULL,
  `acc_name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `acc_type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `accounts`
--

INSERT INTO `accounts` (`acc_id`, `acc_name`, `password`, `acc_type`) VALUES
('KH1', 'tin', '123', 'customer'),
('AD1', 'admin', '1', 'admin');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `booking_tickets`
--

CREATE TABLE `booking_tickets` (
  `booking_id` int(10) NOT NULL,
  `cust_id` varchar(10) NOT NULL,
  `tic_id` varchar(10) NOT NULL,
  `booking_time` time NOT NULL DEFAULT current_timestamp(),
  `booking_date` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `booking_tickets`
--

INSERT INTO `booking_tickets` (`booking_id`, `cust_id`, `tic_id`, `booking_time`, `booking_date`) VALUES
(2, 'KH1', 'T1', '18:00:02', '2022-06-16'),
(3, 'KH1', 'T4', '18:22:56', '2022-06-16'),
(4, 'KH1', 'T3', '18:26:54', '2022-06-16'),
(5, 'KH1', 'T3', '18:28:00', '2022-06-16'),
(6, 'KH1', 'T5', '09:43:46', '2022-06-16');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

CREATE TABLE `customer` (
  `cust_id` varchar(10) NOT NULL,
  `cust_name` varchar(255) NOT NULL,
  `cust_bdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`cust_id`, `cust_name`, `cust_bdate`) VALUES
('KH1', 'Lê Văn Phúc', '2001-02-11');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tickets`
--

CREATE TABLE `tickets` (
  `tic_id` varchar(10) NOT NULL,
  `tic_start` varchar(100) NOT NULL,
  `tic_destination` varchar(100) NOT NULL,
  `tic_price` int(20) NOT NULL,
  `flight_id` varchar(10) NOT NULL,
  `Date_Start` date DEFAULT NULL,
  `Time_Start` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `tickets`
--

INSERT INTO `tickets` (`tic_id`, `tic_start`, `tic_destination`, `tic_price`, `flight_id`, `Date_Start`, `Time_Start`) VALUES
('T1', 'Ho Chi Minh', 'Hue', 1000000, 'Flight1', NULL, NULL),
('T2', 'Hue', 'Ha Noi', 2000000, 'Flight2', NULL, NULL),
('T3', 'Dak Lak', 'Ho Chi Minh', 1000000, 'Flight3', NULL, NULL),
('T4', 'Ho Chi Minh', 'Da Nang', 1200000, 'Flight4', '2022-06-16', '09:15:00'),
('T5', 'Ho Chi Minh', 'Da Nang', 1300000, 'Flight5', '2022-06-16', '09:50:00');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `booking_tickets`
--
ALTER TABLE `booking_tickets`
  ADD PRIMARY KEY (`booking_id`);

--
-- Chỉ mục cho bảng `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cust_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `booking_tickets`
--
ALTER TABLE `booking_tickets`
  MODIFY `booking_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
