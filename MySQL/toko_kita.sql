-- ================================================================
-- LANGKAH 1: Tabel Kategori
-- ================================================================
CREATE DATABASE toko_kita;
USE toko_kita;
CREATE TABLE kategori (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori  VARCHAR(50) NOT NULL
);

INSERT INTO kategori (nama_kategori)
VALUES
    ('Elektronik'),
    ('Pakaian'),
    ('Makanan'),
    ('Alat Tulis'),
    ('Aksesoris');


-- ================================================================
-- LANGKAH 2: Tabel Produk
-- ================================================================

CREATE TABLE produk (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk  VARCHAR(100) NOT NULL,
    harga        DECIMAL(12,2) NOT NULL,
    stok         INT DEFAULT 0,
    kategori_id  INT,
    FOREIGN KEY (kategori_id)
        REFERENCES kategori(id)
);

INSERT INTO produk
    (nama_produk, harga, stok, kategori_id)
VALUES
    ('Laptop Asus',        7500000, 10, 1),
    ('Mouse Wireless',      150000, 50, 1),
    ('Kaos Polos',           75000, 100, 2),
    ('Keripik Singkong',     15000, 200, 3),
    ('Headphone Bluetooth', 350000, 30, 1),
    ('Celana Jeans',        180000, 60, 2),
    ('Coklat Batang',        12000, 150, 3),
    ('Pulpen Pilot',          5000, 500, 4),
    ('Buku Tulis A5',         8000, 300, 4),
    ('Gelang Kulit',         45000, 80, 5),
    ('Charger USB-C',        95000, 40, 1),
    ('Jaket Hoodie',        150000, 45, 2),
    ('Mie Instan (isi 5)',   18000, 400, 3),
    ('Stabilo Warna',        25000, 120, 4),
    ('Topi Baseball',        55000, 70, 5);


-- ================================================================
-- LANGKAH 3: Tabel Pelanggan
-- ================================================================

CREATE TABLE pelanggan (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    nama       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) UNIQUE,
    kota       VARCHAR(50),
    tgl_daftar DATE
);

INSERT INTO pelanggan (nama, email, kota, tgl_daftar)
VALUES
    ('Budi Santoso',    'budi@email.com',    'Jakarta',   '2026-01-10'),
    ('Siti Aminah',     'siti@email.com',    'Bandung',   '2026-01-15'),
    ('Andi Pratama',    'andi@email.com',    'Surabaya',  '2026-02-01'),
    ('Rina Wulandari',  'rina@email.com',   'Pekanbaru', '2026-02-14'),
    ('Doni Saputra',    'doni@email.com',    'Jakarta',   '2026-03-01'),
    ('Maya Putri',      'maya@email.com',    'Medan',     '2026-03-05'),
    ('Fajar Hidayat',   'fajar@email.com',   'Bandung',   '2026-03-10'),
    ('Lina Marlina',    'lina@email.com',    'Pekanbaru', '2026-03-20');


-- ================================================================
-- LANGKAH 4: Tabel Pesanan dan Detail Pesanan
-- ================================================================

CREATE TABLE pesanan (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    pelanggan_id  INT,
    tgl_pesanan   DATETIME,
    STATUS        VARCHAR(20) DEFAULT 'pending',
    FOREIGN KEY (pelanggan_id)
        REFERENCES pelanggan(id)
); 

CREATE TABLE detail_pesanan (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    pesanan_id      INT,
    produk_id       INT,
    jumlah          INT NOT NULL,
    harga_saat_beli DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(id),
    FOREIGN KEY (produk_id) REFERENCES produk(id)
);


-- ================================================================
-- LANGKAH 5: Isi Data Simulasi Pesanan
-- ================================================================

-- Pesanan 1: Budi beli Laptop + Mouse (selesai)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (1, '2026-01-15 10:30:00', 'selesai');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (1, 1, 1, 7500000),
    (1, 2, 2,  150000);

-- Pesanan 2: Siti beli Kaos + Celana Jeans (selesai)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (2, '2026-01-20 14:00:00', 'selesai');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (2, 3, 3, 75000),
    (2, 6, 1, 180000);

-- Pesanan 3: Andi beli Headphone + Charger (dikirim)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (3, '2026-02-05 09:15:00', 'dikirim');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (3, 5, 1, 350000),
    (3, 11, 1, 95000);

-- Pesanan 4: Rina beli Keripik + Mie Instan + Coklat (selesai)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (4, '2026-02-20 16:45:00', 'selesai');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (4, 4, 5,  15000),
    (4, 13, 3, 18000),
    (4, 7, 2,  12000);

-- Pesanan 5: Doni beli Laptop + Headphone (diproses)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (5, '2026-03-10 11:00:00', 'diproses');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (5, 1, 1, 7500000),
    (5, 5, 1, 350000);

-- Pesanan 6: Maya beli Buku + Pulpen + Stabilo (selesai)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (6, '2026-03-12 08:30:00', 'selesai');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (6, 9, 5,  8000),
    (6, 8, 3,  5000),
    (6, 14, 2, 25000);

-- Pesanan 7: Budi beli lagi - Jaket + Topi (pending)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (1, '2026-04-01 19:20:00', 'pending');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (7, 12, 1, 150000),
    (7, 15, 2, 55000);

-- Pesanan 8: Fajar beli Gelang + Topi (selesai)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (7, '2026-03-15 13:00:00', 'selesai');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (8, 10, 3, 45000),
    (8, 15, 1, 55000);

-- Pesanan 9: Siti beli Mouse + Charger (batal)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (2, '2026-03-25 10:00:00', 'batal');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (9, 2, 1, 150000),
    (9, 11, 1, 95000);

-- Pesanan 10: Lina beli Kaos + Jaket + Gelang (dikirim)
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (8, '2026-04-02 15:30:00', 'dikirim');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
    (10, 3, 2, 75000),
    (10, 12, 1, 150000),
    (10, 10, 1, 45000);


-- ================================================================
-- LATIHAN QUERY REFRESH
-- ================================================================

-- Latihan 1: Produk dengan harga di atas Rp 100.000
SELECT nama_produk, harga
FROM produk
WHERE harga > 100000
ORDER BY harga DESC;

-- Latihan 2: Pelanggan dari kota Jakarta
SELECT nama, email, kota
FROM pelanggan
WHERE kota = 'Jakarta';

-- Latihan 3: Hitung jumlah produk
SELECT COUNT(*) AS total_produk
FROM produk;

-- Latihan 4: Urutkan produk dari termahal
SELECT nama_produk, harga
FROM produk
ORDER BY harga DESC;


-- ================================================================
-- QUERY BONUS: Verifikasi Data
-- ================================================================

-- Cek jumlah data di semua tabel
SELECT 'kategori' AS tabel, COUNT(*) AS jumlah FROM kategori
UNION ALL
SELECT 'produk', COUNT(*) FROM produk
UNION ALL
SELECT 'pelanggan', COUNT(*) FROM pelanggan
UNION ALL
SELECT 'pesanan', COUNT(*) FROM pesanan
UNION ALL
SELECT 'detail_pesanan', COUNT(*) FROM detail_pesanan;

-- Detail pesanan lengkap (JOIN semua tabel)
SELECT
    ps.id           AS no_pesanan,
    pel.nama        AS pelanggan,
    pr.nama_produk  AS produk,
    dp.jumlah,
    dp.harga_saat_beli,
    (dp.jumlah * dp.harga_saat_beli) AS subtotal,
    ps.status,
    ps.tgl_pesanan
FROM pesanan ps
JOIN pelanggan pel      ON ps.pelanggan_id = pel.id
JOIN detail_pesanan dp  ON ps.id = dp.pesanan_id
JOIN produk pr          ON dp.produk_id = pr.id
ORDER BY ps.tgl_pesanan;

-- join
SELECT
   p.id,
   p.nama_produk,
   p.harga,
   k.nama_kategori
FROM produk p
JOIN kategori k ON p.kategori_id = k.id;


-- join pelanggan dan pesanan
SELECT
   ps.id AS no_pesanan,
   pel.nama AS nama_pelanggan,
   ps.tgl_pesanan,
   ps.status
FROM pesanan ps
JOIN pelanggan pel ON ps.pelanggan_id = pel.id;

-- agregasi : count (jumlah pesanan per pelangan)
SELECT 
   pel.nama AS pelanggan,
   COUNT(ps.id) AS jumlah_pesanan
FROM pelanggan pel
JOIN pesanan ps ON pel.id = ps.pelanggan_id
GROUP BY pel.nama;

-- agregasi : sum (total nilai pesanan dari setiap pesanan)
SELECT
   ps.id AS no_pesanan,
   pel.nama AS pelanggan,
   SUM(dp.jumlah * dp.harga_saat_beli) AS total_pesanan
FROM pesanan ps
JOIN pelanggan pel ON ps.pelanggan_id = pel.id
JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
GROUP BY ps.id, pel.nama;

-- having
SELECT 
   pel.nama,
   COUNT(ps.id) AS jumlah_pesanan
FROM pelanggan pel
JOIN pelanggan ps ON pel.id = ps.id
GROUP BY pel.nama
HAVING COUNT(ps.id) > 1;

-- subquery
SELECT * FROM produk;
SELECT MAX(harga) FROM produk;

SELECT * FROM produk WHERE harga = (SELECT MAX(harga) FROM produk);

-- barang yang harganya lebih besar dari ratarata
SELECT
   nama_produk,
   harga
FROM produk WHERE harga > (SELECT AVG(harga) FROM produk);

-- barang yang harganya lebih kecil dari ratarata
SELECT
   nama_produk,
   harga
FROM produk WHERE harga < (SELECT AVG(harga) FROM produk);

-- 2 tabel
SELECT 
	pel.`nama`,
	pr.`nama_produk`
FROM produk pr
JOIN detail_pesanan dp ON  pr.id = dp.produk_id
JOIN pesanan pes ON dp.pesanan_id = pes.id
JOIN `pelanggan` pel ON pes.pelanggan_id = pel.id;

-- VIEW
CREATE VIEW pembeli AS
SELECT 
	pel.`nama`,
	pr.`nama_produk`
FROM produk pr
JOIN detail_pesanan dp ON  pr.id = dp.produk_id
JOIN pesanan pes ON dp.pesanan_id = pes.id
JOIN `pelanggan` pel ON pes.pelanggan_id = pel.id;

SELECT * FROM pembeli



-- LATIHAN
-- 1. Tampilkan semua kolom dan baris dari tabel produk
SELECT*FROM produk;
    ('Laptop Asus',        7500000, 10, 1),
    ('Mouse Wireless',      150000, 50, 1),
    ('Kaos Polos',           75000, 100, 2),
    ('Keripik Singkong',     15000, 200, 3),
    ('Headphone Bluetooth', 350000, 30, 1),
    ('Celana Jeans',        180000, 60, 2),
    ('Coklat Batang',        12000, 150, 3),
    ('Pulpen Pilot',          5000, 500, 4),
    ('Buku Tulis A5',         8000, 300, 4),
    ('Gelang Kulit',         45000, 80, 5),
    ('Charger USB-C',        95000, 40, 1),
    ('Jaket Hoodie',        150000, 45, 2),
    ('Mie Instan (isi 5)',   18000, 400, 3),
    ('Stabilo Warna',        25000, 120, 4),
    ('Topi Baseball',        55000, 70, 5);
    
-- 2. Tampilkan hanya kolom nama_produk dan harga dari tabel produk
SELECT nama_produk, harga FROM produk;

-- 3. Tampilkan semua kolom dan baris dari tabel pelanggan
SELECT*FROM pelanggan;    
 
-- 4. Tampilkan semua kolom dan baris dari tabel pesanan
SELECT*FROM pesanan;

-- 5. Tampilkan semua kolom dan baris dari tabel detail_pesanan
SELECT*FROM detail_pesanan;

-- 6. Tampilkan produk yang harganya kurang dari atau sama dengan 50.000
SELECT harga FROM produk WHERE harga <= 50.000;

-- 7. Tampilkan produk yang stoknya lebihnya besar dari 200
SELECT stok FROM produk WHERE stok > 200;

-- 8. Tampilkan pelanggan yang tinggal di kota bandung
SELECT * FROM pelanggan WHERE kota = 'Bandung';

-- 9. Tampilkan pesanan yang statusnya 'selesai'
SELECT * FROM pesanan WHERE STATUS = 'Selesai';

-- 10. Tampilkan pesanan yang terjadi pada bulan februari 2026
SELECT * FROM pesanan WHERE tgl_pesanan BETWEEN '2026-02-01' AND '2026-02-29';



-- TUGAS NAJLA FELISHA PUTRI (PERTEMUAN KE 2)-----------
-- LATIHAN JOIN-------------------------------
-- 1
SELECT p.nama_produk, k.nama_kategori 
FROM produk p
JOIN kategori k ON p.kategori_id = k.id;

-- 2
SELECT p.id AS no_pesanan, pl.nama AS nama_pelanggan, p.tgl_pesanan, p.status 
FROM pesanan p
JOIN pelanggan pl ON p.pelanggan_id = pl.id;

-- 3
SELECT 
    p.id AS no_pesanan, 
    pl.nama AS nama_pelanggan, 
    pr.nama_produk, 
    dp.jumlah, 
    (dp.jumlah * dp.harga_saat_beli) AS subtotal
FROM detail_pesanan dp
JOIN pesanan p ON dp.pesanan_id = p.id
JOIN pelanggan pl ON p.pelanggan_id = pl.id
JOIN produk pr ON dp.produk_id = pr.id;

-- 4
SELECT pr.nama_produk, dp.jumlah, p.id AS no_pesanan
FROM detail_pesanan dp
JOIN pesanan p ON dp.pesanan_id = p.id
JOIN pelanggan pl ON p.pelanggan_id = pl.id
JOIN produk pr ON dp.produk_id = pr.id
WHERE pl.nama = 'Budi Santoso';

-- 5
SELECT p.id AS no_pesanan, COUNT(dp.id) AS total_item_pesanan
FROM pesanan p
JOIN detail_pesanan dp ON p.id = dp.pesanan_id
WHERE p.status = 'selesai'
GROUP BY p.id;


-- Agregasi & GROUP BY------------------

-- 6
SELECT pl.nama AS nama_pelanggan, COUNT(p.id) AS jumlah_pesanan
FROM pelanggan pl
LEFT JOIN pesanan p ON pl.id = p.pelanggan_id
GROUP BY pl.id, pl.nama;

-- 7
SELECT pl.nama AS nama_pelanggan, SUM(dp.jumlah * dp.harga_saat_beli) AS total_belanja
FROM pelanggan pl
JOIN pesanan p ON pl.id = p.pelanggan_id
JOIN detail_pesanan dp ON p.id = dp.pesanan_id
GROUP BY pl.id, pl.nama;

-- 8
SELECT k.nama_kategori, SUM(dp.jumlah * dp.harga_saat_beli) AS total_penjualan
FROM detail_pesanan dp
JOIN produk pr ON dp.produk_id = pr.id
JOIN kategori k ON pr.kategori_id = k.id
GROUP BY k.id, k.nama_kategori;

-- 9
SELECT k.nama_kategori, AVG(p.harga) AS rata_harga
FROM produk p
JOIN kategori k ON p.kategori_id = k.id
GROUP BY k.id, k.nama_kategori;

-- 10
SELECT pr.nama_produk, SUM(dp.jumlah) AS total_terjual
FROM detail_pesanan dp
JOIN produk pr ON dp.produk_id = pr.id
GROUP BY pr.id, pr.nama_produk
ORDER BY total_terjual DESC
LIMIT 3;


-- HAVING (Filter Hasil Agregasi)-----------------

--  11
SELECT pl.nama AS nama_pelanggan, COUNT(p.id) AS jumlah_pesanan
FROM pelanggan pl
JOIN pesanan p ON pl.id = p.pelanggan_id
GROUP BY pl.id, pl.nama
HAVING COUNT(p.id) > 1;

-- 12
SELECT k.nama_kategori, SUM(dp.jumlah * dp.harga_saat_beli) AS total_penjualan
FROM detail_pesanan dp
JOIN produk pr ON dp.produk_id = pr.id
JOIN kategori k ON pr.kategori_id = k.id
GROUP BY k.id, k.nama_kategori
HAVING total_penjualan > 100000;

-- 13
SELECT pl.nama AS nama_pelanggan, SUM(dp.jumlah * dp.harga_saat_beli) AS total_belanja
FROM pelanggan pl
JOIN pesanan p ON pl.id = p.pelanggan_id
JOIN detail_pesanan dp ON p.id = dp.pesanan_id
GROUP BY pl.id, pl.nama
HAVING total_belanja > 500000;

SELECT k.nama_kategori,
       SUM(dp.jumlah * dp.harga_saat_beli) AS total_penjualan
FROM detail_pesanan dp
JOIN produk p ON dp.produk_id = p.id
JOIN kategori k ON p.kategori_id = k.id
GROUP BY k.id, k.nama_kategori
ORDER BY total_penjualan DESC;

-- 1 Constraint dasar
-- 1) Constraint: harga produk harus > 0

ALTER TABLE produk
ADD CONSTRAINT chk_harga_positif
CHECK (harga > 0);

INSERT INTO produk (nama_prodk, harga, stok,bkategori_id)
VALUES ('Produkk Harga Negatif', -5000, 10, 1);
-- Harus gagal / error jika CHECK aktif

-- 2) Constraint: stok tidak boleh negatif


UPDATE produk
SET stok = -10
WHERE id = 1;
-- harus ditolak jika check aktif

-- 3) Constraint: email harus unique
SELECT * FROM pelanggan;
ALTER TABLE pelanggan
ADD CONSTRAINT uq_email_pelangan UNIQUE (email);

INSERT INTO pelanggan (nama, email, kota, tgl_daftar)
VALUES ('test duplikat', 'budi@budiemail.com', 'jakarta', '2026-04-01');
-- harus error karens email sudah dipakai budi

-- memulai transaksi
START TRANSACTION

-- 1 tambah pesanan baru untuk pelanggan id = 1
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (1, NOW(), 'Diproses');

-- 2 cari id pesanan yang baru dibuat
SELECT MAX(id) AS pesanan_baru FROM pesanan
-- catat nilai hasilnya mis : 11

-- 3 tambahkan detail pesanan (gunakan id pesanan baru tsb)
INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES (11, 1,1, 7500000);

-- 4 kurangi stok produk id = 1
UPDATE produk
SET stok = stok - 1
WHERE id = 1;

-- 5 jika semua langkah  diatas tidak error, simpan perubahan
COMMIT;  -- jangan di commit dulu HAHAHAH

SELECT * FROM pesanan;

-- simulasi kesalahan dan rollback
START TRANSACTION

-- turunkan stok secara tidak logis
UPDATE produk
SET stok = 1
WHERE id = 1;

-- cek story sementara
SELECT * FROM produk WHERE id = 1;

-- putuskan bahwa ini salah

-- 1) lost update
-- session 2

START TRANSACTION

SELECT stok
FROM produk
WHERE id = 1;

UPDATE produk 
SET stok = stok - 3
WHERE id = 1;

COMMIT;

-- 2) Dirty Read
-- Session 2
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

SELECT stok
FROM produk
WHERE id = 2;

-- 3). phantom read
-- session 2

INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (1, NOW(), 'pending');

COMMIT;

-- 4). deadlock
-- session 2
START TRANSACTION;
SELECT * FROM pesanan WHERE id = 2 FOR UPDATE;

SELECT * FROM pesanan WHERE id = 1 FOR UPDATE;

-- ================================
-- TUGAS NAJLA FELISHA PERTEMUAN 3
-- ================================

--1. 
SELECT nama_produk, harga
FROM produk
WHERE harga < (
    SELECT AVG(harga)
    FROM produk
);

-- 2.
SELECT nama_produk, stok
FROM produk
WHERE stok > (
    SELECT AVG(stok)
    FROM produk
);

-- 3.
SELECT nama, total_belanja
FROM (
    SELECT
        pel.id,
        pel.nama,
        SUM(dp.jumlah * dp.harga_saat_beli) AS total_belanja
    FROM pelanggan pel
    JOIN pesanan ps ON pel.id = ps.pelanggan_id
    JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
    GROUP BY pel.id, pel.nama
) AS pelanggan_total
WHERE total_belanja > (
    SELECT AVG(total_belanja)
    FROM (
        SELECT
            SUM(dp.jumlah * dp.harga_saat_beli) AS total_belanja
        FROM pelanggan pel
        JOIN pesanan ps ON pel.id = ps.pelanggan_id
        JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
        GROUP BY pel.id
    ) AS rata_pelanggan
);

-- 4.
SELECT ps.id AS no_pesanan
FROM pesanan ps
WHERE (
    SELECT SUM(dp.jumlah * dp.harga_saat_beli)
    FROM detail_pesanan dp
    WHERE dp.pesanan_id = ps.id
) > 200000;

-- 5.
SELECT
    pel.nama,
    (
        SELECT COUNT(*)
        FROM pesanan ps
        WHERE ps.pelanggan_id = pel.id
    ) AS jumlah_pesanan
FROM pelanggan pel;

-- 6.
SELECT
    p.nama_produk,
    (
        SELECT SUM(dp.jumlah)
        FROM detail_pesanan dp
        WHERE dp.produk_id = p.id
    ) AS total_terjual
FROM produk p;

-- 7.
SELECT
    pel.nama,(SELECT SUM(dp.jumlah * dp.harga_saat_beli)
        FROM pesanan ps
        JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
        WHERE ps.pelanggan_id = pel.id) AS total_belanja
FROM pelanggan pel
ORDER BY total_belanja DESC;

-- 8.
CREATE OR REPLACE VIEW v_pesanan_total AS
SELECT
    ps.id AS no_pesanan,
    pel.nama AS nama_pelanggan,
    ps.tgl_pesanan,
    ps.status,
    SUM(dp.jumlah * dp.harga_saat_beli) AS total_pesanan
FROM pesanan ps
JOIN pelanggan pel ON ps.pelanggan_id = pel.id
JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
GROUP BY
    ps.id,
    pel.nama,
    ps.tgl_pesanan,
    ps.status;
    
-- 9.
SELECT * FROM v_pesanan_total
ORDER BY total_pesanan DESC;

-- 10.
CREATE OR REPLACE VIEW v_produk_penjualan AS
SELECT
    p.nama_produk,
    k.nama_kategori,
    SUM(dp.jumlah) AS total_terjual
FROM produk p
JOIN kategori k ON p.kategori_id = k.id
LEFT JOIN detail_pesanan dp ON p.id = dp.produk_id
GROUP BY
    p.nama_produk,
    k.nama_kategori;

-- 11.
SELECT * FROM v_produk_penjualan
ORDER BY total_terjual DESC
LIMIT 5;

-- 12.
CREATE OR REPLACE VIEW v_pelanggan_kota_value AS
SELECT
    pel.nama,
    pel.kota,
    SUM(dp.jumlah * dp.harga_saat_beli) AS total_belanja
FROM pelanggan pel
JOIN pesanan ps ON pel.id = ps.pelanggan_id
JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
GROUP BY
    pel.nama,
    pel.kota;
    
-- 13.
SELECT
    kota,
    AVG(total_belanja) AS rata_rata_belanja
FROM v_pelanggan_kota_value
GROUP BY kota;

-- opsional
SELECT
    k.nama_kategori,
    SUM(dp.jumlah * dp.harga_saat_beli) AS total_penjualan
FROM detail_pesanan dp
JOIN produk p ON dp.produk_id = p.id
JOIN kategori k ON p.kategori_id = k.id
GROUP BY k.id, k.nama_kategori
ORDER BY total_penjualan DESC
LIMIT 1;

-- ================================
-- TUGAS NAJLA FELISHA PERTEMUAN 4
-- ================================
-- 1.
ALTER TABLE produk
ADD CONSTRAINT chk_stok_non_negatif
CHECK (stok >= 0);

-- 2.
UPDATE produk
SET stok = -5
WHERE id = 1;

-- 3.
INSERT INTO pelanggan (nama, email, kota, tgl_daftar)
VALUES ('Pelanggan Baru', 'budi@email.com', 'Jakarta', CURDATE());

-- 4.
START TRANSACTION;

INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (2, NOW(), 'diproses');

SELECT MAX(id) AS pesanan_baru
FROM pesanan;

INSERT INTO detail_pesanan
(pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES (11, 3, 2, 500000);

UPDATE produk
SET stok = stok - 2
WHERE id = 3;

COMMIT;

-- 5.
START TRANSACTION;

INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (2, NOW(), 'diproses');

INSERT INTO detail_pesanan
(pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES (12, 9999, 2, 500000);

UPDATE produk
SET stok = stok - 2
WHERE id = 3;

ROLLBACK;

-- 6.
START TRANSACTION;

UPDATE produk p
JOIN detail_pesanan dp
ON p.id = dp.produk_id
SET p.stok = p.stok + dp.jumlah
WHERE dp.pesanan_id = 2;

UPDATE pesanan
SET STATUS = 'batal'
WHERE id = 2;

COMMIT;

-- 7.

-- 8.
CREATE TABLE IF NOT EXISTS log_perubahan_harga (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produk_id INT,
    harga_lama DECIMAL(12,2),
    harga_baru DECIMAL(12,2),
    tgl_perubahan DATETIME
);

START TRANSACTION;

INSERT INTO log_perubahan_harga
(produk_id, harga_lama, harga_baru, tgl_perubahan)
VALUES
(5, 1000000, 900000, NOW());

UPDATE produk
SET harga = 900000
WHERE id = 5;

COMMIT;

-- 9.
SELECT *
FROM log_perubahan_harga
WHERE produk_id = 5
ORDER BY tgl_perubahan DESC;

-- 10.
START TRANSACTION;

INSERT INTO pesanan
(pelanggan_id, tgl_pesanan, STATUS)
VALUES
(1, NOW(), 'diproses');

INSERT INTO detail_pesanan
(pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES
(13, 9999, 1, 10000);

UPDATE produk
SET stok = stok - 1
WHERE id = 1;

ROLLBACK;

-- uas
-- pert 1
-- 1. Melihat Data (SELECT)
-- Melihat semua data dari sebuah tabel
SELECT * FROM nama_tabel;

-- Melihat kolom tertentu
SELECT kolom1, kolom2 FROM nama_tabel;

-- 2. Menyaring Data (WHERE)
SELECT * FROM produk WHERE harga > 100000;
SELECT nama, kota FROM pelanggan WHERE kota = 'Jakarta';

-- 3. menghitung data (count)
-- Menghitung semua baris
SELECT COUNT(*) FROM pelanggan;

-- Memberi nama pada hasil hitungan (alias)
SELECT COUNT(*) AS jumlah_pelanggan FROM pelanggan;

-- 4. Mengurutkan Data (ORDER BY)
-- ASC (kecil ke besar) adalah default, DESC (besar ke kecil)
SELECT * FROM produk ORDER BY harga DESC;


-- Pertemuan 2: JOIN & Agregasi (COUNT, SUM, GROUP BY, HAVING)
-- 1. JOIN (Menggabungkan Tabel)
-- Tujuan: Menggabungkan data dari dua tabel atau lebih berdasarkan kolom yang berhubungan (foreign key).
-- JOIN Produk & Kategori (relasi: produk.kategori_id = kategori.id)
SELECT p.nama_produk, k.nama_kategori
FROM produk p
JOIN kategori k ON p.kategori_id = k.id;

-- JOIN Pesanan & Pelanggan (relasi: pesanan.pelanggan_id = pelanggan.id)
SELECT ps.id AS no_pesanan, pel.nama
FROM pesanan ps
JOIN pelanggan pel ON ps.pelanggan_id = pel.id;

-- JOIN Banyak Tabel (Struk Belanja)
SELECT ps.id AS no_pesanan, pel.nama AS pelanggan, pr.nama_produk,
       dp.jumlah, dp.harga_saat_beli,
       (dp.jumlah * dp.harga_saat_beli) AS subtotal
FROM pesanan ps
JOIN pelanggan pel ON ps.pelanggan_id = pel.id
JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
JOIN produk pr ON dp.produk_id = pr.id;

-- 2. Agregasi (COUNT, SUM, AVG) & GROUP BY
-- Tujuan: Membuat ringkasan data. GROUP BY mengelompokkan data berdasarkan kategori tertent
-- Hitung Jumlah Pesanan per Pelanggan
SELECT pel.nama, COUNT(ps.id) AS jumlah_pesanan
FROM pelanggan pel
JOIN pesanan ps ON pel.id = ps.pelanggan_id
GROUP BY pel.nama;

-- Total Penjualan per Kategori
SELECT k.nama_kategori, SUM(dp.jumlah * dp.harga_saat_beli) AS total_penjualan
FROM detail_pesanan dp
JOIN produk p ON dp.produk_id = p.id
JOIN kategori k ON p.kategori_id = k.id
GROUP BY k.nama_kategori;

-- 3. HAVING (Filter untuk Hasil Agregasi)
-- Tujuan: Memfilter kelompok yang sudah di-GROUP BY. WHERE untuk baris, HAVING untuk kelompok
-- Tampilkan pelanggan yang punya lebih dari 1 pesanan
SELECT pel.nama, COUNT(ps.id) AS jumlah_pesanan
FROM pelanggan pel
JOIN pesanan ps ON pel.id = ps.pelanggan_id
GROUP BY pel.nama
HAVING COUNT(ps.id) > 1;

-- Pertemuan 3: Subquery
-- Subquery adalah query di dalam query. Hasil dari query dalam digunakan oleh query luar.
-- 1. Subquery di WHERE (Untuk Membandingkan)
-- Tujuan: Membandingkan nilai dengan hasil hitungan dari query lain.
-- Cari Produk dengan Harga di Atas Rata-rata
SELECT nama_produk, harga
FROM produk
WHERE harga > (SELECT AVG(harga) FROM produk);

-- Cari Pelanggan yang Pernah Beli Kategori 'Elektronik'
SELECT DISTINCT pel.nama
FROM pelanggan pel
WHERE pel.id IN (
    SELECT ps.pelanggan_id
    FROM pesanan ps
    JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
    JOIN produk p ON dp.produk_id = p.id
    JOIN kategori k ON p.kategori_id = k.id
    WHERE k.nama_kategori = 'Elektronik'
);

-- 2. Subquery di SELECT (Sebagai Kolom Tambahan)
-- Tujuan: Menambahkan kolom hasil hitungan per baris data.
-- Tampilkan pelanggan dengan total belanja masing-masing
SELECT pel.id, pel.nama,
    (SELECT SUM(dp.jumlah * dp.harga_saat_beli)
     FROM pesanan ps
     JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
     WHERE ps.pelanggan_id = pel.id) AS total_belanja
FROM pelanggan pel;

-- Pertemuan 4: Constraint & Transaksi (COMMIT/ROLLBACK)
-- 1. Constraint (Aturan Data)
-- Tujuan: Menjaga agar data tetap "waras" (valid).
-- CHECK: Memastikan nilai memenuhi syarat (contoh: stok >= 0).
-- UNIQUE: Memastikan tidak ada nilai duplikat (contoh: email).
-- Contoh menambahkan constraint
ALTER TABLE produk ADD CONSTRAINT chk_stok CHECK (stok >= 0);

-- 2. Transaksi (COMMIT / ROLLBACK)
-- Tujuan: Menjalankan beberapa perintah sebagai satu kesatuan yang "atomik". Jika semua berhasil, simpan (COMMIT).
-- (lanjutan) Jika ada yang gagal, batalkan semua (ROLLBACK).

-- Skenario Penting: Proses Pembelian (Kurangi Stok)
START TRANSACTION; (Mulai)

INSERT INTO pesanan ... (Buat pesanan baru)

INSERT INTO detail_pesanan ... (Tambah detail barang)

UPDATE produk SET stok = stok - 1 WHERE id = ...; (Kurangi stok)

COMMIT; (Simpan) atau ROLLBACK; (Batalkan jika ada error)

-- 3. Skenario Penting: Pembatalan Pesanan (Kembalikan Stok)
START TRANSACTION;

UPDATE produk p JOIN detail_pesanan dp ON p.id = dp.produk_id SET p.stok = p.stok + dp.jumlah WHERE dp.pesanan_id = ...; (Kembalikan stok)

UPDATE pesanan SET STATUS = 'batal' WHERE id = ...; (Ubah STATUS)

COMMIT;

-- Tips & Trik Menghadapi UAS
-- Pahami Relasi Tabel:
-- produk terhubung ke kategori via kategori_id.
-- pesanan terhubung ke pelanggan via pelanggan_id.
-- detail_pesanan terhubung ke pesanan (pesanan_id) dan produk (produk_id). Ini adalah tabel jantung untuk menghitung penjualan.
-- Kenali Pola Query:
-- Mau lihat detail? SELECT * FROM ...
-- Mau gabung tabel? ... JOIN ... ON ...
-- Mau hitung total per kelompok? ... SUM(...) ... GROUP BY ...
-- Mau cari yang di atas rata-rata? ... WHERE ... > (SELECT AVG(...) ...)
-- Mau proses beberapa langkah yang harus sukses semua? Gunakan START TRANSACTION; ... COMMIT; atau ROLLBACK;.
-- Perhatikan Penulisan:
-- Awali setiap query dengan titik koma (;) jika ada query sebelumnya.
-- Gunakan alias (AS) untuk membuat hasil query lebih mudah dibaca (contoh: COUNT(*) AS jumlah).
-- Latihan Mandiri (Cepat):
-- Coba tulis query untuk menampilkan total belanja per pelanggan (Gabungan JOIN, SUM, GROUP BY).
-- Coba tulis query untuk menampilkan produk yang stoknya di atas rata-rata (Gabungan WHERE + Subquery AVG).


-- prediksi soal
-- BAGIAN A: DML DASAR (Pertemuan 1) - 20%
-- 1.Tampilkan semua data dari tabel produk.
-- 2. Tampilkan hanya kolom nama_produk dan harga dari tabel produk.
-- 3. Tampilkan pelanggan yang tinggal di kota 'Bandung'.
-- 4. Tampilkan produk dengan harga antara Rp50.000 sampai Rp200.000.
-- 5. Hitung jumlah pelanggan yang berasal dari 'Jakarta'.

-- No. 1
SELECT * FROM produk;
-- No. 2
SELECT nama_produk, harga FROM produk;
-- No. 3
SELECT * FROM pelanggan WHERE kota = 'Bandung';
-- No. 4
SELECT * FROM produk WHERE harga BETWEEN 50000 AND 200000;
-- No. 5
SELECT COUNT(*) AS jumlah_pelanggan_jakarta FROM pelanggan WHERE kota = 'Jakarta';

-- BAGIAN B: JOIN & AGREGASI (Pertemuan 2) - 35%
-- 1. Tampilkan semua produk beserta nama kategorinya.
-- 2. Tampilkan semua pesanan beserta nama pelanggan dan status pesanan.
-- 3. Tampilkan detail belanja (no_pesanan, nama_pelanggan, nama_produk, jumlah, subtotal).
-- 4. Hitung total penjualan (dalam Rupiah) untuk setiap kategori produk.
-- 5. Hitung jumlah pesanan yang dilakukan oleh setiap pelanggan.
-- 6. Hitung total belanja untuk setiap pelanggan.
-- 7. Tampilkan pelanggan yang memiliki lebih dari 1 pesanan (HAVING).
-- 8. Tampilkan kategori yang total penjualannya di atas Rp500.000 (HAVING).
-- 9. Tampilkan 3 produk dengan total item terjual terbanyak.

-- No. 1
SELECT p.nama_produk, k.nama_kategori
FROM produk p
JOIN kategori k ON p.kategori_id = k.id;
-- No. 2
SELECT ps.id AS no_pesanan, pel.nama AS nama_pelanggan, ps.tgl_pesanan, ps.status
FROM pesanan ps
JOIN pelanggan pel ON ps.pelanggan_id = pel.id;
-- No. 3
SELECT ps.id AS no_pesanan, pel.nama AS pelanggan, pr.nama_produk,
       dp.jumlah, (dp.jumlah * dp.harga_saat_beli) AS subtotal
FROM pesanan ps
JOIN pelanggan pel ON ps.pelanggan_id = pel.id
JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
JOIN produk pr ON dp.produk_id = pr.id;
-- No. 4
SELECT k.nama_kategori, SUM(dp.jumlah * dp.harga_saat_beli) AS total_penjualan
FROM detail_pesanan dp
JOIN produk p ON dp.produk_id = p.id
JOIN kategori k ON p.kategori_id = k.id
GROUP BY k.nama_kategori;
-- No. 5
SELECT pel.nama, COUNT(ps.id) AS jumlah_pesanan
FROM pelanggan pel
LEFT JOIN pesanan ps ON pel.id = ps.pelanggan_id
GROUP BY pel.nama;
-- No. 6
SELECT pel.nama, SUM(dp.jumlah * dp.harga_saat_beli) AS total_belanja
FROM pelanggan pel
JOIN pesanan ps ON pel.id = ps.pelanggan_id
JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
GROUP BY pel.nama;
-- No. 7
SELECT pel.nama, COUNT(ps.id) AS jumlah_pesanan
FROM pelanggan pel
JOIN pesanan ps ON pel.id = ps.pelanggan_id
GROUP BY pel.nama
HAVING COUNT(ps.id) > 1;
-- No. 8
SELECT k.nama_kategori, SUM(dp.jumlah * dp.harga_saat_beli) AS total_penjualan
FROM detail_pesanan dp
JOIN produk p ON dp.produk_id = p.id
JOIN kategori k ON p.kategori_id = k.id
GROUP BY k.nama_kategori
HAVING SUM(dp.jumlah * dp.harga_saat_beli) > 500000;
-- No. 9
SELECT p.nama_produk, SUM(dp.jumlah) AS total_terjual
FROM detail_pesanan dp
JOIN produk p ON dp.produk_id = p.id
GROUP BY p.nama_produk
ORDER BY total_terjual DESC
LIMIT 3;

--  BAGIAN C: SUBQUERY (Pertemuan 3) - 25%
-- 1. Tampilkan produk yang harganya di atas rata-rata harga semua produk.Tampilkan produk yang harganya di bawah rata-rata harga semua produk.
-- 2. Tampilkan pelanggan yang total belanjanya di atas rata-rata total belanja semua pelanggan.
-- 3. Tampilkan produk yang stoknya di atas rata-rata stok semua produk.
-- 4. Tampilkan pelanggan yang pernah membeli produk kategori 'Elektronik' (gunakan IN + subquery).
-- 5. Tampilkan daftar pelanggan dengan kolom tambahan total_pesanan (subquery di SELECT).

-- No. 1
SELECT nama_produk, harga
FROM produk
WHERE harga > (SELECT AVG(harga) FROM produk);
-- No. 2
SELECT nama_produk, harga
FROM produk
WHERE harga < (SELECT AVG(harga) FROM produk);
-- No. 3 (Versi 1 - Pakai VIEW)
CREATE OR REPLACE VIEW v_total_per_pelanggan AS
SELECT pel.id, pel.nama, SUM(dp.jumlah * dp.harga_saat_beli) AS total_belanja
FROM pelanggan pel
JOIN pesanan ps ON pel.id = ps.pelanggan_id
JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
GROUP BY pel.id, pel.nama;
SELECT nama, total_belanja
FROM v_total_per_pelanggan
WHERE total_belanja > (SELECT AVG(total_belanja) FROM v_total_per_pelanggan);

-- No. 3 (Versi 2 - Langsung Subquery)
SELECT pel.nama, SUM(dp.jumlah * dp.harga_saat_beli) AS total_belanja
FROM pelanggan pel
JOIN pesanan ps ON pel.id = ps.pelanggan_id
JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
GROUP BY pel.id, pel.nama
HAVING SUM(dp.jumlah * dp.harga_saat_beli) > (
    SELECT AVG(total) FROM (
        SELECT SUM(dp2.jumlah * dp2.harga_saat_beli) AS total
        FROM pelanggan pel2
        JOIN pesanan ps2 ON pel2.id = ps2.pelanggan_id
        JOIN detail_pesanan dp2 ON ps2.id = dp2.pesanan_id
        GROUP BY pel2.id
    ) AS rata
);
-- No. 4
SELECT nama_produk, stok
FROM produk
WHERE stok > (SELECT AVG(stok) FROM produk);
-- No. 5
SELECT DISTINCT pel.nama
FROM pelanggan pel
WHERE pel.id IN (
    SELECT ps.pelanggan_id
    FROM pesanan ps
    JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
    JOIN produk p ON dp.produk_id = p.id
    JOIN kategori k ON p.kategori_id = k.id
    WHERE k.nama_kategori = 'Elektronik'
);
-- No. 6
SELECT pel.id, pel.nama, pel.kota,
    (SELECT COUNT(ps.id)
     FROM pesanan ps
     WHERE ps.pelanggan_id = pel.id) AS total_pesanan
FROM pelanggan pel;

-- BAGIAN D: CONSTRAINT & TRANSAKSI (Pertemuan 4) - 20%
-- 1. Buat transaksi pembelian: Pelanggan id=1 membeli 2 unit produk id=3. Tulis query mulai START TRANSACTION sampai COMMIT.
-- 2. Buat transaksi pembatalan pesanan id=2 (kembalikan stok + ubah status menjadi 'batal').
-- 3. Apa yang terjadi jika stok di-update menjadi negatif? Bagaimana cara mencegahnya? (Constraint CHECK).
-- 4. Simulasikan error transaksi (misal: insert detail dengan produk_id yang salah), lalu lakukan ROLLBACK.
-- 5. Tulis query untuk menambahkan constraint bahwa stok tidak boleh negatif.

-- No. 1 (Transaksi Pembelian)
START TRANSACTION;
-- Insert pesanan baru untuk pelanggan id = 1
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (1, NOW(), 'diproses');
-- Ambil id pesanan yang baru dibuat
SET @pesanan_baru = LAST_INSERT_ID();
-- Insert detail pesanan (2 unit produk id = 3)
INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES (@pesanan_baru, 3, 2, (SELECT harga FROM produk WHERE id = 3));
-- Kurangi stok produk id = 3
UPDATE produk SET stok = stok - 2 WHERE id = 3;
-- Simpan transaksi
COMMIT;

-- No. 2 (Pembatalan Pesanan)
START TRANSACTION;
-- Kembalikan stok produk dari detail_pesanan id = 2
UPDATE produk p
JOIN detail_pesanan dp ON p.id = dp.produk_id
SET p.stok = p.stok + dp.jumlah
WHERE dp.pesanan_id = 2;

-- Ubah status pesanan menjadi 'batal'
UPDATE pesanan SET STATUS = 'batal' WHERE id = 2;

COMMIT;

-- No. 5 (Menambahkan Constraint CHECK)
ALTER TABLE produk ADD CONSTRAINT chk_stok_non_negatif CHECK (stok >= 0);

-- No. 4 (Simulasi Error + ROLLBACK)
START TRANSACTION;

INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS)
VALUES (1, NOW(), 'diproses');

SET @pesanan_baru = LAST_INSERT_ID();

-- SENGAAAJA: produk_id = 9999 (tidak ada)
INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES (@pesanan_baru, 9999, 1, 10000);

-- Query ini akan ERROR karena foreign key melanggar
-- Kemudian jalankan:
ROLLBACK;

-- Gabungan JOIN + GROUP BY + HAVING + ORDER BY
-- Tampilkan pelanggan yang total belanjanya > 500.000, diurutkan dari yang terbesar
SELECT pel.nama, SUM(dp.jumlah * dp.harga_saat_beli) AS total_belanja
FROM pelanggan pel
JOIN pesanan ps ON pel.id = ps.pelanggan_id
JOIN detail_pesanan dp ON ps.id = dp.pesanan_id
GROUP BY pel.nama
HAVING total_belanja > 500000
ORDER BY total_belanja DESC;

-- Gabungan Subquery + JOIN
-- Tampilkan produk yang harganya di atas rata-rata, beserta nama kategorinya
SELECT p.nama_produk, p.harga, k.nama_kategori
FROM produk p
JOIN kategori k ON p.kategori_id = k.id
WHERE p.harga > (SELECT AVG(harga) FROM produk);

-- Transaksi + Constraint (Paling Sering Keluar!)
-- Buat transaksi pembelian dengan pengecekan stok (jika stok cukup)
START TRANSACTION;

-- Cek stok dulu
SELECT stok FROM produk WHERE id = 3; -- Misal stok = 10

-- Jika stok >= jumlah yang dibeli, lanjutkan
INSERT INTO pesanan (pelanggan_id, tgl_pesanan, STATUS) VALUES (1, NOW(), 'diproses');
SET @pesanan_baru = LAST_INSERT_ID();
INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_saat_beli)
VALUES (@pesanan_baru, 3, 5, (SELECT harga FROM produk WHERE id = 3));
UPDATE produk SET stok = stok - 5 WHERE id = 3;

COMMIT;
-- Jika stok < jumlah, jalankan ROLLBACK;
