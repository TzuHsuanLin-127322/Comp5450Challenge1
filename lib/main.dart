import 'package:flutter/material.dart';
import 'pages/add_product_page.dart';
import 'pages/edit_product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/product_list_page.dart';
import 'pages/product_list_view_model.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductListViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Product Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
    home: const ProductListPage(),
  );
}
