import 'package:challenge_1_mobile_store_maker/data/repository/order_repository.dart';
import 'package:challenge_1_mobile_store_maker/data/services/mock_order_service.dart';
import 'package:challenge_1_mobile_store_maker/data/services/order_service.dart';
import 'package:challenge_1_mobile_store_maker/ui/order/order_display.dart';
import 'package:challenge_1_mobile_store_maker/ui/order/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Services
        Provider(create: (context) => FakeOrderService() as OrderService),
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
    return const MaterialApp(
      // TODO: Temporary Page, will need to connect with the main page.
      home: OrderDisplay(),
    );
  }
}
