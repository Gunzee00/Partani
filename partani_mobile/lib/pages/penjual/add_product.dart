import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _satuanController = TextEditingController();
  TextEditingController _minOrderController = TextEditingController();
  TextEditingController _stockController = TextEditingController();

  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Produk'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                prefixIcon: Icon(Icons.shopping_bag),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
              maxLines: null,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _satuanController,
              decoration: InputDecoration(
                labelText: 'satuan',
                prefixIcon: Icon(Icons.dashboard),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _minOrderController,
              decoration: InputDecoration(
                labelText: 'Minimum Order',
                prefixIcon: Icon(Icons.shopping_cart),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _stockController,
              decoration: InputDecoration(
                labelText: 'Stock',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            GestureDetector(
              onTap: _getImage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 50,
                child: _image == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add logic to save product
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF64AA54),
              ),
              child: Text('Tambahkan Produk',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
