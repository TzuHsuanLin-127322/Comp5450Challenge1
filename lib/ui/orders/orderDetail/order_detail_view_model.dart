import 'package:challenge_1_mobile_store_maker/data/repository/order_repository.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:flutter/material.dart';


class OrderDetailViewModel extends ChangeNotifier {
  OrderDetailViewModel({required this.order, required OrderRepository orderRepository})
    : _orderRepository = orderRepository;

  final OrderModel? order;
  final OrderRepository _orderRepository;
  
  Future<void> editOrder(OrderModel? order) async {
    if (order == null) {
      return;
    }
    await _orderRepository.updateOrder(order.id, order);
    notifyListeners();
  }

  Future<void> createOrder(OrderModel? order) async {
    if (order == null) {
      return;
    }
    await _orderRepository.createOrder(order);
    notifyListeners();
  }
}