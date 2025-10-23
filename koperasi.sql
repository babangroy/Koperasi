-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for koperasi
CREATE DATABASE IF NOT EXISTS `koperasi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `koperasi`;

-- Dumping structure for table koperasi.anggotas
CREATE TABLE IF NOT EXISTS `anggotas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nik` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nrp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telepon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Aktif','Tidak Aktif') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `anggotas_nrp_unique` (`nrp`),
  UNIQUE KEY `anggotas_nik_unique` (`nik`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.anggotas: ~3 rows (approximately)
INSERT INTO `anggotas` (`id`, `nik`, `nama`, `nrp`, `alamat`, `telepon`, `jenis_kelamin`, `status`, `created_at`, `updated_at`) VALUES
	(2, '1205162609010004', 'Safirudin', 'AAAS0225AS', 'Jl. Medan', '086955412247', 'Laki-laki', 'Tidak Aktif', '2025-10-17 09:46:48', '2025-10-18 13:00:34'),
	(3, '1205162609010001', 'Herman Simbolon', 'MLS44587DD', 'Jl. Sugiono No 5', '085232565521', 'Laki-laki', 'Tidak Aktif', '2025-10-17 10:48:17', '2025-10-17 10:57:10'),
	(4, '1202336522144545', 'Consectetur deserun', 'Provident qui dolor', 'Sunt iusto laborum ', '085266541125', 'Perempuan', 'Aktif', '2025-10-17 11:12:27', '2025-10-17 16:09:32'),
	(5, '1265321544785520', 'Iskandar Muda Sekali', 'AMK114957', 'Jl. Simalungun', '085631455211', 'Perempuan', 'Tidak Aktif', '2025-10-17 16:11:25', '2025-10-18 07:53:03'),
	(6, '0854613255426666', 'Imanuel', 'LKD7726', 'Jl.Medan banda aceh', '085262639948', 'Laki-laki', 'Tidak Aktif', '2025-10-18 02:53:04', '2025-10-18 02:53:16'),
	(7, '1236552122547888', 'Sudirman', '112HHAU88', 'Jl. Palembang-hshahajahajajaj', '085233697741', 'Perempuan', 'Aktif', '2025-10-18 07:58:08', '2025-10-18 09:24:48'),
	(8, '1250467581342278', 'Lina Wati', 'HHSY22514', 'Jl. Ketapang', '0258465133255', 'Laki-laki', 'Aktif', '2025-10-19 14:10:06', '2025-10-19 14:10:06');

-- Dumping structure for table koperasi.barangs
CREATE TABLE IF NOT EXISTS `barangs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_kategori` bigint unsigned NOT NULL,
  `merek` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga_beli` decimal(15,2) NOT NULL DEFAULT '0.00',
  `harga_jual` decimal(15,2) NOT NULL DEFAULT '0.00',
  `id_satuan` bigint unsigned NOT NULL,
  `stok` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barangs_kode_unique` (`kode`),
  KEY `barangs_id_kategori_foreign` (`id_kategori`),
  KEY `barangs_id_satuan_foreign` (`id_satuan`),
  CONSTRAINT `barangs_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `kategoris` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `barangs_id_satuan_foreign` FOREIGN KEY (`id_satuan`) REFERENCES `satuans` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.barangs: ~9 rows (approximately)
INSERT INTO `barangs` (`id`, `kode`, `nama`, `id_kategori`, `merek`, `harga_beli`, `harga_jual`, `id_satuan`, `stok`, `created_at`, `updated_at`) VALUES
	(1, 'BRG0001', 'Pulpen', 1, 'Pilot', 3000.00, 4000.00, 1, 7, '2025-10-17 12:59:08', '2025-10-20 04:17:40'),
	(2, 'BRG0002', 'Indomie Kuah', 4, 'Indomie', 2700.00, 3500.00, 1, 0, '2025-10-17 13:11:05', '2025-10-20 07:56:13'),
	(4, 'BRG0003', 'Otak Otak', 8, 'Pancen oye', 62500.00, 63000.00, 5, 32, '2025-10-18 09:20:20', '2025-10-19 19:28:19'),
	(5, 'BRG0004', 'Kipas Angin', 4, 'Maspion', 150000.00, 200000.00, 4, 29, '2025-10-18 09:20:20', '2025-10-20 04:17:40'),
	(6, 'BRG0005', 'Tikar Anyam', 3, 'Kuda poni', 1500.00, 3000.00, 4, 40, '2025-10-18 09:21:26', '2025-10-19 19:34:19'),
	(7, 'BRG0006', 'Colokan', 5, 'Hani', 20000.00, 25000.00, 4, 38, '2025-10-18 09:21:26', '2025-10-19 19:45:53'),
	(8, 'BRG0007', 'Botol Minum', 9, 'Tupperware', 75000.00, 80000.00, 1, 37, '2025-10-19 14:11:02', '2025-10-19 20:20:49'),
	(9, 'BRG0008', 'Buku Tulis', 1, 'Sidu', 2500.00, 3000.00, 1, 23, '2025-10-19 20:26:03', '2025-10-19 20:44:36'),
	(10, 'BRG0009', 'Sepidol', 1, 'Kenko', 5000.00, 6500.00, 1, 26, '2025-10-19 20:26:59', '2025-10-19 20:44:36');

-- Dumping structure for table koperasi.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.cache: ~0 rows (approximately)

-- Dumping structure for table koperasi.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.cache_locks: ~0 rows (approximately)

-- Dumping structure for table koperasi.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table koperasi.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.jobs: ~0 rows (approximately)

-- Dumping structure for table koperasi.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.job_batches: ~0 rows (approximately)

-- Dumping structure for table koperasi.kategoris
CREATE TABLE IF NOT EXISTS `kategoris` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kategoris_nama_unique` (`nama`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.kategoris: ~9 rows (approximately)
INSERT INTO `kategoris` (`id`, `nama`, `created_at`, `updated_at`) VALUES
	(1, 'ATK', '2025-10-17 10:35:14', '2025-10-18 02:33:43'),
	(2, 'BHP', '2025-10-17 10:40:44', '2025-10-17 10:40:44'),
	(3, 'Minuman Dingin', '2025-10-17 10:41:01', '2025-10-18 02:49:50'),
	(4, 'Makanan', '2025-10-17 10:41:09', '2025-10-17 10:41:09'),
	(5, 'Sembako2', '2025-10-17 16:04:34', '2025-10-18 09:48:39'),
	(6, 'Sinigami', '2025-10-17 23:59:13', '2025-10-17 23:59:13'),
	(7, 'Heidi', '2025-10-17 23:59:34', '2025-10-17 23:59:34'),
	(8, 'Sembako', '2025-10-18 00:00:24', '2025-10-19 14:11:37'),
	(9, 'Alat Bangunan', '2025-10-18 09:22:32', '2025-10-18 09:22:32');

-- Dumping structure for table koperasi.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.migrations: ~6 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2025_10_17_162306_create_anggotas_table', 2),
	(5, '2025_10_17_173015_create_kategoris_table', 3),
	(6, '2025_10_17_192819_create_satuans_table', 4),
	(7, '2025_10_17_193956_create_barangs_table', 5),
	(8, '2025_10_18_053049_create_tokos_table', 6),
	(9, '2025_10_18_170007_create_penjualans_table', 7),
	(10, '2025_10_18_170318_create_penjualan_details_table', 7);

-- Dumping structure for table koperasi.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table koperasi.penjualans
CREATE TABLE IF NOT EXISTS `penjualans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nomor_nota` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anggota_id` bigint unsigned DEFAULT NULL,
  `tanggal` datetime NOT NULL,
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `diskon` decimal(15,2) NOT NULL DEFAULT '0.00',
  `ppn` decimal(15,2) NOT NULL DEFAULT '0.00',
  `grand_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `penjualans_nomor_nota_unique` (`nomor_nota`),
  KEY `penjualans_anggota_id_foreign` (`anggota_id`),
  KEY `penjualans_user_id_foreign` (`user_id`),
  CONSTRAINT `penjualans_anggota_id_foreign` FOREIGN KEY (`anggota_id`) REFERENCES `anggotas` (`id`) ON DELETE SET NULL,
  CONSTRAINT `penjualans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.penjualans: ~45 rows (approximately)
INSERT INTO `penjualans` (`id`, `nomor_nota`, `anggota_id`, `tanggal`, `total`, `diskon`, `ppn`, `grand_total`, `user_id`, `created_at`, `updated_at`) VALUES
	(1, 'KSR-20251018-0001', 6, '2025-10-18 17:30:55', 66500.00, 0.00, 0.00, 66500.00, 2, '2025-10-18 10:30:55', '2025-10-18 10:30:55'),
	(2, 'PNJ-6QO8ISXB', 3, '2025-10-18 18:44:44', 2403500.00, 0.00, 0.00, 2403500.00, 2, '2025-10-18 11:44:44', '2025-10-18 11:44:44'),
	(3, 'PNJ-WWBCSVD7', 6, '2025-10-18 18:47:09', 7000.00, 0.00, 0.00, 7000.00, 2, '2025-10-18 11:47:09', '2025-10-18 11:47:09'),
	(4, 'PJ-20251018185741-CJ9U', 3, '2025-10-18 18:57:41', 3500.00, 0.00, 0.00, 3500.00, 2, '2025-10-18 11:57:41', '2025-10-18 11:57:41'),
	(5, 'NOTA-1760815550', 6, '2025-10-18 19:25:50', 0.00, 0.00, 0.00, 0.00, 2, '2025-10-18 12:25:50', '2025-10-18 12:25:50'),
	(6, 'PJ-20251018195310-GHZ9', 4, '2025-10-18 19:53:10', 3000.00, 0.00, 0.00, 3000.00, 2, '2025-10-18 12:53:10', '2025-10-18 12:53:10'),
	(7, 'PJ-20251018195614-5XH3', 7, '2025-10-18 19:56:14', 15000.00, 4000.00, 0.00, 11000.00, 2, '2025-10-18 12:56:14', '2025-10-18 12:56:14'),
	(8, 'PJ-20251018203441-RTOB', 7, '2025-10-18 20:34:41', 75000.00, 15000.00, 0.00, 60000.00, 2, '2025-10-18 13:34:41', '2025-10-18 13:34:41'),
	(9, 'PJ-20251019154555', 3, '2025-10-19 15:45:55', 50000.00, 0.00, 0.00, 50000.00, 1, '2025-10-19 08:45:55', '2025-10-19 08:45:55'),
	(10, 'PJ-20251019162155', 3, '2025-10-19 16:21:55', 195500.00, 15000.00, 0.00, 195500.00, 1, '2025-10-19 09:21:55', '2025-10-19 09:21:55'),
	(11, 'PJ-20251019164831', 4, '2025-10-19 16:48:31', 200000.00, 200000.00, 0.00, 200000.00, 1, '2025-10-19 09:48:31', '2025-10-19 09:48:31'),
	(12, 'PJ-20251019171359', 4, '2025-10-19 17:13:59', 203500.00, 0.00, 0.00, 203500.00, 1, '2025-10-19 10:13:59', '2025-10-19 10:13:59'),
	(13, 'PJ-20251019183529', 4, '2025-10-19 18:35:29', 25000.00, 0.00, 0.00, 25000.00, 1, '2025-10-19 11:35:29', '2025-10-19 11:35:29'),
	(14, 'PJ-20251019185713', 3, '2025-10-19 18:57:13', 8000.00, 0.00, 0.00, 8000.00, 1, '2025-10-19 11:57:13', '2025-10-19 11:57:13'),
	(15, 'PJ-20251019191053', 2, '2025-10-19 19:10:53', 4000.00, 0.00, 0.00, 4000.00, 1, '2025-10-19 12:10:53', '2025-10-19 12:10:53'),
	(16, 'PJ-20251019210840', 6, '2025-10-19 21:08:40', 64000.00, 5000.00, 0.00, 64000.00, 1, '2025-10-19 14:08:40', '2025-10-19 14:08:40'),
	(17, 'PJ-20251019211458', 8, '2025-10-19 21:14:58', 210000.00, 0.00, 0.00, 210000.00, 1, '2025-10-19 14:14:58', '2025-10-19 14:14:58'),
	(18, 'PJ-20251019230349', 2, '2025-10-19 23:03:49', 75500.00, 0.00, 0.00, 75500.00, 1, '2025-10-19 16:03:49', '2025-10-19 16:03:49'),
	(19, 'PJ-20251019232004', 3, '2025-10-19 23:20:04', 8000.00, 0.00, 0.00, 8000.00, 1, '2025-10-19 16:20:04', '2025-10-19 16:20:04'),
	(20, 'PJ-20251019233420', 2, '2025-10-19 23:34:20', 4000.00, 0.00, 0.00, 4000.00, 1, '2025-10-19 16:34:20', '2025-10-19 16:34:20'),
	(21, 'PJ-20251020002351', 2, '2025-10-20 00:23:51', 207000.00, 0.00, 0.00, 207000.00, 1, '2025-10-19 17:23:51', '2025-10-19 17:23:51'),
	(22, 'PJ-20251020002835', 6, '2025-10-20 00:28:35', 231000.00, 0.00, 0.00, 231000.00, 1, '2025-10-19 17:28:35', '2025-10-19 17:28:35'),
	(23, 'PJ-20251020004735', 5, '2025-10-20 00:47:35', 330000.00, 4000.00, 0.00, 330000.00, 1, '2025-10-19 17:47:35', '2025-10-19 17:47:35'),
	(24, 'PJ-20251020005210', 3, '2025-10-20 00:52:10', 295000.00, 5000.00, 0.00, 295000.00, 1, '2025-10-19 17:52:10', '2025-10-19 17:52:10'),
	(25, 'PJ-20251020005742', 2, '2025-10-20 00:57:42', 8000.00, 0.00, 0.00, 8000.00, 1, '2025-10-19 17:57:42', '2025-10-19 17:57:42'),
	(26, 'PJ-20251020011900', 3, '2025-10-20 01:19:00', 325000.00, 5000.00, 0.00, 325000.00, 1, '2025-10-19 18:19:00', '2025-10-19 18:19:00'),
	(27, 'PJ-20251020012012', 2, '2025-10-20 01:20:12', 504000.00, 0.00, 0.00, 504000.00, 1, '2025-10-19 18:20:12', '2025-10-19 18:20:12'),
	(28, 'PJ-20251020012645', 5, '2025-10-20 01:26:45', 146000.00, 0.00, 0.00, 146000.00, 1, '2025-10-19 18:26:45', '2025-10-19 18:26:45'),
	(29, 'KSR-20251020-0009', 2, '2025-10-20 01:34:43', 1400000.00, 0.00, 0.00, 1400000.00, 1, '2025-10-19 18:34:43', '2025-10-19 18:34:43'),
	(30, 'KSR-20251020-0010', 3, '2025-10-20 01:46:12', 200000.00, 0.00, 0.00, 200000.00, 1, '2025-10-19 18:46:12', '2025-10-19 18:46:12'),
	(31, 'KSR-20251020-0011', 2, '2025-10-20 01:48:58', 83000.00, 0.00, 0.00, 83000.00, 1, '2025-10-19 18:48:58', '2025-10-19 18:48:58'),
	(32, 'KSR-20251020-0012', 2, '2025-10-20 01:49:21', 83000.00, 0.00, 0.00, 83000.00, 1, '2025-10-19 18:49:21', '2025-10-19 18:49:21'),
	(33, 'KSR-20251020-0013', 2, '2025-10-20 01:53:20', 400000.00, 0.00, 0.00, 400000.00, 1, '2025-10-19 18:53:20', '2025-10-19 18:53:20'),
	(34, 'KSR-20251020-0014', 8, '2025-10-20 01:56:56', 400000.00, 0.00, 0.00, 400000.00, 1, '2025-10-19 18:56:56', '2025-10-19 18:56:56'),
	(35, 'KSR-20251020-0015', 3, '2025-10-20 02:00:55', 126000.00, 0.00, 0.00, 126000.00, 1, '2025-10-19 19:00:55', '2025-10-19 19:00:55'),
	(36, 'KSR-20251020-0016', 3, '2025-10-20 02:05:51', 126000.00, 0.00, 0.00, 126000.00, 1, '2025-10-19 19:05:51', '2025-10-19 19:05:51'),
	(37, 'KSR-20251020-0017', 2, '2025-10-20 02:06:22', 200000.00, 0.00, 0.00, 200000.00, 1, '2025-10-19 19:06:22', '2025-10-19 19:06:22'),
	(38, 'KSR-20251020-0018', 2, '2025-10-20 02:14:53', 63000.00, 0.00, 0.00, 63000.00, 1, '2025-10-19 19:14:53', '2025-10-19 19:14:53'),
	(39, 'KSR-20251020-0019', 2, '2025-10-20 02:19:47', 63000.00, 0.00, 0.00, 63000.00, 1, '2025-10-19 19:19:47', '2025-10-19 19:19:47'),
	(40, 'KSR-20251020-0020', 2, '2025-10-20 02:20:17', 4000.00, 0.00, 0.00, 4000.00, 1, '2025-10-19 19:20:17', '2025-10-19 19:20:17'),
	(41, 'KSR-20251020-0021', 2, '2025-10-20 02:22:50', 4000.00, 0.00, 0.00, 4000.00, 1, '2025-10-19 19:22:50', '2025-10-19 19:22:50'),
	(42, 'KSR-20251020-0022', 2, '2025-10-20 02:26:24', 66000.00, 0.00, 0.00, 66000.00, 1, '2025-10-19 19:26:24', '2025-10-19 19:26:24'),
	(43, 'KSR-20251020-0023', 4, '2025-10-20 02:28:19', 63000.00, 0.00, 0.00, 63000.00, 1, '2025-10-19 19:28:19', '2025-10-19 19:28:19'),
	(44, 'KSR-20251020-0024', 3, '2025-10-20 02:34:19', 61000.00, 0.00, 0.00, 61000.00, 1, '2025-10-19 19:34:19', '2025-10-19 19:34:19'),
	(45, 'KSR-20251020-0025', 6, '2025-10-20 02:37:26', 243000.00, 5000.00, 0.00, 243000.00, 1, '2025-10-19 19:37:26', '2025-10-19 19:37:26'),
	(46, 'KSR-20251020-0026', 2, '2025-10-20 02:45:53', 47000.00, 7000.00, 0.00, 47000.00, 1, '2025-10-19 19:45:53', '2025-10-19 19:45:53'),
	(47, 'KSR-20251020-0027', 3, '2025-10-20 03:20:49', 160000.00, 0.00, 0.00, 160000.00, 1, '2025-10-19 20:20:49', '2025-10-19 20:20:49'),
	(48, 'KSR-20251020-0028', 3, '2025-10-20 03:44:36', 25000.00, 0.00, 0.00, 25000.00, 1, '2025-10-19 20:44:36', '2025-10-19 20:44:36'),
	(49, 'KSR-20251020-0029', 6, '2025-10-20 03:48:49', 200000.00, 0.00, 0.00, 200000.00, 1, '2025-10-19 20:48:49', '2025-10-19 20:48:49'),
	(50, 'KSR-20251020-0030', 2, '2025-10-20 11:17:40', 408000.00, 0.00, 0.00, 408000.00, 1, '2025-10-20 04:17:40', '2025-10-20 04:17:40');

-- Dumping structure for table koperasi.penjualan_details
CREATE TABLE IF NOT EXISTS `penjualan_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `penjualan_id` bigint unsigned NOT NULL,
  `barang_id` bigint unsigned NOT NULL,
  `qty` int NOT NULL,
  `harga` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `penjualan_details_penjualan_id_foreign` (`penjualan_id`),
  KEY `penjualan_details_barang_id_foreign` (`barang_id`),
  CONSTRAINT `penjualan_details_barang_id_foreign` FOREIGN KEY (`barang_id`) REFERENCES `barangs` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `penjualan_details_penjualan_id_foreign` FOREIGN KEY (`penjualan_id`) REFERENCES `penjualans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.penjualan_details: ~73 rows (approximately)
INSERT INTO `penjualan_details` (`id`, `penjualan_id`, `barang_id`, `qty`, `harga`, `subtotal`, `created_at`, `updated_at`) VALUES
	(1, 1, 2, 1, 3500.00, 3500.00, '2025-10-18 10:30:55', '2025-10-18 10:30:55'),
	(2, 1, 4, 1, 63000.00, 63000.00, '2025-10-18 10:30:55', '2025-10-18 10:30:55'),
	(3, 2, 2, 1, 3500.00, 3500.00, '2025-10-18 11:44:44', '2025-10-18 11:44:44'),
	(4, 2, 5, 12, 200000.00, 2400000.00, '2025-10-18 11:44:44', '2025-10-18 11:44:44'),
	(5, 3, 2, 2, 3500.00, 7000.00, '2025-10-18 11:47:09', '2025-10-18 11:47:09'),
	(6, 4, 2, 1, 3500.00, 3500.00, '2025-10-18 11:57:41', '2025-10-18 11:57:41'),
	(7, 6, 6, 1, 3000.00, 3000.00, '2025-10-18 12:53:10', '2025-10-18 12:53:10'),
	(8, 7, 1, 3, 4000.00, 12000.00, '2025-10-18 12:56:14', '2025-10-18 12:56:14'),
	(9, 7, 6, 1, 3000.00, 3000.00, '2025-10-18 12:56:14', '2025-10-18 12:56:14'),
	(10, 8, 7, 3, 25000.00, 75000.00, '2025-10-18 13:34:41', '2025-10-18 13:34:41'),
	(11, 9, 7, 2, 25000.00, 50000.00, '2025-10-19 08:45:55', '2025-10-19 08:45:55'),
	(12, 10, 2, 3, 3500.00, 10500.00, '2025-10-19 09:21:55', '2025-10-19 09:21:55'),
	(13, 10, 5, 1, 200000.00, 200000.00, '2025-10-19 09:21:55', '2025-10-19 09:21:55'),
	(14, 11, 5, 2, 200000.00, 400000.00, '2025-10-19 09:48:31', '2025-10-19 09:48:31'),
	(15, 12, 2, 1, 3500.00, 3500.00, '2025-10-19 10:13:59', '2025-10-19 10:13:59'),
	(16, 12, 5, 1, 200000.00, 200000.00, '2025-10-19 10:13:59', '2025-10-19 10:13:59'),
	(17, 13, 7, 1, 25000.00, 25000.00, '2025-10-19 11:35:29', '2025-10-19 11:35:29'),
	(18, 14, 1, 3, 4000.00, 8000.00, '2025-10-19 11:57:13', '2025-10-19 11:57:13'),
	(19, 15, 1, 1, 4000.00, 4000.00, '2025-10-19 12:10:53', '2025-10-19 12:10:53'),
	(20, 16, 6, 2, 3000.00, 6000.00, '2025-10-19 14:08:40', '2025-10-19 14:08:40'),
	(21, 16, 4, 1, 63000.00, 63000.00, '2025-10-19 14:08:40', '2025-10-19 14:08:40'),
	(22, 17, 8, 2, 80000.00, 160000.00, '2025-10-19 14:14:58', '2025-10-19 14:14:58'),
	(23, 17, 7, 2, 25000.00, 50000.00, '2025-10-19 14:14:58', '2025-10-19 14:14:58'),
	(24, 18, 1, 18, 4000.00, 72000.00, '2025-10-19 16:03:49', '2025-10-19 16:03:49'),
	(25, 18, 2, 1, 3500.00, 3500.00, '2025-10-19 16:03:49', '2025-10-19 16:03:49'),
	(26, 19, 1, 2, 4000.00, 8000.00, '2025-10-19 16:20:04', '2025-10-19 16:20:04'),
	(27, 20, 1, 1, 4000.00, 4000.00, '2025-10-19 16:34:20', '2025-10-19 16:34:20'),
	(28, 21, 1, 1, 4000.00, 4000.00, '2025-10-19 17:23:51', '2025-10-19 17:23:51'),
	(29, 21, 5, 1, 200000.00, 200000.00, '2025-10-19 17:23:51', '2025-10-19 17:23:51'),
	(30, 21, 6, 1, 3000.00, 3000.00, '2025-10-19 17:23:51', '2025-10-19 17:23:51'),
	(31, 22, 7, 1, 25000.00, 25000.00, '2025-10-19 17:28:35', '2025-10-19 17:28:35'),
	(32, 22, 5, 1, 200000.00, 200000.00, '2025-10-19 17:28:35', '2025-10-19 17:28:35'),
	(33, 22, 6, 2, 3000.00, 6000.00, '2025-10-19 17:28:35', '2025-10-19 17:28:35'),
	(34, 23, 1, 1, 4000.00, 4000.00, '2025-10-19 17:47:35', '2025-10-19 17:47:35'),
	(35, 23, 5, 1, 200000.00, 200000.00, '2025-10-19 17:47:35', '2025-10-19 17:47:35'),
	(36, 23, 7, 2, 25000.00, 50000.00, '2025-10-19 17:47:35', '2025-10-19 17:47:35'),
	(37, 23, 8, 1, 80000.00, 80000.00, '2025-10-19 17:47:35', '2025-10-19 17:47:35'),
	(38, 24, 1, 5, 4000.00, 20000.00, '2025-10-19 17:52:10', '2025-10-19 17:52:10'),
	(39, 24, 5, 1, 200000.00, 200000.00, '2025-10-19 17:52:10', '2025-10-19 17:52:10'),
	(40, 24, 8, 1, 80000.00, 80000.00, '2025-10-19 17:52:10', '2025-10-19 17:52:10'),
	(41, 25, 1, 2, 4000.00, 8000.00, '2025-10-19 17:57:42', '2025-10-19 17:57:42'),
	(42, 26, 5, 1, 200000.00, 200000.00, '2025-10-19 18:19:00', '2025-10-19 18:19:00'),
	(43, 26, 8, 1, 80000.00, 80000.00, '2025-10-19 18:19:00', '2025-10-19 18:19:00'),
	(44, 26, 7, 2, 25000.00, 50000.00, '2025-10-19 18:19:00', '2025-10-19 18:19:00'),
	(45, 27, 4, 8, 63000.00, 504000.00, '2025-10-19 18:20:12', '2025-10-19 18:20:12'),
	(46, 28, 4, 1, 63000.00, 63000.00, '2025-10-19 18:26:45', '2025-10-19 18:26:45'),
	(47, 28, 6, 1, 3000.00, 3000.00, '2025-10-19 18:26:45', '2025-10-19 18:26:45'),
	(48, 28, 8, 1, 80000.00, 80000.00, '2025-10-19 18:26:45', '2025-10-19 18:26:45'),
	(49, 29, 5, 7, 200000.00, 1400000.00, '2025-10-19 18:34:43', '2025-10-19 18:34:43'),
	(50, 30, 5, 1, 200000.00, 200000.00, '2025-10-19 18:46:12', '2025-10-19 18:46:12'),
	(51, 31, 8, 1, 80000.00, 80000.00, '2025-10-19 18:48:58', '2025-10-19 18:48:58'),
	(52, 31, 6, 1, 3000.00, 3000.00, '2025-10-19 18:48:58', '2025-10-19 18:48:58'),
	(53, 32, 8, 1, 80000.00, 80000.00, '2025-10-19 18:49:21', '2025-10-19 18:49:21'),
	(54, 32, 6, 1, 3000.00, 3000.00, '2025-10-19 18:49:21', '2025-10-19 18:49:21'),
	(55, 33, 5, 2, 200000.00, 400000.00, '2025-10-19 18:53:20', '2025-10-19 18:53:20'),
	(56, 34, 5, 2, 200000.00, 400000.00, '2025-10-19 18:56:56', '2025-10-19 18:56:56'),
	(57, 35, 4, 2, 63000.00, 126000.00, '2025-10-19 19:00:55', '2025-10-19 19:00:55'),
	(58, 36, 4, 2, 63000.00, 126000.00, '2025-10-19 19:05:51', '2025-10-19 19:05:51'),
	(59, 37, 5, 1, 200000.00, 200000.00, '2025-10-19 19:06:22', '2025-10-19 19:06:22'),
	(60, 38, 4, 1, 63000.00, 63000.00, '2025-10-19 19:14:53', '2025-10-19 19:14:53'),
	(61, 39, 4, 1, 63000.00, 63000.00, '2025-10-19 19:19:47', '2025-10-19 19:19:47'),
	(62, 40, 1, 1, 4000.00, 4000.00, '2025-10-19 19:20:17', '2025-10-19 19:20:17'),
	(63, 41, 1, 1, 4000.00, 4000.00, '2025-10-19 19:22:50', '2025-10-19 19:22:50'),
	(64, 42, 4, 1, 63000.00, 63000.00, '2025-10-19 19:26:24', '2025-10-19 19:26:24'),
	(65, 42, 6, 1, 3000.00, 3000.00, '2025-10-19 19:26:24', '2025-10-19 19:26:24'),
	(66, 43, 4, 1, 63000.00, 63000.00, '2025-10-19 19:28:19', '2025-10-19 19:28:19'),
	(67, 44, 1, 2, 4000.00, 8000.00, '2025-10-19 19:34:19', '2025-10-19 19:34:19'),
	(68, 44, 6, 1, 3000.00, 3000.00, '2025-10-19 19:34:19', '2025-10-19 19:34:19'),
	(69, 44, 7, 2, 25000.00, 50000.00, '2025-10-19 19:34:19', '2025-10-19 19:34:19'),
	(70, 45, 1, 2, 4000.00, 8000.00, '2025-10-19 19:37:26', '2025-10-19 19:37:26'),
	(71, 45, 8, 3, 80000.00, 240000.00, '2025-10-19 19:37:26', '2025-10-19 19:37:26'),
	(72, 46, 1, 1, 4000.00, 4000.00, '2025-10-19 19:45:53', '2025-10-19 19:45:53'),
	(73, 46, 7, 2, 25000.00, 50000.00, '2025-10-19 19:45:53', '2025-10-19 19:45:53'),
	(74, 47, 8, 2, 80000.00, 160000.00, '2025-10-19 20:20:49', '2025-10-19 20:20:49'),
	(75, 48, 10, 2, 6500.00, 13000.00, '2025-10-19 20:44:36', '2025-10-19 20:44:36'),
	(76, 48, 9, 4, 3000.00, 12000.00, '2025-10-19 20:44:36', '2025-10-19 20:44:36'),
	(77, 49, 5, 1, 200000.00, 200000.00, '2025-10-19 20:48:49', '2025-10-19 20:48:49'),
	(78, 50, 1, 2, 4000.00, 8000.00, '2025-10-20 04:17:40', '2025-10-20 04:17:40'),
	(79, 50, 5, 2, 200000.00, 400000.00, '2025-10-20 04:17:40', '2025-10-20 04:17:40');

-- Dumping structure for table koperasi.satuans
CREATE TABLE IF NOT EXISTS `satuans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.satuans: ~7 rows (approximately)
INSERT INTO `satuans` (`id`, `nama`, `created_at`, `updated_at`) VALUES
	(1, 'PCS', '2025-10-17 12:31:00', '2025-10-19 20:43:11'),
	(2, 'Dus', '2025-10-17 12:33:16', '2025-10-17 12:33:16'),
	(3, 'Box', '2025-10-17 12:35:12', '2025-10-17 12:35:12'),
	(4, 'Kaleng', '2025-10-18 02:34:59', '2025-10-18 02:34:59'),
	(5, 'Renteng', '2025-10-18 02:35:17', '2025-10-18 02:35:17'),
	(6, 'Buah', '2025-10-18 02:54:02', '2025-10-18 02:54:02'),
	(7, 'Botol Kaca', '2025-10-18 02:54:17', '2025-10-18 02:56:25');

-- Dumping structure for table koperasi.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.sessions: ~4 rows (approximately)
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('4F4YZ31LBpuvmywriMKHS3ZcShnAQTRRxZnEYccc', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo3OntzOjM6InVybCI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly9rb3BlcmFzaS50ZXN0L2tvcGVyYXNpL2thc2lyLXBvcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NjoiX3Rva2VuIjtzOjQwOiJVRnFNRG1sTG1ZdHhDcml4VEg0MUgxV05XcjY1RWx0WDB5bXRuV0dBIjtzOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkcnMuWDQyWDZRdG1sLk5QeTZTeDBMT1RPelk5d3MuVTh0Y2s3RnNLSWI3YnRpN2dDRTEzcHkiO3M6NjoidGFibGVzIjthOjQ6e3M6NDA6ImFmNTE4MmRkOGJmZWZhNDRmMWExZjY3ZmU2NDYxMTNiX2NvbHVtbnMiO2E6Mjp7aTowO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjU6ImluZGV4IjtzOjU6ImxhYmVsIjtzOjM6Ik5vLiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoibmFtYSI7czo1OiJsYWJlbCI7czo0OiJOYW1hIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fX1zOjQwOiJhMDg5MjlmMTRmY2U0NzI3YWUxYzIwMGM1MmY5ZDU0NF9jb2x1bW5zIjthOjI6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJpbmRleCI7czo1OiJsYWJlbCI7czozOiJOby4iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToxO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6Im5hbWEiO3M6NToibGFiZWwiO3M6NDoiTmFtYSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO319czo0MDoiZTFiMjViYjZmMGEzYTY5NmNlOGFlZDhlMzIzNTUyMmVfY29sdW1ucyI7YTo5OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NToiaW5kZXgiO3M6NToibGFiZWwiO3M6MzoiTm8uIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo0OiJrb2RlIjtzOjU6ImxhYmVsIjtzOjQ6IktvZGUiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6Im5hbWEiO3M6NToibGFiZWwiO3M6NDoiTmFtYSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjM7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTM6ImthdGVnb3JpLm5hbWEiO3M6NToibGFiZWwiO3M6ODoiS2F0ZWdvcmkiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjU6Im1lcmVrIjtzOjU6ImxhYmVsIjtzOjU6Ik1lcmVrIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiaGFyZ2FfYmVsaSI7czo1OiJsYWJlbCI7czoxMDoiSGFyZ2EgYmVsaSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjY7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImhhcmdhX2p1YWwiO3M6NToibGFiZWwiO3M6MTA6IkhhcmdhIGp1YWwiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo3O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjExOiJzYXR1YW4ubmFtYSI7czo1OiJsYWJlbCI7czo2OiJTYXR1YW4iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo4O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6InN0b2siO3M6NToibGFiZWwiO3M6NDoiU3RvayI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO319czo0MDoiZjY3YjhmYmViZDVmM2M1ZDE5MTczMDgwYjM3ZDU4NWVfY29sdW1ucyI7YTo5OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NToiaW5kZXgiO3M6NToibGFiZWwiO3M6MzoiTm8uIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czozOiJuaWsiO3M6NToibGFiZWwiO3M6MzoiTklLIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo0OiJuYW1hIjtzOjU6ImxhYmVsIjtzOjQ6Ik5hbWEiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjM6Im5ycCI7czo1OiJsYWJlbCI7czozOiJOUlAiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6ImFsYW1hdCI7czo1OiJsYWJlbCI7czo2OiJBbGFtYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo1O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjc6InRlbGVwb24iO3M6NToibGFiZWwiO3M6MTA6Ik5vIFRlbGVwb24iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo2O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEzOiJqZW5pc19rZWxhbWluIjtzOjU6ImxhYmVsIjtzOjEzOiJKZW5pcyBLZWxhbWluIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo2OiJzdGF0dXMiO3M6NToibGFiZWwiO3M6NjoiU3RhdHVzIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6ODthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiY3JlYXRlZF9hdCI7czo1OiJsYWJlbCI7czoxNDoiVGFuZ2dhbCBEYWZ0YXIiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fX19', 1760965788),
	('eZdDBN19hvYD0WBDzfAVLc0036naK5YN3xlswsRR', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiYjMzcTJYYkdXc1duOUFLYVRJelB4VVpYZERTc1pyT0J5RTRJSWpTTSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1760972341),
	('MI4UeoG7IqKlBF1SXPHLD5alcjrq6ZvAKWSfzgvm', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiaFNmUjlFNDJTcFhUMEw3cTdjMGRNR3Ixd3JIaXByTlBiWDZmQ1JmTyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9rb3BlcmFzaSI7fXM6ODoiZmlsYW1lbnQiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRycy5YNDJYNlF0bWwuTlB5NlN4MExPVE96WTl3cy5VOHRjazdGc0tJYjdidGk3Z0NFMTNweSI7czo2OiJ0YWJsZXMiO2E6Njp7czo0MDoiZjY3YjhmYmViZDVmM2M1ZDE5MTczMDgwYjM3ZDU4NWVfY29sdW1ucyI7YTo5OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NToiaW5kZXgiO3M6NToibGFiZWwiO3M6MzoiTm8uIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czozOiJuaWsiO3M6NToibGFiZWwiO3M6MzoiTklLIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo0OiJuYW1hIjtzOjU6ImxhYmVsIjtzOjQ6Ik5hbWEiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjM6Im5ycCI7czo1OiJsYWJlbCI7czozOiJOUlAiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjY6ImFsYW1hdCI7czo1OiJsYWJlbCI7czo2OiJBbGFtYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo1O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjc6InRlbGVwb24iO3M6NToibGFiZWwiO3M6MTA6Ik5vIFRlbGVwb24iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo2O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEzOiJqZW5pc19rZWxhbWluIjtzOjU6ImxhYmVsIjtzOjEzOiJKZW5pcyBLZWxhbWluIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo2OiJzdGF0dXMiO3M6NToibGFiZWwiO3M6NjoiU3RhdHVzIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6ODthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMDoiY3JlYXRlZF9hdCI7czo1OiJsYWJlbCI7czoxNDoiVGFuZ2dhbCBEYWZ0YXIiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fXM6NDA6ImUxYjI1YmI2ZjBhM2E2OTZjZThhZWQ4ZTMyMzU1MjJlX2NvbHVtbnMiO2E6OTp7aTowO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjU6ImluZGV4IjtzOjU6ImxhYmVsIjtzOjM6Ik5vLiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoia29kZSI7czo1OiJsYWJlbCI7czo0OiJLb2RlIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo0OiJuYW1hIjtzOjU6ImxhYmVsIjtzOjQ6Ik5hbWEiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEzOiJrYXRlZ29yaS5uYW1hIjtzOjU6ImxhYmVsIjtzOjg6IkthdGVnb3JpIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJtZXJlayI7czo1OiJsYWJlbCI7czo1OiJNZXJlayI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImhhcmdhX2JlbGkiO3M6NToibGFiZWwiO3M6MTA6IkhhcmdhIGJlbGkiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTo2O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEwOiJoYXJnYV9qdWFsIjtzOjU6ImxhYmVsIjtzOjEwOiJIYXJnYSBqdWFsIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6NzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMToic2F0dWFuLm5hbWEiO3M6NToibGFiZWwiO3M6NjoiU2F0dWFuIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6ODthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo0OiJzdG9rIjtzOjU6ImxhYmVsIjtzOjQ6IlN0b2siO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9fXM6NDA6ImEwODkyOWYxNGZjZTQ3MjdhZTFjMjAwYzUyZjlkNTQ0X2NvbHVtbnMiO2E6Mjp7aTowO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjU6ImluZGV4IjtzOjU6ImxhYmVsIjtzOjM6Ik5vLiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoibmFtYSI7czo1OiJsYWJlbCI7czo0OiJOYW1hIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fX1zOjQwOiJhZjUxODJkZDhiZmVmYTQ0ZjFhMWY2N2ZlNjQ2MTEzYl9jb2x1bW5zIjthOjI6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJpbmRleCI7czo1OiJsYWJlbCI7czozOiJOby4iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToxO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6Im5hbWEiO3M6NToibGFiZWwiO3M6NDoiTmFtYSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO319czo0MDoiZTY0NDgzM2Y0ZTRlMDg3MTIzMTVkYTcxYjMzZmFjZDJfY29sdW1ucyI7YTo0OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NToiaW5kZXgiO3M6NToibGFiZWwiO3M6MzoiTm8uIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo0OiJuYW1lIjtzOjU6ImxhYmVsIjtzOjQ6Ik5hbWEiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aToyO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjg6InVzZXJuYW1lIjtzOjU6ImxhYmVsIjtzOjg6IlVzZXJuYW1lIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MzthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo1OiJlbWFpbCI7czo1OiJsYWJlbCI7czo1OiJFbWFpbCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO319czo0MDoiMzA2ZTEyNDEwNGU5ZTdkODA5YjRhYjk3ZGNmZTI2NzJfY29sdW1ucyI7YTo0OntpOjA7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NDoibmFtYSI7czo1OiJsYWJlbCI7czo0OiJOYW1hIjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MTthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo2OiJhbGFtYXQiO3M6NToibGFiZWwiO3M6NjoiQWxhbWF0IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MDtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO047fWk6MjthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czo3OiJ0ZWxlcG9uIjtzOjU6ImxhYmVsIjtzOjc6IlRlbGVwb24iO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjc6InBlbWlsaWsiO3M6NToibGFiZWwiO3M6NzoiUGVtaWxpayI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO319fX0=', 1760972749),
	('nojfrvwI7MpbnJqle8xx2BpPTsIHUxDlUztEq7uB', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMm43bHFNc0VLSUhMT0RBbEJ3Z1ZiSlVvTFd3WHNEb3QyWkhSQ0NEayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTY6Imh0dHA6Ly9sb2NhbGhvc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1760965571);

-- Dumping structure for table koperasi.tokos
CREATE TABLE IF NOT EXISTS `tokos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telepon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pemilik` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.tokos: ~2 rows (approximately)
INSERT INTO `tokos` (`id`, `nama`, `alamat`, `telepon`, `pemilik`, `created_at`, `updated_at`) VALUES
	(1, 'Koperasi Mako Lanud Soewondo', 'Jl. Imam Bonjol, Suka Damai, Kec. Medan Polonia, Kota Medan', '081234567890', 'LANUD SOEWONDO', '2025-10-17 22:39:42', '2025-10-19 20:48:18');

-- Dumping structure for table koperasi.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_user_unique` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table koperasi.users: ~2 rows (approximately)
INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Roy Tua Manihuruk', 'roy', 'royparasian120@gmail.com', NULL, '$2y$12$rs.X42X6Qtml.NPy6Sx0LOTOzY9ws.U8tck7FsKIb7bti7gCE13py', 't3XYaUCU5dyjyKP5KvUoIuR3OLyPd2T27KG3JzVEmT8jzPukUOTDjxSVFjwn', '2025-10-17 08:37:30', '2025-10-20 04:20:12'),
	(2, 'Piter Parker', 'piter', 'piter@gmail.com', NULL, '$2y$12$sEwC9xhvRDH0ZoLVsCyU0enWDnxHUfXdYijBlRfhoAo8D.KjqfI02', NULL, '2025-10-17 16:03:46', '2025-10-19 14:24:33'),
	(4, 'rani', 'rani21', 'rani@gmail.com', NULL, '$2y$12$uRwXevb.vKWu0mtAgw90QuWLTHUlQo9EJ8oJOT47rkdPFBHkNCfra', NULL, '2025-10-18 02:12:43', '2025-10-18 02:48:19'),
	(5, 'Admin Hamidun', 'admin', 'ruthpadinarizky904@gmail.com', NULL, '$2y$12$/sY3oVeJAhH5SIzfHegqRuBkHp1AMagSCShN4hgTZjSeP6KoVpEwi', NULL, '2025-10-19 14:24:13', '2025-10-19 14:24:13');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
