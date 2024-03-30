import 'package:flutter/material.dart';
// import 'package:partani_mobile/pages/add_product.dart';
import 'package:partani_mobile/pages/penjual/add_product.dart';
import 'package:partani_mobile/user_login/login_admin.dart';
import 'manage_product.dart'; // Import halaman Manage Product

class PenjualPage extends StatefulWidget {
  @override
  _PenjualPageState createState() => _PenjualPageState();
}

class _PenjualPageState extends State<PenjualPage> {
  int _selectedIndex = 0;

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Tambahkan penanganan untuk navigasi ke ManageProductPage saat indeks 1 diklik
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ManageProductPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjual Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: _getBody(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFF64AA54),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business, color: Color(0xFF64AA54)),
            label: 'Manage Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF64AA54)),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF64AA54),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return Center(
          child: Text(
            'Ini adalah halaman untuk penjual',
            style: TextStyle(fontSize: 20.0),
          ),
        );
      case 1:
        return ManageProductPage(); // Ganti dengan halaman manajemen produk
      case 2:
        // Ganti dengan halaman profil
        return Center(
          child: Text(
            'Halaman Profil',
            style: TextStyle(fontSize: 20.0),
          ),
        );
      default:
        return Center(
          child: Text(
            'Halaman tidak ditemukan',
            style: TextStyle(fontSize: 20.0),
          ),
        );
    }
  }
}

class ManageProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Produk'),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddProductPage(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF64AA54),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Posisi tombol di kanan bawah
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFF64AA54),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business, color: Color(0xFF64AA54)),
            label: 'Manage Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF64AA54)),
            label: 'Profile',
          ),
        ],
        currentIndex:
            1, // Atur indeks yang dipilih ke 1 karena ini adalah halaman "Manage Product"
        selectedItemColor: Color(0xFF64AA54),
        onTap: (index) {
          // Penanganan navigasi bottom bar
          if (index != 1) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _navigateToAddProductPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductPage()),
    );
  }
}
