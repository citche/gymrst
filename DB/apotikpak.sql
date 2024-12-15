-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2024 at 03:43 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_apotek`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `pelanggan` varchar(15) NOT NULL,
  `produk` varchar(11) NOT NULL,
  `jumlah_produk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `keranjang_pelanggan`
-- (See below for the actual view)
--
CREATE TABLE `keranjang_pelanggan` (
`pelanggan` varchar(15)
,`nama` varchar(50)
,`gambar` text
,`kode_obat` varchar(11)
,`nama_obat` varchar(50)
,`harga` decimal(6,3)
,`jumlah_produk` int(11)
,`total_harga` decimal(16,3)
);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `no_hp` varchar(15) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL,
  `alamat` text NOT NULL,
  `jk` enum('Laki-Laki','Perempuan') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`no_hp`, `nama`, `password`, `alamat`, `jk`) VALUES
('081234567891', 'Gusbayu', '123', 'Jl. Nu', 'Laki-Laki'),
('082233334444', 'Safira', '123', 'Jl. Syiah', 'Perempuan');

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `kode_obat` varchar(11) NOT NULL,
  `nama_obat` varchar(50) NOT NULL,
  `harga` decimal(6,3) NOT NULL,
  `kategori` varchar(11) NOT NULL,
  `stok` int(11) NOT NULL,
  `kegunaan` text NOT NULL,
  `file_gambar` longblob NOT NULL,
  `gambar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `kode_transaksi` int(11) NOT NULL,
  `pelanggan` varchar(15) NOT NULL,
  `jumlah_produk` int(11) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `grand_total` decimal(6,3) NOT NULL,
  `catatan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure for view `keranjang_pelanggan`
--
DROP TABLE IF EXISTS `keranjang_pelanggan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `keranjang_pelanggan`  AS SELECT `cart`.`pelanggan` AS `pelanggan`, `member`.`nama` AS `nama`, `obat`.`gambar` AS `gambar`, `obat`.`kode_obat` AS `kode_obat`, `obat`.`nama_obat` AS `nama_obat`, `obat`.`harga` AS `harga`, `cart`.`jumlah_produk` AS `jumlah_produk`, `obat`.`harga`* `cart`.`jumlah_produk` AS `total_harga` FROM ((`member` join `obat`) join `cart`) WHERE `cart`.`pelanggan` = `member`.`no_hp` AND `cart`.`produk` = `obat`.`kode_obat` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD KEY `pelanggan` (`pelanggan`),
  ADD KEY `produk` (`produk`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`no_hp`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`kode_obat`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`kode_transaksi`),
  ADD KEY `transaksi_ibfk_1` (`pelanggan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `kode_transaksi` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`pelanggan`) REFERENCES `member` (`no_hp`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`produk`) REFERENCES `obat` (`kode_obat`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`pelanggan`) REFERENCES `member` (`no_hp`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
