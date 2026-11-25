CREATE DATABASE peminjaman_alat_lab;

USE peminjaman_alat_lab;

CREATE TABLE peminjaman_alat(
        id_peminjaman INT AUTO_INCREMENT PRIMARY KEY,
        nim CHAR(5), 
        nama_mahaiswa VARCHAR(50),
        program_studi VARCHAR(50),
        nama_alat VARCHAR(50),
        jenis_alat VARCHAR(50),
        kondisi_alat VARCHAR(50),
        jumlah INT,
        tanggal_pinjam DATE,
        tanggal_kembali DATE,
        nama_petugas VARCHAR(50)
);

INSERT TO peminjaman_alat VALUES
('2515100','Ella','Teknik Informatika','Power Supply','Elektronik','Baik',1,'2025-08-15','2025-08-17','Budi'),
('2515100','Ella','Teknik Informatika','Generator Sinyal','Elektronik','Baik',1,'2025-08-15','2025-08-17','Budi'),
('2515115','Muti','Teknik Mesin','Solder','Elektronik','Baik',1,'2025-08-15','2025-08-17','Andi'),
('2515123','Aul','Pwk','Osiloskop','Elektronik','Baik',1,'2025-08-16','2025-08-18','Andi'),
('2515123','Aul','Pwk','Tang Ampere','Elektronik','Baik',1,'2025-08-16','2025-08-18','Andi'),
('2515107','Yaya','Teknik Perminyakan','Multimeter','Elektronik','Baik',1,'2025-08-16','2025-08-18','Budi'),
('2515177','Cici','Teknik Sipil','Breadboard','Elektronik','Baik',1,'2025-08-16','2025-08-18','Budi'),
('2515177','Cici','Teknik Sipil','Multimeter','Elektronik''Baik',1,'2025-08-17','2025-08-19','Budi'),
('2515169','Awa','Teknik Geologi','Osiloskop','Elektronik','Baik',1,'-08-17','2025-08-19','Andi'),
('2515169','Awa','Teknik Geologi','Multimeter','Baik','Elektronik',1,'2025-08-17','2025-08-19','Andi');

SELECT * FROM peminjaman_alat;



