import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/product_service.dart';
import 'services/order_service.dart';
import 'providers/cart_provider.dart';

import 'ui/main_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ProductService()),
        Provider(create: (_) => OrderService()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // Repositories
        // View Holders
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Store Maker',
      initialRoute: '/',
      routes: {
        '/': (_) => MainPage(),
        '/dashboard': (_) => DashboardPage(),
        '/addStore': (_) => AddStorePage(),
        '/orders': (_) => OrdersPage(),
        '/products': (_) => ProductsPage(),
      },
    );
  }
}
