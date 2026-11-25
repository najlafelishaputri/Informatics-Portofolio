CREATE DATABASE toko;

USE toko;

CREATE TABLE barang(
        id_barang CHAR (5) PRIMARY KEY,
        nama_barang VARCHAR (50),
        harga INT,
        stok INT
);

CREATE TABLE pelanggan (
        id_pelanggan CHAR (5) PRIMARY KEY,
        nama_pelanggan VARCHAR (50),
        alamat VARCHAR (50)
);

CREATE TABLE transaksi (
       id_transaksi CHAR (5) PRIMARY KEY,
       id_pelanggan CHAR (5),
       id_barang CHAR (5),
       jumlah INT,
       tanggal DATE,
       FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
       FOREIGN KEY (id_barang) REFERENCES barang(id_barang)
);

INSERT INTO barang VALUES 
('B01','Buku Tulis',5000,50),
('B02','Pena',3000,100),
('B03','Pensil',2000,150);
SELECT * FROM barang;

INSERT INTO pelanggan VALUES 
('P01','Ela','Siak'),
('P02','Anggi','Rohul'),
('P03','Delta','Kamboja');

INSERT INTO transaksi VALUES
('T01','P01','B01',5,'2025-12-01'),
('T02','P02','B02',3,'2025-12-01'),
('T03','P03','B03',4,'2025-12-02'),
('T04','P03','B03',2,'2025-12-02'),
('T05','P02','B02',6,'2025-12-03'),
('T06','P01','B01',2,'2025-12-02');

SELECT * FROM transaksi;

SELECT * FROM pelanggan;

#JOIN dasar (menampilkan semua data penting)
SELECT 
   t.id_transaksi,
   p.nama_pelanggan,
   b.nama_barang,
   t.jumlah,
   t.tanggal
FROM transaksi t
RIGHT JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan
RIGHT JOIN barang b ON t.id_barang = b.id_barang

#JOIN + WHERE (filter pelanggan tertentu)
SELECT 
   t.id_transaksi,
   p.nama_pelanggan,
   b.nama_barang,
   t.jumlah,
   t.tanggal
FROM transaksi t
JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan
JOIN barang b ON t.id_barang = b.id_barang


#JOIN + WHERE (filter barang tertentu)
SELECT 
   t.id_transaksi,
   p.nama_pelanggan,
   b.nama_barang,
   t.jumlah
FROM transaksi t
JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan
JOIN barang b ON t.id_barang = b.id_barang
WHERE b.nama_barang = 'Buku Tulis';

#JOIN + WHERE (filter tanggal)
SELECT 
   t.id_transaksi,
   p.nama_pelanggan,
   b.nama_barang,
   t.jumlah
FROM transaksi t
JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan
JOIN barang b ON t.id_barang = b.id_barang
WHERE t.tanggal = '2025-12-02';

#JOIN + WHERE (filter jumlah)
SELECT 
   t.id_transaksi,
   p.nama_pelanggan,
   b.nama_barang,
   t.jumlah,
   t.tanggal
FROM transaksi t
JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan
JOIN barang b ON t.id_barang = b.id_barang
WHERE t.jumlah = '2';

#JOIN + WHERE (filter id transaksi)
SELECT 
   t.id_transaksi,
   p.nama_pelanggan,
   b.nama_barang,
   t.jumlah,
   t.tanggal
FROM transaksi t
JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan
JOIN barang b ON t.id_barang = b.id_barang
WHERE t.id_transaksi = 'T06';


#count (jumlah data)
SELECT COUNT(stok)AS jumlah_data_stok FROM barang;

#sum (total data)
SELECT SUM(stok)AS total_data_stok FROM barang;

#avg (rata-rata)
SELECT AVG(harga)AS rata_rata_stok FROM barang;

SELECT MIN(harga)AS harga_terkecil FROM barang;

SELECT MAX(harga)AS harga_terbesar FROM barang;

#menampilkan total jumlah barang terjual
SELECT 
b.nama_barang,
SUM(t.jumlah) AS total_terjual
FROM transaksi t
JOIN barang b ON t.id_barang = b.id_barang
GROUP BY b.nama_barang;





SELECT * FROM barang WHERE id_barang = 'B01';

SELECT * FROM barang WHERE nama_barang = 'Pena';

SELECT * FROM pelanggan WHERE id_pelanggan = 'P01';

SELECT * FROM pelanggan WHERE nama_pelanggan = 'ela';

SELECT * FROM barang WHERE harga > 2000

UPDATE barang SET harga = 6000 WHERE id_barang = 'B01';

