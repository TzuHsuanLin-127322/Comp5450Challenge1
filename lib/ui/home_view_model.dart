import 'package:flutter/material.dart';
import '../model/order_model.dart';
import '../model/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<OrderModel> _orders;

  HomeViewModel(this._orders);

  /// Total number of orders
  int get totalOrders => _orders.length;

  /// Number of orders by status
  int ordersByStatus(OrderStatus status) =>
      _orders.where((o) => o.orderStatus == status).length;

  /// Total sales amount
  double get totalSales => _orders
      .map((o) => o.finalPrice.minor)
      .fold(0.0, (sum, val) => sum + val);

  /// Sales amount by status
  double salesByStatus(OrderStatus status) => _orders
      .where((o) => o.orderStatus == status)
      .map((o) => o.finalPrice.minor)
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


