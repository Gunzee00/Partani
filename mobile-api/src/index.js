const bcrypt = require('bcrypt');
const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const mongoose = require('mongoose');
const app = express();
const port = 3001;

// Middleware untuk mengambil data dari body request
app.use(bodyParser.json());

// Konfigurasi database
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'partani'
});

// Koneksi ke database
db.connect((err) => {
  if (err) {
    console.error('Koneksi ke database gagal: ' + err.stack);
    return;
  }
//   console.log('Terhubung ke database dengan id ' + db.threadId);
});


// api register pembeli dan penjual
// Endpoint untuk register user baru
app.post('/register', async (req, res) => {
    try {
      const { username, nama_lengkap, nomor_telepon, alamat, password, role } = req.body;
  
      // Validasi input
      if (!username || !nama_lengkap || !nomor_telepon || !alamat || !password || !role) {
        return res.status(400).json({ error: 'Semua field harus diisi' });
      }
  
      // Hash password menggunakan bcrypt
      const hashedPassword = await bcrypt.hash(password, 10);
  
      // Query untuk menambahkan user ke database
      const sql = `INSERT INTO users (username, nama_lengkap, nomor_telepon, alamat, password, role) VALUES (?, ?, ?, ?, ?, ?)`;
      db.query(sql, [username, nama_lengkap, nomor_telepon, alamat, hashedPassword, role.toLowerCase()], (err, result) => {
        if (err) {
          if (err.code === 'ER_DUP_ENTRY') {
            return res.status(400).json({ error: 'Username sudah digunakan' });
          }
          console.error('Gagal menambahkan user: ' + err.message);
          return res.status(500).json({ error: 'Gagal menambahkan user' });
        }
        res.status(201).json({ message: 'User berhasil didaftarkan' });
      });
    } catch (error) {
      console.error('Terjadi kesalahan: ' + error.message);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  

  //api login penmbeli
// Endpoint untuk login
  app.post('/login', async (req, res) => {
    try {
      const { username, password } = req.body;

      // Validasi input
      if (!username || !password) {
        return res.status(400).json({ error: 'Username dan password harus diisi' });
      }

      // Query untuk mendapatkan data user dari database berdasarkan username
      const sql = `SELECT * FROM users WHERE username = ?`;
      db.query(sql, [username], async (err, results) => {
        if (err) {
          console.error('Gagal melakukan query: ' + err.message);
          return res.status(500).json({ error: 'Gagal melakukan login' });
        }

        if (results.length === 0) {
          return res.status(401).json({ error: 'Username atau password salah' });
        }

        const user = results[0];

        // Verifikasi password menggunakan bcrypt
        const passwordMatch = await bcrypt.compare(password, user.password);

        if (!passwordMatch) {
          return res.status(401).json({ error: 'Username atau password salah' });
        }

        // Jika login berhasil, kembalikan data user tanpa menyertakan password
        const userData = {
          id: user.UserID, // Menggunakan kolom UserID
          username: user.username,
          nama_lengkap: user.nama_lengkap,
          nomor_telepon: user.nomor_telepon,
          alamat: user.alamat,
          role: user.role
        };
        
        res.status(200).json(userData);
      });
    } catch (error) {
      console.error('Terjadi kesalahan: ' + error.message);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

 
  // Endpoint untuk membuat barang baru
  const BarangSchema = new mongoose.Schema({
    id_barang: { type: String, required: true },
    id_pembuat: { type: String, required: true },
    nama_barang: { type: String, required: true },
    harga: { type: Number, required: true },
    gambar: { type: String, required: true },
    deskripsi: { type: String, required: true },
    satuan: { type: String, required: true },
    minimal_pemesanan: { type: Number, required: true },
    stok: { type: Number, required: true }
  });
  
  // Membuat model Barang dari schema
  const Barang = mongoose.model('Barang', BarangSchema);
  
  // Middleware
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: true }));
  
  // Route untuk membuat barang baru
  app.post('/api/barang', async (req, res) => {
    try {
      const { id_barang, id_pembuat, nama_barang, harga, gambar, deskripsi, satuan, minimal_pemesanan, stok } = req.body;
  
      // Membuat objek barang baru
      const newBarang = new Barang({
        id_barang,
        id_pembuat,
        nama_barang,
        harga,
        gambar,
        deskripsi,
        satuan,
        minimal_pemesanan,
        stok
      });
  
      // Menyimpan barang ke database
      const savedBarang = await newBarang.save();
      res.status(201).json(savedBarang);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  });
  
  
  

app.listen(port, () => {
  console.log(`Server berjalan pada port ${port}`);
});
 