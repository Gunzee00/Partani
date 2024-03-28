import 'package:flutter/material.dart';
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
}
