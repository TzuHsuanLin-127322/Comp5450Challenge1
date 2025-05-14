import 'package:challenge_1_mobile_store_maker/data/repository/order_repository.dart';
import 'package:flutter/material.dart';
import '../model/order_model.dart';
import '../model/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  List<OrderModel> _orders = [];

  HomeViewModel({required OrderRepository orderRepository}) : _orderRepository = orderRepository{
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final result = await _orderRepository.fetchOrderList();
    if (result.statusCode == 200) {
      _orders = result.data?.orders ?? [];
    }
    notifyListeners();
  }

  /// Total number of orders
  int get totalOrders => _orders.length;

  /// Number of orders by status
  int ordersByStatus(OrderStatus status) =>
      _orders.where((o) => o.orderStatus == status).length;

  /// Total sales amount
  double get totalSales => _orders
      .map((o) => o.finalPrice.major)
      .fold(0.0, (sum, val) => sum + val);

  /// Sales amount by status
  double salesByStatus(OrderStatus status) => _orders
      .where((o) => o.orderStatus == status)
      .map((o) => o.finalPrice.major)
      .fold(0.0, (sum, val) => sum + val);

  /// Recently sold products
  List<Product> get recentlySoldProducts {
    final products = <Product>[];
    for (var order in _orders) {
      for (var item in order.cart.productList) {
        products.add(item.product);
      }
    }
    return products;
  }

  /// Daily sales for the last [days] days (oldest first)
  List<double> dailySales({int days = 7}) {
    final now = DateTime.now();
    List<double> sales = List.filled(days, 0.0);

    for (var order in _orders) {
      final diff = now.difference(order.orderTime).inDays;
      if (diff >= 0 && diff < days) {
        // bucket index: days - diff - 1 (so today is last index)
        final idx = days - diff - 1;
        sales[idx] += order.finalPrice.major;
      }
    }
    return sales;
  }

  // Labels for days
  List<String> dailyLabels({int days = 7}) {
    final now = DateTime.now();
    return List.generate(days, (i) {
      final day = now.subtract(Duration(days: days - i - 1));
      return "${day.month}/${day.day}";
    });
  }

  /// Hourly sales for a given day
  List<double> hourlySales(DateTime day) {
    List<double> sales = List.filled(24, 0.0);
    for (var order in _orders) {
      final d = order.orderTime;
      if (d.year == day.year && d.month == day.month && d.day == day.day) {
        sales[d.hour] += order.finalPrice.major;
      }
    }
    return sales;
  }

  // Labels for hours
  List<String> hourlyLabels({int intervalHours = 4}) {
    return List.generate(24, (i) {
      if (i % intervalHours != 0) return '';
      final hour12 = i % 12 == 0 ? 12 : i % 12;
      final period = i < 12 ? 'AM' : 'PM';
      return '$hour12 $period';
    });
  }


  /// TODO: Get product information (name, price, image)


}

