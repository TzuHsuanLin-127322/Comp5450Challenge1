// TODO: Complete order service

import 'package:challenge_1_mobile_store_maker/model/base/http_service_result.dart';
import 'package:challenge_1_mobile_store_maker/model/order_list_model.dart';
import 'package:challenge_1_mobile_store_maker/model/order_model.dart';

abstract class OrderService {
  // Interface class for orders service
  Future<HttpServiceResult<OrderListModel>> fetchOrderList();
  Future<HttpServiceResult<OrderModel>> createOrder(OrderModel order);
  Future<HttpServiceResult<OrderModel?>> fetchOrder(int orderId);
  Future<HttpServiceResult<bool>> updateOrder(int orderId, OrderModel order);
  Future<HttpServiceResult<bool>> deleteOrder(int orderId);
}
