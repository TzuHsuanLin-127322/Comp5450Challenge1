import 'package:flutter/material.dart';
import 'pages/add_product_page.dart';
import 'pages/edit_product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Demo Home',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final Map<String, dynamic> dummyProduct = {
    'name': 'Test Product',
    'price': '100',
    'comparePrice': '150',
    'images': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Form Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddProductPage()),
                );
              },
              child: Text('Go to Add Product Page'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProductPage(productData: dummyProduct),
                  ),
                );
              },
              child: Text('Go to Edit Product Page'),
            ),
          ],
        ),
      ),
    );
  }
}
