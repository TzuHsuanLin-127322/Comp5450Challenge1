import 'package:challenge_1_mobile_store_maker/data/repository/order_repository.dart';
import 'package:challenge_1_mobile_store_maker/data/services/mock_order_service.dart';
import 'package:challenge_1_mobile_store_maker/data/services/order_service.dart';
import 'package:challenge_1_mobile_store_maker/ui/order/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/product_service.dart';
import 'providers/cart_provider.dart';

import 'ui/main_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ProductService()),
        Provider(create: (context) => FakeOrderService() as OrderService),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // Repositories
        Provider(create: (context) => OrderRepository(orderService: context.read())),
        // View Holders
        ChangeNotifierProvider(create: (context) => OrderViewModel(orderRepository: context.read()))
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
