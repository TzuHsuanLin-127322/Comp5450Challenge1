// TODO: Complete Order View Model
import 'package:challenge_1_mobile_store_maker/data/repository/order_repository.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderViewModel extends ChangeNotifier{
  final OrderRepository _orderRepository;

  OrderViewModel({
    required OrderRepository orderRepository,
  }): _orderRepository = orderRepository;

  // TODO: Initialization function -> Get order repository list
  void fetchOrderList() {

  }
  // TODO: On ordelete pressed
  void onOrderDeletePress(int index) {}

  // TODO: on order status changed
  void onOrderStatusChange(int index, OrderStatus newStatus) {}


}
