const mysql = require('mysql');

// Buat koneksi ke database MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', // Ganti dengan password MySQL Anda
    database: 'partani' // Ganti dengan nama database yang Anda gunakan
});

// Lakukan koneksi ke database
db.connect((err) => {
    if (err) {
        throw err;
    }
    console.log('Connected to MySQL');
});

module.exports = db;
