import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:partani_mobile/pages/penjual/penjual_page.dart';
import 'package:partani_mobile/pages/role_page.dart';
import '../pages/pembeli_page.dart';
// import '../pages/penjual_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog("Username dan password harus diisi");
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://192.168.100.8:3001/login'),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        print("Login berhasil: $userData");
        if (userData['role'] == 'penjual') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PenjualPage()),
          );
        } else if (userData['role'] == 'pembeli') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PembeliPage()),
          );
        } else {
          _showErrorDialog("Invalid user role");
        }
      } else if (response.statusCode == 401) {
        _showErrorDialog("Username atau password salah");
      } else {
        _showErrorDialog("Gagal melakukan login");
      }
    } catch (error) {
      _showErrorDialog("Terjadi kesalahan: $error");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: loginUser,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF64AA54), // Text color
              ),
              child: Text('Login'),
            ),
            SizedBox(height: 12.0),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RolePage(),
                ));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF64AA54),
                backgroundColor: Colors.white, // Text color
                side: BorderSide(color: Color(0xFF64AA54)), // Border color
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Login App',
    home: LoginPage(),
  ));
}
