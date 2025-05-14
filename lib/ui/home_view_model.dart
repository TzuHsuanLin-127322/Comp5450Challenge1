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
  List<ProductModel> get recentlySoldProducts {
    final products = <ProductModel>[];
    for (var order in _orders) {
      for (var item in order.cart.productList) {
        products.add(item.product);
      }
    }
    return products;
  }
}
